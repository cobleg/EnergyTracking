# Objective: check data

colSums(readings.XTS["2015-01-21 00:00:00/2015-03-24 00:00:00"])
colSums(hourly.readings["2015-01-21 00:00:00/2015-03-24 00:00:00"]) # electricity bill shows 2,878 kWh for this period
colSums(daily.data["2015-01-21/2015-03-24"])

# which(is.na(test.range$Total)) # locate NAs

colSums(readings.XTS["2015-08-30 00:00:00/2015-08-30 23:55:00"])
colSums(hourly.data["2016-08-30 00:00:00/2016-08-31 00:00:00"])
daily.data["2016-08-30"]

# find minimum
daily.data[which.min(daily.data$kWh)]

# find maximum
daily.data[which.max(daily.data$kWh)]

colSums(hourly.data["2015-01-13"])
colSums(readings.XTS["2015-01-13 00:00:00/2015-01-13 23:55:00"])

