library(proxy)
library(recommenderlab)
library(reshape2)

load("~/shauroom/shriny/environment.RData")

shaverma_recommendation <- function(select,select1,select2,grade,grade1,grade2) {
  full<-read.csv("~/shauroom/clean_data_v1.csv")
  full_2<-full
  full_2[45275, "final_grade"] <- grade
  full_2[45275, "id_post"] <- nm[select,2]
  full_2[45275, "reviewer_id"] <- 1337
  full_2[45276, "final_grade"] <- grade1
  full_2[45276, "id_post"] <- nm[select1,2]
  full_2[45276, "reviewer_id"] <- 1337
  full_2[45277, "final_grade"] <- grade2
  full_2[45277, "id_post"] <- nm[select2,2]
  full_2[45277, "reviewer_id"] <- 1337
  
  #Convert rating matrix into a sparse matrix
  tetest_df <- as.data.frame(acast(full_2, reviewer_id~id_post, value.var="final_grade"))
  tetest_matrix<-as.matrix(tetest_df)
  tetest_realm <- as(tetest_matrix, "realRatingMatrix")
  
  #Create Recommender Model. "UBCF" stands for user-based collaborative filtering
  recc_predicted1 <- predict(object = recc_model, newdata = tetest_realm, n = 5)
  recc_matrix1 <- sapply(recc_predicted1@items, function(x){
    colnames(tetest_realm)[x]
  })
  print(recc_matrix1$`1337`)

}


#Пример
shaverma_recommendation(15,164,465,7,2,4)
