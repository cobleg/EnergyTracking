# Objective: Create holiday dummy variable
# Dependencies: mergeFiles.R; XTSobjects.R

library(lubridate)
library(xts)
setwd('C:/Users/Grant/Google Drive/R/Projects/WattWatchers')
if(!exists("daily.data")){
  load(file.path(getwd(), 'data/dailyData.RData'))
}
if(!exists("createTimeXTS")){
  source(file.path(getwd(),'R/createTimeXTS.R'))
}
if(!exists("readings.XTS")){
  source(file.path(getwd(),'R/XTSobject.R'))
}

# remove vacation & holidays columns
daily.data <- daily.data[, (colnames(daily.data) != "events")]
daily.data <- daily.data[, (colnames(daily.data) != "vacation")]
daily.data <- daily.data[, (colnames(daily.data) != "holidays")]

filePath <- file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data", "holidays.csv")
holidays <- read.csv(file = filePath, header = T, colClasses = c("character", "character", "numeric"))
holidays.dates <- as.Date(holidays$Date, format = "%d/%m/%Y")

holidays.xts <- as.xts(holidays$Vector, order.by = holidays.dates)
names(holidays.xts) <- c("holidays")
daily.data <- merge.xts(daily.data, holidays.xts, join = 'left')
daily.data <- na.fill(daily.data, fill = 0)

Date <- seq(as.Date(index(readings.XTS[1])), as.Date(index(readings.XTS[length(readings.XTS[,1])])), "days")
daily.data$vacation <- ifelse((as.Date(Date) >= '2014-12-26') & (as.Date(Date) <= '2014-12-31') |
                              (as.Date(Date) >= '2017-06-26') & (as.Date(Date) <= '2017-07-14') , 1, 0)

daily.data$year <- year(as.Date(index(daily.data)))
save(daily.data, file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/dailyData.RData")
save(daily.data, file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/App-4/data/dailyData.RData")
