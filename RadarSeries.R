 
 
 dt = data.table(split)
 setkey(dt,Id)
 
 # find everytime new radar set starts, using time inversion or radar distance change
 # as indicator of radar changes
 dt[,TimeToEndInversion:=c(1,(sign(diff(TimeToEnd))+1)/2),by=Id]
 dt[,NewDistanceToRadar:=c(1,abs(sign(diff(DistanceToRadar)))),by=Id]
 dt[,NewRadarIndicator:=TimeToEndInversion | NewDistanceToRadar]
 
 # Now just cummulative sum of previous rows in group to incrementally number the radars
 train <- dt[,RadarSeries := cumsum(NewRadarIndicator),by=Id]
 
 dt_test <- data.table(split_test)
 setkey(dt_test,Id)
 
 dt_test[,TimeToEndInversion:=c(1,(sign(diff(TimeToEnd))+1)/2),by=Id]
 dt_test[,NewDistanceToRadar:=c(1,abs(sign(diff(DistanceToRadar)))),by=Id]
 dt_test[,NewRadarIndicator:=TimeToEndInversion | NewDistanceToRadar]
 
 test <- dt_test[,RadarSeries := cumsum(NewRadarIndicator),by=Id]

#The line below finds all the times where the time to end of observations increases from the prior reading and adds
#a column TimeToEndInversion where 0 equals no increase in time and 1 when the time increases.
#This is one of the indicators that the next set of observations is from a different radar station. 

#dt[,TimeToEndInversion:=c(1,(sign(diff(TimeToEnd))+1)/2),by=Id]

#The line above works almost all the time, but sometimes there is no time to end inversion and the only indication we get 
#is that the radar distance changes.  This next line finds all of those times and indicates it with a one.

#dt[,NewDistanceToRadar:=c(1,abs(sign(diff(DistanceToRadar)))),by=Id]

#Finally, both of the two indicators work almost all the time to indicate that the next sequence of observations are from 
#a new radar.  But since neither work all the time, they are combined with an OR to catch (hopefully) all the time that a 
#new radar sequence starts.

#dt[,NewRadarIndicator:=TimeToEndInversion | NewDistanceToRadar]
