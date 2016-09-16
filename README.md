esmisc
============
[![Build Status](https://travis-ci.org/EDiLD/esmisc.png)](https://travis-ci.org/EDiLD/esmisc)

`esmisc` is a R package containing misc functions of Eduard Szöcs.

## Functions
Currently the following functions are available:

  + [LOGKOW](http://logkow.cisti.nrc.ca/logkow/index.jsp)
    + Retrieve recommended log KOW values : `get_kow()`
    + **Service currently not available :** [link](http://codata.ca/eng/resources/logkow.html)
  + `read_regnie()` reads DWD REGNIE data into R.
  + `theme_edi()` is a custom ggplot2 theme that I use.
    
#### Defunct
These functions have been moved to the [webchem-package](https://github.com/ropensci/webchem) and are no longer available in `esmisc`:

  + [Cactus](http://cactus.nci.nih.gov/chemical/structure_documentation) : `cactus()`
  + [Chemspider](http://www.chemspider.com/)
    + Query ChemspiderID (CSID): `get_csid()`
    + Convert CSID to SMILES : `csid_to_smiles()`
    + retrieve additional infos from CSID: `csid_to_ext()`
  + [Pubchem](https://pubchem.ncbi.nlm.nih.gov/)
    + Query CompoundID (CID): `get_cid()`
    + Convert CID to SMILES: `cid_to_smiles()`
    + retrieve additional infos from CID: `cid_to_ext()`
  + [allanwood](http://www.alanwood.net/pesticides/)
    + Query CAS and pesticides groups: `allanwood()`
  + [ETOX](http://webetox.uba.de/webETOX/index.do)
    + Convert names to CAS : `etox_to_cas()`
  + [Allan Wood](http://www.alanwood.net/pesticides/index.html)
    + Search and retrieve CAS and pesticide groups: `allanwood()`
    


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

### Retrieve log KOW values from LOGKOW
**Service currently not available!** [link](http://codata.ca/eng/resources/logkow.html)

```r
get_kow(casnr)
```

### Read DWD REGNIE data into R


```r
r <- read_regnie(system.file('extdata', 'ra141224.gz', package = 'esmisc'))
# plot the raster
require(raster)
plot(r, main = 'Precipitation on 24.12.2014')
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
