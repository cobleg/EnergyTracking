#
# This app displays electricity readings in 5 minute intervals
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Subset data based on temperature selection
  hotDays <- reactive({
    hotDays <- data[data$MaxTemp >= input$maxTemp,]
    hot <- hotDays[complete.cases(hotDays),]
    return(hot)
  })
  
  # Get the dates & times for the selected hot days 
  hot.dates <- reactive({
    hotDates <- as.Date(hotDays()$Date, format="%d-%m-%Y")
    return(hotDates)
  })
  
  # create a selector UI input to choose date
  output$selector <- renderUI({
      selectInput(
        "selectedDate", 
        "Select date", 
        choices = hot.dates()
        )
  })
  
  # Get the data for the chosen date
  selection <- reactive({
    y   <- first(readings.xts[paste0(input$selectedDate, "/"), 4], "1 day")
  })
  
  selection.diff <- reactive({
    x <-  (first(readings.diff[paste0(input$selectedDate, "/")], "1 day"))
  })

  kWh.temp2 <- reactive({
    x <- first(data.xts[paste0(input$selectedDate, "/")], "1 day")
  })
  
  # Create the charts
  output$dygraph.1 <- renderDygraph({
    dygraph(selection(), main = "Energy (kWh)")
 
  })
  
  output$dygraph.2 <- renderDygraph({
    dygraph(selection.diff(), main = "Change in Energy (kWh)")

  })
  
  output$dygraph.3 <- renderDygraph({
    dygraph(kWh.temp2()) %>%
      dyAxis('y', label = 'Temperature') %>%
      dyAxis('y2', label = 'kWh / 5 minutes') %>%
      dySeries("MaxTemp", axis = 'y') %>%
      dySeries("Total", axis = 'y2') %>%
      dyOptions(drawGrid = FALSE)
  })
  
  # Create the tables
  output$table <- renderDataTable(kWh.temp2())
  
})
