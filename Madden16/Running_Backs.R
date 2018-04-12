library(rmarkdown)
library(ggplot2)
library(cluster)
library(knitr)

MaddenAllPlayers = read.csv("All_Player_Import.csv")
MaddenRBs = MaddenAllPlayers[which(MaddenAllPlayers$Position == "HB"),]
RBAttributes = c(6:13, 21, 23, 25:33, 42:44)
RBOriginal = MaddenRBs[RBAttributes]
rownames(RBOriginal) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))

means = c()
sds = c()
RBzscores = matrix(0, nrow = length(RBOriginal[,1]), ncol = length(RBOriginal))
for (i in 1:length(RBOriginal)) {
  means = append(means, mean(RBOriginal[,i]))
  sds = append(sds, sd(RBOriginal[,i])*sqrt((length(RBOriginal[,i])-1)/(length(RBOriginal[,i]))))
  for (j in 1:length(RBOriginal[,i])) {
    RBzscores[j,i] = (RBOriginal[j,i]-means[i])/sds[i]
  }
}
RBzscores = data.frame(RBzscores)
rownames(RBzscores) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))
colnames(RBzscores) = colnames(RBOriginal)

RBNormzscores = RBzscores[,-1]
rowadjz = length(RBNormzscores[1,])
for (i in 1:length(RBNormzscores)) {
  for (j in 1:length(RBNormzscores[,1])) {
    RBNormzscores[j, i] = RBzscores[j, i+1]-(sum(RBzscores[j,])/rowadjz)
  }
}
RBNormzscores = data.frame(RBNormzscores)
rownames(RBNormzscores) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))
colnames(RBNormzscores) = colnames(RBzscores[,-1])

rbover = RBzscores[,1]

rbfitFull <- lm(rbover ~ RBzscores[,2] + RBzscores[,3] + RBzscores[,4] + RBzscores[,5] + RBzscores[,6] + RBzscores[,7] + RBzscores[,8] + RBzscores[,9] + RBzscores[,10] + RBzscores[,11] + RBzscores[,12] + RBzscores[,13] + RBzscores[,14] + RBzscores[,15] + RBzscores[,16] + RBzscores[,17] + RBzscores[,18] + RBzscores[,19] + RBzscores[,20] + RBzscores[,21] + RBzscores[,22], data = RBzscores)
summary(rbfitFull)

RBReduced = RBzscores[,c(1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 22)]
rbfitReduced <- lm(rbover ~ RBReduced[,2] + RBReduced[,3] + RBReduced[,4] + RBReduced[,5] + RBReduced[,6] + RBReduced[,7] + RBReduced[,8] + RBReduced[,9] + RBReduced[,10] + RBReduced[,11] + RBReduced[,12] + RBReduced[,13] + RBReduced[,14] + RBReduced[,15], data = RBReduced)
summary(rbfitReduced)

RBNormReduced = RBNormzscores[,c(1, 2, 3, 4, 5, 6, 7, 13, 14, 15, 16, 17, 18, 21)]
RBNormReducedtemp = RBNormReduced
rowadjreduced = length(RBNormReduced[1,])
for (i in 1:length(RBNormReduced)) {
  for (j in 1:length(RBNormzscores[,1])) {
    RBNormReduced[j, i] = RBNormReducedtemp[j, i]-(sum(RBNormReducedtemp[j,])/rowadjreduced)
  }
}

covarReduced = cov(RBReduced[,-1])

covarFull = cov(RBOriginal[,-1])

set.seed(1)
clustersReduced = kmeans(covarReduced, 3)
clusplot(covarReduced, clustersReduced$cluster, lines=0, labels=2, cex=0.75)

# Cluster 1 - Speed Running
# Cluster 2 - Awareness and Receiving
# Cluster 3 - Power Running

set.seed(1)
clustersFull = kmeans(covarFull, 5)
clusplot(covarFull, clustersFull$cluster, lines=0, labels=2, cex=0.75)


# Cluster 1 - Pass Catching
# Cluster 2 - Power Running
# Cluster 3 - Awareness
# Cluster 4 - Speed Running
# Cluster 5 - Shiftiness

PassCatchingGroup = c(20:22)
PowerRunningGroup = c(14, 17)
AwarenessGroup = c(4, 6, 8, 9, 13)
SpeedRunningGroup = c(2, 3, 5, 10, 11, 12, 16, 18)
ShiftinessGroup = c(15, 19)

