#' Read DWD REGNIE gridded data into R
#' 
#' @description This functions reads DWD REGNIE data.
#' A description of the data can be found here (pdf-format):
#' \url{https://www.dwd.de/DE/leistungen/regnie/download/regnie_beschreibung_pdf.pdf?__blob=publicationFile&v=2}.
#' Data is available here: \url{ftp://ftp-cdc.dwd.de/pub/CDC/grids_germany/daily/regnie/}.
#' @import raster readr
#' @param file path to gz archive
#' @return A \code{RasterLayer} object.
#' @export
#' @examples
#' # Read daily precipitation on 20.01.2005.
#' r <- read_regnie(system.file("extdata", "ra050120.gz", package = "esmisc"))
read_regnie <- function(file){
  cont <- read_fwf(file, 
                   col_positions = fwf_widths(rep(4, 611)), 
                   col_types = cols(.default = col_integer()),
                   n_max = 971, 
                   na = '-999')
  r <- raster(as.matrix(cont))
  # ymax = (55 + 10 / 120)                    = 55.083333
  # ymin = (55 + 10 / 120) - (971 - 1) / 120  = 47
  # xmin = (6 - 10 / 60)                      = 5.833333
  # xmax = (6 - 10 / 60) + (611 - 1) / 60     = 16
  extent(r) <- c(6 - 10 / 60, 
                 (6 - 10 / 60) + (611 - 1) / 60, 
                 (55 + 10 / 120) - (971 - 1) / 120, 
                 55 + 10 / 120)
  crs(r) <- "+proj=longlat"
  # scale to mm
  r <- r/10
  return(r)
}

