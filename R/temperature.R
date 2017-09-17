# Import temperature & humidity readings
library(zoo)
filePath <- ("C:/Users/Grant/Google3/Google Drive/WattWatchers energy monitor")
file <- file.path(filePath, "Temperature.csv")

colNames <- c("Index","TimeStamp", "Temperature", "Humidity")
colClasses <- c("numeric","character", rep("numeric", 2))

weather <- read.table(file, sep=",", col.names=colNames, colClasses=colClasses, skip = 1, header = F)
weather <- weather[!duplicated(weather),]
weather$TimeStamp <- as.POSIXct(strptime(weather$TimeStamp, "%d/%m/%Y %H:%M"))
weather$TimeStamp <- round.POSIXct(weather$TimeStamp, "5 mins") # round timeStamp to nearest 5 minute interval


