
library(dplyr)
library(dygraphs)
library(ggplot2)
library(shiny)
library(shinyapps)

library(xts)

attach(("./Data/Readings.RData"))

readings.xts <- xts(readings[,-1], order.by = readings[,1])