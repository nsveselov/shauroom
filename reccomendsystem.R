
#MAKE MATRIX
df <- as.data.frame(acast(ex, reviewer_id~id_post, value.var="score"))
library(reshape2)

#создали матрицу для системы рекомменд
df_matrix <- as.matrix(df)
real_matrix <- as(df_matrix, "realRatingMatrix")

#попытались
recc_model <- Recommender(data = real_matrix, method = "IBCF",
                            +                           parameter = list(k = 30))
recc_model


model_details <- getModel(recc_model)
model_details$description
model_details$sim[1:5, 1:5]







```
