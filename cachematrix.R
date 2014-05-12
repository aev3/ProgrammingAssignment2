#
#
# Introduction
# 
# Write an R function that is able to cache potentially time-consuming 
# computations. For example, taking the mean of a numeric vector is 
# typically a fast operation. However, for a very long vector, it may 
# take too long to compute the mean, especially if it has to be 
# computed repeatedly (e.g. in a loop). If the contents of a vector are 
# not changing, it may make sense to cache the value of the mean so that 
# when we need it again, it can be looked up in the cache rather than 
# recomputed. 
# 
# Take advantage of the scoping rules of the R language and how they can 
# be manipulated to preserve state inside of an R object.
#
# Example: Caching the Mean of a Vector
# 
# In this example we introduce the '<<-' operator which can be used 
# to assign a value to an object in an environment that is different 
# from the current environment. Below are two functions that are 
# used to create a special object that stores a numeric vector and 
# cache's its mean.
# 
# The first function, makeVector creates a special "vector", which is 
# really a list containing a function to:
# set the value of the vector
# get the value of the vector
# set the value of the mean
# get the value of the mean
#
makeCacheMatrix <- function(x = matrix()) {
#   m <- NULL
#   set <- function(y) {
#     x <<- y
#     m <<- NULL
#   }
#   get <- function() x
#   setmean <- function(mean) m <<- mean
#   getmean <- function() m
#   list(set = set, get = get,
#        setmean = setmean,
#        getmean = getmean)
    key <- "http://mytext.com"
    value <- "This is the content I downloaded"
    cacheEnv <- new.env()
    assign(key, value, envir=cacheEnv)
    get(key, envir=cacheEnv)
}
#
#
# The following function calculates the mean of the special "vector" 
# created with the above function. However, it first checks to see 
# if the mean has already been calculated. If so, it gets the mean from 
# the cache and skips the computation. Otherwise, it calculates the mean
# of the data and sets the value of the mean in the cache via the 
# setmean function.
#
cacheSolve <- function(x, ...) {
#   m <- NULL
#   set <- function(y) {
#     x <<- y
#     m <<- NULL
#   }
#   get <- function() x
#   setmean <- function(mean) m <<- mean
#   getmean <- function() m
#   list(set = set, get = get,
#        setmean = setmean,
#        getmean = getmean)
#       ## Return a matrix that is the inverse of 'x'
    if (exists(url, envir=cacheEnv)) {
      return(get(url, envir=cacheEnv))
    }
    
    file <- content(GET(url))
    assign(url, file, envir=cacheEnv)
    
    file
  }