PassCatchingGroupWeights = c(0, 1.084, 3.745)
PowerRunningGroupWeights = c(33.72, 7.405)
AwarenessGroupWeights = c(5.199, 41.47, 20.41, 0.4197, 0)
SpeedRunningGroupWeights = c(11.12, 4.818, 12.51, 0, 0, 0, 20.69, 6.711)
ShiftinessGroupWeights = c(26.05, 8.637)

OVR = c()
PassCatchingScores = c()
PowerRunningScores = c()
AwarenessScores = c()
SpeedRunningScores = c()
ShiftinessScores = c()

RBCluster = matrix(0, nrow = length(RBOriginal[,1]), ncol = 6)

for (i in 1: length(RBzscores[,1])) {
  OVR = append(OVR, RBzscores[i, 1])
  PassCatchingScores = append(PassCatchingScores, sum(RBzscores[i, PassCatchingGroup]*PassCatchingGroupWeights)/sum(PassCatchingGroupWeights))
  PowerRunningScores = append(PowerRunningScores, sum(RBzscores[i, PowerRunningGroup]*PowerRunningGroupWeights)/sum(PowerRunningGroupWeights))
  AwarenessScores = append(AwarenessScores, sum(RBzscores[i, AwarenessGroup]*AwarenessGroupWeights)/sum(AwarenessGroupWeights))
  SpeedRunningScores = append(SpeedRunningScores, sum(RBzscores[i, SpeedRunningGroup]*SpeedRunningGroupWeights)/sum(SpeedRunningGroupWeights))
  ShiftinessScores = append(ShiftinessScores, sum(RBzscores[i, ShiftinessGroup]*ShiftinessGroupWeights)/sum(ShiftinessGroupWeights))
  RBCluster[i, 1] = OVR[i]
  RBCluster[i, 2] = PassCatchingScores[i]
  RBCluster[i, 3] = PowerRunningScores[i]
  RBCluster[i, 4] = AwarenessScores[i]
  RBCluster[i, 5] = SpeedRunningScores[i]
  RBCluster[i, 6] = ShiftinessScores[i]
}
RBCluster = data.frame(RBCluster)
rownames(RBCluster) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))
colnames(RBCluster) = c("Overall", "Pass Catching", "Power Running", "Awareness", "Speed Running", "Shiftiness")

RBClusternoOverall = RBCluster[,-1]

PassCatchingNormGroup = PassCatchingGroup-1
PowerRunningNormGroup = PowerRunningGroup-1
AwarenessNormGroup = AwarenessGroup-1
SpeedRunningNormGroup = SpeedRunningGroup-1
ShiftinessNormGroup = ShiftinessGroup-1

PassCatchingNormGroupWeights = c(0, 1.084, 3.745)
PowerRunningNormGroupWeights = c(33.72, 7.405)
AwarenessNormGroupWeights = c(5.199, 41.47, 20.41, 0.4197, 0)
SpeedRunningNormGroupWeights = c(11.12, 4.818, 12.51, 0, 0, 0, 20.69, 6.711)
ShiftinessNormGroupWeights = c(26.05, 8.637)

PassCatchingNormScores = c()
PowerRunningNormScores = c()
AwarenessNormScores = c()
SpeedRunningNormScores = c()
ShiftinessNormScores = c()

RBNormCluster = matrix(0, nrow = length(RBOriginal[,1]), ncol = 5)
RBNormClustertemp = RBNormCluster

