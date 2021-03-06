best <- function(state, outcome) {
  ## Read outcome data
  Data.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  set.state <- unique(Data.outcome$State)
  set.outcome <- c("heart attack","heart failure","pneumonia")
  if(!(state %in% set.state)) stop("invalid state")
  if(!(outcome %in% set.outcome)) stop("invalid outcome")
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  if(outcome=="heart attack") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  if(outcome=="heart failure") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  if(outcome=="pneumonia") col.name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"

  rate <- as.numeric(Data.outcome[Data.outcome$State==state,col.name])
  names(rate) <- Data.outcome$Hospital.Name[Data.outcome$State==state]
  return(names(sort(rate)[1]))
}