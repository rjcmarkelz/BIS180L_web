#setwd("~/git.repos/BIS180L_web/") #Cody
setwd("~/git.repos/BIS180L_web/") #Julin

library(knitr)

jekyll.knit <- function(input) {
    rel.path = substr(input, 6, nchar(input) - 4)
    output = paste("_posts/", rel.path, ".md", sep = "")
    knit(input = input, output = output)
    system(paste("perl -pi -e 's|images/|{{ site.baseurl }}/images/|gi'", output, sep = " ")) # for non-R generated figures
    system(paste("perl -pi -e 's|figure/|{{ site.baseurl }}/figure/|gi'", output, sep = " ")) # for R figures generated during knitting
    
    
}
# .Rmd files in _rmd directory
# Usage example:
# jekyll.knit("_rmd/2013-XX-XX-post-name.Rmd")
jekyll.knit("_rmd/2015-05-21-genetic-networks-2.Rmd")
?maxSE

**Exercise 7:**
In the gene_graph85, what 

```{r, eval = FALSE}

graph.density(gene_graph85)
length(E(gene_graph85))
length(V(gene_graph85))
clusters(gene_graph85)$no
head(shortest.paths(gene_graph85))
degree(gene_graph85)
E <- get.edgelist(gene_graph85)
E
distMatrix <- shortest.paths(gene_graph85, v=V(gene_graph85), to=V(gene_graph85))
head(distMatrix)
```

Bra027717 - high
Bra021171 - medium
Bra028893 - low

```{r, eval = FALSE}
g <- barabasi.game(25, m=1)
g2 <- barabasi.game(25, m=5)
edge.connectivity(g, 25, 1)
edge.connectivity(g2, 25, 1)
?edge.disjoint.paths
edge.disjoint.paths(g2, 25, 1)

?get.shortest.paths
pa <- get.shortest.paths(gene_graph85, 2, 6)[[1]]
pa

V(gene_graph85)[pa]$color <- 'green'
E(gene_graph85)$color <- 'grey'
E(gene_graph85, path=ShortPth[[1]])$color <- "blue" 
E(gene_graph85, path=pa)$width <- 3
plot(gene_graph85, layout=layout.fruchterman.reingold, vertex.size=6,)
plot(g2)

names(gene_graph85)
str(gene_graph85)
```