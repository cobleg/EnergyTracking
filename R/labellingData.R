
# create labelled data for machine learning

attach(("./Data/Readings.RData"))
attach(("./Data/temperature.RData"))

# Create a date variable for readings
readings$Date <- lubridate::date(readings$TimeStamp)  # Extract dates from timestamp & add as a separate column

# Add temperature data to electricity readings data
data <- merge(readings, temperature, by="Date")  

data.xts <- xts(data[,-2], order.by = data[,2]) # convert dataframe to xts format
data.xts$firstDiff <- xts(diff.xts(as.numeric(data.xts[,5])),order.by = index(data.xts)) # calculate first difference

data <- data.frame(Timestamp=index(data.xts), coredata(data.xts))
data$Date <- lubridate::date(data$Timestamp)
# Create binary variable for air-conditioner starting
data$AC <- ifelse( data$firstDiff >= 0.4, 1, 0 )

# export to CSV format
write.csv(data, file = "./Data/FiveMinuteData.CSV")