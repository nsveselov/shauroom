---
  title: "efimov`s workfile"
author: "Ruslan Efimov"
date: "29 04 2017"
output: html_document
---

library(dplyr)  
library(scales)

#### очистка и подготовка данных -- преокончательный вариант ####

df_723_right_addresses <- read.csv('https://docs.google.com/spreadsheets/d/1xBtJrLZ_eCI9xWvYzjjvVHQCnP7g68y-eTnE1e9gGf8/pub?gid=403323493&single=true&output=csv', 
                                   stringsAsFactors=FALSE)

shaverma_df_light <- read.csv("~/shauroom/shaverma_df_light.csv")

test <- inner_join(shaverma_df_light, df_723_right_addresses, by = "id_post")
test$address <- NULL
test$score_test <- NULL
test$answer_id <- NULL
test$score <- NULL
test$question_poll <- NULL
test$date <- NULL

test_test <- test %>% filter((answer_text == unique(test$answer_text)[1]) |
                               (answer_text == unique(test$answer_text)[2]) |
                               (answer_text == unique(test$answer_text)[3]) |
                               (answer_text == unique(test$answer_text)[8]) |
                               (answer_text == unique(test$answer_text)[9]) |
                               (answer_text == unique(test$answer_text)[10]) |
                               (answer_text == unique(test$answer_text)[16]) |
                               (answer_text == unique(test$answer_text)[18]) |
                               (answer_text == unique(test$answer_text)[19]) |
                               (answer_text == unique(test$answer_text)[21]) |
                               (answer_text == unique(test$answer_text)[23]) |
                               (answer_text == unique(test$answer_text)[25]) |
                               (answer_text == unique(test$answer_text)[26]) |
                               (answer_text == unique(test$answer_text)[30]) |
                               (answer_text == unique(test$answer_text)[31]) |
                               (answer_text == unique(test$answer_text)[32]) |
                               (answer_text == unique(test$answer_text)[37]) |
                               (answer_text == unique(test$answer_text)[38]) |
                               (answer_text == unique(test$answer_text)[39]) |
                               (answer_text == unique(test$answer_text)[41]) |
                               (answer_text == unique(test$answer_text)[43]) |
                               (answer_text == unique(test$answer_text)[44]) |
                               (answer_text == unique(test$answer_text)[45]) |
                               (answer_text == unique(test$answer_text)[48]) |
                               (answer_text == unique(test$answer_text)[49]) |
                               (answer_text == unique(test$answer_text)[50]) |
                               (answer_text == unique(test$answer_text)[51]) |
                               (answer_text == unique(test$answer_text)[52]) |
                               (answer_text == unique(test$answer_text)[53]) |
                               (answer_text == unique(test$answer_text)[54]) |
                               (answer_text == unique(test$answer_text)[57]) |
                               (answer_text == unique(test$answer_text)[59]) |
                               (answer_text == unique(test$answer_text)[62]) |
                               (answer_text == unique(test$answer_text)[64]) |
                               (answer_text == unique(test$answer_text)[65]) |
                               (answer_text == unique(test$answer_text)[66]) |
                               (answer_text == unique(test$answer_text)[68]) |
                               (answer_text == unique(test$answer_text)[72]) |
                               (answer_text == unique(test$answer_text)[74]) |
                               (answer_text == unique(test$answer_text)[78]) |
                               (answer_text == unique(test$answer_text)[79]) |
                               (answer_text == unique(test$answer_text)[87]) |
                               (answer_text == unique(test$answer_text)[89]) |
                               (answer_text == unique(test$answer_text)[90]) |
                               (answer_text == unique(test$answer_text)[93]) |
                               (answer_text == unique(test$answer_text)[94]) |
                               (answer_text == unique(test$answer_text)[95]) |
                               (answer_text == unique(test$answer_text)[100]) |
                               (answer_text == unique(test$answer_text)[103]) |
                               (answer_text == unique(test$answer_text)[104]) |
                               (answer_text == unique(test$answer_text)[106]) |
                               (answer_text == unique(test$answer_text)[110]) |
                               (answer_text == unique(test$answer_text)[113]) |
                               (answer_text == unique(test$answer_text)[115]) |
                               (answer_text == unique(test$answer_text)[116]) |
                               (answer_text == unique(test$answer_text)[117]) |
                               (answer_text == unique(test$answer_text)[118]))

unique(test_test$answer_text)

