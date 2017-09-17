# Objective: create appliance operation data

readings.10min <- to.minutes10(readings.XTS$Total, name = "Total")

readings.10min$Change <- diff(readings.10min$Total.Close, 1)

readings.10min$HVAC_On <- 0
readings.10min$HVAC_On[readings.10min$Change >= 0.15] <- 1

readings.10min$HVAC_Off <- 0
readings.10min$HVAC_Off[readings.10min$Change <= -0.15] <- -1

HVAC_On.DateTimes <- as.POSIXct(index(readings.10min[readings.10min$HVAC_On == 1]), tz = "Australia/Perth")
HVAC_Off.DateTimes <- as.POSIXct(index(readings.10min[readings.10min$HVAC_Off == -1]), tz = "Australia/Perth")

Events.HVAC <- min(length(HVAC_On.DateTimes), length(HVAC_Off.DateTimes))

for(i in 1:Events.HVAC) {
  HVAC_operation[i] <- HVAC_Off.DateTimes[i] - HVAC_On.DateTimes[i] 
}

library(dygraphs)

dygraph(readings.10min[,c("Total.Close", "HVAC_On", "HVAC_Off")]) %>% 
  dyRangeSelector() %>%
  dySeries("Total.Close", label = "Total Energy") %>%
  dySeries("HVAC_On", label = "HVAC on", axis = "y2") %>%
  dySeries("HVAC_Off", label = "HVAC off", axis = "y2") %>%
  add_shades(weekends)

hist(as.numeric(readings.XTS$Change))

library(metricsgraphics)
mjs_hist(as.numeric(readings.XTS$Change)*100, bins = 100)
