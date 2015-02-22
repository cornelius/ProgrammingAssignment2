## This file provides functions to cache the inverse of a matrix. This is useful when dealing with
## big matrices where calculating the inverse takes a long time and the inverse is needed repeatedly.

## The function `makeCacheMatrix` creates a special matrix object which provides functions to set and
## get its matrix value, and to set and get its cached inverse.
##
## Here are some examples how to use the function:
##
## Create cache matrix object (where `matrix` is a given matrix):
##
##    m <- makeCacheMatrix(matrix)
##
## Set matrix value:
##
##    m$set(matrix)
##
## Get matrix value:
##
##    m$get()
##
## Set cached inverse:
##
##    m$setinverse(solve(matrix))
##
## Get cached inverse:
##
##    m$getinverse()
##
makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL

  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setinverse <- function(i) inverse <<- i
  getinverse <- function() inverse

  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}

## The function `cacheSolve` calculates the inverse of a matrix and caches the result for subsequent
## calls. The matrix has to be given as a special matrix object created with the `makeCacheMatrix`
## function.
##
## Here is an example how to use the function (where `matrix`is a given matrix):
##
##    m <- makeCacheMatrix(matrix)
##    cacheSolve(m)
##
cacheSolve <- function(x, ...) {
  inverse <- x$getinverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setinverse(inverse)
  inverse
}