for (i in 1: length(RBNormzscores[,1])) {
  PassCatchingNormScores = append(PassCatchingNormScores, sum(RBNormzscores[i, PassCatchingNormGroup]*PassCatchingNormGroupWeights)/sum(PassCatchingNormGroupWeights))
  PowerRunningNormScores = append(PowerRunningNormScores, sum(RBNormzscores[i, PowerRunningNormGroup]*PowerRunningNormGroupWeights)/sum(PowerRunningNormGroupWeights))
  AwarenessNormScores = append(AwarenessNormScores, sum(RBNormzscores[i, AwarenessNormGroup]*AwarenessNormGroupWeights)/sum(AwarenessNormGroupWeights))
  SpeedRunningNormScores = append(SpeedRunningNormScores, sum(RBNormzscores[i, SpeedRunningNormGroup]*SpeedRunningNormGroupWeights)/sum(SpeedRunningNormGroupWeights))
  ShiftinessNormScores = append(ShiftinessNormScores, sum(RBNormzscores[i, ShiftinessNormGroup]*ShiftinessNormGroupWeights)/sum(ShiftinessNormGroupWeights))
  RBNormClustertemp[i, 1] = PassCatchingNormScores[i]
  RBNormClustertemp[i, 2] = PowerRunningNormScores[i]
  RBNormClustertemp[i, 3] = AwarenessNormScores[i]
  RBNormClustertemp[i, 4] = SpeedRunningNormScores[i]
  RBNormClustertemp[i, 5] = ShiftinessNormScores[i]
}

RBNormClustertemp = data.frame(RBNormClustertemp)

rowadjcluster = length(RBNormCluster[1,])
for (i in 1:length(RBNormClustertemp)) {
  for (j in 1:length(RBNormClustertemp[,1])) {
    RBNormCluster[j, i] = RBNormClustertemp[j, i]-(sum(RBNormClustertemp[j,])/rowadjcluster)
  }
}

RBNormCluster = data.frame(RBNormCluster)
rownames(RBNormCluster) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))
colnames(RBNormCluster) = c("Pass Catching", "Power Running", "Awareness", "Speed Running", "Shiftiness")


# Cluster 1 - Speed Running
# Cluster 2 - Awareness and Receiving
# Cluster 3 - Power Running

SpeedRunningGroupReduced = c(2, 3, 5, 10, 14) 
AwarenessAndReceivingGroupReduced = c(6, 7, 11, 13, 15)
PowerRunningGroupReduced = c(4, 8, 9, 12)
SpeedRunningWeightsReduced = c(11.25, 4.941, 11.98, 26.16, 8.773)
AwarenessAndReceivingWeightsReduced = c(41.24, 4.510, 20.41, 6.543, 3.868)
PowerRunningWeightsReduced = c(5.117, 20.51, 33.78, 7.580)

OVRReduced = c()
SpeedRunningScoresReduced = c()
AwarenessAndReceivingScoresReduced = c()
PowerRunningScoresReduced = c()

RBClusterReduced = matrix(0, nrow = length(RBOriginal[,1]), ncol = 4)

for (i in 1: length(RBReduced[,1])) {
  OVRReduced = append(OVRReduced, RBReduced[i, 1])
  SpeedRunningScoresReduced = append(SpeedRunningScoresReduced, sum(RBReduced[i, SpeedRunningGroupReduced]*SpeedRunningWeightsReduced)/sum(SpeedRunningWeightsReduced))
  AwarenessAndReceivingScoresReduced = append(AwarenessAndReceivingScoresReduced, sum(RBReduced[i, AwarenessAndReceivingGroupReduced]*AwarenessAndReceivingWeightsReduced)/sum(AwarenessAndReceivingWeightsReduced))
  PowerRunningScoresReduced = append(PowerRunningScoresReduced, sum(RBReduced[i, PowerRunningGroupReduced]*PowerRunningWeightsReduced )/sum(PowerRunningWeightsReduced))
  RBClusterReduced[i, 1] = OVRReduced[i]
  RBClusterReduced[i, 2] = SpeedRunningScoresReduced[i]
  RBClusterReduced[i, 3] = AwarenessAndReceivingScoresReduced[i]
  RBClusterReduced[i, 4] = PowerRunningScoresReduced[i]
}
RBClusterReduced = data.frame(RBClusterReduced)
rownames(RBClusterReduced) = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " "))
colnames(RBClusterReduced) = c("Overall", "Speed Running", "Awareness and Receiving", "Power Running")
RBClusternoOverallReduced = RBClusterReduced[,-1]

SpeedRunningNormGroupReduced = SpeedRunningGroupReduced-1
AwarenessAndReceivingNormGroupReduced = AwarenessAndReceivingGroupReduced-1
PowerRunningNormGroupReduced = PowerRunningGroupReduced-1
SpeedRunningNormWeightsReduced = c(11.25, 4.941, 11.98, 26.16, 8.773)
AwarenessAndReceivingNormWeightsReduced = c(41.24, 4.510, 20.41, 6.543, 3.868)
PowerRunningNormWeightsReduced = c(5.117, 20.51, 33.78, 7.580)

