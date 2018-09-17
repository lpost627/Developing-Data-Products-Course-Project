
library(shiny)
library(maps)
library(mapdata)
library(ggplot2)

states <- map_data("state")
capFirst <- function(s) {
  paste(toupper(substring(s,1,1)), substring(s,2), sep = "")
}
states$region <- capFirst(states$region)
state_list <- c("")
state_list <- c(state_list, unique(states$region))
remove <- c("district of columbia")
state_list <- state_list[! state_list %in% remove]

shinyUI(fluidPage(
  titlePanel("Identify the States"),
  sidebarLayout(
    sidebarPanel(
      "Select a state to highlight:",
      selectInput("state_selection", "", state_list, selected = NULL, multiple = FALSE),
      h4("Instructions"),
      "This application allows you to choose a state to highlight on a map of the United States.
      Use the selector above to choose which state you would like to display."
    ),
    mainPanel(
      h4("Map of the United States"),
      plotOutput("mapPlot")
    )
  )
))



