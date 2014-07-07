#' Query cactus
#' 
#' Query cactus (\url{http://cactus.nci.nih.gov/chemical/structure_documentation}).
#' 
#' @import XML plyr
#' 
#' @param query character; as vector of search queries (e.g. CAS numbers).
#' @param output character; what output should be returned ? Available options are 'smiles',
#' 'iupac_name', 'mw' (molecular weight), see \url{http://cactus.nci.nih.gov/chemical/structure_documentation} for more options.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... Other arguments past to \code{\link[plyr]{ldply}}.
#' @return A character vector.
#' 
#' @note If more than one hit is found, only the first is returned. A warinig is given.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' # convert CAS to smiles
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8", "1031-07-8")
#' cactus(casnr, output = 'smiles')
#' # Get molecular weight from CAS
#' casnr <- c("107-06-2", "107-13-1", "319-84-6")
#' cactus(casnr, output = 'mw', verbose = TRUE)
cactus <- function(query, output = 'smiles', verbose = FALSE, ...){
  fnx <- function(x, output, verbose...){
    baseurl <- "http://cactus.nci.nih.gov/chemical/structure"
    qurl <- paste(baseurl, x, output, 'xml', sep = '/')
    if(verbose)
      message(qurl)
    h <- xmlParse(qurl, isURL = TRUE)
    #     print(h)
    out <- xpathSApply(h, "//data", xmlValue)
    if(length(out) == 0){
      warning("Query '", x, " not found!\n Returning NA!")
      out <- NA
    }
    if(length(out) > 1){
      warning("More then one hit found!\n Using first hit.")
      out <- out[1]
    }
    Sys.sleep(0.3)
    return(out)
  }
  out <- unlist(lapply(query, fnx, output, verbose, ...))
  return(out)
}
