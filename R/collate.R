# Collate the meter readings in one data frame
readings.new <- data.frame(meter.1$TimeStamp, meter.1$RealEnergy, meter.2$RealEnergy, meter.3$RealEnergy)

# factorconvert <- function(f){as.numeric(levels(f))[f]}
# readings.new[, 2:4] <- lapply(readings.new[, 2:4], factorconvert)

colnames(readings.new) <- c("TimeStamp", "Meter1", "Meter2", "Meter3")
readings.new$Total <- rowSums(readings.new[,2:4])

timeStamp <- as.POSIXlt(readings.new$TimeStamp)
readings.new$hour <- as.factor(timeStamp$hour)
readings.new$day <- as.factor(timeStamp$wday)
readings.new$mday <- as.factor(timeStamp$mday)
readings.new$month <- as.factor(timeStamp$mon)

load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/Readings.RData")
readings <- rbind(readings, readings.new)
readings <- readings[order(readings$TimeStamp),]

timeStamp <- as.POSIXlt(readings$TimeStamp)
readings$hour <- as.factor(timeStamp$hour)
readings$day <- as.factor(timeStamp$wday)
readings$mday <- as.factor(timeStamp$mday)
readings$month <- as.factor(timeStamp$mon)

# Save file at 5 minute intervals
file = "Readings.RData"
filePath = file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data", file)
save(readings, file=filePath)

