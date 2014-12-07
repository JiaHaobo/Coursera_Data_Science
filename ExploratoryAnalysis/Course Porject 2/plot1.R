###############################################################################
# Import packages
library(data.table)
library(ggplot2)
###############################################################################

###############################################################################
# Load Raw Data
NEI <- readRDS(summarySCC_PM25.rds)
SCC <- readRDS(Source_Classification_Code.rds)
###############################################################################

###############################################################################
# Clean Data
NEI <- data.table(NEI); gc()
NEI[,Pollutant:=NULL];gc()
###############################################################################

###############################################################################
# Plot 1
# get plotting data
data1 <- NEI[,.(TotalEmissions=sum(Emissions)),by=year]

# save plot in png
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# barplot
barplot(height=data1$TotalEmissions/10^6,width=1,names.arg=data1$year,
        col = "dodgerblue", border = par("fg"),
        main = expression(bold(paste("Total ",PM[2.5]," Emissions in the United States"))), 
        xlab = expression(Year), 
        ylab = expression(paste(PM[2.5], " Emissions (in ",bold(Million)," Tons)")))
dev.off()
###############################################################################