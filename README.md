esmisc
============
[![Build Status](https://travis-ci.org/EDiLD/esmisc.png)](https://travis-ci.org/EDiLD/esmisc)
[![Build status](https://ci.appveyor.com/api/projects/status/ju4fwso1luyanrn6?svg=true)](https://ci.appveyor.com/project/EDiLD/esmisc-98v1t)
[![Coverage Status](https://codecov.io/github/edild/esmisc/coverage.svg)](https://codecov.io/gh/EDiLD/esmisc)
[![Open Issues](https://img.shields.io/github/issues/edild/esmisc.svg)](https://github.com/edild/esmisc/issues)
[![Downloads](http://cranlogs.r-pkg.org/badges/esmisc)](http://cranlogs.r-pkg.org/badges/esmisc)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/esmisc)](http://cran.r-project.org/web/packages/esmisc)


`esmisc` is a R package containing misc functions of Eduard Szöcs.

## Functions
Currently the following functions are available:

  + `read_regnie()` reads DWD REGNIE data into R.
  + `theme_edi()` is a custom ggplot2 theme that I use.
    

    
## Installation
`esmisc` is currently only available on github. To install `esmisc` use:

```r
install.packages('devtools')
library(devtools)
install_github('esmisc', 'EDiLD')
library(esmisc)
```

## Examples

```r
library(esmisc)
```


### Read DWD REGNIE data into R


```r
r <- read_regnie(system.file("extdata", "ra050120.gz", package = "esmisc"))
# plot the raster
require(raster)
plot(r, main = 'Precipitation on 20.01.2005')
```

![](README_files/figure-html/read_regnie-1.png)<!-- -->

### ggplot2 theme


```r
library(ggplot2)
p <- ggplot(mtcars) + 
  geom_point(aes(x = wt, y = mpg, colour=factor(gear))) + 
  facet_wrap(~am) + 
  theme_edi()
p
```

![](README_files/figure-html/ggplot_themes-1.png)<!-- -->
