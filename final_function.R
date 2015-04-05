library(reshape2)
library(splitstackshape)
library(data.table)


function(x){
x <- fread("train.csv")

colsToSplit = colnames(train)[2:19]
split = cSplit(train,splitCols=colsToSplit,sep=" ",direction="long", fixed=FALSE, makeEqual = FALSE)

 dt = data.table(split)
 setkey(dt,Id)
 
 dt[,TimeToEndInversion:=c(1,(sign(diff(TimeToEnd))+1)/2),by=Id]
 dt[,NewDistanceToRadar:=c(1,abs(sign(diff(DistanceToRadar)))),by=Id]
 dt[,NewRadarIndicator:=TimeToEndInversion | NewDistanceToRadar]
 
 train <- dt[,RadarSeries := cumsum(NewRadarIndicator),by=Id]

 train <- train[,Mean:=mean(Reflectivity),by=c("Id","RadarSeries")]
 
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
    
    model_x <-lm(Expected~.,data=x)
    summary(model_x)




}
