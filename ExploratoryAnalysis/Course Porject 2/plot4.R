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
# Plot 4
# get plotting data
coal.SCC <- SCC[grepl("[Cc]oal",SCC$SCC.Level.Four) & 
                  (grepl("[Ff]ire",SCC$SCC.Level.Four) | 
                     grepl("[Cc]ombustion",SCC$SCC.Level.Four) | 
                     grepl("[Bb]urn",SCC$SCC.Level.Four)) ,
                "SCC"]

data4 <- NEI[SCC %in% coal.SCC,.(TotalEmissions=sum(Emissions)),by=.(year)]

# save plot in png
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# ggplot-bar
ggplot(aes(x=factor(year),y=TotalEmissions),data=data4)+
  geom_bar(stat = "identity",position="dodge",fill="dodgerblue")+
  labs(title = expression(bold(paste("Coal combustion-related ",PM[2.5]," Emissions in the United States"))),
       x="Year",y=expression(paste(PM[2.5], " Emissions (in Tons)")))+
  theme(legend.position = "none",
        plot.background = element_rect(fill = "transparent",colour = NA),
        strip.text.x = element_text(colour = "blue", size = 11,
                                    hjust = 0.5, vjust = 0.5))
dev.off()
###############################################################################