#' Read DWD REGNIE gridded data into R
#' 
#' @description This functions reads DWD gridded data (currently only tested with REGNIE).
#'  Moreover, it reprojects the raster either using \code{\link[raster]{projectRaster}} or 
#' gdalwarp (faster, but needs gdal on the path). 
#' A description of the data can be found here:
#' \url{ftp://ftp.dwd.de/pub/CDC/grids_germany/daily/regnie/REGNIE_Beschreibung.pdf}.
#' @import raster
#' @param file path to gzip archive
#' @param crs reproject raster to specified CRS? 
#' character or object of class 'CRS'. PROJ.4 description of the coordinate reference system. 
#' If NULL the returned raster is longlat.
#' @param usegdal Use gdal to reproject raster? If \code{FALSE} \code{\link[raster]{projectRaster}} is used.
#' If \code{TRUE} gdalwarp is needed in path.
#' @return A projected \code{RasterLayer} object.
#' @export
#' @examples \dontrun{
#' # using projectRaster takes few seconds
#' r <- read_regnie(system.file("extdata", "ra141224.gz", package = "esmisc"), 
#'    crs = CRS('+init=epsg:31467'), usegdal = FALSE)
#' 
#' }
read_regnie <- function(file, crs = NULL, usegdal = TRUE){
  # file <- '/home/edisz/Documents/Uni/Projects/PHD/4BFG/Project/data/regnie/ra2014m/ra141224.gz'
  # read file
  zz <- gzfile(file)
    cont <- readLines(zz, n = 971)
  close(zz)
  # replace NA value
  cont <- gsub('-999', ' NA ', cont, fixed = TRUE)
  
  r <- raster(matrix(scan(textConnection(cont), what = integer(0), n = 971*611), 
                     nrow = 971, ncol = 611, byrow = TRUE))
  extent(r) <- c(5.833333, 16, 47, 55.083333)
  crs(r) <- "+proj=longlat"
  if (!is.null(crs)) {
    if (usegdal) {
      # projectRaster is slow - use gdalwarp
      tf <- tempfile(fileext = '.tif')
      tf2 <- tempfile(fileext = '.tif')
      writeRaster(r, tf)
      system(command = paste("gdalwarp -t_srs \'+init=epsg:31467\' -r near -overwrite", 
                             tf,
                             tf2))
      r <- raster(tf2)
    } else {
      r <- projectRaster(from = r, crs = crs)
    }
  }
  # scale to mm
  r <- r/10
  if (!is.null(crs))
    if (usegdal)
      unlink(c(tf, tf2))  
  return(r)
}
