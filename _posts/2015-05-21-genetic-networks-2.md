---
layout: lab
title: Genetic Networks 2 - co-expression networks
hidden: true
tags:
     - networks
     - R
     - clustering
     - kmeans
     - RNA-seq 
     - graphs
--- 
# Biological Context 
In the past few weeks we have taken data off the sequencer, aligned the reads to our reference genome, calculated counts for the number of reads that mapped to each gene in out reference genome, found out what genes are differentially expressed between our genotype treatment combinations, and started to interpret the data using clustering. With these large data sets there is more than one way to look at the data. As biologists this is where we need to critically evaluate what the data is telling us and interpret it using our knowledge of biology and the design of the experiment. In our case we have an environmental perturbation that we have imposed on the plants by altering the density of plants in a given pot. Understanding mechanistically how plants respond to crowding is important for understanding how plants grow and compete for resources in natural ecosystems, and how we might manipulate plants to grow optimally in agroecosystems. In our case, we have two genotypes of plants that show very different physiological and morphological responses to crowding. We have a lot of data, some quantitative, some observational, that support this. Plant growth, just like the growth of any organism, is a really complicated thing. Organisms have evolved to interact with the environment by taking in information from their surroundings and trying to alter their physiology and biochemistry to better live in that environment. We know a lot about the details of how these signals are intercepted by the organisms, but we know less how this translates to changes in biochemistry, physiology, development, growth, and ultimately reproductive outputs. In our case, plants recieve information about their neighbors through detecting changes in light quality through the phytochrome light receptors. This is a focus of the Maloof lab. You can read more generally about the way plants percieve these changes **here**. We want to understand how plants connect the upstream perception of environmental signals (in this case the presence of neighbors) and how this information cascades through the biological network of the organism to affect the downstream outputs of physiological and developmental changes. To get an approximation of what is going on in the biological network we need to work with an intermediate form of biological information: gene expression. Although there are important limitations to only using gene expression data which we will discuss during the lecture, it should provide some clues as to how to best connect the upstream environmental perception with the downstream growth outputs.

# Review
In the last section you learned about techniques to reduce our high-dimensional gene expression data by projecting them onto a simpler two dimensional representation. The axes of this projection describes the two largest axes of variation contained within the dataset. Each of these is axes of variation is called a principle component (PC for short). During the lecture last time, I used the example of trying to summarize a 3D object by projecting a shadow of the object on the dry erase board. If we could only observe the shadow of the object, we have reduced the object from being a 3D shape into a 2D summary. We also discussed how the shape of the 2D summary shadow would depend on how the 3D object was oriented in 3D space and what angle the light source was at to cast the shadow onto the dry erase board. So we can define the largest axes of variation in the dataset and plot them onto a 2D plane. 
K-means clustering allows us to search this higher dimensional space for patterns in the data, find the patterns, and assign cluster numbers to each gene in the dataset. When we combine PC plots with k-means plots we can assign a color value to each cluster like you did for exercise X. We will now build on these ideas of data reduction and visualization to build a correlation based gene co-expression network. 

# Networks Intuition
In our example dataset from last time we used US cities to represent individual nodes that cluster together with one another based on **relationship** of each city geographic distance. To put this in network terminology, each of the individual cities we could define as a **node**.

**(NY)**    **(BOS)**    **(DC)**

The relationships, or **edges**, between the city nodes were defined by measurements of geographic distance.

**(NY)--MILES?--(BOS)**

**(NY)--MILES?--(SF)**

Okay, lets load up our city data again and get started by playing with some examples!


```bash
#wget https://github.com/rjcmarkelz/BIS180L_web/tree/feature-networks/data/us_cities.txt
```


```r
# setwd("/Users/Cody_2/git.repos/BIS180L_web/data/")
cities <- read.table("/Users/Cody_2/git.repos/BIS180L_web/data/us_cities.txt", sep = "\t", header = TRUE)
rownames(cities) <- cities$X #make first column the rownames
cities <- cities[,-1] #remove first column
cities <- as.matrix(cities) #convert to matrix
cities # print matrix
```

