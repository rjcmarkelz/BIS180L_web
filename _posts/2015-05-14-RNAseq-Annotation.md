---
layout: lab
hidden: true
title: 'Differential Gene Expression: Now What?'
output: html_document
tags:
- R
- Brassica
- Illumina
- RNAseq
---



# Assignment

Pull your repository.

There are three questions below.  Please answer them using the new file `RNA_Seq_Assignment2.Rmd` in your `Brassica_Assignment/Diff_Exp` directory.

Knit the file and submit the .Rmd and .html when you are done.  Open an issue indicating that the assignment is ready to be graded.

# Background

Now what?

We have found our lists of differentially expressed genes.  Now what?  We want to know the potential functions of those differentially expressed genes and possibly their regulators.  Specifically we will:

1. Merge the list of differentially expressed genes with a gene annotation file to learn about the function of the most up-regulated genes.
2. Ask if particular classes of genes genes are up-regulated, by using functional classifiers known as [Gene Ontology (GO) terms](http://geneontology.org/).
3. Determine whether the differentially expressed genes have any common promoter motifs.

## Annotate the differentially expressed genes.

As part of [his B_rapa annotation paper](http://www.g3journal.org/content/4/11/2065.long) a postdoc in my lab, Upendra Devisetty, did a quick annotation of the _B. rapa_ genes by BLASTing each gene to the NCBI non-redundant database and taking the gene description of the best match (above a threshold). You can download the description with this command:

    wget http://www.g3journal.org/content/suppl/2014/08/12/g3.114.012526.DC1/FileS9.txt
  
Place the file into your `Brapa_reference` directory.
  
Now open Rstudio, set the working directory to your `Diff_Exp` directory, and proceed.
  
__Exercise 1__

(Note: you should have these gene lists from the previous lab.  And they should have been saved as files `DEgenes.trt.csv` and `DEgenes.interaction.csv`, so you can load them in from these files).

__a.__ Use `merge()` to add gene descriptions for the genes found to be regulated by the DP treatment.  Output a table of the top 10 genes that includes the output from edgeR and the descriptions.  __Important: Pay attention to the "sort="" argument to `merge()`.  Should it be TRUE or FALSE?

__b.__ Repeat this for  genes with a genotype x trt interaction.



By looking at the annotated interaction gene list we can see that many of the identified genes code for proteins that modify the plant cell wall (I wouldn't expect you to know this unless you are a plant biologist).  This might relate to the different properties of the two cultivars, IMB211 and R500, and their different responses to the treatment.  Depending on our interests and knowledge of the system we might at this point choose follow up study on specific genes.

## Test for enrichment of functional classes of genes.

A casual glance indicated that there might be an enrichment for cell wall related genes in  the gt X trt DE gene list.  We can test this more rigorously by asking if there is statistical over-representation of particular [Gene Ontology (GO)](http://geneontology.org/) terms in this set of genes.  GO terms provide a precise, defined language to describe gene function.

To test for test for enrichment of GO terms we essentially ask the question of whether the prevalence of a term in our gene set of interest is higher than its prevalence in the rest of the genome (aka the universe).  For example if 20% of the differentially expressed genes have the GO term "Cell Wall" but only 10% of the not-differentially expressed genes have the term Cell Wall that the term "Cell Wall" might be over-represented, or enriched, in our differentially expressed genes.  In principle this could be tested using a [Chi-squared test](http://www.biostathandbook.com/chiind.html) or [Fisher's exact test](http://www.biostathandbook.com/fishers.html) for contingency tables.  In practice we will use [GOseq](http://www.bioconductor.org/packages/release/bioc/html/goseq.html) that [makes an adjustement for gene-length bias](http://genomebiology.com/2010/11/2/r14) since it is easier to detect differential expression of longer genes.  

It is important in these analyses to define the "Universe" correctly.  The Universe of genes is all of the genes where you could have detected an expression difference.  It would not have been possible to detect an expression difference in genes that were not expressed at a detectable level in our experiment.  So the Universe in this case is all expressed genes, rather than all genes.

### Expressed genes

We need a list of expressed genes.  You could generate this yourself, or you can download this with

    wget http://jnmaloof.github.io/BIS180L_web/data/internode_expressed_genes.txt
    
Place this file in you `Diff_Exp` directory.

### Install GOseq

__If you can't install GOseq, skip ahead to "GO visualization below"__


```r
source("http://bioconductor.org/biocLite.R")
biocLite("goseq")
```

### Download the GO annotation and gene length for B.rapa

GO term annotation for _B. rapa_ is also available from the [Devisetty et al paper](http://www.g3journal.org/content/4/11/2065.long).

cDNA gene lengths were estimated by the `featureCounts()` command used in Tuesday's lab.  I have saved them for you and you can download them as instructed below.  (You're welcome)

Download the files using the commands below (in Linux) and place the file in your `Brapa_reference` directory.

GO terms:

    wget http://www.g3journal.org/content/suppl/2014/08/12/g3.114.012526.DC1/FileS11.txt
    
Gene Length:

    wget http://jnmaloof.github.io/BIS180L_web/data/Brapa_CDS_lengths.txt
  
  
### Format data for GOseq

We need to do a bit of data wrangling to get things in the correct format for GOSeq.  First we import the gene lengths and GO terms.  We also import a table of all expressed genes in the experiment (you could have gotten this from Tuesday's data)

Get the data

```r
library(goseq)
go.terms <- read.delim("../Brapa_reference/FileS11.txt",header=FALSE,as.is=TRUE)
head(go.terms)
names(go.terms) <- c("GeneID","GO")
summary(go.terms)

expressed.genes <- read.delim("internode_expressed_genes.txt",as.is=TRUE)
head(expressed.genes)
names(expressed.genes) <- "GeneID"

gene.lengths <- read.table("../Brapa_reference/Brapa_CDS_lengths.txt",as.is=TRUE)
head(gene.lengths)
summary(gene.lengths)

#we need to reduce the gene.length to only contain entries for those genes in our expressed.genes set.  We also need this as a vector
gene.lengths.vector <- gene.lengths$Length[gene.lengths$GeneID %in% expressed.genes$GeneID]
names(gene.lengths.vector) <- gene.lengths$GeneID[gene.lengths$GeneID %in% expressed.genes$GeneID]
head(gene.lengths.vector)

#Do the reverse to make sure everyting matches up (it seems that we don't have length info for some genes?)
expressed.genes.match <- expressed.genes[expressed.genes$GeneID %in% names(gene.lengths.vector),]
```

Format go.terms for goseq.  We want them in list format, and we need to separate the terms into separate elements.

```r
go.list <- strsplit(go.terms$GO,split=",")
names(go.list) <- go.terms$GeneID
head(go.list)
```

Format gene expression data for goseq.  We need a vector for each gene with 1 indicating differential expression and 0 indicating no differential expression.

```r
DE.interaction <- expressed.genes.match %in% rownames(DEgene.interaction) 
    #for each gene in expressed gene, return FALSE if it is not in DEgene.trt and TRUE if it is.
names(DE.interaction) <- expressed.genes.match
head(DE.interaction)
DE.trt <- as.numeric(DE.interaction) #convert to 0s and 1s
head(DE.interaction)
sum(DE.interaction) # number of DE genes
```

### Calculate over-representation

Now we can look for GO enrichment

```r
#determines if there is bias due to gene length.  The plot shows the relationship.
nullp.result <- nullp(DEgenes = DE.interaction,bias.data = gene.lengths.vector)

#calculate p-values for each GO term
rownames(nullp.result) <- names(gene.lengths.vector) #because of a bug in nullp()
GO.out <- goseq(pwf = nullp.result,gene2cat = go.list,test.cats=("GO:BP"))

#list over-represented GO terms (p < 0.05)
GO.out[GO.out$over_represented_pvalue < 0.05,]
```

### GO visualization

If you were not able to run `goseq` then you can download the [output as an .Rdata file](http://jnmaloof.github.io/BIS180L_web/data/GO.out.Rdata)

Then from  within R (only if you downloaded the file).  You may need to update the path.

    load("GO.out.Rdata")

This creates an object "GO.out" that otherwise would have been created by goseq.  You can look at it with:

    GO.out[GO.out$over_represented_pvalue < 0.05,]


Looking through a long list can be tough.  There is a nice visualizer called [REVIGO](http://revigo.irb.hr/).  To use it we need to cut and paste the column with the GO term and the one with the p-value.  Use the command below to print these to columns to the console:


```r
print(GO.out[GO.out$over_represented_pvalue < 0.05,1:2],row.names=FALSE)
```

Cut and paste the GO terms and p-values into [REVIGO](http://revigo.irb.hr/).  You can use the default settings.  There are three types of GO terms:

* Biological Process (BP)
* Cellular Compartment (CC)
* Molecular Functions (MF)

Generally I find the BP terms most helpful but you can look at each type by clicking in the tabs.

REVIGO has three types of visualizers.  The "TreeMap"  Can be particular nice because it groups the GO terms into a hierarchy.

__Exercise 2__:  

__a:__ In REVIGO display a "TreeMap" of the BP GO terms.  Was our hypothesis that cell wall genes are enriched in the genotype X treatment gene set correct?  You DO NOT need to include the treemap in your answer.

__b:__ Display a "TreeMap" of the CC GO terms.  There are four general categories shown, some with sub-categories.  What are the two general categories with the largest number of sub categories?  How might these general categories relate to differences in plant growth?  You DO NOT need to include the treemap in your answer.

## Promoter motif enrichment

To help us understand what causes these genes to be differentially expressed it would be helpful to know if they have any common transcription factor binding motifs in their promoters.

First we must get the sequence of the promoters.  For ease we will define the promoters as the 1000bp upstream of the start of the gene.  In the interest of time I have pre-computed this for you, but I show you how to do this below in case you need to do it in the future.

### Get gene "promoters".

__You do not need to run this__

To extract the promoters I used Mike Covington's [extract-utr script](https://github.com/mfcovington/extract-utr) and downloaded the CDS as file S4 from [Devisetty et al](http://www.g3journal.org/content/4/11/2065.long)

The command I used was
```
extract-utr.pl --gff_file=Brapa_gene_v1.5.gff \
--genome_fa_file=BrapaV1.5_chrom_only.fa  \
--cds_fa_file=Brassica_rapa_final_CDS.fa  \
--fiveprime --utr_length=1000 --gene_length=0 \
--output_fa_file=BrapaV1.5_1000bp_upstream.fa
```

### Gather data for motif enrichment

First lets gather the data that we need.  you do need to run the following.

Download the promoters and place them in your `Brapa_reference` directory.  You can download them with

    wget http://jnmaloof.github.io/BIS180L_web/data/BrapaV1.5_1000bp_upstream.fa.gz
  
Siobhan Brady has compiled a file of plant transcription factor binding motifs.  You can download those from

    wget http://jnmaloof.github.io/BIS180L_web/data/element_name_and_motif_IUPACsupp.txt
  
Place these in your `Brapa_reference` directory

Load the promoter sequences

```r
library(Biostrings) #R package for handling DNA and protein data
promoters <- readDNAStringSet("../Brapa_reference/BrapaV1.5_1000bp_upstream.fa.gz")

#convert "N" to "-" in promoters.  otherwise motifs will match strings of "N"s
promoters <- DNAStringSet(gsub("N","-",promoters))

promoters
```

Load the motifs and convert to a good format for R

```r
motifs <- read.delim("../Brapa_reference/element_name_and_motif_IUPACsupp.txt",header=FALSE,as.is=TRUE)
head(motifs)
motifsV <- as.character(motifs[,2])
names(motifsV) <- motifs[,1]
motifsSS <- DNAStringSet(motifsV)
motifsSS
```

Next we need to subset the promoters into those in our DE genes and those in the "Universe"

```r
#get names to match...there are are few names in the DEgene list not in the promoter set
DEgene.interaction.match <- row.names(DEgene.interaction)[row.names(DEgene.interaction) %in% names(promoters)]

#subset promoter files
universe.promoters <- promoters[expressed.genes.match]
target.promoters <- promoters[DEgene.interaction.match]
```

### Look for over-represented motifs

I have written a function to wrap up the required code.  Paste this into R to create the function

```r
#create a function to summarize the results and test for significance
motifEnrichment <- function(target.promoters,universe.promoters,all.counts=F,motifs=motifsSS) {
  
  #use vcountPDict to count the occurences of each motif in each promoter
  target.counts <- vcountPDict(motifs,target.promoters,fixed=F) + 
    vcountPDict(motifsSS,reverseComplement(target.promoters),fixed=F)
  universe.counts <- vcountPDict(motifs,universe.promoters,fixed=F) + 
    vcountPDict(motifsSS,reverseComplement(universe.promoters),fixed=F)
  
  if (all.counts) { 
    #count all occurences of a motif instead of the number of promoters that it occurs in
    target.counts.sum <- apply(target.counts,1,sum)
    universe.counts.sum <- apply(universe.counts,1,sum)
  } else {
    target.counts.sum <- apply(ifelse(target.counts > 0,1,0),1,sum)
    universe.counts.sum <- apply(ifelse(universe.counts > 0 , 1, 0),1,sum)
  }
  n.motifs <- length(target.counts.sum)
  results <- vector(mode="numeric",length=n.motifs)
  for (i in 1:n.motifs) {
    if (all.counts) { #the contigency tables are different depending on whether we are looking at promoters or overall occurences
      #test if ratio of occurences to promoters is the same in the target and the universe
      m <- matrix(c(
        target.counts.sum[i],                       #number of occurences within target
        dim(target.counts)[2],                      #number of promoters in target
        universe.counts.sum[i],                  #number of occurences within universe
        dim(universe.counts)[2]                  #number of promoters in universe
      ),ncol=2)
    } else { #looking at promoters with and without hits
      m <- matrix(c(
        target.counts.sum[i],                        #number of promoters in target with hit
        dim(target.counts)[2]-target.counts.sum[i],            #number of promoters in target with no hit
        universe.counts.sum[i],                   #number of promoters in universe with hit
        dim(universe.counts)[2]-universe.counts.sum[i]   #number of promoters in universe with no hit
      ),ncol=2)
    } #else
    results[i] <- fisher.test(m,alternative="greater")$p.value
  } #for loop
  results.table <- data.frame(
    motif=names(motifs),
    universe.percent = round(universe.counts.sum/dim(universe.counts)[2],3)*100,
    target.percent = round(target.counts.sum/dim(target.counts)[2],3)*100,
    p.value =  results)
  results.table <- results.table[order(results.table$p.value),]
  results.table
}
```

Now with the function entered we can do the enrichment

```r
motif.results <- motifEnrichment(target.promoters,universe.promoters)
head(motif.results)
```
The resulting table gives the p-value for enrichment for each motif, as well as the %of promoters in the universe and in our target gene set that have the motif.


__Exercise 3__ 

__a.__ How many motifs are enriched at P < 0.05?  
__b.__ What is the identity of the most significantly over-enriched promoter?  
__c.__ What percentage of genes in the "Universe" have this motif?  What percentage in our target set?  
__d.__ You can find information on the motifs [here](http://arabidopsis.med.ohio-state.edu/AtcisDB/bindingsites.html).  Do you think that the most enriched motif represents a biologically meaningful result?  Discuss why or why not.









