
# ui.r
# library(dygraphs)

shinyUI(fluidPage(
  
  titlePanel("Intra-day electricity consumption profile"),
  
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("slider"),
      
      # sliderInput("HotDay", label = "Select a hot day to compare", 
      #              value = 1, min = 1, max =  41),
      sliderInput("upper.percentile", label = "Select upper percentile",
                  value = 90, min = 50, max = 100),
      sliderInput("lower.percentile", label = "Select lower percentile",
                  value = 10, min = 5, max = 50),
      checkboxInput("showgrid", label = "Show Grid", value = TRUE),
      
      checkboxInput("weekends", label = "Exclude weekends", value = TRUE),
      
      numericInput("temp", label = h3("Enter temperature (Celsius) threshold for comparison"),
                  min = 1, max = 40, value = 35)
    ),
    mainPanel(
      dygraphOutput("dygraph"),
      
      br(),
      
      tableOutput("table.2")
      
      
      
    )
  )
))