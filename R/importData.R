# Import Watt Watchers data from Meter 1, Meter 2 and Meter 3
if (!exists('currentMonth')) {
  stop(paste('Stopping script: run updateFiles.R'))
} else{
  directory <-
    file.path("C:/Users/Grant/Google Drive/WattWatchers energy monitor",
              currentMonth)
  
  filenames <- list.files(path = directory, full.names = T)
  # filenames <- filenames[-1]
  colNames <- c("TimeStamp", "RealEnergy")
  
  newFiles <- lapply(filenames, function(i) {
    read.csv(
      i,
      header = F,
      skip = 1,
      stringsAsFactors = F,
      na.strings = "NULL"
    )
  })
  
  
  meter.1 <-
    data.frame(newFiles[1])
  meter.1 <- subset(meter.1, select = c(1, 3))
  meter.2 <-
    data.frame(newFiles[2])
  meter.2 <- subset(meter.2, select = c(1, 3))
  meter.3 <-
    data.frame(newFiles[3])
  meter.3 <- subset(meter.3, select = c(1, 3))
  
  names(meter.1) <- colNames
  names(meter.2) <- colNames
  names(meter.3) <- colNames
  
  # meter.1$RealEnergy <- as.numeric(meter.1$RealEnergy)
  
  meter.1$TimeStamp <-
    as.POSIXct(strptime(meter.1$TimeStamp, "%Y-%m-%d %H:%M"))
  meter.2$TimeStamp <-
    as.POSIXct(strptime(meter.2$TimeStamp, "%Y-%m-%d %H:%M"))
  meter.3$TimeStamp <-
    as.POSIXct(strptime(meter.3$TimeStamp, "%Y-%m-%d %H:%M"))
  
}
