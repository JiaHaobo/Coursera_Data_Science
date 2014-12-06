library(data.table)
library(zoo)
load("Data.rda")

##############################################################
# Plot 3
# save the plot to png file (transparent background)
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
# construct a zoo object for "eazy" plot
Sub <- zoo(Data[,.(as.numeric(Sub_metering_1),
                   as.numeric(Sub_metering_2),
                   as.numeric(Sub_metering_3))],
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(Sub[,1],xlab="",ylab="Energy sub metering")
lines(Sub[,2],col=2)
lines(Sub[,3],col=4)
# Legend for plot
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c(1,2,4),lty=1)
dev.off()
##############################################################