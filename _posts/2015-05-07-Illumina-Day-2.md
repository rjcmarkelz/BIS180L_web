---
layout: lab
title: Viewing Illumina reads in IGV; finding SNPs
hidden: true    <!-- To prevent post from being displayed as regular blog post -->
tags:
- Brassica
- Illumina
- Linux
---

# Goals

In the last lab period we learned about Illumina reads and fastq files.  We performed quality trimming and then mapped those reads to the _B. rapa_ reference genome.

Today we will pick up where we left off.  Our goals are to:

1. Learn about sequence alignment/mapping (SAM/BAM) files.
2. Examine mapped reads in [IGV--the integrative genomics viewer](https://www.broadinstitute.org/igv/).  This will allow us to see how reads are placed on the genome during the mapping process. 
3. Find polymorphic positions in our sequencing data.


# Preliminaries

## Data files

Download output from tophat run on a larger number of sequences:

    wget http://de.iplantcollaborative.org/dl/d/4B3E55F9-FF19-456E-9468-36A0BE74E4C0/tophat_out-IMB211_NDP_2_INTERNODE.1_matched.fq.tar.gz
    tar -xvzf tophat_out-IMB211_NDP_2_INTERNODE.1_matched.fq.tar.gz

untar and unzip the files

## IGV

Unfortunately the version of IGV installed on your computers does not work and it must be reinstalled.

Download the binary distribution from the [download page](https://www.broadinstitute.org/software/igv/download)

Move the unzipped directory to BioinformaticsPackages

    mv ~/Downloads/IGV_2.3.52 ~/BioinformaticsPackages/

Add the following line to the end of your `.bashrc` file

    PATH="$HOME/BioinformaticsPackages/IGV_2.3.52:$PATH"

The source your `.bashrc`

    source .bashrc

## FreeBayes

There are many SNP callers available.  We will use one called [FreeBayes](https://github.com/ekg/freebayes) (If you scroll down on the webpage you will get to the help file, etc.)

    cd BioinformaticsPackages/
    git clone --recursive git://github.com/ekg/freebayes.git
    sudo apt-get install cmake
    cd freebayes
    make
    sudo make install


## Examine tophat output

`cd` into one of your tophat output directories

You will see several files there.  Some of these are listed below

* `accepted_hits.bam` -- A [bam](https://samtools.github.io/hts-specs/SAMv1.pdf) file for reads that were successfully mapped
* `unmapped.bam` A bam file for reads that were not able to be mapped
* `deletions.bed` and `insertions.bed` [bed](https://genome.ucsc.edu/FAQ/FAQformat.html) files giving insertions and deletions
* `junctions.bed` A bed file giving introns
* `align_summary.txt` Summarizes the mapping

__Exercise 6__: Take a look at the `align_summary.txt` file.  
__a__.  What percentage of reads mapped to the reference?
__b__.  Give 2 reasons why reads might not map to the reference.

## Look at a bam file

Bam files contain the information about where each read maps.  There are in a binary, compressed format so we can not use `less` on its own.  Thankfully there is a collection of programs called [`samtools`](http://www.htslib.org/) that allow us to view and manipulate these files.

Let's take a look at `accepted_hits.bam`.  For this we use the `samtools view` command

    samtools view accepted_hits.bam | less

| Field | Value |
|-------|-------|
| 01 | Read Name (just like in the fastq) |
| 02 | Code providing info about the alighment.  |
| 03 | Template Name (Chromosome in this case) |
| 04 | Position on the template where the read starts |
| 05 | Phred based mapping quality for the read |
| 06 | CIGAR string providing information about the mapping |
| 10 | Sequence |
| 11 | Phred+33 quality of sequence |
| Additional fields | Varies; see SAM page for more info |

`samtools` has many additional functions.  These include

`samtools merge` -- merge BAM files  
`samtools sort` -- sort BAM files; required by many downstream programs  
`samtools index` -- create an index for quick access; required by many downstream programs  
`samtools idxstats` -- summarize reads mapping to each reference sequence  
`samtools mpileup` -- count the number of matches and mismatches at each position  

And more 

## Look at a bam file with IGV

While `samtools view` is nice, it would be nicer to actually see our reads in context.  We can do this with [IGV, the Integrative Genome Viewer](https://www.broadinstitute.org/igv/)

To use IGV we need to create an index of our bam file

    samtools index accepted_hits.bam

Start IGV from the Start > Education > IGV menu

### Create a .genome file for IGV to use

By default IGV starts with the human genome.  It has a number of built-in genomes, but does not include _B. rapa_.  We must define it ourself.  This only needs to be done once per computer; IGV will remember it.

Click on Genomes > Create .genome file

Fill in the fields as follows:

* Unique Identifier: BrapaV1.5
* Descriptive name: Brassica rapa version 1.5
* FASTA file: (click on Browse and point to BrapaV1.5_chrom_only.fa)
* Cytoband file: (leave blank)
* Gene file: (click on Browse and point to the Brapa_gene_v1.5.gff file)
* Alias file: (leave blank)

### Load some tracks

Now to load our mapped reads:

Click on File > Load From File ; then select the accepted.bam file

Click on File > Load From File again ; then select the junctions.bed file

### Take a look

Click on the "ALL" button and select a chromosome.  Then zoom in until you can see the reads.