SpeedRunningNormScoresReduced = c()
AwarenessAndReceivingNormScoresReduced = c()
PowerRunningNormScoresReduced = c()


RBNormClusterReduced = matrix(0, nrow = length(RBNormReduced[,1]), ncol = 3)
RBNormClusterReducedtemp = RBNormClusterReduced
for (i in 1: length(RBNormReduced[,1])) {
  SpeedRunningNormScoresReduced = append(SpeedRunningNormScoresReduced, sum(RBNormReduced[i, SpeedRunningNormGroupReduced]*SpeedRunningNormWeightsReduced)/sum(SpeedRunningNormWeightsReduced))
  AwarenessAndReceivingNormScoresReduced = append(AwarenessAndReceivingNormScoresReduced, sum(RBNormReduced[i, AwarenessAndReceivingNormGroupReduced]*AwarenessAndReceivingNormWeightsReduced)/sum(AwarenessAndReceivingNormWeightsReduced))
  PowerRunningNormScoresReduced = append(PowerRunningNormScoresReduced, sum(RBNormReduced[i, PowerRunningNormGroupReduced]*PowerRunningNormWeightsReduced )/sum(PowerRunningNormWeightsReduced))
  RBNormClusterReducedtemp[i, 1] = SpeedRunningNormScoresReduced[i]
  RBNormClusterReducedtemp[i, 2] = AwarenessAndReceivingNormScoresReduced[i]
  RBNormClusterReducedtemp[i, 3] = PowerRunningNormScoresReduced[i]
}

RBNormClusterReducedtemp = data.frame(RBNormClusterReducedtemp)

rowadjclusterReduced = length(RBNormClusterReduced[1,])
for (i in 1:length(RBNormClusterReducedtemp)) {
  for (j in 1:length(RBNormClusterReducedtemp[,1])) {
    RBNormClusterReduced[j, i] = RBNormClusterReducedtemp[j, i]-(sum(RBNormClusterReducedtemp[j,])/rowadjclusterReduced)
  }
}

RBNormClusterReduced = data.frame(RBNormClusterReduced, row.names = do.call(paste, c(MaddenRBs[c("First.Name", "Last.Name")], sep = " ")))
colnames(RBNormClusterReduced) = c("Speed Running", "Awareness and Receiving", "Power Running")

nclusters = 5

set.seed(1)
RBkz = kmeans(RBzscores, nclusters)
set.seed(1)
RBNormkz = kmeans(RBNormzscores, nclusters)
set.seed(1)
RBkreduced = kmeans(RBReduced, nclusters)
set.seed(1)
RBNormkreduced = kmeans(RBNormReduced, nclusters)
set.seed(1)
RBkcluster = kmeans(RBCluster, nclusters)
set.seed(1)
RBNormkcluster = kmeans(RBNormCluster, nclusters)
set.seed(1)
RBkclusterReduced = kmeans(RBClusterReduced, nclusters)
set.seed(1)
RBNormkclusterReduced = kmeans(RBNormClusterReduced, nclusters)


clusplot(RBzscores, RBkz$cluster, lines=0, labels=2, cex=0.75)
RBkz$centers
clusplot(RBNormzscores, RBNormkz$cluster, lines=0, labels=2, cex=0.75)
RBNormkz$centers
clusplot(RBReduced, RBkreduced$cluster, lines=0, labels=2, cex=0.75)
RBkreduced$centers
clusplot(RBNormReduced, RBNormkreduced$cluster, lines=0, labels=2, cex=0.75)
RBNormkreduced$centers
clusplot(RBCluster, RBkcluster$cluster, lines=0, labels=2, cex=0.75)
RBkcluster$centers
clusplot(RBNormCluster, RBNormkcluster$cluster, lines=0, labels=2, cex=0.75)
RBNormkcluster$centers
clusplot(RBClusterReduced, RBkclusterReduced$cluster, lines=0, labels=2, cex=0.75)
RBkclusterReduced$centers
clusplot(RBNormClusterReduced, RBNormkclusterReduced$cluster, lines=0, labels=2, cex=0.75)
RBNormkclusterReduced$centers

