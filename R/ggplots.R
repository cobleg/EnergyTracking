# Create ggplot2 graphics
if(!"ggplot2" %in% rownames(installed.packages())){
  install.packages("ggplot2")
} 
library(ggplot2)

daily.readings.df <- data.frame(date=index(daily.readings), coredata(daily.readings))
colnames(daily.readings.df) <- c("Date","Readings")
qplot(Date, Readings, data = daily.readings.df, geom="line", main="Summer energy consumption (daily)")

weekly.readings.df <- data.frame(date=index(weekly.readings), coredata(weekly.readings))
colnames(weekly.readings.df) <- c("Date","Readings")
qplot(Date, Readings, data = weekly.readings.df, geom="line", main="Summer energy consumption (weekly)")

# Temperature plots
qplot(TimeStamp, Temperature, data=weather, facets = . ~ day) +geom_smooth()

qplot(Temperature, Total, data=energy.df, facets = . ~ vacation, main='Energy consumption versus Temperature') + geom_smooth()

qplot(Temperature, Total, data=energy.df, facets = . ~ hour) +geom_smooth()

qplot(as.numeric(hour), Total, data=readings, facets = . ~ mday) +geom_smooth()
Jan.readings <- readings[readings$month == '0',]
ggplot(Jan.readings, aes(as.numeric(hour), Total)) +geom_smooth()
qplot(as.numeric(hour), Total, data = Jan.readings) + geom_smooth() + xlab("Hour of the day")

maxRows <- by(Jan.readings, Jan.readings$hour, function(X) X[which(X$Total==max(X$Total)),])
str(maxRows)


