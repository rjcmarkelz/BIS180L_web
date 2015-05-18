---
layout: lab
title: Genetic Networks using co-expression clustering
hidden: true
tags:
     - networks
---
#Part I
## Clustering
As you learned last week, when we are dealing with genome scale data it is hard to come up with very specific summaries of the data unless you know exactly the question you are trying to ask computationally. Today we will be talking about three different ways to cluster data and get visual summaries of the expression of all genes that had a significant GxE interaction. Once we have these clusters, it allows us to ask further more detailed questions such as what GO categories are enriched in each cluster, or are there specfic metabolic pathways contained in the clusters? While clustering can be used in an exploratory way, the basics you will be learning today have been extended to very sophisticated statistical/machine learning methods used across many disciplines. Lets learn the basics on some data that you are already familiar with.

The first thing that we will do is load some of the data from last time. I have a created a small R package that contains some of the data and functions already installed in a compressed, cleaned up format so we are all starting at the same step today.

```{r ,echo=F,results='hide'}
install.packages("devtools") # may have already done this
library(devtools)
devtools::install_github("rjcmarkelz/BIS180L")
```

As you learned last week, count data needs to get special treatment so we need to some data transformation steps so we will be better able to use the clustering methods that have assumption that the data come from a normal distribution. 

The three clustering methods that we will be exploring for the first part of the class are hierachical clustering, k-means clustering, and self organizing map. All three of these have important similarities and differences that we will discuss in detail throughout today.

To build some intuition about how these things work there is a cool R package called "animation". You do not have to run the following code, but I will use it to demonstrate a few examples with the projector. These examples are based directly on the **documentation** for the functions so if you wanted to look at how some other commonly used methods work with visual summary I encourage you to check out this package on your own time.

```{r ,echo=F,results='hide'} 
library(animation)

kmeans.ani(x = cbind(X1 = runif(50), X2 = runif(50)), centers = 3,
hints = c("Move centers!", "Find cluster?"), pch = 1:3, col = 1:3)

kmeans.ani(x = cbind(X1 = runif(50), X2 = runif(50)), centers = 10,
hints = c("Move centers!", "Find cluster?"), pch = 1:3, col = 1:3)

kmeans.ani(x = cbind(X1 = runif(50), X2 = runif(50)), centers = 5,
hints = c("Move centers!", "Find cluster?"), pch = 1:3, col = 1:3)

```


```{r ,echo=F,results='hide'} 
hclust() 
kmeans()
som()
```


* clustering live demo
* clustering part 2 - our gene expression data
* But how to pick the number of clusters? 

If you remember last week, you found some genes that had significant GxE in the internode tissue. We are going to be taking a look at those genes again this week. I followed the same tutorial that you did last week and the gene list that I came up with can be found *here*. This week will be a review of all the cool data manipulation steps you have learned in past weeks. We want to start with the same file that we did last week, but we are going to have different downstream steps that we use on the data. edgeR does a good job normalizing the data for us. We are going to reuse the code from last week, normalize the data, then do something different with the data...cluster! 

```{r ,echo=F,results='hide'} 
setwd("/Users/Cody_2/git.repos/BIS180L/data")
counts.data <- read.table("gh_internode_counts.tsv")
```

Later in the day we are going to take motif enrichment data to build more complicated network models. 





# Part II
## Graph Models
Nodes:

* abstract concept that can represent data or process
* examples of social and biological nodes

**(PersonA)**

**(PersonB)**

**(A)**    **(B)**    **(C)**

**(Gene1)**    **(Gene2)**    **(Gene3)**

Relationships:
* abstract concept that can represent data or process
* examples of social nodes

**(PersonA)--knows--(PersonB)**

**(PersonB)--doesnotknow--(PersonC)**

**(PersonC)--knows--(PersonB)**

Simplified:

**(A)--1--(B)**

**(A)--0--(C)**

**(B)--1--(C)**

# Concept Outline

### Relationships
* adjacency 
* corr based networks
* other weightings
* social networks examples

### Graphs
* intro to graphs
* igraph basics
* now code simple social network by hand
* ask question that requires following information along network

### Brief intro of shade avoidance and dataset we will be working with
* see how much Julin did this

### Gene co-expression networks and phenotype networks
* transition from social network to gene-gene interaction example
* code small shade avoidance network beforehand to play with
* ask biologically motivated question with simulated shade network

### Break into teams for network construction
* have each team (or set of) create networks for tissue types - need to double check time
* create adjacency network first- visualize with heatmap
* use either WGCNA or Network package to create full network - need to do speed comparisons







