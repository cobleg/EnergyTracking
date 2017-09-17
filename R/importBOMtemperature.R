# Objective: Import temperature data
setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data")

maxTemperatureJandakot <- read.csv("C:/Users/Grant/Google Drive/WattWatchers energy monitor/Temperature/IDCJAC0010_009172_1800_Data.csv",
                                   header = T, stringsAsFactors = F)
minTemperatureJandakot <- read.csv("C:/Users/Grant/Google Drive/WattWatchers energy monitor/Temperature/IDCJAC0011_009172_1800_Data.csv",
                                    header = T, stringsAsFactors = F)

tempColNumber = 6

startDate.max <- paste(head(maxTemperatureJandakot$Year, n = 1),
                     head(maxTemperatureJandakot$Month, n = 1),
                     head(maxTemperatureJandakot$Day, n = 1), sep = "-")

startDate.min <- paste(head(minTemperatureJandakot$Year, n = 1),
                       head(minTemperatureJandakot$Month, n = 1),
                       head(minTemperatureJandakot$Day, n = 1), sep = "-")

endDate.max <- paste(tail(maxTemperatureJandakot$Year, n = 1),
                 tail(maxTemperatureJandakot$Month, n = 1),
                 tail(maxTemperatureJandakot$Day, n = 1), sep = "-")

endDate.min <- paste(tail(minTemperatureJandakot$Year, n = 1),
                     tail(minTemperatureJandakot$Month, n = 1),
                     tail(minTemperatureJandakot$Day, n = 1), sep = "-")

maxTemperatureJandakot$Date <- seq(from = as.Date(startDate.max), to = as.Date(endDate.max), by = "day")
minTemperatureJandakot$Date <- seq(from = as.Date(startDate.min), to = as.Date(endDate.min), by = "day")

names(maxTemperatureJandakot)[tempColNumber] <- "MaxTemp"
names(minTemperatureJandakot)[tempColNumber] <- "MinTemp"

TemperatureJandakot.max <- data.frame(Date = maxTemperatureJandakot$Date, MaxTemp = maxTemperatureJandakot$MaxTemp)
TemperatureJandakot.min <- data.frame(Date = minTemperatureJandakot$Date, MinTemp = minTemperatureJandakot$MinTemp)

temperature <- merge(TemperatureJandakot.max, TemperatureJandakot.min, by = "Date") 
save(temperature, file = 'temperature.RData')
