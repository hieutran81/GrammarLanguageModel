library(dplyr)
library(tidyr)
BROWN <- read.csv("brown.csv",header=T)
BROWN <- unite(BROWN,"id",filename,para_id)
set.seed(1)
sampled_5percent <- data.frame(id=sample(unique(BROWN$id),length(unique(BROWN$id))/20),selected="Yes")
BROWN <- left_join(BROWN,sampled_5percent)
small_corpurs <- BROWN[!is.na(BROWN$selected),]
small_corpurs_for_perplexity = data.frame(id=NA,full_paragraph=NA)
k=1
for(i in unique(small_corpurs$id)){
  current_id_rows = small_corpurs[small_corpurs$id==i,]
  full_paragraph = ""
  for(j in 1:nrow(current_id_rows)){
    full_paragraph <- paste(full_paragraph, current_id_rows[j,'tokenized_text'])
  }
  small_corpurs_for_perplexity[k,'id'] <- i
  small_corpurs_for_perplexity[k,'full_paragraph'] <- full_paragraph
  k=k+1
}
NO_weirdmark <- small_corpurs_for_perplexity[!grepl("``",small_corpurs_for_perplexity$full_paragraph),]
No_short <- NO_weirdmark[nchar(NO_weirdmark$full_paragraph)>=100,]
write.csv(No_short,"perplexity_corpus.csv",row.names = F)
#One additional is manually taken out post-hoc because it was found that that paragraph contains TONs of people's names and thus makes an outlier of perplexity
#total numb of paragraphs evaluated for perplexity is 447