install.packages("BoolNet")
library(BoolNet)

data(cellcycle)
ls()
cellcycle

data(yeastTimeSeries)
yeastTimeSeries
binSeries <- binarizeTimeSeries(cellcycle)
binSeries

net <- reconstructNetwork(binSeries$binarizedMeasurements, method = "bestfit", maxK = 4, returnPBN = TRUE)
net
plotNetworkWiring(net)

attract <- getAttractors(cellcycle)
attract
plotAttractors(attract, mode="graph")

net <- loadBioTapestry("example.btp")


PhyB -| PIF4/5
PhyB -| auxin
PIF4/5 -> HFR1
HFR1 -| PIF4/5
TAA1 -> YUCCA
YUCCA -> auxin
auxin -> elongation
PIF4/5 -> YUCCA

setwd("/Users/Cody_2/git.repos/BIS180L_web/_posts")
shade <- loadNetwork("shade_network.txt")
?plotNetworkWiring
plotNetworkWiring(shade)









