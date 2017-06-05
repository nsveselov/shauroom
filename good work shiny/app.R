library(leaflet)
library(shiny)

runApp(
  shinyApp(
    ui = shinyUI(
      fluidPage(
        
        # Copy this part here for the Script and disposal-div
        uiOutput("script"),
        tags$div(id = "garbage"),
        mainPanel(leafletOutput("map")),
        sidebarPanel(
          # не юзается
          # textOutput("Showcase"),
          textOutput("summary"))
      )
    ),
    
    server = function(input, output, session){
      
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
        data = unique_idshava # загрузили данные
        event <- input$map_marker_click # считали нажатие на маркер
        input$rateac # нажатие на кнопку "Подтвердить" запускает скрипт
        name = data[data$idshava == event$id, "name"] # получаем название шавки
        address = data[data$idshava == event$id, "right_addres"] # получаем адрес шавки
        paste0('id шавермешной: ', event$id, "\n",
               ', адрес: ', address,
               ', название: ', name,
               ', оценка ', isolate(input$ratesl))}) # выводим текст

      
      
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
        ), launch.browser = TRUE
      )

# https://rstudio.github.io/leaflet/shiny.html можно сделать карту на весь экран
