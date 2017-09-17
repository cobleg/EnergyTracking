#' Calendar plot to view time series data
#' 
#' @name calendarPlot
#' @author Grant Coble-Neal
#' 
#' @description This function plots time series data in a calendar format
#' 
#' @param dataframe requires a data frame containing the following columns:  
#'        time-stamp of class POSIXct; and a numeric series.

calendarPlot <- function(dataframe){
  localenv <- environment()
  # Check for required packages and install them if not already installed
  package.list <- c("zoo", "plyr", "grid", "ggplot2", "devtools")
  for (i in 1:length(package.list)){
    if(!package.list[i] %in% rownames(installed.packages())){
      install.packages(package.list[i])
    } 
  }
  # load the required packages
  packs <- c("quantmod", "ggplot2", "reshape2", "plyr", "scales", "grid", "devtools")
  invisible(lapply(packs, library, character.only = TRUE))
    
  timeStamp <- as.POSIXlt(timeStamp)

  hour <- as.numeric(as.factor(timeStamp$hour))
  dataframe$weekday <- factor(timeStamp$wday, levels = 0:6, 
                              labels = c("Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat"),
                              ordered = T)
  dataframe$month <- as.numeric(timeStamp$mon + 1)
  dataframe$year <- format(timeStamp, "%Y")
  dataframe$yearmonth <- as.yearmon(timeStamp)
  dataframe$yearmonthf <- factor(dataframe$yearmonth)
  dataframe$week <- as.numeric(format(dataframe$TimeStamp, "%U"))
  dataframe <- ddply(dataframe, .(yearmonthf), transform, monthweek = 1 + week - min(week))
  yvar <- dataframe$Total
  calPlot <-  ggplot(dataframe, aes(as.numeric(dataframe$hour), dataframe$Total), environment = localenv) + 
              geom_path(colour = "black") + 
              facet_grid(monthweek ~ weekday) + 
              ggtitle(paste(month.name[dataframe$month[1]], dataframe$year[1])) +  
              xlab("") + ylab("") +
              theme_linedraw() +
              theme(panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.margin = unit(0, "lines"),
                    axis.text.x = element_blank(),
                    axis.ticks.x = element_blank()) +
              scale_x_continuous(expand = c(0,0))
  return(calPlot)}



#' @example energy.df.2 <- energy.df[energy.df$month == 12,] 
#'          calendarPlot(dataframe = energy.df.2)

