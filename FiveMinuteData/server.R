#
# This app displays electricity readings in 5 minute intervals
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  selection <- reactive({
    y   <- first(readings.xts[paste0(input$date, "/"), 4], "1 day")
  })
  
  selection.diff <- reactive({
    x <-  (first(readings.diff[paste0(input$date, "/")], "1 day"))
  })
  
  kWh.temp <- reactive({
    x <-  (first(data.xts[paste0(input$date, "/"),], "1 day"))
  })
  
  output$dygraph.1 <- renderDygraph({
    dygraph(selection(), main = "Energy (kWh)")
 
  })
  
  output$dygraph.2 <- renderDygraph({
    dygraph(selection.diff(), main = "Change in Energy (kWh)")

  })
  
  output$dygraph.3 <- renderDygraph({
    dygraph(kWh.temp()) %>%
      dyAxis('y', label = 'Temperature') %>%
      dyAxis('y2', label = 'kWh') %>%
      dySeries("Total", axis = 'y2') %>%
      dyOptions(drawGrid = FALSE)
  })
  
})
