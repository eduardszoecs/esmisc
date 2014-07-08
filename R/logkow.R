#' Retrieve KOW from CAS
#' 
#' Retrieve KOW from CAS via LOGKOW, see \url{http://logkow.cisti.nrc.ca/logkow/search.html}.
#' @import httr XML
#' 
#' @param cas charachter; CAS numbers.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a character vector.
#' 
#' @note 
#' If more then on match is found user is asked for input.
#' 
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8")
#' get_kow(casnr)
get_kow <- function(cas, verbose = FALSE, ...){
  fun <- function(cas, verbose) {
    baseurl <- "http://logkow.cisti.nrc.ca/logkow/LOGKOW?searchtype=cas&start=0"
    qurl <- paste0(baseurl, '&criteria=', cas)
    if(verbose)
      message(qurl, '\n')
    tt <- GET(qurl)
    ttt <- htmlParse(tt)
    kow <- xpathSApply(ttt, "//p", xmlValue)
    kow <- as.numeric(gsub('Recommended value: ', '', kow))
    return(kow)
  }
  kow <- unlist(lapply(cas, fun, verbose))
  return(kow)
}