test_test$answer_text <- as.character(test_test$answer_text)

test_test[test_test$answer_text ==unique(test$answer_text)[1], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[2], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[3], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[8], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[9], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[10], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[16], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[18], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[19], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[21], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[23], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[25], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[26], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[30], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[31], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[32], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[37], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[38], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[39], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[41], "answer_text"]<- "Cогласен"
test_test[test_test$answer_text ==unique(test$answer_text)[43], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[44], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[45], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[48], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[49], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[50], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[51], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[52], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[53], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[54], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[57], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[59], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[62], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[64], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[65], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[66], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[68], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[72], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[74], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[78], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[79], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[87], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[89], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[90], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[93], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[94], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[95], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[100], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[103], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[104], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[106], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[110], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[113], "answer_text"]<- "9.5"
test_test[test_test$answer_text ==unique(test$answer_text)[115], "answer_text"]<- "2"
test_test[test_test$answer_text ==unique(test$answer_text)[116], "answer_text"]<- "4"
test_test[test_test$answer_text ==unique(test$answer_text)[117], "answer_text"]<- "6"
test_test[test_test$answer_text ==unique(test$answer_text)[118], "answer_text"]<- "8"
test_test[test_test$answer_text == unique(test_test$answer_text)[4], "answer_text"]<- unique(test_test$answer_text)[1]

unique(test_test$answer_text)
# ура! все ответы стандатизованы!



#### получение распределения оценок ####

score_dist <- test_test %>% group_by(id_post) %>% summarise(score = mean(post_score))
score_dist <- na.omit(score_dist)

# график плотности
gg_score_dist <- ggplot(data = score_dist, aes(x = score)) + geom_density()
# данные графика плотности
build_score_dist <- ggplot_build(gg_score_dist)
df_score_dist <- build_score_dist$data[[1]]

# вероятность на отрезке
integrate(approxfun(density(score_dist$score)), lower=0, upper=7)$value

ggplot(data = score_dist, aes(x = score)) + geom_density()
ggplot(data = score_dist[1:50,], aes(x = score)) + geom_density()

# матожидание левой/правой ветвей распределения оценок
post_score = 8
mean(score_dist$score[score_dist$score < post_score])



#### сравнение распределений ####

ks.test(score_dist[1:50,]$score, score_dist$score, alternative = "two.sided")

# все варианты сравнения: https://goo.gl/plV3av

# Критерий Колмогорова-Смирнова проверяет гипотезу о том, 
# что выборки извлечены из одной и той же популяции, 
# против альтернативной гипотезы, когда выборки извлечены из разных популяций. 
# Иными словами, проверяется гипотеза однородности двух выборок. 
# https://goo.gl/nLe12o -- описание механики работы

id_post = 10817

post_score = round(mean(test_test$post_score[test_test$id_post == id_post]), 0)
emp_dist = test_test$answer_text[test_test$id_post == id_post]
emp_dist[emp_dist == "Лучше"] <- 1
emp_dist[emp_dist == "Хуже"] <- -1
emp_dist[emp_dist == "Согласен"] <- 0

popul_dist = as.numeric(round(score_dist$score, 0))
popul_dist[popul_dist >= post_score+1] <- "Лучше"
popul_dist[popul_dist <= post_score-1] <- "Хуже"
popul_dist[popul_dist == post_score] <- "Согласен"
popul_dist[popul_dist == "Лучше"] <- 1
popul_dist[popul_dist == "Хуже"] <- -1
popul_dist[popul_dist == "Согласен"] <- 0

ks.test(as.numeric(emp_dist), as.numeric(popul_dist), alternative = "two.sided")$p.value

# emp_data = red
# popul_data = blue
ggplot(data = as.data.frame(as.numeric(emp_dist)), aes(x = as.numeric(emp_dist), color = 'red')) + 
  geom_density() +
  geom_density(data = as.data.frame(as.numeric(popul_dist)), aes(x = as.numeric(popul_dist), color = 'blue')) + 
  scale_x_continuous(breaks=seq((-1),1,1),lim=c((-1),1))


