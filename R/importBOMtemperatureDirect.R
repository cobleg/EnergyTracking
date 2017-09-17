
# Get temperature data from the BOM web site. Note that URLs are obtained from mouse right button click 
# on "All years of data" link, copy URL address 

list.of.packages <- c("RCurl", "utils")  
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(RCurl)
library(utils)

# Get maximum temperature
temp <- "C:/Users/Grant/Downloads/temp.zip"
download.file("http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_display_type=dailyZippedDataFile&p_stn_num=009172&p_c=-16820475&p_nccObsCode=122&p_startYear=2016
",temp, mode="wb")
temperature.data <- read.table(unzip(temp, "IDCJAC0010_009172_1800_Data.csv"), header=T, sep = ",")
unlink(temp)
temperature.max <- temperature.data[,c(3:6)]
names(temperature.max) <-c("Year", "Month", "Day", "Max.Temperature")

# Get minimum temperature

temp <- "C:/Users/Grant/Downloads/temp.zip"
download.file("http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_display_type=dailyZippedDataFile&p_stn_num=009172&p_c=-16820671&p_nccObsCode=123&p_startYear=2016
              ",temp, mode="wb")
# CSV file name in the next line needs to match the name in the temp.zip file
temperature.data <- read.table(unzip(temp, "IDCJAC0011_009172_1800_Data.csv"), header=T, sep = ",")
unlink(temp)

temperature.min <- temperature.data[,c(3:6)]
names(temperature.min) <-c("Year", "Month", "Day", "Min.Temperature")
temperature.min$Date <- as.Date(paste(temperature.min$Year, temperature.min$Month, temperature.min$Day, sep = "/"))
temperature.max$Date <- as.Date(paste(temperature.max$Year, temperature.max$Month, temperature.max$Day, sep = "/"))
BOM.Temperature <- merge(temperature.min, temperature.max, by = "Date")
BOM.Temperature <- BOM.Temperature[,c("Date", "Min.Temperature", "Max.Temperature")]
save(BOM.Temperature, file="C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data/temperature2.RData")
