#' Extract numbers from string
#' 
#' Extract numbers from string
#'
#' @param x string
#' @return numeric vector
#' @references \url{ http://stackoverflow.com/questions/19252663/extracting-decimal-numbers-from-a-string}
#' @export
#' @examples 
#' numextractall('1 2 3')
#' numextractall('1,2,3')
#' numextractall('1;2,3 4')
#' numextractall('1;2,3 4,46')
numextractall <- function(x) { 
  as.numeric(unlist(regmatches(x, gregexpr("[[:digit:]]+\\.*[[:digit:]]*", x)), 
                    use.names = FALSE))
} 
