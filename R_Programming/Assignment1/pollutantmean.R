pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  file.names <- list.files(directory)[id]
  
  data <- lapply(file.names,function(x) read.csv(paste(directory,x,sep = "/")))
  names(data) <- id
  
  target.data <- unlist(lapply(data,function(x) x[,pollutant]))
  
  return(mean(target.data,na.rm=T))
  
}



