library(leaflet)
library(shiny)
library(RCurl)
library(readr)
library(shinydashboard)
library(googlesheets)
library(recommenderlab)
library(reshape2)
library(dplyr)
#clean_data_v3 <- readr::read_csv("clean_data_v3.csv")
#unique_idshava <- readr::read_csv("unique_idshava.csv")
#storage = clean_data_v3
#egarots = unique_idshava
#egarots$X <- NA
#write.csv(storage[,2:4], "storage.csv")

storage <- readr::read_csv("storage.csv")
egarots <- readr::read_csv("egarots.csv")

# body <- shinydashboard::dashboardBody(
#   fluidRow(
#     box(title='Map',
#         status = "primary",
#         uiOutput("script"),
#         tags$div(id = "garbage"),
#         tags$head(tags$script(type="text/javascript", src="//vk.com/js/api/openapi.js?146")),
#         mainPanel(leafletOutput("map")))
#     
#   ),
#   p(),
#   fluidRow(
#     box(title='Авторизуйтесь',
#         sidebarPanel(
#           # не юзается
#           textOutput('text'),
#           solidHeader = TRUE,
#           collapsible = TRUE,
#           actionButton("groups", "Паблосы"),
#           # textOutput("Showcase"),
#           textOutput("hummary")
#        ),
#     box(title= 'Address',
#         textOutput("summary")),
#     p(),
#     box(title = 'Рекомендации',
#         actionButton("recs", "Рекомендовать"),
#         textOutput("recst")
#         ),
#     box(title = 'Узнай, сколько шаверм ты оценил',
#         actionButton("countscoreb", "???"),
#         textOutput("countscoret")
#     ),
#     box(tags$script(HTML("")),
#           tags$script(type="text/javascript", HTML("VK.init({apiId: 6063999});")),
#           tags$div(id="vk_auth"),
#           tags$script(type="text/javascript",
#                       HTML("VK.Widgets.Auth('vk_auth',
#                            {authUrl: 'https://rvefimov.shinyapps.io/goodworkshiny/'});")))
#         # tags$script(type="text/javascript",
#         #             HTML("VK.Widgets.Auth('vk_auth', {onAuth: function(data)
#         #                  {alert('user '+data['uid']+' authorized');} });")))
#         
#     ))
#   )
# ui <- dashboardPage(
#   dashboardHeader(title = "Your shauroom"),
#   dashboardSidebar(),
#   body
# )

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  uiOutput("script"),
  tags$div(id = "garbage"),
  tags$head(tags$script(type="text/javascript", src="//vk.com/js/api/openapi.js?146")),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                box(sidebarPanel(width = 17,
                  # не юзается
                  textOutput('text'), #?
                  textOutput("summary"),
                  fixed = TRUE,
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  actionButton("recs", "Рекомендовать"),
                  textOutput("recst"),
                  actionButton("groups", "Паблосы"),
                  textOutput("hummary"),
                  actionButton("countscoreb", "Сколько ты оценил?"),
                  textOutput("countscoret"),
                  tags$script(HTML("")),
                  tags$script(type="text/javascript", HTML("VK.init({apiId: 6063999});")),
                  tags$div(id="vk_auth"),
                  tags$script(type="text/javascript",
                              HTML("VK.Widgets.Auth('vk_auth',
                           {authUrl: 'https://rvefimov.shinyapps.io/goodworkshiny/'});"))
                ))))

