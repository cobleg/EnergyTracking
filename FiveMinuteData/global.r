
library(dplyr)
library(dygraphs)
library(ggplot2)
library(shiny)
library(shinyapps)

library(xts)

attach(("./Data/Readings.RData"))

readings.xts <- xts(readings[,-1], order.by = readings[,1])
readings.diff <- xts(diff.xts(as.numeric(readings.xts[,4])),order.by = readings[,1])