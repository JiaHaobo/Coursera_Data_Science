##############################################################
# Clean data
library(data.table)
library(zoo)
# Fast read data from txt file using "fread"
RawData <- fread("household_power_consumption.txt")
# Get the target data
Data <- RawData[Date %in% c("1/2/2007","2/2/2007"),]
# save the clean data for further analysis
save(Date,file="Data.rda")