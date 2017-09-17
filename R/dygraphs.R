# Objective: create a dygraph with shading for weekends

if(!"dygraphs" %in% rownames(installed.packages())){
  install.packages("dygraphs")
} 
library(dygraphs)
setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('createTimeXTS.R')

load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/readings.RData")
readings.XTS <- createTimeXTS(readings[,2:9], readings$TimeStamp)



# Create list object containing start and end dates for the shading
weekends <- lapply(startDate, function(startDate) {
  list(from = startDate, to = startDate + 60*60*24*1)
})

# Create a function to create the dyshading objects
add_shades <- function(x, periods, ...) {
  for(period in periods){
  x <- dyShading(x, from = period$from, to = period$to)
  } 
  x
}

readings.10min <- period.apply(readings.XTS$Total, endpoints(readings.XTS$Total, "minutes", 10), sum)/6

Datetime <- strptime(index(readings.10min), "%Y-%m-%d %H:%M:%S", tz="UTC"); Datetime[1]
index(readings.10min) <- Datetime - 60*60*7-60*55 # manually adjust for difference between UTC and local time
index(readings.10min)[1]

# Create a vector containing dates that correspond to successive Saturdays
readings.10min$day <- as.factor(Datetime$wday)
startDate <- unique(as.POSIXct(index(readings.10min[readings.10min$day == 7])))
# Now produce the dygraph
dygraph(readings.10min$Total) %>% 
  dyRangeSelector() %>%
  dySeries("Total", label = "Total Energy") %>%
  add_shades(weekends)

