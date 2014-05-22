# Matrix inversion can be and usually is a costly computation and there may be 
# some benefit to caching the inverse of a matrix rather than computing it 
# repeatedly. The following two functions are used to cache the inverse of a 
# matrix.
#
# makeCacheMatrix creates a special matrix object and cacheSolve calculates the 
# inverse of the matrix. If the matrix inverse has already been calculated, it 
# will instead find it in the cache and return it. Thus, the recalculation of 
# the inverse of the matrix will be unecessary.

# makeCacheMatrix creates a list containing a function to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of inverse of the matrix
# 4. get the value of inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    # The operators <<- and ->> are normally only used in functions, and cause 
    # a search to made through parent environments for an existing definition 
    # of the variable being assigned. If such a variable is found (and its 
    # binding is not locked) then its value is redefined, otherwise assignment 
    # takes place in the global environment. 
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set=set, get=get, 
       setinverse=setinverse, 
       getinverse=getinverse)
}

# The function cacheSolve returns the inverse of a matrix created with the
# makeCacheMatrix function. If the cached inverse is available, cacheSolve
# retrieves it. If the inverse is not available, the cacheSolve function 
# computes, caches, and returns the inverse of the cacheable matrix.
cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)) {
      message("Reusing cached inverse matrix")
      return(inv)
    }
    data <- x$get()
    inv <- solve(data)
    x$setinverse(inv)
    return(inv)
  }
#
# Example usage:
#
# > x = rbind(c(1, -1/8), c(-1/8, 1))
# > m = makeCacheMatrix(x)
# > m$get()
#       [,1]  [,2]
# [1,]  1.00 -0.125
# [2,] -0.125  1.00
#
# First run:
# > cacheSolve(m)
#           [,1]      [,2]
# [1,] 1.0158730 0.1269841
# [2,] 0.1269841 1.0158730
#
# Second run:
# > cacheSolve(m)
# Reusing cached inverse matrix
#           [,1]      [,2]
# [1,] 1.0158730 0.1269841
# [2,] 0.1269841 1.0158730
#
#
# EoF

