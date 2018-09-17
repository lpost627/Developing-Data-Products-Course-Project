library(shiny)
library(ggplot2)
library(maps)
library(mapdata)

shinyServer(function(input, output) {
   
  states <- map_data("state")
  capFirst <- function(s) {
    paste(toupper(substring(s,1,1)), substring(s,2), sep = "")
  }
  states$region <- capFirst(states$region)
  state_selection <- reactive({
    subset(states, states$region %in% input$state_selection)
  })
  
  output$mapPlot <- renderPlot({
    ggplot(data = states) +
             geom_polygon(aes(x=long, y=lat, group=group), fill = "grey", color = "black") +
             coord_fixed(1.3) +
             guides(fill=FALSE) + geom_polygon(data=state_selection(), aes(x=long, y=lat, group=group), fill="blue")
  })
})

