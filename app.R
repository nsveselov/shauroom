library(shiny)
library(reshape2)
library(recommenderlab)
#описание функции shaverma_recommendation в shriny/helpercode
load("environment.RData")
ui <- fluidPage("Shauroom",
                selectInput("select", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("grade", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                hr(),
                
                selectInput("select1", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("grade1", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                hr(),
                
                selectInput("select2", label = h3("Выберите шаверменную"), 
                            choices = namesAdrr, 
                            selected = 1),
                
                numericInput("grade2", label = h3("Введите оценку"), value = 1, min=0, max = 10),
                
                submitButton("Submit"),
                
                
                mainPanel(
                  tableOutput('result')
                )
)

server <- function (input,output) { 
  input$Submit
  output$result <- renderTable({ 
    
    load("environment.RData")
    
    print(shaverma_recommendation(input$select,input$select1,input$select2, input$grade,input$grade1,input$grade2))
    
  })
}

shinyApp(ui=ui, server=server)
