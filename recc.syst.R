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
a<-melt(recc_matrix)
colnames(a)<- c("recc","reviewer_id")
for(i in 1:(nrow(a)/5)){
  a[((i-1)*5+1),3]<-paste(a$recc[((i-1)*5+1):((i-1)*5+5)],collapse = ",")
}
a<-na.omit(a)
a$recc<-NULL
colnames(a)<- c("reviewer_id","recommended")

#в общем то всё








#рекомендует не всем, и не совсем ясно как доставать данные
dim(recc_matrix)
df<-data_frame()
nrow(test_realm)
uniq<-as.data.frame(sort(unique(test$reviewer_id)))
df$V7<-df$V1

for(i in 1:100){
  df[i,1] <- uniq[i,1]
  if(is.na(recc_predicted@items[[i]])=="FALSE FALSE FALSE FALSE FALSE FALSE"){
df[i,2:7]<- recc_predicted@items[[i]]} else {df[i,2]<-"0"}
}

if(is.na(recc_predicted@items[[9]])=="FALSE"){
  df[9,2:7]<- recc_predicted@items[[9]]} else {df[9,1]<-0}

df[7,2]<- (recc_predicted@items[[9]]


#ИТОГ - табличка с 2 столбцами
a$recommend[1]<-list(a[1,1])
b<-list(a$reviewer_id)
a<-melt(recc_matrix)
colnames(a)<- c("recc","reviewer_id","recommend")
for(i in 1:(nrow(a)/5)){
  a[((i-1)*5+1),3]<-paste(a$recc[((i-1)*5+1):((i-1)*5+5)],collapse = ",")
}
a<-na.omit(a)



```
id<-filter(full, reviewer_id=="2545")
