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
tetest[41667,1]=1337
tetest[41667,4]=14238
tetest[41667,8]=4

tetest[41668,1]=1337
tetest[41668,4]=20760
tetest[41668,8]=4.25

tetest[41669,1]=1337
tetest[41669,4]=26611
tetest[41669,8]=3

tetest[41670,1]=1337
tetest[41670,4]=35601
tetest[41670,8]=7

tetest_df <- as.data.frame(acast(tetest, reviewer_id~idshava, value.var="score"))
tetest_matrix<-as.matrix(tetest_df)
tetest_realm <- as(tetest_matrix, "realRatingMatrix")

recc_predicted1 <- predict(object = recc_model, newdata = tetest_realm, n = 5)
recc_matrix1 <- sapply(recc_predicted1@items, function(x){
  colnames(tetest_realm)[x]
})
recc_matrix1$`1337`
#чтото есть
as(recc_predicted, "list")



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


tetest_realm["1337",]
#UBCF
tetest<-full
tetest[40653,2]=1337
tetest[40653,3]="id1049"
tetest[40653,4]=9

tetest[40654,2]=1337
tetest[40654,3]="id2047"
tetest[40654,4]=9

tetest[40655,2]=1337
tetest[40655,3]="id2390"
tetest[40655,4]=9

tetest[40656,2]=1337
tetest[40656,3]="id1077"
tetest[40656,4]=1

Rec.model<-Recommender(df_realm, method = "UBCF", param=list(normalize = "Z-score",method="Cosine",nn=5))
predicted.affinity.u1 <- predict(object=Rec.model, newdata=tetest_realm["1337",], 
                                 n=5)
# to see the user "u15348"'s predicted affinity for items we didn't have any value for
as(predicted.affinity.u1, "list")
# .. and the real affinity for the items obtained from the affinity.matrix
as(df_realm["u15348",], "list")
[1] "id2113" "id2311" "id1001" "id1002" "id1003" ubcf
[1] "id1010" "id1017" "id1022" "id1030" "id1045" ibcf не фонтан&%?
predicted.affinity.u1@items$`654`
a<-as(predicted.affinity.u1, "list")




##Заново для UBCF
full<-read.csv("~/shauroom/clean_data_v3.csv")
full$X.1<- NULL
#MAKE MATRIX
library(reshape2)
library(recommenderlab)

tetest<-full
n<-nrow(tetest)
tetest[(n+1),2]=1337
tetest[(n+1),3]="id2010"
tetest[(n+1),4]=5

tetest[(n+2),2]=1337
tetest[(n+2),3]="id2210"
tetest[(n+2),4]=3
#2025?? то7гда некруто
tetest[(n+3),2]=1337
tetest[(n+3),3]="id2390"
tetest[(n+3),4]=9

tetest[(n+4),2]=1337
tetest[(n+4),3]="id1077"
tetest[(n+4),4]=1

tetest_df <- as.data.frame(acast(tetest, reviewer_id~idshava, value.var="score"))
tetest_matrix<-as.matrix(tetest_df)
tetest_realm <- as(tetest_matrix, "realRatingMatrix")
tetest_realm["1337",]
Rec.model<-Recommender(tetest_realm, method = "UBCF", param=list(normalize = "Z-score",method="Cosine",nn=5))

Rec.modelwithoutparam<-Recommender(tetest_realm, method = "UBCF")
predicted.1337.simple <- predict(object=Rec.model, newdata=tetest_realm["1337",], 
                                 n=5)
predicted.1337.withoutparam <- predict(object=Rec.modelwithoutparam, newdata=tetest_realm["1337",], 
                                 n=5)
as(predicted.1337.simple, "list")
as(predicted.1337.withoutparam, "list")
#в среднем, оценки шар, рекомендованных по Rec.modelwithoutparam выше
#по двум рекомендует обычно
#иногда рекомендует шавермы id1001-id1005 (видимо когда мало данных, тк при 4х оценках такого нет)