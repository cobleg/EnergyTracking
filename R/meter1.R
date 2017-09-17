# Import Watt Watchers data from Meter 1
currentMonth <- ("February 2015")
directory <- file.path("C:/Users/Grant/Google3/Google Drive/WattWatchers energy monitor", currentMonth)

filenames <- list.files(path = directory, full.names=T)
colClasses <- c(rep("character",2), "numeric", "numeric")
colNames <- c("StartTime", "EndTime", "RealEnergy", "ReactiveEnergy")
                              
lapply(filenames, function(i){
  read.csv(file = i, header=T, skip = 1)
})

import <- readFile(newFiles)



colClasses <- c("character", "numeric", "numeric")
colNames <- c("TimeStamp", "RealEnergy", "ReactiveEnergy")
Meter.1 <- read.csv(file, header=F, sep=",", colClasses, col.name=colNames, skip=1)
Meter.1$TimeStamp <- as.POSIXct(strptime(Meter.1$TimeStamp, "%d/%m/%Y %H:%M"))
