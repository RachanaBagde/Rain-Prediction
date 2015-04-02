 
 
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

