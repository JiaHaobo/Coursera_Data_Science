library(data.table)
library(zoo)
load("Data.rda")

##############################################################
# Plot 2
# save the plot to png file (transparent background)
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
# Get the data "Global_active_power" from data.table "Data" 
# and construct a zoo object for plotting
GAP <- zoo(as.numeric(Data[,Global_active_power]),
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
# plot
plot(GAP,xlab="",ylab="Global Active power (Kilowatts)")
dev.off()
##############################################################