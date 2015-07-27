#' Read DWD REGNIE gridded data into R
#' 
#' @description This functions reads DWD gridded data (currently only tested with REGNIE).
#' A description of the data can be found here:
#' \url{ftp://ftp.dwd.de/pub/CDC/grids_germany/daily/regnie/REGNIE_Beschreibung.pdf}.
#' Data is available here: \url{ftp://ftp.dwd.de/pub/CDC/grids_germany/daily/regnie/}.
#' @import raster
#' @param file path to gz archive
#' @return A \code{RasterLayer} object.
#' @export
#' @examples
#' # Read daily precipitation on 24.12.2014.
#' r <- read_regnie(system.file("extdata", "ra141224.gz", package = "esmisc"))
read_regnie <- function(file){
  # read file
  zz <- gzfile(file)
    cont <- readLines(zz, n = 971)
  close(zz)
  # replace NA values
  cont <- gsub('-999', ' NA ', cont, fixed = TRUE)
  r <- raster(matrix(scan(textConnection(cont), what = integer(0), n = 971*611), 
                     nrow = 971, ncol = 611, byrow = TRUE))
  extent(r) <- c(5.833333, 16, 47, 55.083333)
  crs(r) <- "+proj=longlat"
  # scale to mm
  r <- r/10
  return(r)
}
