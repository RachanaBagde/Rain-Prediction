library(reshape2)
library(splitstackshape)
library(data.table)

train<- fread("train_2013_2.csv")
sum<- function(x){


colsToSplit = colnames(x)[2:19]
split = cSplit(x,splitCols=colsToSplit,sep=" ",direction="long", fixed=FALSE, makeEqual = FALSE)

 dtf = data.table(split)
 setkey(dtf,Id)
 
 dtf[,TimeToEndInversion:=c(1,(sign(diff(TimeToEnd))+1)/2),by=Id]
 dtf[,NewDistanceToRadar:=c(1,abs(sign(diff(DistanceToRadar)))),by=Id]
 dtf[,NewRadarIndicator:=TimeToEndInversion | NewDistanceToRadar]
 
 dtf <- dtf[,RadarSeries := cumsum(NewRadarIndicator),by=Id]

 dtf <- dtf[,Mean:=mean(Reflectivity),by=c("Id","RadarSeries")]
 
 dtf$Composite[dtf$Composite==-99900] <- -14
    dtf$HybridScan[dtf$HybridScan==-99900] <- -14


    dtf$RR2[dtf$RR2==-99900]<-0
    dtf$RR3[dtf$RR3==-99900]<-0
    
    dtf$RadarQualityIndex[dtf$RadarQualityIndex==-99900]<-0.0005
    dtf$RadarQualityIndex[dtf$RadarQualityIndex==999]<-0.95

    # Remove ReflectivityQC column
    dtf$ReflectivityQC <- NULL
    # Other replacements...
    dtf$RhoHV[dtf$RhoHV== -99903]<-0.785
     
    dtf$Velocity[dtf$Velocity==-99901|dtf$Velocity==-99903] <--0.08643 
    dtf$Velocity[dtf$Velocity==-99900] <--35.0000
    
    dtf$Zdr[dtf$Zdr==-99900]<- -7.875
    dtf$Zdr[dtf$Zdr==-99903|dtf$Zdr==-99901]<- 1.334
    
    dtf$TimeToEndInversion <-NULL
    dtf$NewDistanceToRadar <-NULL
    dtf$NewRadarIndicator <- NULL
    
    library(dplyr)
    dtf %>% group_by(Id, RadarSeries, Mean) %>%
    summarise_each(funs(max))

    dtf %>% group_by(Id) %>%
    filter(Mean==max(Mean))
    
    model_x<-lm(Expected~Id+DistanceToRadar+Composite+HybridScan+HydrometeorType+RR1+RR3+RadarQualityIndex+RhoHV+RadarSeries+Mean,data=dtf)
    return(summary(model_x))




}
sum(train)
