# Additional variables for readings.new data set
timeStamp <- as.POSIXlt(readings.new$TimeStamp)

# readings.new$hour <- as.factor(timeStamp$hour)
# readings.new$day <- as.factor(timeStamp$wday)
# readings.new$mday <- as.factor(timeStamp$mday)
# readings.new$month <- as.factor(timeStamp$mon)
# 
# 
# readings <- rbind(readings, readings.new)

readings$hour <- as.factor(timeStamp$hour)
readings$day <- as.factor(timeStamp$wday)
readings$mday <- as.factor(timeStamp$mday)
readings$month <- as.factor(timeStamp$mon)


filePath = file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data","Readings.RData")
save(readings, file = filePath)
