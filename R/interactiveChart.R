
setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/App-5")
attach(("./Data/hourlyData.RData"))

library(dygraphs)
library(xts)
year <- 2015
month <- 01
day1 <- 1
day2<- day1 + 1
date.range <- paste0(year, "-", ifelse(month>9,month, paste0('0', month)), "-", day1, "::", year, "-", ifelse(month>9,month, paste0('0', month)), "-", day1)


y <- hourly.data[date.range]

plot(y[,1], main = paste0('Electricity consumption for ', month.abb[month], " ", day1, ", ", year), xlab='Time', ylab='kWh')

dygraph(y[,1], main = paste0('Electricity consumption for ', month.abb[month], " ", day1, ", ", year)) %>%
  dyAxis("y", label = "kWh")
