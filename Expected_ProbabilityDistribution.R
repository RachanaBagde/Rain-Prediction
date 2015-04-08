
 
 submit <-function(test)
 {
 mat <- matrix(0,nrow=nrow(test),ncol=72)
 colnames(mat)<-c("Id","Expected","Predicted0","Predicted1","Predicted2","Predicted3","Predicted4","Predicted5","Predicted6","Predicted7","Predicted8","Predicted9","Predicted10","Predicted11","Predicted12","Predicted13","Predicted14","Predicted15","Predicted16","Predicted17","Predicted18","Predicted19","Predicted20","Predicted21","Predicted22","Predicted23","Predicted24","Predicted25","Predicted26","Predicted27","Predicted28","Predicted29","Predicted30","Predicted31","Predicted32","Predicted33","Predicted34","Predicted35","Predicted36","Predicted37","Predicted38","Predicted39","Predicted40","Predicted41","Predicted42","Predicted43","Predicted44","Predicted45","Predicted46","Predicted47","Predicted48","Predicted49","Predicted50","Predicted51","Predicted52","Predicted53","Predicted54","Predicted55","Predicted56","Predicted57","Predicted58","Predicted59","Predicted60","Predicted61","Predicted62","Predicted63","Predicted64","Predicted65","Predicted66","Predicted67","Predicted68","Predicted69")
 mat$Id<-test$Id
 
 test$Expected <- round(test$Expected)
 test$Expected[test$Expected<0]<-0
 
 mat$Expected<-test$Expected
 mat$Predicted0[mat$Expected==0]<-1
 mat$Predicted1[mat$Expected==1]<-1
 mat$Predicted2[mat$Expected==2]<-1
 mat$Predicted3[mat$Expected==3]<-1
 mat$Predicted4[mat$Expected==4]<-1
 mat$Predicted5[mat$Expected==5]<-1
 mat$Predicted6[mat$Expected==6]<-1
 mat$Predicted7[mat$Expected==7]<-1
 mat$Predicted8[mat$Expected==8]<-1
 mat$Predicted9[mat$Expected==9]<-1
 mat$Predicted10[mat$Expected==10]<-1
 mat$Predicted11[mat$Expected==11]<-1
 mat$Predicted12[mat$Expected==12]<-1
 mat$Predicted13[mat$Expected==13]<-1
 mat$Predicted14[mat$Expected==14]<-1
 mat$Predicted15[mat$Expected==15]<-1
 mat$Predicted16[mat$Expected==16]<-1
 mat$Predicted17[mat$Expected==17]<-1
 mat$Predicted18[mat$Expected==18]<-1
 mat$Predicted19[mat$Expected==19]<-1
 mat$Predicted20[mat$Expected==20]<-1
 mat$Predicted21[mat$Expected==21]<-1
 mat$Predicted22[mat$Expected==22]<-1
 mat$Predicted23[mat$Expected==23]<-1
 mat$Predicted24[mat$Expected==24]<-1
 mat$Predicted25[mat$Expected==25]<-1
 mat$Predicted26[mat$Expected==26]<-1
 mat$Predicted27[mat$Expected==27]<-1
 mat$Predicted28[mat$Expected==28]<-1
 mat$Predicted29[mat$Expected==29]<-1
 mat$Predicted30[mat$Expected==30]<-1
 mat$Predicted31[mat$Expected==31]<-1
 mat$Predicted32[mat$Expected==32]<-1
 mat$Predicted33[mat$Expected==33]<-1
 mat$Predicted34[mat$Expected==34]<-1
 mat$Predicted35[mat$Expected==35]<-1
 mat$Predicted36[mat$Expected==36]<-1
 mat$Predicted37[mat$Expected==37]<-1
 mat$Predicted38[mat$Expected==38]<-1
 mat$Predicted39[mat$Expected==39]<-1
 mat$Predicted40[mat$Expected==40]<-1
 mat$Predicted41[mat$Expected==41]<-1
 mat$Predicted42[mat$Expected==42]<-1
 mat$Predicted43[mat$Expected==43]<-1
 mat$Predicted44[mat$Expected==44]<-1
 mat$Predicted45[mat$Expected==45]<-1
 mat$Predicted46[mat$Expected==46]<-1
 mat$Predicted47[mat$Expected==47]<-1
 mat$Predicted48[mat$Expected==48]<-1
 mat$Predicted49[mat$Expected==49]<-1
 mat$Predicted50[mat$Expected==50]<-1
 mat$Predicted51[mat$Expected==51]<-1
 mat$Predicted52[mat$Expected==52]<-1
 mat$Predicted53[mat$Expected==53]<-1
 mat$Predicted54[mat$Expected==54]<-1
 mat$Predicted55[mat$Expected==55]<-1
 mat$Predicted56[mat$Expected==56]<-1
 mat$Predicted57[mat$Expected==57]<-1
 mat$Predicted58[mat$Expected==58]<-1
 mat$Predicted59[mat$Expected==59]<-1
 mat$Predicted60[mat$Expected==60]<-1
 mat$Predicted61[mat$Expected==61]<-1
 mat$Predicted62[mat$Expected==62]<-1
 mat$Predicted63[mat$Expected==63]<-1
 mat$Predicted64[mat$Expected==64]<-1
 mat$Predicted65[mat$Expected==65]<-1
 mat$Predicted66[mat$Expected==66]<-1
 mat$Predicted67[mat$Expected==67]<-1
 mat$Predicted68[mat$Expected==68]<-1
 mat$Predicted69[mat$Expected>69]<-1


 mat_l <- summarise(group_by(mat,Id),length=length(Id))

 mat <- mat %>% group_by(Id) %>% summarise_each(funs(sum))
 
 mat$length <- mat_l$length
 mat_f <- mat
 mat_f <- mat_f[-c(1,ncol(df))]/mat_f$length
 mat_f$Expected <- NULL
 mat_f$length <- NULL

 mat_f <-with(mat_f, cbind(Id, mat_f[!names(mat_f) %in% c("Id", "length")]/length, length))
 
 mat_f$Expected <-NULL
 mat_f$length <-NULL
 return(mat_f)
 }
 
 test<-fread("test_predicted_1.csv")
 mat_f <-submit(test)
 write.csv(data.frame(mat_f),file="Submission_1.csv",row.names=FALSE)
