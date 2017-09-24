
library(dplyr)
library(dygraphs)
library(lubridate)
library(shiny)
library(shinyapps)
library(xts)

attach(("./Data/Readings.RData"))
attach(("./Data/temperature.RData"))

readings$Date <- lubridate::date(readings$TimeStamp)  # Extract dates from timestamp & add as a separate column
readings.xts <- xts(readings[,-1], order.by = readings[,1]) # convert dataframe to xts format
readings.diff <- xts(diff.xts(as.numeric(readings.xts[,4])),order.by = readings[,1]) # calculate first difference

# Add temperature data to electricity readings data
data <- merge(readings, temperature, by="Date")  
data <- data[, c(1,2,6,11)]
#data$Date <- as.Date(data$Date, format = "%d-%M-%Y")

data.xts <- xts(data[,-2], order.by = data[,2])

