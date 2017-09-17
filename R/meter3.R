# Import Watt Watchers data from Meter 3
filePath <- ("C:/Users/Grant/Google3/Google Drive/WattWatchers energy monitor/")
file <- paste0(filePath, "Meter3.csv")

colClasses <- c("character", "numeric", "numeric")
colNames <- c("TimeStamp", "RealEnergy", "ReactiveEnergy")
Meter.3 <- read.csv(file, header=F, sep=",", colClasses, col.name=colNames, skip=1)
Meter.3$TimeStamp <- as.POSIXct(strptime(Meter.3$TimeStamp, "%d/%m/%Y %H:%M"))