for (i in score_dist$id_post){
  id_post = i
  
  post_score = round(mean(test_test$post_score[test_test$id_post == id_post]), 0)
  emp_dist = test_test$answer_text[test_test$id_post == id_post]
  emp_dist[emp_dist == "Лучше"] <- 1
  emp_dist[emp_dist == "Хуже"] <- -1
  emp_dist[emp_dist == "Согласен"] <- 0
  
  popul_dist = as.numeric(round(score_dist$score, 0))
  popul_dist[popul_dist >= post_score+1] <- "Лучше"
  popul_dist[popul_dist <= post_score-1] <- "Хуже"
  popul_dist[popul_dist == post_score] <- "Согласен"
  popul_dist[popul_dist == "Лучше"] <- 1
  popul_dist[popul_dist == "Хуже"] <- -1
  popul_dist[popul_dist == "Согласен"] <- 0
  
  score_dist[score_dist$id_post == i, "p_value"] <- round(ks.test(as.numeric(emp_dist), as.numeric(popul_dist), alternative = "two.sided")$p.value, 2)
}

plot(density(as.numeric(emp_dist)))

N = length(as.numeric(emp_dist))

hist(rnorm(N, sample(rescale(as.numeric(emp_dist),range(1,10)), size = N, replace = TRUE),
            density(rescale(as.numeric(emp_dist),range(1,10)))$bw), freq = FALSE)
lines(density(rescale(as.numeric(emp_dist),range(1,10))))
resc_dist = rescale(rnorm(N, sample(rescale(as.numeric(emp_dist),range(1,10)), size = N, replace = TRUE), 
                   density(rescale(as.numeric(emp_dist),range(1,10)))$bw), range(1,10))
mean(resc_dist[resc_dist < post_score]) # восстановленная оценка

# approxfun(density(as.numeric(emp_dist)))
# uniroot(approxfun(density(as.numeric(emp_dist))), c(0,10))




#### восстановление оценок -- вариант 1 ####

#1 test_test_copy <- test_test
#2 test_test <- test_test_copy

test_test$final_grade <- test_test$answer_text

x = 0
### без 9119 -> его сделать руками !!!
for (i in unique(test_test$id_post)[1:(length(unique(test_test$id_post))-1)]){
  #print(i)
  print(x/length(unique(test_test$id_post)))
  x = x + 1
  
  # сформировали эмпирическое распределение оценок и кодировали
  post_score = round(mean(test_test$post_score[test_test$id_post == i]), 1)
  emp_dist = test_test$answer_text[test_test$id_post == i]
  emp_dist[emp_dist == "Лучше"] <- 1
  emp_dist[emp_dist == "Хуже"] <- -1
  emp_dist[emp_dist == "Согласен"] <- 0
  resc_dist = rescale(rnorm(length(as.numeric(emp_dist)), sample(rescale(as.numeric(emp_dist),range(1,10)), size = length(as.numeric(emp_dist)), replace = TRUE), 
                            density(rescale(as.numeric(emp_dist),range(0,10)))$bw), range(0,10))
  
  try(test_test[(test_test$id_post == i) & (test_test$answer == "Согласен"), ]$final_grade <- round(post_score, 1), silent = T)
  try(test_test[(test_test$id_post == i) & (test_test$answer == "Хуже"), ]$final_grade <- round(mean(resc_dist[resc_dist < post_score]), 1), silent = T)
  try(test_test[(test_test$id_post == i) & (test_test$answer == "Лучше"), ]$final_grade <- round(mean(resc_dist[resc_dist > post_score]), 1), silent = T)
} 

#test_test[(test_test$id_post == 9119) & (test_test$answer == "Согласен"), ]$final_grade <- 8
#test_test[(test_test$id_post == 9119) & (test_test$answer == "9,5"), ]$final_grade <- 9.5
test_test[(test_test$post_score == 0.0) & (test_test$final_grade == NaN), ]$final_grade <- 0
test_test[(test_test$post_score == 10.0) & (test_test$final_grade == NaN), ]$final_grade <- 10
#test_test[(test_test$final_grade == 10), ]$final_grade

#### убрали чуваков с 1-им и 2-мя отзывами ####

# удаление повторяющихся reviewer_id
test_test %>% group_by(reviewer_id,id_post) %>% summarise(n = n()) %>% filter(n > 1)
test_test[(test_test$reviewer_id == 89195353) & (test_test$id_post == 33951), ]
test_test <- test_test[-10199,]

# number <- clean_data_v1 %>% group_by(reviewer_id) %>% summarise(n = n()) %>% filter(n >= 0) %>% group_by(n) %>% summarise(nn = n())
number <- test_test %>% group_by(reviewer_id) %>% summarise(n = n()) %>% filter(n >= 3)

