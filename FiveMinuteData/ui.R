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
      uiOutput("slider"),
      
      sliderInput(
        "date",
        label = "Select date",
        value = as.Date("01-01-2016", "%d-%m-%Y"),
        min = as.Date("23-11-2014", "%d-%m-%Y"),
        max = as.Date("31-08-2016", "%d-%m-%Y")
      )

    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Levels",dygraphOutput("dygraph.1")),
        tabPanel("Difference", dygraphOutput("dygraph.2")),
        tabPanel("Levels vs Temperature", dygraphOutput("dygraph.3"))
        ))
       )
  )
)

