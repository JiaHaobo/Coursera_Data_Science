## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
###############################################################################
# This function creates a special "matrix" object that can cache 
# its inverse.
makeCacheMatrix <- function(x = matrix()) {
  Solve <- NULL               # Initialize the Inverse Matrix as NULL
  # set function: Set matrix value and Initialize Inver Matrix in the cache env;
  set <- function(y) {
    x <<- y
    Solve <<- NULL
  }
  # get function: get the value of the matrix
  get <- function() x
  # setsolve function: set the Inverse Matrix in the cache env. 
  setsolve <- function(solve) Solve <<- solve
  # getsolve function: get the Inverse Matrix from the cache env. 
  getsolve <- function() Solve
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}
###############################################################################

## Write a short comment describing this function
###############################################################################
# This function computes the inverse of the special "matrix" returned 
# by makeCacheMatrix above. 
# If the inverse has already been calculated (and the matrix has not changed), 
# then the cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  # First try to get the Inverse Matrix from the cache env.  
  Solve <- x$getsolve()
  if(!is.null(Solve)) {
    message("getting cached data")
    return(Solve)
  }
  
  # If the Inverse matrix in cache env is NULL, then calculate the Inverse Matrix
  # and set it as the Inverse Matrix in the cache env. 
  data <- x$get()
  Solve <- solve(data, ...)
  x$setsolve(Solve)
  # Return the Inverse Matrix 
  Solve
}
###############################################################################
