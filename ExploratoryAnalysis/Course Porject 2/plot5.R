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
# Plot 5
# get plotting data
motor.SCC <- as.character(SCC[grep("Motorcycles",SCC$SCC.Level.Three),"SCC"])
data5 <- NEI[fips=="24510" & SCC %in% motor.SCC, .(MotorEmissions=sum(Emissions)),by=.(year)]

# save plot in png
png(filename = "plot5.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# ggplot-bar
ggplot(aes(x=factor(year),y=MotorEmissions),data=data5)+
  geom_bar(stat = "identity",position="dodge",fill="dodgerblue")+
  labs(title = expression(bold(paste("Motor Source ",PM[2.5]," Emissions in Baltimore City"))),
       x="Year",y=expression(paste(PM[2.5], " Emissions (in Tons)")))+
  theme(legend.position = "none",
        plot.background = element_rect(fill = "transparent",colour = NA))
dev.off()
###############################################################################
