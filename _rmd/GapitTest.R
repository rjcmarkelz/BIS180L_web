data.geno <- read.csv("~/git/BIS180L_web/data/Rice_44K_genotypes.csv.gz",row.names=1,as.is=T)

data.geno <- t(data.geno)

head(data.geno[,1:10],)

data.geno[data.geno=="00"] <- "NN"

chromosome <- sub("X([0-9]+)_.+","\\1",rownames(data.geno))
position <- sub("X[0-9]+_([0-9]+)$","\\1",rownames(data.geno))

head(chromosome)
head(position)

data.geno.hmp <- as.data.frame(cbind("id"=rownames(data.geno),NA,"chrom"=chromosome,"pos"=position,NA,NA,NA,NA,NA,NA,NA,data.geno))

#quick way to move headers to the first row; annoyingly this is where GAPIT wants them.
write.csv(data.geno.hmp,"data.geno.gmp.csv",) 
data.geno.hmp <- read.csv("data.geno.gmp.csv",header = F,row.names=1)

head(data.geno.hmp[,1:15])

summary(data.geno.hmp[1:15])

source("http://www.bioconductor.org/biocLite.R")
biocLite("multtest")

install.packages("gplots")
install.packages("LDheatmap")
install.packages("genetics")
install.packages("scatterplot3d") #The downloaded link at: http://cran.r-project.org/package=scatterplot3d

library(multtest)
library(gplots)
library(LDheatmap)
library(genetics)
library(compiler) #this library is already installed in R
library("scatterplot3d")

source("http://zzlab.net/GAPIT/gapit_functions.txt")
source("http://zzlab.net/GAPIT/emma.txt")

head(data.pheno)

test <- GAPIT(Y = data.frame(Taxa=rownames(data.pheno),Alu.tol=data.pheno[,4]),G=data.geno.hmp,PCA.total=0)


myY <- read.table("~/Downloads/GAPIT_Tutorial_Data/mdp_traits.txt", head = TRUE)

myG <- read.table("~/Downloads/GAPIT_Tutorial_Data/mdp_genotype_test.hmp.txt", head = FALSE)

head(myY)

head(myG[1:15])
