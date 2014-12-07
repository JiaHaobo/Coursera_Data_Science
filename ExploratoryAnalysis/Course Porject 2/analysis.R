###############################################################################
# Load data
rm(list=ls())
path.data <- "g:/Coursera/Data Science/Github/RawData/"
load(paste0(path.data,"NEISCC.rda"))
###############################################################################

###############################################################################
# Import packages
library(data.table)
library(ggplot2)
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