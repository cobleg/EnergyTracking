# Objective: Create XTS objects. This makes it easier to aggregate and match time series data
# Dependencies: createTimeXTS.R
if(!exists("createXTS")){
  source('C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R/createXTS.R')
}
load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/readings.RData")
readings.XTS <- createTimeXTS(readings[,2:9], readings$TimeStamp)

# Wifi sensor temperature & humidty data (internal)
# weather.XTS <- createTimeXTS(weather[,3:4], weather$TimeStamp)

# Create BOM temperature XTS file
load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/HourlyTemperature.RData")
temperature.BOM.XTS <- createTimeXTS(temperature.hourly[,3], temperature.hourly$TimeStamp)

load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/Temperature.RData")
dailyTemperature.XTS <- createXTS(temperature[,2:3], temperature$Date)

# load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/energy.RData")
# energy.XTS <- createTimeXTS(energy.df[,2:4], energy.df$TimeStamp)
