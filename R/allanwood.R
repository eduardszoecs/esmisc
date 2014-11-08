#' Query http://www.alanwood.net/pesticides
#' 
#' Query http://www.alanwood.net/pesticides for CAS and activity
#' @import XML RCurl
#' 
#' @param  x character; A common name.
#' @return character; The CAS number. NA if the substance is not found.
#' 
#' @note If more than one reference is found on the first is taken.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' allanwood('Fluazinam')
#' sapply(c('Fluazinam', 'Diclofop', 'xxxxx'), allanwood)
allanwood <- function(x){
  baseurl <- 'http://www.alanwood.net/pesticides/index_cn.html'
  ttt <- htmlParse(getURL(baseurl))
  names <- xpathSApply(ttt,"//a", xmlValue)
  names <- names[!names == '']
  links <- xpathSApply(ttt,"//a//@href")
  takelink <- links[tolower(names) == tolower(x)]
  if(length(takelink) == 0){
    message('Not found! Returning NA.')
    return(c(CAS = NA_character_, activity = NA_character_))
  }
  ttt <- htmlParse(getURL(paste0('http://www.alanwood.net/pesticides/', takelink)))
  CAS <- xpathSApply(ttt, "//tr/th[@id='r5']/following-sibling::td", xmlValue)
  activity <- xpathSApply(ttt, "//tr/th[@id='r7']/following-sibling::td", xmlValue)
  return(c(CAS = CAS, activity = activity))
}