```
##       BOS   NY   DC  MIA  CHI  SEA   SF   LA  DEN
## BOS     0  206  429 1504  963 2976 3095 2979 1949
## NY    206    0  233 1308  802 2815 2934 2786 1771
## DC    429  233    0 1075  671 2684 2799 2631 1616
## MIA  1504 1308 1075    0 1329 3273 3053 2687 2037
## CHI   963  802  671 1329    0 2013 2142 2054  996
## SEA  2976 2815 2684 3273 2013    0  808 1131 1307
## SF   3095 2934 2799 3053 2142  808    0  379 1235
## LA   2979 2786 2631 2687 2054 1131  379    0 1059
## DEN  1949 1771 1616 2037  996 1307 1235 1059    0
```
What if we were an airline and we wanted to calculate what the best route from city to city was, but the planes that we have in our fleet have a maximum fuel range of only 1500 miles. This would put a constraint on our city network. Cities with distances between them greater than 1500 miles would no longer be reachable directly. Rather than representing our network as miles, we can simplify it by having a connection (or edge) value be a 1 if distance between cities is <1500 miles or a 0 if the distance is >1500. This 1 or 0 representation of the network is called the network **adjacency** matrix. 

Lets create an adjacency matrix for our test dataset.


```r
cities_mat <- cities # leave original matrix intact
cities_mat[cities <= 1500] <- 1
cities_mat[cities >= 1500] <- 0
diag(cities_mat) <- 0 # we do not have to fly within each of cities :)
cities_mat # check out the adjacency matrix
```

```
##      BOS NY DC MIA CHI SEA SF LA DEN
## BOS    0  1  1   0   1   0  0  0   0
## NY     1  0  1   1   1   0  0  0   0
## DC     1  1  0   1   1   0  0  0   0
## MIA    0  1  1   0   1   0  0  0   0
## CHI    1  1  1   1   0   0  0  0   1
## SEA    0  0  0   0   0   0  1  1   1
## SF     0  0  0   0   0   1  0  1   1
## LA     0  0  0   0   0   1  1  0   1
## DEN    0  0  0   0   1   1  1  1   0
```
**Exercise 1:**
Based on this 0 or 1 representation of our network given a maximum distance cutoff between cities of 1500 miles, what city is the most highly connected? *Hint: sum the column values down a column OR across a row*

What if you were to extend the range to 2000 miles in the above code. Does the highest connected city change? If so explain. 

Now plot this example to see the connections based on the 2000 mile distance cutoff. It should show the same connections as in your adjacency matrix. 


```r
install.packages("igraph") # Download and install the package
```

```
## Installing package into '/Users/Cody_2/Library/R/3.1/library'
## (as 'lib' is unspecified)
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/jh/6yqw6n710sj2xr9knz37tt0w0000gn/T//RtmprFIuZ5/downloaded_packages
```

```r
library(igraph) # load package
# make sure to use the 2000 mile distance cutoff 
cities_graph2 <- graph.adjacency(cities_mat, "undirected")
plot.igraph(cities_graph2)
```

![plot of chunk unnamed-chunk-4]({{ site.baseurl }}/figure/unnamed-chunk-4-1.png) 
**Exercise 2:**
What is the total number of nodes you can see in your plot? 
What is the total number of edges you can see in your plot?

**Exercise 3:**
Re-calculate the adjacency matrix with the cutoff value at 2300. Calculate the number of edges rapidly using the following code. What do you get?


```r
sum(cities_mat)/2 # divide by 2 because the matrix has 2 values for each edge
```
How can we extend this analogy to biology? Well one of the simplest ways to do this would be to define each gene as a node and the relationships/edges between the nodes as some value that we can calculate with data on hand to make an adjacency matrix. 

**(Gene1)**    **(Gene2)**    **(Gene3)**

**(Gene1)--Value?--(Gene2)**

We do not have geographic distance between genes, but we do have observations of each gene's relative expression value across our many Genotype by Environment by Tissue type combinations. We can reduce this data down if we did a simple correlation based analysis of the data. We could calculate a correlation coefficient (a value between -1 and +1) for each gene with every other gene in our data set across all the samples.

**(Gene1)--Correlation--(Gene2)**

There are **MANY** important caveats and limitations to this approach outlined **here**, but that does not mean that the method is not useful for helping us to interpret this data. If we look across our dataset and calculate a correlation coefficient between each gene we would have edge values to construct a network. However, to start with an adjacency matrix of our simple gene network lets put some constraints on what we want to call an edge. Lets say greater than the 0.7 correlation (+ or -) we will draw an edge value of 1, if not it will get a 0. This is called an unsigned network. There is no sign associated with the positive or negative correlation values. 

**(Gene1)--(+0.9)--(Gene2)**

**(Gene2)--(-0.76)--(Gene3)**

**(Gene1)--(+0.50)--(Gene3)**

**(Gene3)--(-0.69)--(Gene4)**

**Exercise 4:**
Fill in the following 0 or 1 values for our gene network.
**(Gene1)--(?)--(Gene2)**

**(Gene2)--(?)--(Gene3)**

**(Gene1)--(?)--(Gene3)**

**(Gene3)--(?)--(Gene4)**

