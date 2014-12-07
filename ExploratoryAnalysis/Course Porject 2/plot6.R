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
# Plot 6
# get plotting data
motor.SCC <- as.character(SCC[grep("Motorcycles",SCC$SCC.Level.Three),"SCC"])
data6 <- NEI[(fips %in% c("24510","06037")) & (SCC %in% motor.SCC), 
             .(MotorEmissions=sum(Emissions),
               county=ifelse(fips=="24510","Baltimore City","Los Angeles County")),
             by=.(year,fips)]

# save plot in png
png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# ggplot-bar
ggplot(aes(x=factor(year),y=MotorEmissions),data=data6)+
  geom_bar(stat = "identity",position="dodge",fill="dodgerblue")+
  facet_wrap(~county,scales = "free_y")+
  labs(title = expression(bold(paste("The comparision of Motor Source ",PM[2.5]," Emissions"))),
       x="Year",y=expression(paste(PM[2.5], " Emissions (in Tons)")))+
  theme(legend.position = "none",
        plot.background = element_rect(fill = "transparent",colour = NA),
        strip.text.x = element_text(colour = "blue", size = 11,
                                    hjust = 0.5, vjust = 0.5))
dev.off()
###############################################################################