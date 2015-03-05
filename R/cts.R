#' Get record details from Chemical Translation Service (CTS)
#' 
#' Get record details from CTS, see \url{http://cts.fiehnlab.ucdavis.edu}
#' @import RCurl RJSONIO
#' @param inchikey character, InChIkey.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a list of 7. inchikey, inchicode, molweight, exactmass, formula, synonyms and externalIds
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples 
#' \dontrun{
#' # omit synonyms and external links from output
#' cts_compinfo("DNYVWBJVOYZRCX-RNGZQALNSA-N")[1:5]
#' }
cts_compinfo <- function(inchikey, verbose = FALSE, ...){
  if(length(cid) > 1){
    stop('Cannot handle multiple input strings.')
  }
  baseurl <- "http://cts.fiehnlab.ucdavis.edu/service/compound"
  qurl <- paste0(baseurl, '/', inchikey)
  if(verbose)
    message(qurl)
  Sys.sleep(0.3)
  h <- try(getURL(qurl))
  if(!inherits(h, "try-error")){
    out <- fromJSON(h)
  } else{
    warning('Problem with web service encountered... Returning NA.')
    out < NA
  }
  return(out)
}
