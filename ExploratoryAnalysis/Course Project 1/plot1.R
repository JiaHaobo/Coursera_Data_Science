library(data.table)
library(zoo)
load("Data.rda")

##############################################################
# Plot 1
# save the plot to png file (transparent background)
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
# histogram
hist(x=as.numeric(Data[,Global_active_power]), col = "red", 
     main = "Global Active power",
     xlab = "Global Active power (Kilowatts)")
dev.off()
##############################################################