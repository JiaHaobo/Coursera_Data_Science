rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  Data.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  set.state <- unique(Data.outcome$State)
  set.outcome <- c("heart attack","heart failure","pneumonia")
  if(!(state %in% set.state)) stop("invalid state")
  if(!(outcome %in% set.outcome)) stop("invalid outcome")
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if(outcome=="heart attack") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  if(outcome=="heart failure") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  if(outcome=="pneumonia") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  
  df <- data.frame(Hospital.Name=Data.outcome$Hospital.Name,Rate=as.numeric(Data.outcome[,col.name]),stringsAsFactors=F)
  ind <- Data.outcome$State==state
  df.state <- df[ind,]
  ind.ord <- order(df.state$Rate,df.state$Hospital.Name)
  final.df <- df.state[ind.ord,][complete.cases(df.state[ind.ord,]),]
  if(num=="best") return(head(final.df$Hospital.Name,1)) else 
    if(num=="worst") return(tail(final.df$Hospital.Name,1)) else
      return(final.df$Hospital.Name[num])
}
