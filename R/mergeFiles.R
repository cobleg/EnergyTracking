# Merge the weather and readings data sets

energy.data <- merge(hourly.readings, hourly.temp, join='inner')
plot(energy.data[,1])
plot(energy.data[,2])

energy.df <- data.frame(date=index(energy.data), coredata(energy.data))
colnames(energy.df) <- c("TimeStamp", "Total", "Temperature")
plot(energy.df$Temperature, energy.df$Total)


# Objective: Create holiday dummy variable
# Dependencies: mergeFiles.R

energy.df$holidays <-  ifelse(as.Date(energy.df$TimeStamp) == '2014-12-25', 1, 
                              ifelse(as.Date(energy.df$TimeStamp) == '2015-1-1', 1, 
                                     ifelse(as.Date(energy.df$TimeStamp) == '2015-1-26', 1, 
                                            ifelse(as.Date(energy.df$TimeStamp) == '2015-3-3', 1, 
                                                   ifelse(as.Date(energy.df$TimeStamp) == '2015-3-24', 1,
                                                          ifelse(as.Date(energy.df$TimeStamp) == '2015-3-27', 1, 
                                                                 ifelse(as.Date(energy.df$TimeStamp) == '2015-4-25', 1,
                                                                        ifelse(as.Date(energy.df$TimeStamp) == '2015-9-28', 1,
                                                                               ifelse(as.Date(energy.df$TimeStamp) == '2015-12-25', 1,
                                                                                      ifelse(as.Date(energy.df$TimeStamp) == '2015-12-26', 1,
                                                                                             0))))))))))
energy.df$vacation <- ifelse((as.Date(energy.df$TimeStamp) >= '2014-12-26') & (as.Date(energy.df$TimeStamp) <= '2014-12-31'), "Away", "Home")
filePath <- file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data", "energy.RData")

save(energy.df, file = filePath)