clean_df_for_recommend <- inner_join(number, test_test, by = "reviewer_id")
clean_df_for_recommend$n <- NULL
clean_df_for_recommend$address.x <- NULL
clean_df_for_recommend$X <- NULL
clean_df_for_recommend$Do <- NULL
clean_df_for_recommend$coordinate <- NULL


clean_df_for_recommend$final_grade <- as.numeric(clean_df_for_recommend$final_grade)
write.csv(clean_df_for_recommend, 'clean_data_v2.1.csv')


# #### почистил от записей с повторениями reviewer_id и id_post
# #### апдейдтнул файл, эта часть не требуется
# full<-read.csv("~/sss/shauroom/clean_data.csv")
# number <- full %>% group_by(reviewer_id,id_post) %>% summarise(n = n())
# #крашится матрица изза этого
# for(i in 1:nrow(full)){
#   if(i%%2000==0){print(i)}
#   if(full[i,5]=="17012" & full[i,7]=="Садовая, 42"){full<-full[-i,]}
# }
# full<-full[-23532,]
# full$X.1<-NULL
# write.csv(full, "clean_data_v1.csv")

######### загузка координат ###########
adres <- read.csv('https://docs.google.com/spreadsheets/d/1xBtJrLZ_eCI9xWvYzjjvVHQCnP7g68y-eTnE1e9gGf8/pub?gid=403323493&single=true&output=csv', 
                  stringsAsFactors=FALSE)
library(httr)
library("RCurl")
library(jsonlite)
library(stringr)

for (i in 643:nrow(adres)){
  print(i)
  # url1 = paste0('http://catalog.api.2gis.ru/geo/search?q=Санкт-Петербург,+',  
  #              gsub(" ", "+", adres[i,"right_addres"]),
  #              '&version=1.3&key=rutnpt3272')
  # adres[i,"address"] <- answer$result$name # address
  # adres[i,"coordinate"] <- answer$result$centroid # coordinate
  # if (length(answer$result$attributes$district) > 0){
  #   adres[i,"district"] <- answer$result$attributes$district # district
  url1 = paste0('https://catalog.api.2gis.ru/2.0/geo/search?page=1&page_size=1&q=Санкт-Петербург,+',
                gsub(" ", "+", adres[i,"right_addres"]),
                '&region_id=38&fields=search_attributes,items.address,items.adm_div,items.geometry.centroid,items.geometry.selection,items.geometry.style,items.floors,items.group&key=rutnpt3272')
  answer <- fromJSON(getURL(url1))
  adres[i,"address"] <- answer$result$items$full_name # address
  adres[i,"coordinate"] <- answer$result$items$geometry$centroid # coordinate
  adres[i,"coord1"] <- str_extract_all(answer$result$items$geometry$centroid, '\\d+.\\d+')[[1]][1]
  adres[i,"coord2"] <- str_extract_all(answer$result$items$geometry$centroid, '\\d+.\\d+')[[1]][2]
  if (length(answer$result$items$adm_div[[1]]$name[2]) > 0){
    adres[i,"district"] <- answer$result$items$adm_div[[1]]$name[2] # district
  }
}
write.csv(adres, "adres.csv")

######## переход к idshava ############

clean_data_v3 <- clean_data_v2_1 %>% group_by(reviewer_id, idshava) %>% summarise(score = mean(final_grade))
n1 <- clean_data_v3 %>% group_by(reviewer_id, idshava) %>% summarise(n())

# бд с уникальными параметрами шавермешных
n2 <- unique(subset(clean_data_v2_1, select = c("idshava", "name", "photo","right_addres", "coord1", "coord2", "district")))
n2 <- n2 %>% group_by(idshava) %>% summarize(n())
n2 <- unique(subset(clean_data_v2_1, select = c("idshava", "name", "photo","right_addres", "coord1", "coord2", "district")))
n2 <- as.data.frame(n2)
n2[n2$idshava == 'id2144', ]
n2 <- n2[-267,]
rownames(n2) <- 1:nrow(n2)
n2[n2$idshava == 'id1040', ]
n2 <- n2[-290,]
unique_idshava <- n2
write.csv(unique_idshava, "unique_idshava.csv")


clean_data_v3 <- inner_join(clean_data_v3, n2, by = c("idshava"))
write.csv(clean_data_v3, 'clean_data_v3.csv')
