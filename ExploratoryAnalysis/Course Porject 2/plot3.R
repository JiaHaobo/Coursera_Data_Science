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
# Plot 3
# get plotting data
data3 <- NEI[fips=="24510",.(TotalEmissions=sum(Emissions)),by=.(year,type)]

# save plot in png
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# ggplot-bar
ggplot(aes(x=factor(year),y=TotalEmissions),data=data3)+
  geom_bar(stat = "identity",position="dodge",fill="dodgerblue")+
  facet_wrap(~type,scales = "free_y")+
  labs(title = expression(bold(paste(PM[2.5]," Emissions in Baltimore City (by type)"))),
       x="Year",y=expression(paste(PM[2.5], " Emissions (in Tons)")))+
  theme(legend.position = "none",
        plot.background = element_rect(fill = "transparent",colour = NA),
        strip.text.x = element_text(colour = "blue", size = 11,
                                    hjust = 0.5, vjust = 0.5))
dev.off()
###############################################################################