#Загрузка
full<-read.csv("~/shauroom/clean_data_v3.csv")
full$X.1<- NULL
#MAKE MATRIX
library(reshape2)
library(recommenderlab)

df <- as.data.frame(acast(full, reviewer_id~idshava, value.var="score"))
df_matrix<-as.matrix(df)
df_realm <- as(df_matrix, "realRatingMatrix")

#запись модели (не знаю, что означают параметры в функции)
#считает минуты 4
recc_model <- Recommender(data = df_realm, method = "IBCF", parameter = list(k = 30))

#создание матрицы рекомендаций для полльзователей
recc_predicted <- predict(object = recc_model, newdata = df_realm, n = 5)
recc_matrix <- sapply(recc_predicted@items, function(x){
  colnames(df_realm)[x]
})
#один вариант
a<-melt(recc_matrix)
colnames(a)<- c("recc","reviewer_id")
for(i in 1:(nrow(a)/5)){
  a[((i-1)*5+1),3]<-paste(a$recc[((i-1)*5+1):((i-1)*5+5)],collapse = ",")
}
a<-na.omit(a)
a$recc<-NULL
colnames(a)<- c("reviewer_id","recommended")

#получить табличку с отдельными колонками для каждой шаверменной
library(tidyr)
recc<-separate(a, col='recommended', into=c("one","two","three","four","five"), sep=",")

#конец

#добавил рандомные значения, и посмотрел что рекомендует
tetest<-full
tetest[40653,1]=1337
tetest[40653,4]=14238
tetest[40653,8]=4

tetest[40654,1]=1337
tetest[40654,4]=20760
tetest[40654,8]=4.25

tetest[40655,1]=1337
tetest[40655,4]=26611
tetest[40655,8]=3

tetest[40656,1]=1337
tetest[40656,4]=35601
tetest[40656,8]=7

tetest_df <- as.data.frame(acast(tetest, reviewer_id~id_post, value.var="final_grade"))
tetest_matrix<-as.matrix(tetest_df)
tetest_realm <- as(tetest_matrix, "realRatingMatrix")

recc_predicted1 <- predict(object = recc_model, newdata = tetest_realm, n = 5)
recc_matrix1 <- sapply(recc_predicted1@items, function(x){
  colnames(tetest_realm)[x]
})
recc_matrix1$`1337`
#чтото есть




#разделить на обуч и тест?(вроде не нужно)
set.seed(163)
test.ind = sample(seq_len(nrow(full)), size = nrow(full)*0.2)
test = full[test.ind,]
main = full[-test.ind,]
test_df <- as.data.frame(acast(test, reviewer_id~id_post, value.var="final_grade"))
main_df <- as.data.frame(acast(main, reviewer_id~id_post, value.var="final_grade"))
test_matrix<-as.matrix(test_df)
test_realm <- as(test_matrix, "realRatingMatrix")
main_matrix<-as.matrix(main_df)
main_realm <- as(main_matrix, "realRatingMatrix")



