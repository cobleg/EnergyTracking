#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  selection <- reactive({
    y   <- first(readings.xts[paste0(input$date, "/"), 4], "1 day")
  })
  
  output$dygraph <- renderDygraph({
    
    dygraph(selection(), main = "Energy (kWh)")
    

  })
  
})
