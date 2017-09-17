# Import short energy
library(xts)
subfolderName <- "2015-01-28"
directory <- file.path("C:/Users/Grant/Google Drive/WattWatchers energy monitor/Short energy", subfolderName)

if(file.exists(file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/ShortEnergy.RData")) {
  load(file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/ShortEnergy.RData")
}

filenames <- list.files(path = directory, full.names=T)
colNames <- c("TimeStamp", "RealEnergy", "ReactiveEnergy", "RMSVolts", "RMSCurrent", "Frequency")

newFiles <- lapply(filenames, function(i){
  read.csv(i, header=F, skip = 1, stringsAsFactors = F, na.strings = "NULL")
})


meter.1 <- data.frame(newFiles[1]); 
meter.2 <- data.frame(newFiles[2]); 
meter.3 <- data.frame(newFiles[3]); 

names(meter.1) <- colNames
names(meter.2) <- colNames
names(meter.3) <- colNames

meter.1.XTS <- createTimeXTS(meter.1[,2:6], meter.1$TimeStamp)
meter.2.XTS <- createTimeXTS(meter.2[,2:6], meter.2$TimeStamp)
meter.3.XTS <- createTimeXTS(meter.3[,2:6], meter.3$TimeStamp)

meter.XTS <- merge(merge(meter.1.XTS, meter.2.XTS), meter.3.XTS, join = 'outer')
meter.XTS[is.na(meter.XTS)] <- 0

aggregate.XTS <- function(xtsObject){
  # This function is for irregular timestamp observations recorded multiple times per minute
  if("xts" %in% rownames(installed.packages()) == FALSE)
  {install.packages("xts")}
  require(xts)
  xtsObject <- align.time(xtsObject, n=60)
  output.zoo <- aggregate(xtsObject, format(index(xtsObject), "%Y-%m-%d %H:%M:%S"), function(x) mean(x))
  output.xts <- xts(output.zoo, order.by = strptime(index(output.zoo), format = "%Y-%m-%d %H:%M:%S"))
  return(output.xts)
}

ShortEnergy.new <- aggregate.XTS(meter.XTS)

names(ShortEnergy.new) <- c("RealEnergy.1", "ReactiveEnergy.1", "RMSVolts.1", "RMSCurrent.1", "Frequency.1",
                      "RealEnergy.2", "ReactiveEnergy.2", "RMSVolts.2", "RMSCurrent.2", "Frequency.2",
                      "RealEnergy.3", "ReactiveEnergy.3", "RMSVolts.3", "RMSCurrent.3", "Frequency.3")

ShortEnergy.new$TotalRealEnergy <- rowSums(subset(ShortEnergy.new, select = c(RealEnergy.1, RealEnergy.2, RealEnergy.3)))

ShortEnergy <- rbind(ShortEnergy, ShortEnergy.new)

save(ShortEnergy, file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/ShortEnergy.RData")

hourly.readings <- period.apply(ShortEnergy$TotalRealEnergy, endpoints(ShortEnergy$TotalRealEnergy, "hours"), sum)/60

Datetime <- strptime(index(ShortEnergy), "%Y-%m-%d %H:%M:%S", tz = "UTC"); Datetime[1]
index(ShortEnergy) <- Datetime - 60*60*9 + 60

# Now produce the dygraph
dygraph(ShortEnergy$TotalRealEnergy) %>% 
  dyRangeSelector() %>%
  dySeries("TotalRealEnergy", label = "Total Energy")

dygraph(hourly.readings$TotalRealEnergy) %>% 
  dyRangeSelector() %>%
  dySeries("TotalRealEnergy", label = "Total Energy")

