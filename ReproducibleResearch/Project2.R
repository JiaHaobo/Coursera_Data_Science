library(R.utils)
library(data.table)
library(reshape2)
library(ggplot2)

## Getting Data
# Download data from url
data.url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
data.bz.file <- "G:/Coursera/Data Science/Github/RawData/repdata-data-StormData.csv.bz2"
download.file(data.url, data.bz.file, mode="wb")
# unzip the file
bunzip2(data.file)
data.csv.file <- "G:/Coursera/Data Science/Github/RawData/repdata-data-StormData.csv"
# read the file to R and change it to data.table format
rawdata <- read.csv(data.csv.file,stringsAsFactors=FALSE)
rawdata <- data.table(rawdata)

## Cleaning Data
# change name to lower case
setnames(rawdata,tolower(names(rawdata)))
## Set correct damage amount (in million)
DT <- rawdata[,.(state,evtype,fatalities,injuries,propdmg,propdmgexp,cropdmg,cropdmgexp)]
DT[grepl("[Bb]",propdmgexp),propdmg:=propdmg*1e9*1e-6]
DT[grepl("[Mm]",propdmgexp),propdmg:=propdmg*1e6*1e-6]
DT[grepl("[Kk]",propdmgexp),propdmg:=propdmg*1e3*1e-6]
DT[grepl("[Hh]",propdmgexp),propdmg:=propdmg*1e2*1e-6]

DT[grepl("[Bb]",cropdmgexp),cropdmg:=cropdmg*1e9*1e-6]
DT[grepl("[Mm]",cropdmgexp),cropdmg:=cropdmg*1e6*1e-6]
DT[grepl("[Kk]",cropdmgexp),cropdmg:=cropdmg*1e3*1e-6]

DT[,':='(propdmgexp=NULL,cropdmgexp=NULL)]
setnames(DT,c("State","EventType","Fatalities","Injuries","PropertyDamage","CropDamage"))
## Create total damage variable
DT[,TotalDamage:=PropertyDamage+CropDamage]

## Event Types
# Convection
Key.Convection <- c("TORNADO", "FUNNEL", "TSTM", "LIGHTNING", 
                    "LIGHTING", "THUNDERSTORM", "WIND", "HAIL")
regex.Convection <- paste(Key.Convection, collapse = "|")
index.Convection <- grep(regex.Convection,DT$EventType)
DT[index.Convection,EventType:="Convection"]
# Extreme Temperatures
Key.ExTemperature <- c("COLD", "HEAT", "WARM", "COOL")
regex.ExTemperature <- paste(Key.ExTemperature,collapse = "|")
index.ExTemperature <- grep(regex.ExTemperature,DT$EventType)
index.ExTemperature <- setdiff(index.ExTemperature,index.Convection)
DT[index.ExTemperature,EventType:="Extreme Temperatures"]
# Flood
Key.Flood <- c("FLOOD", "RAIN", "PRECIP", "SHOWER")
regex.Flood <- paste(Key.Flood,collapse = "|")
index.Flood <- grep(regex.Flood,DT$EventType)
index.Flood <- setdiff(index.Flood,
                       unique(c(index.Convection,index.ExTemperature)))
DT[index.Flood,EventType:="Flood"]
# Winter
Key.Winter <- c("SNOW", "ICE", "ICY", "FREEZ", "WINT")
regex.Winter <- paste(Key.Winter,collapse = "|")
index.Winter <- grep(regex.Winter,DT$EventType)
index.Winter <- setdiff(index.Winter,
                        unique(c(index.Convection,index.ExTemperature,index.Flood)))
DT[index.Winter,EventType:="Winter"]
# Other
index.Other <- setdiff(1:nrow(DT),unique(c(index.Convection,index.ExTemperature,
                                            index.Flood,index.Winter)))
DT[index.Other,EventType:="Other"]

## events -- population health
DT.health <- DT[,.(Fatalities=sum(Fatalities),
                   Injuries=sum(Injuries)),
                by=EventType]
DT.health

DT.health.melt <- melt(DT.health,measure=c("Fatalities","Injuries"),id="EventType")
ggplot(data=DT.health.melt) + 
  geom_bar(aes(x=EventType,y=value,fill=variable),stat="identity",position="dodge") +
  facet_wrap(~variable, scales = "free_y",nrow=2) +
  labs(title="Harms of Events on Population Health", x= "Type of Events", y="Number") +
  theme(legend.position="none",
        strip.text=element_text(colour="purple",size = 12,face="bold"),
        title=element_text(size = 14,face = "bold"),
        axis.text=element_text(colour="blue"))


## events -- economic consequences
DT.eco <- DT[,.(PropertyDamage=sum(PropertyDamage),
                CropDamage=sum(CropDamage)),by=EventType]
DT.eco

DT.eco.melt <- melt(DT.eco,measure=c("PropertyDamage","CropDamage"),id="EventType")
ggplot(data=DT.eco.melt) + 
  geom_bar(aes(x=EventType,y=value,fill=variable),stat="identity",position="dodge") +
  facet_wrap(~variable, scales = "free_y",nrow=2) +
  labs(title="Harms of Events on Economics", x= "Type of Events", y="Damages (in million $)") +
  theme(legend.position="none",
        strip.text=element_text(colour="purple",size = 12,face="bold"),
        title=element_text(size = 14,face = "bold"),
        axis.text=element_text(colour="blue"))


