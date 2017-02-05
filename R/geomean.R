#' Geometric mean
#' 
#' Function for the geometric mean. 
#' 
#' @details The geometric mean is comuted as
#' \deqn{x = e^{(\sum \log x) / n}}
#' 
#' @param x a numeric vector.
#' @param na.rm a logical value indicating whether NA values should be 
#' stripped before the computation proceeds.
#' 
#' @return  numeric vector of length one with the geometric mean.
#' @references \url{http://stackoverflow.com/questions/2602583/geometric-mean-is-there-a-built-in}
#' @export
#' @examples 
#' x <- c(1, 10, 100)
#' mean(x)
#' geomean(x)
geomean = function(x, na.rm = TRUE){
  exp(sum(log(x[x > 0]), na.rm = na.rm) / length(x))
}
