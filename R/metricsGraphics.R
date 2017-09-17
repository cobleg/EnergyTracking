# Objective: create a metricsGraphic chart

if(!"metricsgraphics" %in% rownames(installed.packages())){
  install.packages("metricsgraphics")
} 

attach("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/dailyData.R")

library(metricsgraphics)
mjs_plot(as.data.frame(daily.data), x = MaxTemp, y = kWh) %>%
  mjs_point(size_accessor = kWh) %>%
  mjs_labs(x = "Maximum temperature", y = "Electricity consumed (kWh)")
