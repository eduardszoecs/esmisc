#' Retrieve CID from Pubchem
#' 
#' Return CompoundID (CID) for a search query, see \url{https://pubchem.ncbi.nlm.nih.gov/}.
#' @import httr XML RCurl
#' 
#' @param query charachter; search query (e.g. CAS numbers).
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
#' get_cid(casnr)
get_cid <- function(query, verbose = FALSE, ...){
  fun <- function(name, verbose) {
    searchurl <- paste("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pccompound&term=",
                       name, sep = "")
    if(verbose)
      print(searchurl)
    xml_result <- xmlParse(getURL(searchurl))
    Sys.sleep(0.33)
    cid <- xpathSApply(xml_result, "//IdList/Id", xmlValue)
    # not found on ncbi
    if (length(cid) == 0){
      message(verbose, "Not found. Return NA.")
      cid <- NA
    }
    # more than one found on ncbi -> user input
    if(length(cid) > 1){
      message("More then one hit found for ", name, " ! \n 
              Enter rownumber of UID (other inputs will return 'NA'):\n")
      print(data.frame(cid))
      take <- scan(n = 1, quiet = TRUE, what = 'raw')
      if(length(take) == 0)
        cid <- NA
      if(take %in% seq_len(length(cid))){
        take <- as.numeric(take)
        message("Input accepted, took UID '", as.character(cid[take]), "'.\n")
        cid <- as.character(cid[take])
      } else {
        cid <- NA
        message(verbose, "\nReturned 'NA'!\n\n")
      }
    }
    return(cid)
  }
  cid <- unlist(lapply(query, fun, verbose))
  return(cid)
}
# casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8")
# cid <- get_cid(casnr)


#' Convert CID to SMILES
#' 
#' Convert CompoundID (CID) to SMILES, see \url{https://pubchem.ncbi.nlm.nih.gov/}
#' @import httr XML
#' @param cid character, CID as returned by get_cid.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a charater vector.

#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' # convert CAS to CSID
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8")
#' cid <- get_cid(casnr)
#' # get SMILES from CSID
#' cid_to_smiles(csid)
cid_to_smiles <- function(cid, verbose = FALSE, ...){
  fnx <- function(x, ...){
    baseurl <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pccompound"
    qurl <- paste0(baseurl, '&ID=', x)
    if(verbose)
      message(qurl)
    tt <- GET(qurl)
    ttt <- xmlParse(tt)
    # better use xpath and xmlParse
    smiles <- xpathSApply(ttt, '//Item[@Name = "CanonicalSmiles"]', xmlValue)
    Sys.sleep(0.3)
    return(smiles)
  }
  smiles<- unlist(lapply(cid, fnx, ...))
  return(smiles)
}
# cid_to_smiles(cid)


#' Get extended information from Pubchem
#' 
#' Get extended info from pubchem, see \url{https://pubchem.ncbi.nlm.nih.gov/}
#' @import httr XML
#' @param cid character, CID as returned by get_cid.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param ... currently not used.
#' @return a charater vector
#' 
#' @author Eduard Szoecs, \email{eduardszoecs@@gmail.com}
#' @export
#' @examples
#' # convert CAS to CID
#' casnr <- c("107-06-2", "107-13-1", "319-84-6", "319-86-8", "1031-07-8")
#' cid <- get_cid(casnr)
#' # get SMILES from CID
#' cid_to_ext(cid)
cid_to_ext <- function(cid, verbose = FALSE, ...){
  fnx <- function(x, token, ...){
    baseurl <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pccompound"
    qurl <- paste0(baseurl, '&ID=', x)
    if(verbose)
      message(qurl)
    tt <- GET(qurl)
    ttt <- xmlParse(tt)
    iupac <- xpathSApply(ttt, '//Item[@Name = "IUPACName"]', xmlValue)
    smiles <- xpathSApply(ttt, '//Item[@Name = "CanonicalSmiles"]', xmlValue)
    mw <- xpathSApply(ttt, '//Item[@Name = "MolecularWeight"]', xmlValue)
    mf <- xpathSApply(ttt, '//Item[@Name = "MolecularFormula"]', xmlValue)
    InChIKey <- xpathSApply(ttt, '//Item[@Name = "InChIKey"]', xmlValue)
    out <- data.frame(iupac, smiles, mw, mf, InChIKey)
    Sys.sleep(0.1)
    return(out)
  }
  out <- ldply(cid, fnx, token, verbose)
  return(out)
}
# cid_to_ext(cid)
