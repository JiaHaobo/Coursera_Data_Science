library(data.table)
library(zoo)
# RawData <- fread("household_power_consumption.txt")
# Data <- RawData[Date %in% c("1/2/2007","2/2/2007"),]
load("Data.rda")

##############################################################
# Plot 1
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

hist(x=as.numeric(Data[,Global_active_power]), col = "red", 
     main = "Global Active power",
     xlab = "Global Active power (Kilowatts)")
dev.off()
##############################################################


##############################################################
# Plot 2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
GAP <- zoo(as.numeric(Data[,Global_active_power]),
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(GAP,xlab="",ylab="Global Active power (Kilowatts)")
dev.off()
##############################################################


##############################################################
# Plot 3
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
Sub <- zoo(Data[,.(as.numeric(Sub_metering_1),
                   as.numeric(Sub_metering_2),
                   as.numeric(Sub_metering_3))],
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(Sub[,1],xlab="",ylab="Energy sub metering")
lines(Sub[,2],col=2)
lines(Sub[,3],col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c(1,2,4),lty=1)
dev.off()
##############################################################


##############################################################
# Plot 4
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

par(mfcol=c(2,2)) # sort by col
# subplot 1
GAP <- zoo(as.numeric(Data[,Global_active_power]),
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(GAP,xlab="",ylab="Global Active power (Kilowatts)")

# subplot 2
Sub <- zoo(Data[,.(as.numeric(Sub_metering_1),
                   as.numeric(Sub_metering_2),
                   as.numeric(Sub_metering_3))],
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(Sub[,1],xlab="",ylab="Energy sub metering")
lines(Sub[,2],col=2)
lines(Sub[,3],col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c(1,2,4),lty=1,
       box.lwd = 0,box.col = "transparent",bg = "transparent")

# subplot 3
Vol <- zoo(as.numeric(Data[,Voltage]),
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(Vol,xlab="datetime",ylab="Voltage")

# subplot 4
GRP <- zoo(as.numeric(Data[,Global_reactive_power]),
           strptime(Data[,paste(Date,Time)],format="%d/%m/%Y %H:%M:%S"))
plot(GRP,xlab="datetime",ylab="Global_reactive_power")

dev.off()
##############################################################
