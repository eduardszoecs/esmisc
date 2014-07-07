#' Get CSID from chemspider
#' 
#' Return ChemspiderId (CSID) for a search query, see \url{http://www.chemspider.com/}.
#' @import httr XML
#' 
#' @param query charachter; search query (e.g. CAS numbers).
#' @param token character; security token.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a character vector of class 'csid' with CSID.
#' 
#' @note A security token is neeeded. Please register at RSC 
#' \url{https://www.rsc.org/rsc-id/register} 
#' for a security token.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' token <- '37bf5e57-9091-42f5-9274-650a64398aaf'
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8", "1031-07-8")
#' get_csid(casnr, token = token)
get_csid <- function(query, token, verbose = FALSE, ...){
  fnx <- function(x, token, ...){
    baseurl <- 'www.chemspider.com/Search.asmx/SimpleSearch?'
    qurl <- paste0(baseurl, 'query=', x, '&token=', token)
    if(verbose)
      message(qurl)
    tt <- GET(qurl)
    ttt <- xmlTreeParse(tt)
    csid <- xmlToList(ttt)$int
    if(length(csid) == 0){
      warning("CSID '", x, " not found!\n Returning NA!")
      out <- NA
    }
    if(length(csid) > 1){
      warning("More then one hit found!\n Returning first hit.")
      csid <- csid[1]
    }
    Sys.sleep(0.1)
    return(csid)
  }
  csid <- unlist(lapply(query, fnx, token, ...))
  class(csid) <- 'csid'
  return(csid)
}


#' Convert CSID to SMILES via chemspider
#' 
#' Convert ChemspiderId (CSID) to SMILES, see \url{http://www.chemspider.com/}
#' @import httr XML
#' @param csid character, CSID as returned by get_csid.
#' @param token character; security token.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a charater vector of class 'csid' with CSID.

#' @note A security token is neeeded. Please register at RSC 
#' \url{https://www.rsc.org/rsc-id/register} 
#' for a security token.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' token <- '37bf5e57-9091-42f5-9274-650a64398aaf'
#' # convert CAS to CSID
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8", "1031-07-8")
#' csid <- get_csid(casnr, token = token)
#' # get SMILES from CSID
#' csid_to_smiles(csid, token)
csid_to_smiles <- function(csid, token, verbose = FALSE, ...){
  fnx <- function(x, token, ...){
    baseurl <- 'www.chemspider.com/Search.asmx/GetCompoundInfo?'
    qurl <- paste0(baseurl, 'CSID=', x, '&token=', token)
    if(verbose)
      message(qurl)
    tt <- GET(qurl)
    ttt <- xmlTreeParse(tt)
    # better use xpath and xmlParse
    out <- xmlToList(ttt)
    smiles <- out$SMILES
    Sys.sleep(0.1)
    return(smiles)
  }
  smiles<- unlist(lapply(csid, fnx, token, ...))
  return(smiles)
}


#' Get extended information from Chemspider
#' 
#' Get extended info from Chemspider, see \url{http://www.chemspider.com/}
#' @import httr XML
#' @param csid character, CSID as returned by get_csid.
#' @param token character; security token.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a charater vector of class 'csid' with CSID.

#' @note A security token is neeeded. Please register at RSC 
#' \url{https://www.rsc.org/rsc-id/register} 
#' for a security token.
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' token <- '37bf5e57-9091-42f5-9274-650a64398aaf'
#' # convert CAS to CSID
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8", "1031-07-8")
#' csid <- get_csid(casnr, token = token)
#' # get SMILES from CSID
#' csid_to_ext(csid, token)
csid_to_ext <- function(csid, token, verbose = FALSE, ...){
  fnx <- function(x, token, ...){
    baseurl <- 'www.chemspider.com/MassSpecAPI.asmx/GetExtendedCompoundInfo?'
    qurl <- paste0(baseurl, 'CSID=', x, '&token=', token)
    if(verbose)
      message(qurl)
    tt <- GET(qurl)
    ttt <- xmlTreeParse(tt)
    # better use xpath and xmlParse
    out <- xmlSApply(ttt$doc$children$ExtendedCompoundInfo, xmlValue)
    Sys.sleep(0.1)
    return(out)
  }
  out <- ldply(csid, fnx, token, verbose)
  return(out)
}
