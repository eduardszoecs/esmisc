#' Search for CAS numbers on ETOX
#' 
#' Search for CAS numbers on ETOX (https://webetox.uba.de/webETOX/index.do)
#' @import httr XML RCurl
#' 
#' @param  x character; The searchterm
#' @return character; The CAS number. NA if the substance is not found.
#' #' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' etox_to_cas('2,4,5-Trichlorphenol')
#' etox_to_cas('xxxxx')
etox_to_cas <- function(x){
  # search
  baseurl <- 'http://webetox.uba.de/webETOX/public/search/stoff.do'
  out <- postForm(baseurl, .params = list('stoffname.selection[0].name' = x))
  
  # get substances and links
  tt <- htmlParse(out)
  subs <- xpathSApply(tt,"//*/table[@class = 'listForm']//a", xmlValue)
  if(is.null(subs)){
    message('Substance not found! Returing NA.')
    return(NA)
  }
  links <- xpathSApply(tt,"//*/table[@class = 'listForm']//a//@href")
  # clean substances
  subs <- gsub('\\n|\\t| ', '', subs)
  take <- subs == x
  take_link <- links[take]
  # clean link
  id <- gsub('^.*\\?id=(.*)', '\\1', take_link)
  
  
  # get additional information
  compurl <- paste0('http://webetox.uba.de/webETOX/public/basics/stoff.do?id=', id)
  tt2 <- htmlParse(getURL(compurl))
  tab <- readHTMLTable(tt2)[[15]]
  names(tab) <- c('value', 'type')
  CAS <- as.character(tab[tab$type == 'CAS', 'value'])
  return(CAS)
}
