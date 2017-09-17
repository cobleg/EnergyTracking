##' Aggregate an xts object containing high frequency data (1 minute or less)
##'
##' @description Aggregate a xts object
##' 
##' @param xts object to be aggregated

##' @example ## sourceFile <- file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/ShortEnergy.RData")
##'          ## load(sourceFile)
##'          ## myTest <- aggregate.XTS(ShortEnergy)


aggregate.XTS <- function(xtsObject){
  if("xts" %in% rownames(installed.packages()) == FALSE)
  {install.packages("xts")}
  require(xts)
  xtsObject <- align.time(xtsObject, n=60)
  output.zoo <- aggregate(xtsObject, format(index(xtsObject), "%Y-%m-%d %H:%M:%S"), function(x) mean(x))
  output.xts <- xts(output.zoo, order.by = strptime(index(output.zoo), format = "%Y-%m-%d %H:%M:%S"))
  return(output.xts)
}
