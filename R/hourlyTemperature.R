# Objective: Convert daily to hourly temperature

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/")

list.of.packages <- c("ggplot2", "xts", "maptools", "timeDate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Create an hourly time stamp series to calculate hourly temperatures
library(timeDate)
library(maptools)

# Load temperature data
load(file.path(getwd(),"data/temperature.RData")) # name of data set is: temperature
StartTime <- as.POSIXct(temperature$Date[1], tz="UTC")

# Establish the location of interest and required parameters
Willetton <- matrix(c(115.866667, -32.033333), nrow = 1)
Willetton.loc <- SpatialPoints(Willetton, proj4string=CRS("+proj=longlat +datum=WGS84"))

# Calculate sunrise and sunset times
Willetton.1 <- apply(Willetton, 2, function(c) rep(c, nrow(temperature)))  # Creates an nrow x 2 matrix of the same location 
Sunrise <- sunriset(Willetton.1, as.POSIXct(temperature$Date), direction="sunrise", POSIXct.out=TRUE)
Sunset <- sunriset(Willetton.1, as.POSIXct(temperature$Date), direction="sunset", POSIXct.out=TRUE)

# Add sunrise and sunset times to the Temperature data frame
temperature <- data.frame(Date = temperature$Date, Max.Temperature = temperature$MaxTemp, Min.Temperature = temperature$MinTemp, Sunrise = Sunrise$time, Sunset = Sunset$time)

TimeStamp.series <- timeSequence(from = strptime(temperature$Sunrise[1], "%Y-%m-%d %H:%M:%S"), to = strptime(temperature$Sunset[length(temperature$Sunset)], "%Y-%m-%d %H:%M:%S"), by = "hour")

Temperature.hourly <- data.frame(TimeStamp = as.POSIXct(TimeStamp.series))
Temperature.hourly$Date <- as.Date(Temperature.hourly$TimeStamp)
Temperature.hourly.1 <- merge(Temperature.hourly, temperature, by = "Date", all = T, sort = T)
Temperature.hourly.2 <- Temperature.hourly.1[with(Temperature.hourly.1, order(TimeStamp)),]

# Interpolate hourly temperature with a cosine fit
Temperature.hourly.2$hour <- as.numeric(format(strptime(Temperature.hourly.2$TimeStamp, "%Y-%m-%d %H:%M:%S"), "%H"))
x1 <- cos((Temperature.hourly.2$hour - 1) * pi / 13)
x2 <- cos((Temperature.hourly.2$hour - 7) * pi / 30)
Temperature.hourly.2$Hourly.Temperature.1 = -(Temperature.hourly.2$Max.Temperature - Temperature.hourly.2$Min.Temperature)/2 * x1 + (Temperature.hourly.2$Max.Temperature + Temperature.hourly.2$Min.Temperature)/2
Temperature.hourly.2$Hourly.Temperature.2 = -(Temperature.hourly.2$Max.Temperature - Temperature.hourly.2$Min.Temperature)/2 * x2 + (Temperature.hourly.2$Max.Temperature + Temperature.hourly.2$Min.Temperature)/2
alpha <- round(1/(1 + exp(-0.8*(Temperature.hourly.2$hour - 10))),1)
Temperature.hourly.2$Hourly.Temperature.3 <- alpha*Temperature.hourly.2$Hourly.Temperature.1 + (1-alpha)*Temperature.hourly.2$Hourly.Temperature.2

# Save the result
temperature.hourly <- data.frame(Date = Temperature.hourly.2$Date, TimeStamp = Temperature.hourly.2$TimeStamp, Temperature = Temperature.hourly.2$Hourly.Temperature.3)
file <-file.path(getwd(),"data", "HourlyTemperature.RData")
save(temperature.hourly, file = file)
