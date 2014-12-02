corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  data.nobs <- complete(directory)
  ## Return a numeric vector of correlations
  id <- as.numeric(data.nobs[data.nobs$nobs > threshold,"id"])
  
  file.names <- list.files(directory)[id]
  
  data <- lapply(file.names,function(x) read.csv(paste(directory,x,sep = "/")))
  names(data) <- id
  
  result <- unlist(lapply(data,function(x) cor(x[complete.cases(x),"nitrate"],x[complete.cases(x),"sulfate"])))
  return(result)
}