# googleVis plots

if(!"googleVis" %in% rownames(installed.packages())){
  install.packages('googleVis')
} 
library(googleVis)
names <- c("Temperature", "Total")

energy.df.1 <- data.frame(as.Date(energy.df$TimeStamp), energy.df$weekday, energy.df$Temperature, energy.df$Total, energy.df$vacation)
colnames(energy.df.1) <- c("Date", "weekday", "Temperature", "Total", "Vacation")
energy.df.1 <- energy.df.1[!duplicated(energy.df.1$Date),]

plot(gvisMotionChart(energy.df.1, idvar="weekday", timevar = "Date",xvar = "Temperature", yvar = "Total", 
                     options = list(width = 1200, height = 400))
