## ui.r ##

# Display Wattwatchers data

library(dygraphs)
library(metricsgraphics)
library(shiny)
library(shinydashboard)
library(plotly)
library(xts)


ui <- dashboardPage(
  dashboardHeader(title = "Electricity use"),
  dashboardSidebar(sidebarMenu(
    menuItem("Introduction", tabName = "introduction", icon = icon("book")),
    menuItem("Time series graphs", tabName = "timeseries", icon = icon("dashboard")),
    menuItem("Scatter graphs", tabName = "scatterplots", icon = icon("bar-chart")),
    menuItem("Intra-day profiles", tabName = "profiles", icon = icon("line-chart"))
  )),
  dashboardBody(tabItems(
    # First tab content
    tabItem(tabName = "introduction",
            fluidRow(
              box(tags$h3("Introduction"),
                  tags$body("This dashboard provides simple analytical graphs
                                  and metrics related to household electricity consumption.
                                  The electricity consumption data is provided by a wi-fi enabled Wattwatchers Auditor 3.
                            
                                  The electricity consumed is from a four bedroom, 2 bathroom double brick and tile house in the Perth (Western Australia) metropolitan area. There is a 12 kW output / 4kW input
                                  Fujitsu air-conditioner installed in 2003, which can account for most of the electricity consumption during a Perth heat wave. There are also pool pumps and an 
                                  electric oven. The electric oven is typically not used during heatwave events.
                            
                             After recording baseline data for 18 months, the insulation was upgraded by installing sprayfoam insulation in the roof cavity (August 2016), upgrading
                            the house thermal rating to 5.6. "), 
                  width = '350')
            )),
    tabItem(tabName = "timeseries",
            fluidRow(
              box(tags$h3("Time series of electricity consumption"), tags$body("for a four bedroom, two bathroom house in Perth, Western Australia.
                                                                               The shaded region (i.e. the bisque shade) indicates the installation of sprayfoam insulation, which 
                                                                               increased the thermal rating of the house to 5.6"), tags$p(),tags$p(),
                dygraphOutput('graph1'), title = "kWh / day", width = '350')
            ),
            
            fluidRow(
              box(dygraphOutput('graph2'), title = "kWh / hour", width = '350')
            )),
    
    tabItem(tabName = "scatterplots",
            fluidRow(
              box(width = 50, tags$h3("Temperature versus electricity consumption"),
                  tags$body("The graph belows indicates that there is a clear relationship between
                            the daily maximum temperature and the amount of electricity consumed. This
                            is largely due to the use of a 12kW output / 4 kW input Fujitsu air-conditioner during periods of extreme
                            hot and cold.")),
              box(width=50, metricsgraphicsOutput('graph3'), title = "Temperature versus electricity")
              
              ),
            fluidRow(
              box(width=50, tags$h3("Scatter plot by year"),
                  tags$body("The graph below shows the relationship between maximum daily temperature
                            and electricity consumed by year. Observing the relationship by year reveals 
                            any difference following the installation of sprayfoam insulation in August 2016."),
              box(width=50,plotlyOutput('graph4'), title = "Temperature versus electricity by year")
            ))
           
            ),
    tabItem(tabName = "profiles",
            fluidRow(
              titlePanel("Intra-day electricity consumption profile"),
              
              sidebarLayout(
                sidebarPanel(
                  uiOutput("slider"),
                  
                  sliderInput("upper.percentile", label = "Select upper percentile",
                              value = 90, min = 50, max = 100),
                  sliderInput("lower.percentile", label = "Select lower percentile",
                              value = 10, min = 5, max = 50),
                  checkboxInput("showgrid", label = "Show Grid", value = TRUE),
                  
                  checkboxInput("weekends", label = "Exclude weekends", value = TRUE),
                  
                  numericInput("temp", label = h3("Enter temperature (Celsius) threshold for comparison"),
                               min = 1, max = 40, value = 35)
                ),
                box(
                  dygraphOutput("graph5"),
                  
                  br(),
                  
                  tableOutput("table.2")
                  
                )
              )
            ))
  ))
  
)
