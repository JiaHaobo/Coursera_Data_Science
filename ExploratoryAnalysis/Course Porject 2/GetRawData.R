###############################################################################
# Read data
path.data <- "g:/Coursera/Data Science/Github/RawData/"
file.NEI <- paste0(path.data,"summarySCC_PM25.rds")
file.SCC <- paste0(path.data,"Source_Classification_Code.rds")
NEI <- readRDS(file.NEI)
SCC <- readRDS(file.SCC)
save(NEI,SCC,file=paste0(path.data,"NEISCC.rda"))
###############################################################################


