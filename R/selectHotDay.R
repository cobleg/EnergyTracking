

## Objective: create an ineractive Dygraph comparing a day's consumption profile against a hot day profile

library(dygraphs)
library(xts)

load("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/hourlyData.RData")
# tzone(hourly.data) <- "Australia/Perth"

hourly.data$day <- substr(index(hourly.data), 9, 10)
hourly.data.df <- as.data.frame(hourly.data)

# subset data based on temperature
temperature <- 35
hot <- hourly.data.df[hourly.data.df$hourly.BOM.temp >= temperature, ]
hot <- hot[complete.cases(hot),]
hotDates <- (strptime(rownames(hot), format="%Y-%m-%d", tz="Australia/Perth"))
hot <- xts(hot, order.by = hotDates)
hot.times <- as.Date(index(hot))
hot.dates <- strptime(index(hourly.data[hourly.data.df$hourly.BOM.temp >= temperature, ]), format="%Y-%m-%d %H:%M:%S")

# Select all the data for hot days
hot.days <- hourly.data[as.Date(index(hourly.data)) %in% as.Date(hot.dates),]

# exclude weekends
if (TRUE){ hot.days <- hot.days 
}else{ hot.days <- hot.days[!weekdays(index(hot.days)) %in% c("Saturday", "Sunday")] 
}

# exclude dates
# (hot.days[!(.index(hot.days)) > strptime("2016-1-1", "%Y-%m-%d") & (.index(hot.days)) < strptime("2016-3-14", "%Y-%m-%d")])

# extract hour of the day from hot.days
hot.days$hour = .indexhour(hot.days)

# calculate percentiles for hot.days data

# function for upper percentile
percentile.profile <- function(input.data, selected.percentile, variable.name) {
  profile.2 <- aggregate(
    input.data$Total ~ input.data$hour,
    FUN = quantile,
    probs = selected.percentile / 100

  )
  names(profile.2) <- c("Hour", variable.name)
  return(profile.2)
}

average.profile <- percentile.profile(hot.days, 50, "Median.kWh")
upper.profile <- percentile.profile(hot.days, 90, "Upper.kWh")
lower.profile <- percentile.profile(hot.days, 10, "Lower.kWh")
  
# average.profile <- aggregate(hot.days$Total~hot.days$hour, FUN=median)
# upper.profile <- aggregate(hot.days$Total~hot.days$hour, FUN=quantile, probs=.9)
# lower.profile <- aggregate(hot.days$Total~hot.days$hour, FUN=quantile, probs=.25)

names(average.profile) <- c("Hour","Median.kWh")
names(upper.profile) <- c("Hour", "Upper.kWh")
names(lower.profile) <- c("Hour", "Lower.kWh")

# select one of the hot days & chart it
hotDayList <- index(hot.days)
attr(hotDayList, "tzone") <- "AWST"

DatesOnly <- unique(substr(hotDayList, 1, 10))
selectedHotDay <- hotDayList[grepl(DatesOnly[2], hotDayList)]
hot.day <- hourly.data[paste0(selectedHotDay, "/", selectedHotDay), ]

# combine the daily average.profile and the selected hot day
hot.day.2 <- hot.day[, "Total"]
names(hot.day.2) <- c("HotDay.kWh")

rownames(average.profile) <- (index(hot.day.2))
average.profile <- xts(average.profile, order.by = as.POSIXlt(rownames(average.profile)))

rownames(upper.profile) <- index(hot.day.2)
upper.profile <- xts(upper.profile, order.by = as.POSIXlt(rownames(upper.profile)))

rownames(lower.profile) <- index(hot.day.2)
lower.profile <- xts(lower.profile, order.by = as.POSIXlt(rownames(lower.profile)))

chart.data <- merge.xts(hot.day = hot.day.2, average.profile, "inner")
chart.data <- chart.data[,c(-2,-4)]
chart.data <- merge.xts(chart.data, upper.profile, "inner")
chart.data <- chart.data[,c(-3,-5)]
chart.data <- merge.xts(chart.data, lower.profile, "inner")
chart.data <- chart.data[,c(-4,-6)]

# create new date-time index

index.StartYear <- format(start(chart.data), "%Y")
index.StartMonth <- format(start(chart.data), "%m")
index.StartDay <- format(start(chart.data), "%d")  
index.StartHour <- format(start(chart.data), "%H")
index.length <- length(index(chart.data))
Date.Time <- seq(c(ISOdatetime(year = index.StartYear, month = index.StartMonth, day = index.StartDay, hour = 0, min = 0, sec=0, tz = "UTC")), by = "hour", length.out = index.length)
row.names(chart.data) <- Date.Time
chart.data <- as.data.frame(chart.data)
chart.data <- xts(chart.data, order.by = Date.Time)
tzone(chart.data) <- "UTC"

# create interactive chart
dygraph(data=chart.data) %>%
  dySeries(c("Lower.kWh", "Median.kWh", "Upper.kWh"), label = "Hotday profile") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Dark2")) %>%
  dyAxis("y", label = "kWh") %>%
  dyOptions(labelsUTC =  TRUE)


