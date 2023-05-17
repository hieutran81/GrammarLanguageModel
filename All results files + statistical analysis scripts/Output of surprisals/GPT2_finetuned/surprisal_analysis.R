library(dplyr)
#finetuned on wh_island   Wilcox original material
wh_island_1 <- read.csv("on_wh_island/wh-island_surprisals1_102.csv")
wh_island_2 <- read.csv("on_wh_island/wh-island_surprisals2_102.csv")
wh_island <- rbind(wh_island_1,wh_island_2)
wh_island$item <- as.factor(rep(rep(1:22,times=c(3,3,3,3,2,6,3,2,4,6,4,4,4,3,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",288),rep("no",288))
wh_island$island <- rep(c(rep("that",144),rep("whether",144)),2)
wh_island$gap <- rep(c(rep("no",72),rep("yes",72)),4)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$island,wh_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
           SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
    SUM[i:(i+3),'SG'] <- 1
  }else{SUM[i:(i+3),'SG'] <- 0}
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{SUM[i:(i+3),'SG_1'] <- 0}
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{SUM[i:(i+3),'SG_2'] <- 0}
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #noisland
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #whether_island




#fine-tuned on wh_island, test=Wilcox wh-island  250
wh_island_1 <- read.csv("on_wh_island/wh-island_surprisals1_250.csv")
wh_island_2 <- read.csv("on_wh_island/wh-island_surprisals2_250.csv")
wh_island <- rbind(wh_island_1,wh_island_2)
wh_island$item <- as.factor(rep(rep(1:22,times=c(3,3,3,3,2,6,3,2,4,6,4,4,4,3,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",288),rep("no",288))
wh_island$island <- rep(c(rep("that",144),rep("whether",144)),2)
wh_island$gap <- rep(c(rep("no",72),rep("yes",72)),4)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$island,wh_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
           SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
    SUM[i:(i+3),'SG'] <- 1
  }else{SUM[i:(i+3),'SG'] <- 0}
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{SUM[i:(i+3),'SG_1'] <- 0}
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{SUM[i:(i+3),'SG_2'] <- 0}
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #noisland
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #whether_island




#fine-tuned on wh_island, test=Wilcox wh-island  250  epoch2
wh_island_1 <- read.csv("on_wh_island/wh-island_surprisals1_250_epoch2.csv")
wh_island_2 <- read.csv("on_wh_island/wh-island_surprisals2_250_epoch2.csv")
wh_island <- rbind(wh_island_1,wh_island_2)
wh_island$item <- as.factor(rep(rep(1:22,times=c(3,3,3,3,2,6,3,2,4,6,4,4,4,3,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",288),rep("no",288))
wh_island$island <- rep(c(rep("that",144),rep("whether",144)),2)
wh_island$gap <- rep(c(rep("no",72),rep("yes",72)),4)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$island,wh_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
           SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
    SUM[i:(i+3),'SG'] <- 1
  }else{SUM[i:(i+3),'SG'] <- 0}
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{SUM[i:(i+3),'SG_1'] <- 0}
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{SUM[i:(i+3),'SG_2'] <- 0}
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #noisland
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #whether_island





#fine-tuned on mix_construction, test=Wilcox wh-island
wh_island1 <- read.csv("on_mix_construction/wh-island_surprisals1_26.csv")
wh_island2 <- read.csv("on_mix_construction/wh-island_surprisals2_26.csv")
wh_island <- rbind(wh_island1,wh_island2)
wh_island$item <- as.factor(rep(rep(1:24,times=c(3,3,3,3,2,6,3,2,2,4,6,4,4,4,3,4,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",312),rep("no",312))
wh_island$gap <- rep(c(rep("no",78),rep("yes",78)),4)
wh_island$island <- rep(c(rep("that",156),rep("whether",156)),2)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$gap,wh_island$island),FUN=sum)
colnames(SUM) <- c("item","licenser","gap","island","sum_surprisals")
SUM <- arrange(SUM,item)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="that"){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,gap,island,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap",'island',"mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3])  #no_island
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7])  #whether_island



#fine-tuned on mix_construction, test=Wilcox wh-island
wh_island1 <- read.csv("on_mix_construction/wh-island_surprisals1_65.csv")
wh_island2 <- read.csv("on_mix_construction/wh-island_surprisals2_65.csv")
wh_island <- rbind(wh_island1,wh_island2)
wh_island$item <- as.factor(rep(rep(1:24,times=c(3,3,3,3,2,6,3,2,2,4,6,4,4,4,3,4,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",312),rep("no",312))
wh_island$gap <- rep(c(rep("no",78),rep("yes",78)),4)
wh_island$island <- rep(c(rep("that",156),rep("whether",156)),2)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$gap,wh_island$island),FUN=sum)
colnames(SUM) <- c("item","licenser","gap","island","sum_surprisals")
SUM <- arrange(SUM,item)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="that"){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,gap,island,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap",'island',"mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3])  #no_island
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7])  #whether_island




#fine-tuned on mix_construction, test=Wilcox wh-island epoch2
wh_island1 <- read.csv("on_mix_construction/wh-island_surprisals1_65_epoch2.csv")
wh_island2 <- read.csv("on_mix_construction/wh-island_surprisals2_65_epoch2.csv")
wh_island <- rbind(wh_island1,wh_island2)
wh_island$item <- as.factor(rep(rep(1:24,times=c(3,3,3,3,2,6,3,2,2,4,6,4,4,4,3,4,4,2,2,2,4,3,2,3)),8))
wh_island$licenser <- c(rep("yes",312),rep("no",312))
wh_island$gap <- rep(c(rep("no",78),rep("yes",78)),4)
wh_island$island <- rep(c(rep("that",156),rep("whether",156)),2)
SUM <- aggregate(wh_island$surprisals,by=list(wh_island$item,wh_island$licenser,wh_island$gap,wh_island$island),FUN=sum)
colnames(SUM) <- c("item","licenser","gap","island","sum_surprisals")
SUM <- arrange(SUM,item)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="that"){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

wh_island <- left_join(wh_island,SUM)

wh_island_summary <- distinct(wh_island,item,licenser,gap,island,sum_surprisals)
RESULTS <-aggregate(wh_island_summary$sum_surprisals,by=list(wh_island_summary$licenser,wh_island_summary$gap,wh_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap",'island',"mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3])  #no_island
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7])  #whether_island






#fine_tuned on adjunct island (adjunct island)
adjunct_island_1 <- read.csv("on_adjunct_island/adj-islands_surprisals1_102.csv")
adjunct_island_2 <- read.csv("on_adjunct_island/adj-islands_surprisals2_102.csv")
adjunct_island_3 <- read.csv("on_adjunct_island/adj-islands_surprisals3_102.csv")
adjunct_island_4 <- read.csv("on_adjunct_island/adj-islands_surprisals4_102.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening



#fine_tuned on adjunct island (adjunct island)
adjunct_island_1 <- read.csv("on_adjunct_island/adj-islands_surprisals1_250.csv")
adjunct_island_2 <- read.csv("on_adjunct_island/adj-islands_surprisals2_250.csv")
adjunct_island_3 <- read.csv("on_adjunct_island/adj-islands_surprisals3_250.csv")
adjunct_island_4 <- read.csv("on_adjunct_island/adj-islands_surprisals4_250.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening




#fine_tuned on adjunct island (adjunct island)  epoch2
adjunct_island_1 <- read.csv("on_adjunct_island/adj-islands_surprisals1_250_epoch2.csv")
adjunct_island_2 <- read.csv("on_adjunct_island/adj-islands_surprisals2_250_epoch2.csv")
adjunct_island_3 <- read.csv("on_adjunct_island/adj-islands_surprisals3_250_epoch2.csv")
adjunct_island_4 <- read.csv("on_adjunct_island/adj-islands_surprisals4_250_epoch2.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening










#fine_tuned on mix_construction (adjunct island)
adjunct_island_1 <- read.csv("on_mix_construction/adj-islands_surprisals1_26.csv")
adjunct_island_2 <- read.csv("on_mix_construction/adj-islands_surprisals2_26.csv")
adjunct_island_3 <- read.csv("on_mix_construction/adj-islands_surprisals3_26.csv")
adjunct_island_4 <- read.csv("on_mix_construction/adj-islands_surprisals4_26.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening





#fine_tuned on mix_construction (adjunct island)
adjunct_island_1 <- read.csv("on_mix_construction/adj-islands_surprisals1_65.csv")
adjunct_island_2 <- read.csv("on_mix_construction/adj-islands_surprisals2_65.csv")
adjunct_island_3 <- read.csv("on_mix_construction/adj-islands_surprisals3_65.csv")
adjunct_island_4 <- read.csv("on_mix_construction/adj-islands_surprisals4_65.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening






#fine_tuned on mix_construction (adjunct island)
adjunct_island_1 <- read.csv("on_mix_construction/adj-islands_surprisals1_65_epoch2.csv")
adjunct_island_2 <- read.csv("on_mix_construction/adj-islands_surprisals2_65_epoch2.csv")
adjunct_island_3 <- read.csv("on_mix_construction/adj-islands_surprisals3_65_epoch2.csv")
adjunct_island_4 <- read.csv("on_mix_construction/adj-islands_surprisals4_65_epoch2.csv")
adjunct_island <- rbind(adjunct_island_1,adjunct_island_2,adjunct_island_3,adjunct_island_4)
adjunct_island$item <- as.factor(rep(rep(1:20,times=c(3,3,3,3,4,3,3,4,4,2,3,3,3,5,4,4,3,4,3,2)),16))
adjunct_island$licenser <- c(rep("yes",528),rep("no",528))
adjunct_island$island <- rep(c(rep("modifier",132),rep("adjunct_back",132),rep("intervening_adj",132),rep("nonintervening_adj",132)),2)
adjunct_island$gap <- rep(c(rep("no",66),rep("yes",66)),8)
SUM <- aggregate(adjunct_island$surprisals,by=list(adjunct_island$item,adjunct_island$licenser,adjunct_island$island,adjunct_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']=="adjunct_back"){
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{
      SUM[i:(i+3),'SG_1'] <- 0
    }
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{
      SUM[i:(i+3),'SG_2'] <- 0
    }
  }
  else{
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
  }
  if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_1'] <- 1
  }else{
    SUM[i:(i+3),'SG_1'] <- 0
  }
  if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
    SUM[i:(i+3),'SG_2'] <- 1
  }else{
    SUM[i:(i+3),'SG_2'] <- 0
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))
adjunct_island <- left_join(adjunct_island,SUM)


adjunct_island_summary <- distinct(adjunct_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(adjunct_island_summary$sum_surprisals,by=list(adjunct_island_summary$licenser,adjunct_island_summary$gap,adjunct_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #intervening_adjunct
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #nonintervening








#fine-tuned on complexNP, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("on_complexNP_island/complexNP-island_surprisals1_102.csv")
complexNP_island_2 <- read.csv("on_complexNP_island/complexNP-island_surprisals2_102.csv")
complexNP_island_3 <- read.csv("on_complexNP_island/complexNP-island_surprisals3_102.csv")
complexNP_island_4 <- read.csv("on_complexNP_island/complexNP-island_surprisals4_102.csv")
complexNP_island_5 <- read.csv("on_complexNP_island/complexNP-island_surprisals5_102.csv")
complexNP_island_6 <- read.csv("on_complexNP_island/complexNP-island_surprisals6_102.csv")
complexNP_island_7 <- read.csv("on_complexNP_island/complexNP-island_surprisals7_102.csv")
complexNP_island_8 <- read.csv("on_complexNP_island/complexNP-island_surprisals8_102.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])


#fine-tuned on complexNP, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("on_complexNP_island/complexNP-island_surprisals1_250.csv")
complexNP_island_2 <- read.csv("on_complexNP_island/complexNP-island_surprisals2_250.csv")
complexNP_island_3 <- read.csv("on_complexNP_island/complexNP-island_surprisals3_250.csv")
complexNP_island_4 <- read.csv("on_complexNP_island/complexNP-island_surprisals4_250.csv")
complexNP_island_5 <- read.csv("on_complexNP_island/complexNP-island_surprisals5_250.csv")
complexNP_island_6 <- read.csv("on_complexNP_island/complexNP-island_surprisals6_250.csv")
complexNP_island_7 <- read.csv("on_complexNP_island/complexNP-island_surprisals7_250.csv")
complexNP_island_8 <- read.csv("on_complexNP_island/complexNP-island_surprisals8_250.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])






#fine-tuned on complexNP, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("on_complexNP_island/complexNP-island_surprisals1_250_epoch2.csv")
complexNP_island_2 <- read.csv("on_complexNP_island/complexNP-island_surprisals2_250_epoch2.csv")
complexNP_island_3 <- read.csv("on_complexNP_island/complexNP-island_surprisals3_250_epoch2.csv")
complexNP_island_4 <- read.csv("on_complexNP_island/complexNP-island_surprisals4_250_epoch2.csv")
complexNP_island_5 <- read.csv("on_complexNP_island/complexNP-island_surprisals5_250_epoch2.csv")
complexNP_island_6 <- read.csv("on_complexNP_island/complexNP-island_surprisals6_250_epoch2.csv")
complexNP_island_7 <- read.csv("on_complexNP_island/complexNP-island_surprisals7_250_epoch2.csv")
complexNP_island_8 <- read.csv("on_complexNP_island/complexNP-island_surprisals8_250_epoch2.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])








#fine-tuned on mix_construction, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("on_mix_construction/complexNP-island_surprisals1_26.csv")
complexNP_island_2 <- read.csv("on_mix_construction/complexNP-island_surprisals2_26.csv")
complexNP_island_3 <- read.csv("on_mix_construction/complexNP-island_surprisals3_26.csv")
complexNP_island_4 <- read.csv("on_mix_construction/complexNP-island_surprisals4_26.csv")
complexNP_island_5 <- read.csv("on_mix_construction/complexNP-island_surprisals5_26.csv")
complexNP_island_6 <- read.csv("on_mix_construction/complexNP-island_surprisals6_26.csv")
complexNP_island_7 <- read.csv("on_mix_construction/complexNP-island_surprisals7_26.csv")
complexNP_island_8 <- read.csv("on_mix_construction/complexNP-island_surprisals8_26.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])









#fine-tuned on mix_construction, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("on_mix_construction/complexNP-island_surprisals1_65.csv")
complexNP_island_2 <- read.csv("on_mix_construction/complexNP-island_surprisals2_65.csv")
complexNP_island_3 <- read.csv("on_mix_construction/complexNP-island_surprisals3_65.csv")
complexNP_island_4 <- read.csv("on_mix_construction/complexNP-island_surprisals4_65.csv")
complexNP_island_5 <- read.csv("on_mix_construction/complexNP-island_surprisals5_65.csv")
complexNP_island_6 <- read.csv("on_mix_construction/complexNP-island_surprisals6_65.csv")
complexNP_island_7 <- read.csv("on_mix_construction/complexNP-island_surprisals7_65.csv")
complexNP_island_8 <- read.csv("on_mix_construction/complexNP-island_surprisals8_65.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])




#fine-tuned on mix_construction, test=original Wilcox material (complexNP) epoch2
complexNP_island_1 <- read.csv("on_mix_construction/complexNP-island_surprisals1_65_epoch2.csv")
complexNP_island_2 <- read.csv("on_mix_construction/complexNP-island_surprisals2_65_epoch2.csv")
complexNP_island_3 <- read.csv("on_mix_construction/complexNP-island_surprisals3_65_epoch2.csv")
complexNP_island_4 <- read.csv("on_mix_construction/complexNP-island_surprisals4_65_epoch2.csv")
complexNP_island_5 <- read.csv("on_mix_construction/complexNP-island_surprisals5_65_epoch2.csv")
complexNP_island_6 <- read.csv("on_mix_construction/complexNP-island_surprisals6_65_epoch2.csv")
complexNP_island_7 <- read.csv("on_mix_construction/complexNP-island_surprisals7_65_epoch2.csv")
complexNP_island_8 <- read.csv("on_mix_construction/complexNP-island_surprisals8_65_epoch2.csv")
complexNP_island <- rbind(complexNP_island_1,complexNP_island_2,
                          complexNP_island_3,complexNP_island_4,
                          complexNP_island_5,complexNP_island_6,
                          complexNP_island_7,complexNP_island_8)
complexNP_island$item <- as.factor(rep(rep(1:21,times=c(2,4,3,3,4,5,2,4,2,2,3,4,4,2,2,5,4,5,1,2,2)),32))
complexNP_island$licenser <- rep(c(rep("no",130),rep("yes",130)),8)
complexNP_island$island <- c(rep("no-island",260),rep("wh-rc",260),rep("that-rc",260),rep("obj-prep",260),rep("sub-no-island",260),rep("sub-that-rc",260),rep("sub-wh-rc",260),rep("sub-prep",260))
complexNP_island$gap <- rep(c(rep("no",65),rep("yes",65)),16)
SUM <- aggregate(complexNP_island$surprisals,by=list(complexNP_island$item,complexNP_island$licenser,complexNP_island$island,complexNP_island$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","island","gap","sum_surprisals")
SUM <- arrange(SUM,item,island)
for(i in seq(1,nrow(SUM),4)){
  if(SUM[i,'island']%in%c("no-island","sub-no-island")){
    if(all(c(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0,
             SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0)==c(TRUE,TRUE))){
      SUM[i:(i+3),'SG'] <- 1
    }else{SUM[i:(i+3),'SG'] <- 0}
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}
  }else{
    SUM[i:(i+3),'SG'] <- NA
    if(SUM[i,'sum_surprisals']-SUM[i+1,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_1'] <- 1
    }else{SUM[i:(i+3),'SG_1'] <- 0}
    if(SUM[i+3,'sum_surprisals']-SUM[i+2,'sum_surprisals']<0){
      SUM[i:(i+3),'SG_2'] <- 1
    }else{SUM[i:(i+3),'SG_2'] <- 0}  
  }
}
View(distinct(SUM,item,island,SG,SG_1,SG_2))

complexNP_island <- left_join(complexNP_island,SUM)

complexNP_island_summary <- distinct(complexNP_island,item,licenser,island,gap,sum_surprisals)
RESULTS <-aggregate(complexNP_island_summary$sum_surprisals,by=list(complexNP_island_summary$licenser,complexNP_island_summary$gap,complexNP_island_summary$island),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","island","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) 
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) 
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11])
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15])
(RESULTS$mean_sum_surprisals[18]-RESULTS$mean_sum_surprisals[17])-(RESULTS$mean_sum_surprisals[20]-RESULTS$mean_sum_surprisals[19]) 
(RESULTS$mean_sum_surprisals[22]-RESULTS$mean_sum_surprisals[21])-(RESULTS$mean_sum_surprisals[24]-RESULTS$mean_sum_surprisals[23]) 
(RESULTS$mean_sum_surprisals[26]-RESULTS$mean_sum_surprisals[25])-(RESULTS$mean_sum_surprisals[28]-RESULTS$mean_sum_surprisals[27])
(RESULTS$mean_sum_surprisals[30]-RESULTS$mean_sum_surprisals[29])-(RESULTS$mean_sum_surprisals[32]-RESULTS$mean_sum_surprisals[31])