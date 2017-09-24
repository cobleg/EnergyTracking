#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

shinyUI(fluidPage(
  titlePanel("Five minute profile"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        'maxTemp',
        label = "Select maximum temperature",
        value = 40,
        min = 25,
        max = 45,
        step = 1), # subset on temperature

      uiOutput("selector")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Levels",dygraphOutput("dygraph.1")),
        tabPanel("Difference", dygraphOutput("dygraph.2")),
        tabPanel("Levels vs Temperature", dygraphOutput("dygraph.3")),
        tabPanel("Levels vs Temperature", dataTableOutput("table")) #
        ))
       )
  )
)

