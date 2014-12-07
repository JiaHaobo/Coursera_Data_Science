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
# Plot 2
# get plotting data
data2 <- NEI[fips=="24510",.(TotalEmissions=sum(Emissions)),by=year]

# save plot in png
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# barplot
barplot(height=data2$TotalEmissions,width=1,names.arg=data2$year,
        col = "dodgerblue", border = par("fg"),
        main = expression(bold(paste("Total ",PM[2.5]," Emissions in Baltimore City"))), 
        xlab = expression(Year), 
        ylab = expression(paste(PM[2.5], " Emissions (in Tons)")))
dev.off()
###############################################################################