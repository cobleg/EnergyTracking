# check and install required packages

list.of.packages <- c("dygraphs", "metricsgraphics", "shiny", "shinydashboard", "xts")
new.packages <- list.of.packages[!(list.of.packages %in% install.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
