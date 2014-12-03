rankall <- function(outcome, num = "best") {
  ## Read outcome data
  Data.outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  set.state <- unique(Data.outcome$State)
  set.outcome <- c("heart attack","heart failure","pneumonia")
  if(!(state %in% set.state)) stop("invalid state")
  if(!(outcome %in% set.outcome)) stop("invalid outcome")
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  a <- as.data.frame(sapply(sort(set.state), function(state) rankhospital(state, outcome=outcome, num = num)),stringsAsFactors=F)
  names(a) <- "hospital"
  a$state <- rownames(a)
  return(a)
}
