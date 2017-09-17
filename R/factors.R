# Create factor variables for ggplots
library(zoo)
library(plyr)
library(grid)
library(ggplot2)
library(packrat)

packs <- c("quantmod", "ggplot2", "reshape2", "plyr", "scales", "grid", "devtools")
invisible(lapply(packs, library, character.only = TRUE))
install_github("plotflow/trinker")



timeStamp <- as.POSIXlt(weather$TimeStamp)
str(timeStamp)
hour <- as.factor(timeStamp$hour)
day <- as.factor(timeStamp$wday)

weather <-data.frame(weather, hour, day)

timeStamp <- as.POSIXlt(energy.df$TimeStamp)
energy.df$hour <- as.factor(timeStamp$hour)
energy.df$weekday <- factor(timeStamp$wday, levels = 0:6, 
                               labels = c("Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat"),
                               ordered = T)
energy.df$month <- as.numeric(timeStamp$mon + 1)
energy.df$year <- format(timeStamp, "%Y")
energy.df$yearmonth <- as.yearmon(energy.df$TimeStamp)
energy.df$yearmonthf <- factor(energy.df$yearmonth)
energy.df$week <- as.numeric(format(energy.df$TimeStamp, "%U"))
energy.df <- ddply(energy.df, .(yearmonthf), transform, monthweek = 1 + week - min(week))
energy.df.Nov <- energy.df[energy.df$month == 11,]
energy.df.Dec <- energy.df[energy.df$month == 12,]


calPlot <- function(dataframe){
  ggplot(dataframe, aes(as.numeric(hour), Total, )) + 
  geom_path(colour = "black") + 
  facet_grid(monthweek ~ weekday) + 
  ggtitle(paste(month.name[dataframe$month[1]], dataframe$year[1])) +  
  xlab("") + 
  theme_linedraw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.margin = unit(0, "lines"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  scale_x_continuous(expand = c(0,0))
}
energy.df.Jan <- energy.df[energy.df$month == 2,]
calPlot(energy.df[energy.df$month == 2,])
