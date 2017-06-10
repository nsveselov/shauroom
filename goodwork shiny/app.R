library(leaflet)
library(shiny)
library(RCurl)
library(readr)
clean_data_v3 <- readr::read_csv("clean_data_v3.csv")
unique_idshava <- readr::read_csv("unique_idshava.csv")
storage = clean_data_v3
egarots = unique_idshava
egarots$X <- NA

ui = shinyUI(
  fluidPage(
    
    # Copy this part here for the Script and disposal-div
    uiOutput("script"),
    tags$div(id = "garbage"),
    tags$head(tags$script(type="text/javascript", src="//vk.com/js/api/openapi.js?146")),
    mainPanel(leafletOutput("map")),
    sidebarPanel(
      # не юзается
      textOutput('text'),
      actionButton("groups", "Паблосы"),
      # textOutput("Showcase"),
      textOutput("hummary"),
      textOutput("summary"),
      tags$script(HTML("")),
      tags$script(type="text/javascript", HTML("VK.init({apiId: 6063999});")),
      tags$div(id="vk_auth"),
      tags$script(type="text/javascript",
                  HTML("VK.Widgets.Auth('vk_auth',
                       {authUrl: 'https://vasilina11.shinyapps.io/goodworkshiny/'});")))
    # tags$script(type="text/javascript",
    #             HTML("VK.Widgets.Auth('vk_auth', {onAuth: function(data)
    #                  {alert('user '+data['uid']+' authorized');} });")))
    
      )
)

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
  text <- NULL
  event <- NULL
  
  makeReactiveBinding("text")
  output$Showcase <- renderText({text})
  
  output$popup <- renderUI({tagList(
    sliderInput("ratesl", "Оцените шавермечную", min = 1, max = 5, value = 3),
    actionButton("rateac", "Подтвердить")
    # submitButton("Update View", icon("refresh"))
  )})
  
  output$summary <- renderText({
    if (input$rateac == 0)
      return()
    data = unique_idshava # загрузили данные
    event <- input$map_marker_click # считали нажатие на маркер
    #input$rateac # нажатие на кнопку "Подтвердить" запускает скрипт
    name = data[data$idshava == event$id, "name"] # получаем название шавки
    address = data[data$idshava == event$id, "right_addres"] # получаем адрес шавки
    isolate(egarots[egarots$idshava == event$id, "X"] <<- input$ratesl) # робит, но с ошибками
    paste0('id шавермешной: ', event$id, "\n",
           ', адрес: ', address,
           ', название: ', name,
           ', оценка ', isolate(input$ratesl)) # выводим текст
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
      
      # рисуем карту
      data = unique_idshava
      output$map <- renderLeaflet({
        leaflet(data) %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE)) %>% 
          ### первоначальный вариант (п. 2)
          #     addMarkers(~coord1, ~coord2, layerId = c(data$idshava),
          #                popup = lapply(paste0("popup", 1:3), popupMaker))})
          addMarkers(~coord1, ~coord2, layerId = c(data$idshava),
                     popup = "<div id=\"popup\" style='min-width:10000px;max-height:500px'
                     class=\"shiny-html-output\"></div>")})
      
      
      
      
      }
shinyApp(ui=ui, server=server)
