##' Import xlsx files
##' 
##' @description This function imports xlsx files and performs a variety of
##' data cleaning tasks
##' @param file the file name
##' @param sheetName worksheet name
##' @param startRow the beginning row of the data set
##' @param endRow the end row of the data set
##' @param rowIndex an index indicating the rows to inmport
##' @param colIndex an index indicating the columns to import
##' @param colClasses the class for each column (i.e. character, numeric)
##' 
# Make sure that JAVA_HOME is not set

import_XLSX <- function(file, sheetName, rowIndex, colIndex, colClasses){
  Sys.getenv("JAVA_HOME")
  if (Sys.getenv("JAVA_HOME")!="")
    Sys.setenv(JAVA_HOME="")
  
  # Read source files
  if("xlsx" %in% rownames(installed.packages()) == FALSE)
  {install.packages("xlsx")}  
  library(xlsx)
  require(xlsx)
  
  data <- read.xlsx(file = file, sheetName = sheetName, rowIndex = rowIndex,  colIndex = colIndex, stringsAsFactors=TRUE)
  
  data[data == "na"] <- NA
  data[data == "np"] <- NA  
  data[data == "#NA"] <- NA
  
  return(data)
}