server = function(input, output, session){
  
  # output$text <- renderText({
  #   query <- parseQueryString(session$clientData$url_search)
  #   paste(names(query), query, sep = "=", collapse=", ")
  #   print(query$uid[1])
  #   getURL(paste('https://api.vk.com/method/users.getSubscriptions?user_id=', query$uid[1], 
  #                "&extended=0&fields=id,name12", "&v=5.62", sep = ""))
  #   
  # })
  
  # Just for Show
  text <- NULL #?
  event <- NULL
  
  makeReactiveBinding("text") #?
  output$Showcase <- renderText({text}) #?
  
  output$popup <- renderUI({tagList(
    # address???
    HTML(paste(egarots[egarots$idshava == input$map_marker_click$id, "name"], 
          egarots[egarots$idshava == input$map_marker_click$id, "right_addres"], sep="<br/>")),
    sliderInput("ratesl", "Оцените шавермечную", min = 1, max = 5, value = 3, step = 0.5),
    HTML(paste("<center>", actionButton("rateac", "Подтвердить"), "</center>"))
    # submitButton("Update View", icon("refresh"))
  )})
  
  output$summary <- renderText({
    if (input$rateac == 0)
      return()
    #data = unique_idshava # загрузили данные
    event <- input$map_marker_click # считали нажатие на маркер
    #input$rateac # нажатие на кнопку "Подтвердить" запускает скрипт
    name = egarots[egarots$idshava == event$id, "name"] # получаем название шавки
    address = egarots[egarots$idshava == event$id, "right_addres"] # получаем адрес шавки
    #isolate(storage[storage$idshava == event$id, "X"] <<- input$ratesl) # робит, но с ошибками
    storage<-read.csv("storage.csv")
    if (nrow((storage[((storage$idshava == event$id) & 
                  (storage$reviewer_id == parseQueryString(session$clientData$url_search)$uid[1])), ])) == 0){
    storage[nrow(storage)+1,] <- NA
    isolate(storage[(nrow(storage)),"reviewer_id"] <- parseQueryString(session$clientData$url_search)$uid[1])
    isolate(storage[(nrow(storage)),"idshava"] <- event$id)
    isolate(storage[(nrow(storage)),"score"] <- (input$ratesl)*2)
    }
    else {
    isolate(storage[((storage$idshava == event$id) & 
                               (storage$reviewer_id == parseQueryString(session$clientData$url_search)$uid[1])),"score"] <- input$ratesl)  
    }
    write.csv(storage,"storage.csv")
    paste0('id шавермешной: ', event$id, "\n",
           ', адрес: ', address,
           ', название: ', name,
           ', оценка ', isolate(input$ratesl),
           ' записанная оценка ', isolate((storage[((storage$idshava == event$id) & 
                                             (storage$reviewer_id == parseQueryString(session$clientData$url_search)$uid[1])), "score"])),
           ' количество строк  ', nrow(storage) ) # выводим текст
    
  }) 
  
  output$recst <- renderText({
    if (input$recs == 0)
      return()
    storage <- readr::read_csv("storage.csv")
    df <- as.data.frame(acast(storage, reviewer_id~idshava, value.var="score"))
    matrix<-as.matrix(df)
    realm <- as(matrix, "realRatingMatrix")
    model<-Recommender(realm, method = "UBCF")
    #predicted <- predict(object=model, newdata=realm[parseQueryString(session$clientData$url_search)$uid[1],],n=5)
    #paste0(as(predicted, "list"))
    shavas <- as.data.frame(as(predict(object=model, 
                  newdata=realm[parseQueryString(session$clientData$url_search)$uid[1],],n=5), 
                  "list"))
    colnames(shavas)<- "idshava"
    shavas <- inner_join(shavas, egarots[,c("idshava", "right_addres")], by = "idshava")
    noquote(strsplit(paste(paste(shavas[,"right_addres"], "\n"), collapse = ""), " \n")[[1]])
    # shavas<-as.data.frame(as(predicted, "list"))
    # colnames(shavas)<- c("idshava")
    # shavas<-inner_join(shavas, egarots, by = "idshava")
    # paste('Адреса рекомендованной шавермы:')
    # paste0(as(predicted, "list"))
    
    # paste0(as(predict(object=model, newdata=realm[2545,]), "list"))
    # shavas <- as.data.frame(as(predict(object=model, newdata=realm[2545,]), "list"))
    # colnames(shavas)<- "idshava"
    # shavas<-inner_join(shavas, egarots[,c("idshava", "right_addres")], by = "idshava")
    # noquote(strsplit(paste(paste(shavas[,"right_addres"], "\n"), collapse = ""), " \n")[[1]])
    })

  output$countscoret <- renderText({
    if (input$countscoreb == 0)
      return()
    storage <- readr::read_csv("storage.csv")
    df <- as.data.frame(acast(storage, reviewer_id~idshava, value.var="score"))
    matrix<-as.matrix(df)
    realm <- as(matrix, "realRatingMatrix")
    a <- realm[parseQueryString(session$clientData$url_search)$uid[1],]
    paste("У нас есть столько твоих оценок: " , nrow(as(a, "data.frame")))
    })
  
  output$hummary <- renderText({
    if ((input$groups == 0) | (length(parseQueryString(session$clientData$url_search)) == 0))
      return()
    input$groups # нажатие на кнопку "Подтвердить" запускает скрипт
    isolate(query <- parseQueryString(session$clientData$url_search))
    isolate(getURL(paste('https://api.vk.com/method/users.getSubscriptions?user_id=', query$uid[1], 
                         "&extended=0&fields=id,name", "&v=5.62", sep = ""))) # выводим текст
  }) 
  
  
  
  ### тоже рабочий вариант
  # observeEvent(input$Go2, {text <<- paste0(text, "\n", input$dynamic)})
  
  ### так было реализовано первоначально
  # output$popup3 <- renderUI({
  #   actionButton("Go3", "Go3")})
  # observeEvent(input$Go3, {
  #   text <<- paste0(text, "\n", "Button 3 is fully reactive.")})
  
  
  ### хз что это. что это?!
  output$script <- renderUI({
    tags$script(HTML('
                     var target = document.querySelector(".leaflet-popup-pane");
                     
                     var observer = new MutationObserver(function(mutations) {
                     mutations.forEach(function(mutation) {
                     if(mutation.addedNodes.length > 0){
                     Shiny.bindAll(".leaflet-popup-content");
                     };
                     if(mutation.removedNodes.length > 0){
                     var popupNode = mutation.removedNodes[0].childNodes[1].childNodes[0].childNodes[0];
                     
                     var garbageCan = document.getElementById("garbage");
                     garbageCan.appendChild(popupNode);
                     
                     Shiny.unbindAll("#garbage");
                     garbageCan.innerHTML = "";
                     };
                     });    
                     });
                     
                     var config = {childList: true};
                     
                     observer.observe(target, config);
                     '))})
      
      #tags$script(HTML('alert(document.URL)'))
      ### первоначальный вариант (п. 1)      
      ### код для вставки попапов
      # popupMaker <- function(id){
      #   a = as.character(uiOutput(id))
      #   b = strsplit(a, " ")
      #   paste(b[[1]][1], b[[1]][2], "style='min-width:10000px;max-height:500px'", b[[1]][3])}
      
  getColor <- function(quakes) {
    sapply(quakes$mag, function(mag) {
      if(mag <= 4) {
        "green"
      } else if(mag <= 5) {
        "orange"
      } else {
        "red"
      } })
  }
  
  
      # рисуем карту
      output$map <- renderLeaflet({
        leaflet(egarots) %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE)) %>% 
          setView(lng = 30.307184, lat = 59.944156, zoom = 10) %>% 
          ### первоначальный вариант (п. 2)
          #     addMarkers(~coord1, ~coord2, layerId = c(data$idshava),
          #                popup = lapply(paste0("popup", 1:3), popupMaker))})
          addMarkers(~coord1, ~coord2, layerId = c(egarots$idshava),
                     popup = "<div id=\"popup\" style='min-width:250px;max-height:500px'
                     class=\"shiny-html-output\"></div>")}) 
      
      
      
       
      }
shinyApp(ui=ui, server=server)
