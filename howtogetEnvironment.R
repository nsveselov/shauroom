#записываю окружение в файл
library(shiny)
full<-read.csv("~/shauroom/clean_data_v1.csv")

library(reshape2)
library(recommenderlab)
adresa <- unique(full$right_addres)
m = length(adresa)
namesAdrr = as.list(1:m)
names(namesAdrr) = adresa
nm = as.data.frame(unique(full$id_post))
nm = cbind(c(1:720), nm)
colnames(nm) <- c("number", "id_post")
full_1 = dplyr::left_join(nm,full, by = 'id_post')
rm(m)
rm(adresa)
rm(full)

#рекк модель в принципе та же, взял из local_shiny 
load("~/shauroom/local_shiny/recc_model_only.RData")


save.image("~/shauroom/publish/for_publ.RData")