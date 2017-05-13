#Загрузка
full<-read.csv("~/sss/shauroom/fixed_score.csv")
full$X.1<-NULL
#MAKE MATRIX
library(reshape2)
library(recommenderlab)
df <- as.data.frame(acast(full, reviewer_id~id_post, value.var="post_score"))

#разделить на обуч и тест?
set.seed(100)
test.ind = sample(seq_len(nrow(full)), size = nrow(full)*0.2)
test = full[test.ind,]
main = full[-test.ind,]
test_df <- as.data.frame(acast(test, reviewer_id~id_post, value.var="fix"))
main_df <- as.data.frame(acast(main, reviewer_id~id_post, value.var="fix"))
test_matrix<-as.matrix(test_df)
test_realm <- as(test_matrix, "realRatingMatrix")
main_matrix<-as.matrix(main_df)
main_realm <- as(main_matrix, "realRatingMatrix")
#запись модели (не знаю, что означают параметры в функции)
recc_model <- Recommender(data = main_realm, method = "IBCF", parameter = list(k = 30))
recc_model

#создание матрицы рекомендаций для полльзователей
recc_predicted <- predict(object = recc_model, newdata = test_realm, n = 5)
recc_matrix <- sapply(recc_predicted@items, function(x){
  colnames(test_realm)[x]
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

#второй вариант
library(tidyr)
recc<-separate(a, col='recommended', into=c("one","two","three","four","five"), sep=",")
#на выходе табличка с шестью колонками

uniq<-as.data.frame(sort(unique(test$reviewer_id)))
all<-as.data.frame(NULL)
for (i in 1:(nrow(a)/5)){
  if(i%%5000=="0"){print(i)}
  all[i, "reviewer_id"] = uniq[i,1]
  all[i, "recommendation"] = paste(a$recc[((i-1)*5+1):((i-1)*5+5)],collapse = ",")
}
typeof(all$recommendation)
unlist(all$recommendation[1])
recc1<-unlist(all$recommendation[1])
#в общем то всё
#решил, что проще в лист записать, чем в 5 разных столбиков


#добавил рандомные значения, и посмотрел что рекомендует
tetest<-test
tetest[14630,2]=1337
tetest[14630,4]=14238
tetest[14630,8]=4

tetest[14631,2]=1337
tetest[14631,4]=20760
tetest[14631,8]=4.25

tetest[14632,2]=1337
tetest[14632,4]=26611
tetest[14632,8]=3

tetest_df <- as.data.frame(acast(tetest, reviewer_id~id_post, value.var="fix"))
tetest_matrix<-as.matrix(tetest_df)
tetest_realm <- as(tetest_matrix, "realRatingMatrix")

recc_predicted1 <- predict(object = recc_model, newdata = tetest_realm, n = 5)
recc_matrix1 <- sapply(recc_predicted1@items, function(x){
  colnames(tetest_realm)[x]
})
recc_matrix1$`1337`
#Ответ:
> recc_matrix1$`1337`
[1] "10124" "11251" "11344" "12066" "13350"
#чтото есть, уже неплохо

#рекомендует не всем, и не совсем ясно как доставать данные
dim(recc_matrix)
df<-data_frame()
nrow(test_realm)
uniq<-as.data.frame(sort(unique(test$reviewer_id)))
df$V7<-df$V1

if(is.na(recc_predicted@items[[9]])=="FALSE"){
  df[9,2:7]<- recc_predicted@items[[9]]} else {df[9,1]<-0}

df[7,2]<- (recc_predicted@items[[9]])


#ИТОГ - табличка с 2 столбцами
a$recommend[1]<-list(a[1,1])
b<-list(a$reviewer_id)
a<-melt(recc_matrix)
colnames(a)<- c("recc","reviewer_id","recommend")
for(i in 1:(nrow(a)/5)){
  a[((i-1)*5+1),3]<-paste(a$recc[((i-1)*5+1):((i-1)*5+5)],collapse = ",")
}
a<-na.omit(a)


