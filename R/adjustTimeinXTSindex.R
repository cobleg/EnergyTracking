
indexTZ(hourly.data) <- "Australia/Perth"
indexTZ(hourly.data) 

Datetime <- index(hourly.data)
index(hourly.data) <- Datetime - 60*60*8
save(hourly.data, file = "C:/Users/Grant/Google Drive/R/Projects/WattWatchers/App-4/Data/hourlyData.RData")
