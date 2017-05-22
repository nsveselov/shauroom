library(shiny)
full<-read.csv("~/shauroom/clean_data_v1.csv")
#MAKE MATRIX

library(reshape2)
library(recommenderlab)
df <- as.data.frame(acast(full, reviewer_id~id_post, value.var="final_grade"))
adresa <- unique(full$right_addres)
m = length(adresa)
namesAdrr = as.list(1:m)
names(namesAdrr) = adresa
nm = as.data.frame(unique(full$id_post))
nm = cbind(c(1:720), nm)
colnames(nm) <- c("number", "id_post")
full_1 = dplyr::left_join(nm,full, by = 'id_post')
ui <- fluidPage("Shauroom",
                selectInput("select", label = h3("Выбери шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                hr(),
                fluidRow(column(3, verbatimTextOutput("value"))),
                
                numericInput("num", label = h3("Введите оценку"), value = 1, min=0, max = 10),

                
                mainPanel(
                tableOutput('result')
                )
)

server <- function (input,output) { 
  
  output$result <- renderPrint({ 
    #Загрузка
    full<-read.csv("~/shauroom/clean_data_v1.csv")
    
    library(reshape2)
    library(recommenderlab)
    n = dim(full_1)[1]
    full_1[n+1, "final_grade"] = input$num 
    full_1[n+1, "number"] = input$select
    df <- as.data.frame(acast(full_1, reviewer_id~number, value.var="final_grade"))
    
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
    
    
    output$result <- renderTable(recc)
    })
}

shinyApp(ui=ui, server=server)
