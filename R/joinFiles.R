# Objective: join data sets to create a single larger data set

# Requires hourly.BOM.temp and hourly.readings, which are created in aggregateXTS.R
hourly.BOM.temp <- hourly.BOM.temp[!is.na(index(hourly.BOM.temp))]
hourly.data <- merge.xts(hourly.readings, hourly.BOM.temp, join = 'left')

filePath <- file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/hourlyData.RData")
save(hourly.data, file = filePath)

dailyTemperature.XTS <- dailyTemperature.XTS[!is.na(index(dailyTemperature.XTS))] # dailyTemperature.XTS was created in XTSobject.R
daily.data <- merge.xts(daily.readings, dailyTemperature.XTS, join = 'inner')

filePath <- file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/dailyData.RData")
save(daily.data, file = filePath)

