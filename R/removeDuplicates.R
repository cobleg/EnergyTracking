
readings <- unique(readings)
# Save file at 5 minute intervals
file = "Readings.RData"
filePath = file.path("C:/Users/Grant/Google Drive/R/Projects/WattWatchers/data", file)
save(readings, file=filePath)
