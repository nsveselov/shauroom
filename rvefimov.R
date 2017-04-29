---
  title: "efimov`s workfile"
author: "Ruslan Efimov"
date: "29 04 2017"
output: html_document
---
  
  ```{r Стандартизация answer_text, include=FALSE }
df_727_right_addresses <- read.csv("~/shaverma/shauroom/727_правильных_адресов.csv")
shaverma_df_light <- read.csv("~/shaverma/shauroom/shaverma_df_light.csv")

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

unique(test_test$answer_text)

test_test[test_test$answer_text == unique(test_test$answer_text)[4], "answer_text"]<- unique(test_test$answer_text)[1]

# ура! все ответы стандатизованы!

```





```{r Распределение оценок}
score_dist <- test_test %>% group_by(id_post) %>% summarise(score = mean(post_score))

score_dist <- na.omit(score_dist)

# график плотности
gg_score_dist <- ggplot(data = score_dist, aes(x = score)) + geom_density()
# данные графика плотности
build_score_dist <- ggplot_build(gg_score_dist)
df_score_dist <- build_score_dist$data[[1]]

#вероятность на отрезке
integrate(approxfun(density(score_dist$score)), lower=0, upper=7)$value

?distrEx
library(distrEx)
E(approxfun(density(score_dist$score)), lower=0, upper=7)
```

