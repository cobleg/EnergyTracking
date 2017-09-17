##' Create an xts object from the SolarPVinstallations data frame
##'
##' @description Converts a dataframe to an xts object
##' 
##' @param A data frame to be converted to an xts object
##' @param A date series (of class 'character') to be used as a time index
##' @example ## sourceFile <- file.path("C:/Users/Grant/Google3/Google Drive/R/Projects/CER Data/Data/solarPVinstallations.RData")
##'          ## load(sourceFile)
##'          ## myTest <- createXTS(solarPVinstallations[,-1], solarPVinstallations$dates)

# Create xts object
createXTS <- function(DataFrame, dateSeries) {
  if("xts" %in% rownames(installed.packages()) == FALSE)
  {install.packages("xts")}
  require(xts)
  dates <- strptime(dateSeries, "%Y-%m-%d", tz = "UTC")
  xtsObject <- xts(DataFrame, order.by = dates)
  return(xtsObject)
}
