---
  title: "efimov`s workfile"
author: "Ruslan Efimov"
date: "29 04 2017"
output: html_document
---

library(dplyr)  
library(scales)

#### очистка и подготовка данных -- преокончательный вариант ####

df_727_right_addresses <- read.csv("~/shauroom/727_правильных_адресов.csv")
shaverma_df_light <- read.csv("~/shauroom/shaverma_df_light.csv")

test <- inner_join(shaverma_df_light, df_727_right_addresses, by = "id_post")
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
                               (answer_text == unique(test$answer_text)[19]) |
                               (answer_text == unique(test$answer_text)[21]) |
                               (answer_text == unique(test$answer_text)[22]) |
                               (answer_text == unique(test$answer_text)[24]) |
                               (answer_text == unique(test$answer_text)[26]) |
                               (answer_text == unique(test$answer_text)[28]) |
                               (answer_text == unique(test$answer_text)[29]) |
                               (answer_text == unique(test$answer_text)[33]) |
                               (answer_text == unique(test$answer_text)[34]) |
                               (answer_text == unique(test$answer_text)[35]) |
                               (answer_text == unique(test$answer_text)[40]) |
                               (answer_text == unique(test$answer_text)[41]) |
                               (answer_text == unique(test$answer_text)[42]) |
                               (answer_text == unique(test$answer_text)[44]) |
                               (answer_text == unique(test$answer_text)[46]) |
                               (answer_text == unique(test$answer_text)[47]) |
                               (answer_text == unique(test$answer_text)[48]) |
                               (answer_text == unique(test$answer_text)[51]) |
                               (answer_text == unique(test$answer_text)[52]) |
                               (answer_text == unique(test$answer_text)[53]) |
                               (answer_text == unique(test$answer_text)[54]) |
                               (answer_text == unique(test$answer_text)[55]) |
                               (answer_text == unique(test$answer_text)[56]) |
                               (answer_text == unique(test$answer_text)[57]) |
                               (answer_text == unique(test$answer_text)[60]) |
                               (answer_text == unique(test$answer_text)[62]) |
                               (answer_text == unique(test$answer_text)[65]) |
                               (answer_text == unique(test$answer_text)[67]) |
                               (answer_text == unique(test$answer_text)[68]) |
                               (answer_text == unique(test$answer_text)[69]) |
                               (answer_text == unique(test$answer_text)[71]) |
                               (answer_text == unique(test$answer_text)[75]) |
                               (answer_text == unique(test$answer_text)[77]) |
                               (answer_text == unique(test$answer_text)[81]) |
                               (answer_text == unique(test$answer_text)[82]) |
                               (answer_text == unique(test$answer_text)[90]) |
                               (answer_text == unique(test$answer_text)[92]) |
                               (answer_text == unique(test$answer_text)[93]) |
                               (answer_text == unique(test$answer_text)[96]) |
                               (answer_text == unique(test$answer_text)[97]) |
                               (answer_text == unique(test$answer_text)[98]) |
                               (answer_text == unique(test$answer_text)[103]) |
                               (answer_text == unique(test$answer_text)[106]) |
                               (answer_text == unique(test$answer_text)[107]) |
                               (answer_text == unique(test$answer_text)[109]) |
                               (answer_text == unique(test$answer_text)[113]) |
                               (answer_text == unique(test$answer_text)[116]) |
                               (answer_text == unique(test$answer_text)[118]) |
                               (answer_text == unique(test$answer_text)[119]) |
                               (answer_text == unique(test$answer_text)[120]) |
                               (answer_text == unique(test$answer_text)[121]))

unique(test_test$answer_text)

test_test$answer_text <- as.character(test_test$answer_text)

test_test[test_test$answer_text ==unique(test$answer_text)[1], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[2], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[3], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[8], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[9], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[10], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[19], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[21], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[22], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[24], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[26], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[28], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[29], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[33], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[34], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[35], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[40], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[41], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[42], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[44], "answer_text"]<- "Cогласен"
test_test[test_test$answer_text ==unique(test$answer_text)[46], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[47], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[48], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[51], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[52], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[53], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[54], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[55], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[56], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[57], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[60], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[62], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[65], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[67], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[68], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[69], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[71], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[75], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[77], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[81], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[82], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[90], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[92], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[93], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[96], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[97], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[98], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[103], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[106], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[107], "answer_text"]<- "Хуже"
test_test[test_test$answer_text ==unique(test$answer_text)[109], "answer_text"]<- "Лучше"
test_test[test_test$answer_text ==unique(test$answer_text)[113], "answer_text"]<- "Согласен"
test_test[test_test$answer_text ==unique(test$answer_text)[116], "answer_text"]<- "9,5"
test_test[test_test$answer_text ==unique(test$answer_text)[118], "answer_text"]<- "2"
test_test[test_test$answer_text ==unique(test$answer_text)[119], "answer_text"]<- "4"
test_test[test_test$answer_text ==unique(test$answer_text)[120], "answer_text"]<- "6"
test_test[test_test$answer_text ==unique(test$answer_text)[121], "answer_text"]<- "8"
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
for (i in unique(test_test$id_post)){
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
  
  test_test[(test_test$id_post == i) & (test_test$answer == "Согласен"), ]$final_grade <- round(post_score, 1)
  try(test_test[(test_test$id_post == i) & (test_test$answer == "Хуже"), ]$final_grade <- round(mean(resc_dist[resc_dist < post_score]), 1), silent = T)
  try(test_test[(test_test$id_post == i) & (test_test$answer == "Лучше"), ]$final_grade <- round(mean(resc_dist[resc_dist > post_score]), 1), silent = T)
} 



