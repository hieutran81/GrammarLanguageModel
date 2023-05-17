library(dplyr)
#pre fine-tuning, test=original Hu material (fgd_pp)
fgd_pp <- read.csv("fgd_pp.csv")
fgd_pp$item <- as.factor((rep(1:24,times=c(16,4,12,8,8,16,12,16,8,16,24,16,12,4,12,12,8,16,16,16,8,8,8,8))))
licenser <- c()
for(i in unique(fgd_pp$item)){
  licenser <- c(licenser,c(rep("no",nrow(fgd_pp[fgd_pp$item==i,])/2),rep("yes",nrow(fgd_pp[fgd_pp$item==i,])/2)))
}
fgd_pp$licenser <- licenser
gap <- c()
for(i in unique(fgd_pp$item)){
  gap <- c(gap,c(rep("yes",nrow(fgd_pp[fgd_pp$item==i,])/4),rep("no",nrow(fgd_pp[fgd_pp$item==i,])/4),rep("yes",nrow(fgd_pp[fgd_pp$item==i,])/4),rep("no",nrow(fgd_pp[fgd_pp$item==i,])/4)))
}
fgd_pp$gap <- gap
SUM <- aggregate(fgd_pp$surprisals,by=list(fgd_pp$item,fgd_pp$licenser,fgd_pp$gap),FUN=sum)
colnames(SUM) <- c("item","licenser","gap","sum_surprisals")
SUM <- arrange(SUM,item)
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
View(distinct(SUM,item,SG,SG_1,SG_2))

fgd_pp <- left_join(fgd_pp,SUM)

fgd_pp_summary <- distinct(fgd_pp,item,licenser,gap,sum_surprisals)
RESULTS <-aggregate(fgd_pp_summary$sum_surprisals,by=list(fgd_pp_summary$licenser,fgd_pp_summary$gap),FUN=mean)
colnames(RESULTS) <- c("gap_licenser","gap","mean_sum_surprisals")
print(RESULTS)
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #that__noisland




#pre fine-tuning, test=original Wilcox material
wh_island_1 <- read.csv("wh-island_surprisals1.csv")
wh_island_2 <- read.csv("wh-island_surprisals2.csv")
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

t.test(wh_island_summary$sum_surprisals[wh_island_summary$island=="whether"&wh_island_summary$gap=="yes"&wh_island_summary$licenser=="yes"],
       wh_island_summary$sum_surprisals[wh_island_summary$island=="whether"&wh_island_summary$gap=="yes"&wh_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")



#pretrained Wilcox (adjunct island)
adjunct_island_1 <- read.csv("adj-islands_surprisals1.csv")
adjunct_island_2 <- read.csv("adj-islands_surprisals2.csv")
adjunct_island_3 <- read.csv("adj-islands_surprisals3.csv")
adjunct_island_4 <- read.csv("adj-islands_surprisals4.csv")
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
(RESULTS$mean_sum_surprisals[2]-RESULTS$mean_sum_surprisals[1])-(RESULTS$mean_sum_surprisals[4]-RESULTS$mean_sum_surprisals[3]) #adjunct_back
(RESULTS$mean_sum_surprisals[6]-RESULTS$mean_sum_surprisals[5])-(RESULTS$mean_sum_surprisals[8]-RESULTS$mean_sum_surprisals[7]) #adjunct_front
(RESULTS$mean_sum_surprisals[10]-RESULTS$mean_sum_surprisals[9])-(RESULTS$mean_sum_surprisals[12]-RESULTS$mean_sum_surprisals[11]) #modifier
(RESULTS$mean_sum_surprisals[14]-RESULTS$mean_sum_surprisals[13])-(RESULTS$mean_sum_surprisals[16]-RESULTS$mean_sum_surprisals[15]) #modifier


t.test(adjunct_island_summary$sum_surprisals[adjunct_island_summary$island=="adjunct_back"&adjunct_island_summary$gap=="yes"&adjunct_island_summary$licenser=="yes"],
       adjunct_island_summary$sum_surprisals[adjunct_island_summary$island=="adjunct_back"&adjunct_island_summary$gap=="yes"&adjunct_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")





#pretrained, test=original Wilcox material (complexNP)
complexNP_island_1 <- read.csv("complexNP-island_surprisals1.csv")
complexNP_island_2 <- read.csv("complexNP-island_surprisals2.csv")
complexNP_island_3 <- read.csv("complexNP-island_surprisals3.csv")
complexNP_island_4 <- read.csv("complexNP-island_surprisals4.csv")
complexNP_island_5 <- read.csv("complexNP-island_surprisals5.csv")
complexNP_island_6 <- read.csv("complexNP-island_surprisals6.csv")
complexNP_island_7 <- read.csv("complexNP-island_surprisals7.csv")
complexNP_island_8 <- read.csv("complexNP-island_surprisals8.csv")
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

t.test(complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="obj-prep"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="yes"],
       complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="obj-prep"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")
t.test(complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="sub-prep"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="yes"],
       complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="sub-prep"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")
t.test(complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="that-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="yes"],
       complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="that-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")
t.test(complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="wh-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="yes"],
       complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="wh-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")
t.test(complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="sub-that-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="yes"],
       complexNP_island_summary$sum_surprisals[complexNP_island_summary$island=="sub-that-rc"&complexNP_island_summary$gap=="yes"&complexNP_island_summary$licenser=="no"],
       paired=TRUE, alternative="two.sided")
