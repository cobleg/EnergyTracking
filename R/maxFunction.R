# Find maximum by criteria
localenv <- environment()
# Check for required packages and install them if not already installed
package.list <- c("zoo", "plyr", "grid", "ggplot2", "devtools")
for (i in 1:length(package.list)){
  if(!package.list[i] %in% rownames(installed.packages())){
    install.packages(package.list[i])
  } 
}
library(plyr)
maxByhour <- ddply(Jan.readings, .(hour), function(X) X[which(X$Total==max(X$Total)),])
qplot(as.numeric(hour), Total, data = maxByhour) + geom_smooth()  + xlab("Hour of the day")

