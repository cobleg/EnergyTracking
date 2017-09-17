# Aggregate meter readings data

hourly.readings <- period.apply(readings.XTS[,4], endpoints(readings.XTS[,4], "hours"), sum)
hourly.readings <- align.time(hourly.readings, n=60*60)
hourly.readings$WeekDay <- .indexwday(hourly.readings)

daily.readings <- apply.daily(readings.XTS[,4], sum)
index(daily.readings) <- as.Date(index(daily.readings))
colnames(daily.readings) <- "kWh"

weekly.readings <- apply.weekly(readings.XTS, sum)

# Graph aggregated data
plot(hourly.readings)
plot(daily.readings)
plot(weekly.readings)

# Align BOM temperature data
hourly.BOM.temp <- align.time(temperature.BOM.XTS, n=60*60) # temperature.BOM.XTS is created in XTSobject.R
