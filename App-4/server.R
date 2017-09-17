## server.R ##


library(dygraphs)
library(metricsgraphics)
library(shiny)
library(shinydashboard)
library(plotly)
library(xts)

attach("./Data/dailyData.RData")
attach("./Data/hourlyData.RData")

source("helpers.r")

shinyServer(function(input, output) {
  
  # 1. Define a subset of the data based on temperature, i.e. just the hot days
  hot <- reactive({
    hourly.data.df <- as.data.frame(hourly.data)
    hot <- hourly.data.df[hourly.data.df$hourly.BOM.temp >= input$temp, ]
    hot <- hot[complete.cases(hot),]
    
    return(hot)
  })
  
  # 2. Get the dates & times for the selected hot days 
  hot.dates <- reactive({
    hotDates <- (strptime(rownames(hot()), format="%Y-%m-%d", tz="Australia/Perth"))
    
    return(hotDates)
  })
  
  # 3. Select just the days that match the chosen temperature threshold 
  hot.days <- reactive({
    hot <- xts(hot(), order.by = hot.dates())
    hot.times <- as.Date(index(hot))
    hot.dates <- strptime(index( hot ), format="%Y-%m-%d %H:%M:%S")
    
    # Select all the data for hot days
    hot.days <- hourly.data[as.Date(index(hourly.data)) %in% as.Date(hot.times),]
    
    return(hot.days)
  })
  
  # 4. Exclude weekends if desired
  hotDayList <- reactive({
    if (input$weekends){ hot.days <- hot.days()[!weekdays(index(hot.days())) %in% c("Saturday", "Sunday")] 
    }else{ hot.days <- hot.days() }
    hotDayList <- index(hot.days)
    attr(hotDayList, "tzone") <- "AWST"
    return(hotDayList)
  })
  
  # 5. Count the number of days in the selected sample
  hot.days.count <- reactive({
    DatesOnly <- unique(substr(hotDayList(), 1, 10))
    length(unique(as.Date(DatesOnly)))
  })
  
  # 6. Create an interactive slider for selecting which hot day to view on the chart
  output$slider <- renderUI({
    sliderInput("HotDay", "Select a hot day to compare",
                value = 1, min = 1, max =  hot.days.count(), step = 1)
  })
  
  # 7. Prepare chart data
  chart.data <- reactive({
    # exclude weekends
    
    if (input$weekends){ hot.days <- hot.days()[!weekdays(index(hot.days())) %in% c("Saturday", "Sunday")]
    }else{ hot.days <- hot.days() }
    
    # extract hour of the day from hot.days
    hot.days$hour = .indexhour(hot.days)
    
    # calculate percentiles for hot.days data
    
    average.profile <- percentile.profile(hot.days, 50, "Median.kWh")
    lower.profile <- percentile.profile(hot.days, input$lower.percentile, "Lower.kWh")
    names(average.profile) <- c("Hour","Median.kWh")
    names(lower.profile) <- c("Hour", "Lower.kWh")
    
    upper.profile <- percentile.profile(hot.days, input$upper.percentile, "Upper.kWh")
    names(upper.profile) <- c("Hour", "Upper.kWh")
    
    # select one of the hot days & chart it
    hotDayList <- index(hot.days)
    attr(hotDayList, "tzone") <- "UTC"
    
    DatesOnly <- unique(substr(hotDayList, 1, 10))
    
    HotDay.1 <- input$HotDay
    if (is.null(HotDay.1)) return(1)
    
    selectedHotDay <- hotDayList[grepl(DatesOnly[HotDay.1], hotDayList)]
    
    hot.day <- hourly.data[paste0(selectedHotDay, "/", selectedHotDay), ]
    
    # combine the daily average.profile and the selected hot day
    hot.day.2 <- hot.day[, "Total"]
    names(hot.day.2) <- c("HotDay.kWh")
    
    rownames(average.profile) <- (index(hot.day.2))
    average.profile <- xts(average.profile, order.by = as.POSIXlt(rownames(average.profile)))
    
    rownames(upper.profile) <- index(hot.day.2)
    upper.profile <- xts(upper.profile, order.by = as.POSIXlt(rownames(upper.profile)))
    
    rownames(lower.profile) <- index(hot.day.2)
    lower.profile <- xts(lower.profile, order.by = as.POSIXlt(rownames(lower.profile)))
    
    chart.data <- merge.xts(hot.day = hot.day.2, average.profile, "inner")
    chart.data <- chart.data[,c(-2,-4)]
    chart.data <- merge.xts(chart.data, upper.profile, "inner")
    chart.data <- chart.data[,c(-3,-5)]
    chart.data <- merge.xts(chart.data, lower.profile, "inner")
    chart.data <- chart.data[,c(-4,-6)]
    
    # create new date-time index
    index.StartYear <- format(start(chart.data), "%Y")
    index.StartMonth <- format(start(chart.data), "%m")
    index.StartDay <- format(start(chart.data), "%d")  
    index.StartHour <- format(start(chart.data), "%H")
    index.length <- length(index(chart.data))
    Date.Time <- seq(c(ISOdatetime(year = index.StartYear, month = index.StartMonth, day = index.StartDay, hour = 0, min = 0, sec=0, tz = "AWST")), by = "hour", length.out = index.length)
    Date.Time <- Date.Time - 8*60*60
    row.names(chart.data) <- Date.Time
    chart.data <- as.data.frame(chart.data)
    chart.data <- xts(chart.data, order.by = Date.Time)
    tzone(chart.data) <- "AWST"
    
    return(chart.data)
  })
  

output$graph1 <- renderDygraph({Energy.data <- cbind(daily.data[,"kWh"], daily.data[,"MaxTemp"])
  
                                vacation <- as.Date(index(daily.data[daily.data$Vacation == 1]))
                                startDate <- vacation[1]
                                endDate <- vacation[length(vacation)]
                                
                                insulationInstalled <- as.Date(index(daily.data)) >= as.Date("2016-08-01")
                                startDate2 <- as.Date(index(daily.data[min(which(insulationInstalled[insulationInstalled = TRUE]))]))
                                endDate2 <- as.Date(index(daily.data[length(insulationInstalled)]))
                                
                                dygraph(Energy.data) %>% 
                                dySeries("MaxTemp", label = "Maximum Temperature", axis = 'y2') %>%
                                dyRangeSelector() %>%
                                dyShading(from = startDate, to = endDate, color = "grey") %>%
                                dyShading(from = startDate2, to = endDate2, color = "bisque") %>%
                                dyEvent(x = "2014-12-25", label = "Christmas Day") %>%
                                dyEvent(x = "2015-1-1", label = "New Year's Day") %>%
                                dyEvent(x = "2015-1-26", label = "Australia Day") %>%
                                dyEvent(x = "2015-3-2", label = "Labour Day") %>%
                                dyEvent(x = "2015-4-3", label = "Good Friday") %>%
                                dyEvent(x = "2015-4-6", label = "Easter Monday") %>%
                                dyEvent(x = "2015-4-27", label = "ANZAC Day") %>%
                                dyEvent(x = "2015-6-1", label = "Western Australia Day") %>%
                                dyEvent(x = "2015-9-28", label = "Queen's Birthday") %>%
                                dyEvent(x = "2015-12-25", label = "Christmas Day") %>%
                                
                                dyEvent(x = "2016-1-1", label = "New Year's Day") %>%
                                dyEvent(x = "2016-1-26", label = "Australia Day") %>%
                                dyEvent(x = "2016-3-5", label = "Labour Day") %>%
                                dyEvent(x = "2016-3-30", label = "Good Friday") %>%
                                dyEvent(x = "2016-4-2", label = "Easter Monday") %>%
                                dyEvent(x = "2016-4-25", label = "ANZAC Day") %>%
                                dyEvent(x = "2016-6-4", label = "Western Australia Day") %>%
                                dyEvent(x = "2016-9-24", label = "Queen's Birthday") %>%
                                dyEvent(x = "2016-12-25", label = "Christmas Day") %>%
                                
                                dyEvent(x = "2017-1-1", label = "New Year's Day") %>%
                                dyEvent(x = "2017-1-26", label = "Australia Day") %>%
                                dyEvent(x = "2017-3-5", label = "Labour Day") %>%
                                dyEvent(x = "2017-3-30", label = "Good Friday") %>%
                                dyEvent(x = "2017-4-2", label = "Easter Monday") %>%
                                dyEvent(x = "2017-4-25", label = "ANZAC Day") %>%
                                dyEvent(x = "2017-6-4", label = "Western Australia Day") %>%
                                dyEvent(x = "2017-9-24", label = "Queen's Birthday") %>%
                                dyEvent(x = "2017-12-25", label = "Christmas Day") %>%
                                dyEvent(x = "2017-12-25", label = "Boxing Day")
                                
                                })



output$graph2 <- renderDygraph({
 
  Datetime <- strptime(index(hourly.data), "%Y-%m-%d %H:%M:%S", tz = "UTC")
  # index(hourly.data) <- Datetime - 60*60*8
  
   
  startDate <- unique(as.Date(index(hourly.data[hourly.data$WeekDay == 6])))
  
  # Create list object containing start and end dates for the shading
  weekends <- lapply(startDate, function(startDate) {
    list(from = startDate, to = startDate + 1)
  })
  
  # Create a function to create the dyshading objects
  add_shades <- function(x, periods, ...) {
    for(period in periods){
      x <- dyShading(x, from = period$from, to = period$to)
    } 
    x
  }
  dygraph(hourly.data[,"Total"]) %>% 
    dyRangeSelector() %>%
    dySeries("Total", label = "Total Energy") %>%
    add_shades(weekends)
  })

output$graph3 <- renderMetricsgraphics({
  library(metricsgraphics)
  mjs_plot(as.data.frame(daily.data), x = MaxTemp, y = kWh) %>%
    mjs_point(size_accessor = kWh) %>%
    mjs_labs(x = "Maximum temperature", y = "Electricity consumed (kWh)") 
    
  })

output$graph4 <- renderPlotly({
  plot_ly(as.data.frame(daily.data), x = ~MaxTemp, y = ~kWh, color = ~year)
})

# 8. create interactive chart
output$graph5 <- renderDygraph({
  
  if(is.xts(chart.data())){
    dygraph(data=chart.data()) %>%
      dySeries(c("Lower.kWh", "Median.kWh", "Upper.kWh"), label = "Hotday profile") %>%
      dyOptions(colors = RColorBrewer::brewer.pal(3, "Dark2")) %>%
      dyAxis("y", label = "kWh") %>%
      dyOptions( drawGrid = input$showgrid, labelsUTC =  F)
  }
  
}) 



})