# Unreduced
# 1: Pure Speed Back: very shifty, good speed, no catching or power
# 2: Backfield Receiver: Good catching, no power, good speed and shiftiness
# 3: Balanced RB: close to 0 on most
# 4: Goal Line Back: Good power and catching, no speed
# 5: Power Running Back: Great Power, no catching, average speed
# Reduced
# 1: Balanced RB
# 2: Backfield Receiver
# 3: Pure Speed Back
# 4: Power Running Back
# 5: Goal Line Back


RBNormCluster
RBNormClusterReduced
RBNormkclusterReduced
RBNormkclusterReduced

unreducedRBfit <- lm(RBCluster[,1] ~ RBCluster[,2] + RBCluster[,3] + RBCluster[,4] + RBCluster[,5] + RBCluster[,6], data = RBCluster)
summary(unreducedRBfit)
reducedRBfit <- lm(RBClusterReduced[,1] ~ RBClusterReduced[,2] + RBClusterReduced[,3] + RBClusterReduced[,4], data = RBClusterReduced)
summary(reducedRBfit)

normalizetolength = function(v, l = 1) {
  newvector = v
  sum = sum(v)
  for (i in 1:length(v)) {
    newvector[i] = l*v[i]/sum
  }
  return(newvector)
}

normalizealldataframe = function(frame, l = 1) {
  newframe = frame
  for (i in 1:length(frame[,1])) {
    tempsum = sum(newframe[i,])
    newframe[i,] = l*frame[i,]/tempsum
  }
  newframe
}

standardreducedweights = c(63.11, 76.57, 66.99)
standardreducedweights = standardreducedweights/sum(standardreducedweights)

standardunreducedweights = c(7.371, 40.89, 67.02, 55.64, 35.09)
standardunreducedweights = standardunreducedweights/sum(standardunreducedweights)

clusterreducedweights = normalizealldataframe(pnorm(RBNormkclusterReduced$centers))
clusterunreducedweights = normalizealldataframe(pnorm(RBNormkcluster$centers))

adjustedreducedweights = clusterreducedweights
adjustedunreducedweights = clusterunreducedweights

for(i in 1:5) {
  adjustedreducedweights[i,] = normalizetolength(standardreducedweights+clusterreducedweights[i,])
  adjustedunreducedweights[i,] = normalizetolength(standardunreducedweights+clusterunreducedweights[i,])
}

RBTotalScoresReduced = RBClusternoOverallReduced
RBTotalScoresUnreduced = RBClusternoOverall

for (i in 1:length(RBOriginal[,1])) {
  for (j in 1:5) {
    RBTotalScoresReduced[i, j] = 100*pnorm(sum(RBClusternoOverallReduced[i,]*adjustedreducedweights[j,]))
  }
}

for (i in 1:length(RBOriginal[,1])) {
  for (j in 1:5) {
    RBTotalScoresUnreduced[i, j] = 100*pnorm(sum(RBClusternoOverall[i,]*adjustedunreducedweights[j,]))
  }
}

RBNormkclusterReduced$centers
RBNormkcluster$centers

# Unreduced
# 1: Pure Speed Back: very shifty, good speed, no catching or power
# 2: Backfield Receiver: Good catching, no power, good speed and shiftiness
# 3: Balanced RB: close to 0 on most
# 4: Goal Line Back: Good power and catching, no speed
# 5: Power Running Back: Great Power, no catching, average speed
# Reduced
# 1: Balanced RB
# 2: Backfield Receiver
# 3: Pure Speed Back
# 4: Power Running Back
# 5: Goal Line Back

colnames(RBTotalScoresUneduced) = c("Pure Speed Back", "Backfield Receiver", "Balanced RB", "Goal Line Back", "Power Running Back")
colnames(RBTotalScoresReduced) = c("Balanced RB", "Backfield Receiver", "Pure Speed Back", "Power Running Back", "Goal Line Back")

RBTotalScoresReduced
RBTotalScoresUnreduced

RBTotalScoresReducedwithOVR = RBTotalScoresReduced
RBTotalScoresUnreducedwithOVR = RBTotalScoresUnreduced

RBTotalScoresReducedwithOVR[,6] = RBOriginal[,1]
RBTotalScoresUnreducedwithOVR[,6] = RBOriginal[,1]

RBTotalScoresReducedwithOVR
RBTotalScoresUnreducedwithOVR