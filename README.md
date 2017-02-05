esmisc
======

[![Build
Status](https://travis-ci.org/EDiLD/esmisc.png)](https://travis-ci.org/EDiLD/esmisc)
[![Build
status](https://ci.appveyor.com/api/projects/status/ju4fwso1luyanrn6?svg=true)](https://ci.appveyor.com/project/EDiLD/esmisc-98v1t)
[![codecov](https://codecov.io/gh/EDiLD/esmisc/branch/master/graph/badge.svg)](https://codecov.io/gh/EDiLD/esmisc)
[![Open
Issues](https://img.shields.io/github/issues/edild/esmisc.svg)](https://github.com/edild/esmisc/issues)
[![Downloads](http://cranlogs.r-pkg.org/badges/esmisc)](http://cranlogs.r-pkg.org/badges/esmisc)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/esmisc)](http://cran.r-project.org/web/packages/esmisc)

`esmisc` is a R package containing misc functions of Eduard Szöcs.

Functions
---------

Currently the following functions are available:

-   `read_regnie()` reads DWD REGNIE data into R.
-   `theme_edi()` is a custom ggplot2 theme that I use.

Installation
------------

`esmisc` is currently only available on github. To install `esmisc` use:

    install.packages('devtools')
    library(devtools)
    install_github('esmisc', 'EDiLD')
    library(esmisc)

Examples
--------

    library(esmisc)

### Read DWD REGNIE data into R

    r <- read_regnie(system.file("extdata", "ra050120.gz", package = "esmisc"))
    # plot the raster
    require(raster)
    plot(r, main = 'Precipitation on 20.01.2005')

![](README_files/figure-markdown_strict/read_regnie-1.png)

### ggplot2 theme

    library(ggplot2)
    p <- ggplot(mtcars) + 
      geom_point(aes(x = wt, y = mpg, colour = factor(gear))) + 
      facet_wrap(~am) + 
      theme_edi()
    p

![](README_files/figure-markdown_strict/ggplot_themes-1.png)

### other functions

#### Geometric mean

    mean(c(1, 10, 100))

    ## [1] 37

    geomean(c(1, 10, 100))

    ## [1] 10
