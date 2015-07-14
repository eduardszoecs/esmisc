#' Search for CAS numbers on ETOX
#' 
#' Search for CAS numbers on ETOX (https://webetox.uba.de/webETOX/index.do)
#' @import httr XML RCurl
#' 
#' @param  x character; The searchterm
#' @param verbose logical; print message during processing to console?
#' @return character; The CAS number. NA if the substance is not found.
#' 
#' @note If more than one reference is found on the first is taken.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' \dontrun{
#' etox_to_cas('2,4,5-Trichlorphenol')
#' sapply(c('2,4,5-Trichlorphenol', '2,4-D', 'xxxxx'), etox_to_cas)
#' }
etox_to_cas <- function(x, verbose = TRUE){
  # TODO preprocess input with regex (e.g. strip ending 'e', or 
  # add dash to 3,4Dichloroaniline (3,4-Dichloroaniline))
  if(verbose)
    message('Searching ', x)
  # search
  baseurl <- 'http://webetox.uba.de/webETOX/public/search/stoff.do'
  out <- postForm(baseurl, .params = list('stoffname.selection[0].name' = x, event = 'Search'))
  
  # get substances and links
  tt <- htmlParse(out)
  subs <- xpathSApply(tt,"//*/table[@class = 'listForm resultList']//a", xmlValue)
  if(is.null(subs)){
    if(verbose)
      message('Substance not found! Returing NA. \n')
    return(NA_character_)
  }
  link <- unique(xpathSApply(tt, "//*/table[@class = 'listForm resultList']//a//@href"))
  if (length(link) > 1) {
    if (verbose) 
      message("More then one Link found. Returning first hit. \n")
    link <- link[1]
  }
  id <- gsub('^.*\\?id=(.*)', '\\1', link)
  Sys.sleep(0.01)
  
  # get additional information
  compurl <- paste0('http://webetox.uba.de/webETOX/public/basics/stoff.do?id=', id)
  Sys.sleep(0.3)
  tt2 <- htmlParse(getURL(compurl))
  nodes <- getNodeSet(tt2, "//table[contains(.,'CAS')]")
  if(length(nodes) == 0){
    if(verbose)
      message('No CAS found! Returing NA. \n')
    return(NA_character_)
  }
  # get last table
  tab <- readHTMLTable(nodes[length(nodes)][[1]], header = FALSE)
  names(tab) <- c('value', 'type')
  CAS <- as.character(tab[tab$type == 'CAS', 'value'])
  return(CAS)
}
