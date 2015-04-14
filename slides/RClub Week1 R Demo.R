#read the data
data <- read.csv("TomatoR2CSHL.csv")

#get a quick summary
summary(data)

#look at the first few lines
head(data)

#a histogram
hist(data$hyp)

#load the lattice package.  Allows splitting up graphs by different categories
library(lattice) #contains the histogram() function, used below.
#hist() is for a single histogram, whereas histogram() is for splitting up the data


#histograms of hyp, split by treatment
histogram(~data$hyp | data$trt)

#histograms of hyp, split by species
histogram(~data$hyp | data$species)

#histograms of hyp, split by treatment and species
histogram(~data$hyp | data$species+data$trt)

#another plotting package
library(ggplot2) #contains the function qplot, used below

#look at individual data points
qplot(x=1,y=hyp,data=data, xlab="")

#spread it out some
qplot(x=1,y=hyp,data=data,geom="jitter", xlab="")

#split it by species
qplot(x=species,y=hyp,data=data,geom="jitter")

#indicate treatment by color
qplot(x=species,y=hyp,data=data,color=trt,geom="jitter")

#indicate measure by plotting symbol
qplot(x=species,y=hyp,data=data,colour=trt,shape=who,geom="jitter")

# some simple statistics:

#mean
mean(data$hyp)

#median
median(data$hyp)

#variance
var(data$hyp)

#standard dev
sd(data$hyp)

#create our own sem function
sem <- function(x) {
	sd(x,na.rm=T)/sqrt(length(na.omit(x)))}

#calculate means for each species and treatment separately
hyp.mean <- tapply(data$hyp,list(species=data$trt,trt=data$species),mean,na.rm=T)

#calculate s.e.m. for each species and treatment
hyp.sem <- tapply(data$hyp,list(trt=data$trt,species=data$species),sem)


#simple statistical tests
#T-test
t.test(data$hyp~data$trt)

#all species t tests
pairwise.t.test(data$hyp,data$species)

#calculate ANOVA, put results in an object and summarize
aov1 <- aov(data$hyp~data$species)
summary(aov1)

#two way
aov2 <- aov(hyp~species+trt,data=data)
summary(aov2)

#two-way with interaction
aov3 <- aov(hyp~species*trt,data=data)
summary(aov3)

#linear regressions have nicer outputs
#calculate linear regression, put results in an object and summarize
lm1 <- lm(hyp~species,data=data)
summary(lm1)

#two way
lm2 <- lm(hyp~species+trt,data=data)
summary(lm2)

#two way with interaction effect
lm3 <- lm(hyp~species*trt,data=data)
summary(lm3)


#how about the relationship between two internodes?
plot(data$int1,data$int2)

#between all internode data?
pairs(data[,c("int1","int2","int3","int4")])

cor(data[,c("int1","int2","int3","int4")],use="complete.obs")


