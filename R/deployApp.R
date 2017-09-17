# Objective: deploy a shiny app

if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/shinyapps")

library(shinyapps)
setwd('C:/Users/Grant/Google Drive/R/Projects/WattWatchers/App-4')
shinyapps::setAccountInfo(name='coble-neal', token='1BF47637C4D661E50DA0F4206FF7709B', secret='8B2MRJ+h0cRgTgZy7SBbsT5ve972AkSqTlnia3DQ')
deployApp(account = 'coble-neal')
