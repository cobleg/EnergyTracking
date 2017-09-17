# Import Watt Watchers data from Meter 2
filePath <- ("C:/Users/Grant/Google3/Google Drive/WattWatchers energy monitor/")
file <- paste0(filePath, "Meter2.csv")

colClasses <- c("character", "numeric", "numeric")
colNames <- c("TimeStamp", "RealEnergy", "ReactiveEnergy")
Meter.2 <- read.csv(file, header=F, sep=",", colClasses, col.name=colNames, skip=1)
Meter.2$TimeStamp <- as.POSIXct(strptime(Meter.2$TimeStamp, "%d/%m/%Y %H:%M"))