Okay, I think now that we have the basic concepts, lets work with the larger gene expression data set. In following up on the pattern that we observed in our clustering analysis on Tuesday I found out that the libraries that appeared to be part of thier own cluster (especially in the heat map) were bad libraries. **The value of plotting data and being thoughtful about what it is telling you!** We will remove these libraries from our analysis today.


```r
# setwd("/Users/Cody_2/git.repos/BIS180L_web/data/")
genes <- read.table("/Users/Cody_2/git.repos/BIS180L_web/data/voom_transform_brassica.csv", sep = ",", header = TRUE)
genes <- genes[,-c(38,42,46)] # remove questionable library columns
DE_genes <- read.table("/Users/Cody_2/git.repos/BIS180L_web/data/DEgenes_GxE.csv", sep = ",")
DE_gene_names <- rownames(DE_genes)
GxE_counts <- as.data.frame(genes[DE_gene_names,])
genes_cor <- cor(t(GxE_counts))

# take a look at the distibution of gene gene correlations
hist(genes_cor[upper.tri(genes_cor)]) # slightly right skewed
```

![plot of chunk unnamed-chunk-6]({{ site.baseurl }}/figure/unnamed-chunk-6-1.png) 

```r
genes_adj <- abs(genes_cor) > 0.85
diag(genes_adj) <- 0 
```

**Exercise 5:**
Now we can do some calculations. If our cutoff is abs(0.80), how many edges do we have in our 255 node gene network? What if we increase our cutoff to 0.90?

**Exercise 6:**
Use the following code to plot our networks using different thresholds for connectivity. What patterns do you see in the visualization of this data? *Note: the second plot will take a while to render*


```r
genes_adj95 <- abs(genes_cor) > 0.95
diag(genes_adj95) <- 0 

gene_graph95 <- graph.adjacency(genes_adj95, mode = "undirected")
comps <- clusters(gene_graph95)$membership
colbar <- rainbow(max(comps)+1)
V(gene_graph95)$color <- colbar[comps+1]
plot(gene_graph95, layout=layout.fruchterman.reingold, vertex.size=6, vertex.label=NA)
```

![plot of chunk unnamed-chunk-7]({{ site.baseurl }}/figure/unnamed-chunk-7-1.png) 

```r
#this one will take a little while to render
genes_adj85 <- abs(genes_cor) > 0.85
diag(genes_adj85) <- 0 
gene_graph85 <- graph.adjacency(genes_adj85, mode = "undirected")
comps <- clusters(gene_graph85)$membership
colbar <- rainbow(max(comps)+1)
V(gene_graph85)$color <- colbar[comps+1]
plot(gene_graph85, layout=layout.fruchterman.reingold, vertex.size=6, vertex.label=NA)
```

![plot of chunk unnamed-chunk-7]({{ site.baseurl }}/figure/unnamed-chunk-7-2.png) 

**Exercise 7:**
In the gene_graph85, what is the total graph density? This is a measure of the total number of connections between nodes out of the total possible number of connections between nodes. 


```r
graph.density(gene_graph85)
```
We can follow a path connecting genes in our network. Use the following code to do a partial path analysis for the two genes specified.


```r
gene_graph85 <- graph.adjacency(genes_adj85, mode = "undirected")
distMatrix <- shortest.paths(gene_graph85, v=V(gene_graph85), to=V(gene_graph85))

pl <- get.shortest.paths(gene_graph85, 2, 6)$vpath[[1]] # pull paths between node 2 and 6

V(gene_graph85)[pl]$color <- paste("green")          # define node color
E(gene_graph85)$color <- paste("grey")               # define default edge color
E(gene_graph85, path = pl)$color <- paste("blue")    # define edge color
E(gene_graph85, path = pl)$width <- 10               # define edge width
plot(gene_graph85, layout = layout.fruchterman.reingold, vertex.size = 6, vertex.label = NA)
```

![plot of chunk unnamed-chunk-9]({{ site.baseurl }}/figure/unnamed-chunk-9-1.png) 


```r
edge.connectivity(gene_graph85, 16, 10)
```

**Exercise 8:**
Make a plot of your path analysis between two genes with coordates 10, 16. Plot it and give the path length. 

**Exercise 9:**
Using the edge.connectivity() function, what is the connectivity between these two genes? *Hint: it is not the same thing as the shortest path between them.*

**Exercise 10:**
Using what you know about graphs, repeat your analysis of the smaller cities matrix. Find the shortest path between SEA and DC. Graph it. What is the edge connectivity between LA and DEN? What is the connectivity between LA and CHI? What is the graph density of the cities network?













