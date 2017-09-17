# Objective: Update the WattWatchers data set

# Before running this script:
# 1. Run this manual procedure: https://coble-neal.atlassian.net/wiki/display/EMA/Get+the+electricity+consumption+data

currentMonth <- ("August 2017")

# define functions
setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('createXTS.R')
source('createTimeXTS.R')

# import sources data
setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('importData.R')
source('importBOMtemperature.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('collate.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('hourlyTemperature.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('XTSobject.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('aggregateXTS.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('joinFiles.R')

setwd("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/R")
source('holidays.R')

