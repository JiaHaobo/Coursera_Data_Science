complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  file.names <- list.files(directory)[id]
  
  data <- lapply(file.names,function(x) read.csv(paste(directory,x,sep = "/")))
  names(data) <- id
  
  result.list <- unlist(lapply(data,function(x) sum(complete.cases(x))))
  return(data.frame(id=names(result.list),nobs=result.list,row.names = NULL,stringsAsFactors = F))
  
}