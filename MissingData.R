
#Replace all -99900 in Composite with -14.     
     
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
    
    


