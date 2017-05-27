library(shiny)
library(reshape2)
library(recommenderlab)
#описание функции shaverma_recommendation в shriny/helpercode
ui <- fluidPage("Shauroom",
                selectInput("select", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("num", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                hr(),
                
                selectInput("select2", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("num2", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                hr(),
                
                selectInput("select3", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("num3", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                submitButton("Submit"),
                
                
                mainPanel(
                  tableOutput('result')
                )
)

server <- function (input,output) { 
  
  output$result <- renderTable({ 
    
    load("~/shauroom/shriny/environment.RData")
    
    print(shaverma_recommendation(input$select,input$select2,input$select3, input$num,input$num2,input$num3))
    
  })
}

shinyApp(ui=ui, server=server)