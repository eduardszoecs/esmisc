# esmisc
[![Build Status](https://travis-ci.org/EDiLD/esmisc.png)](https://travis-ci.org/EDiLD/esmisc)

`esmisc` is a R package containing misc functions of Eduard Szöcs.

## Functions
Currently the following functions are available:

### Web scraping Chemical/Ecotoxicological Information
  + [Cactus](http://cactus.nci.nih.gov/chemical/structure_documentation) : `cactus()`
  + [Chemspider](http://www.chemspider.com/)
    + Query ChemspiderID (CSID): `get_csid()`
    + Convert CSID to SMILES : `csid_to_smiles()`
    + retrieve additional infos from CSID: `csid_to_ext()`
  + [Pubchem](https://pubchem.ncbi.nlm.nih.gov/)
    + Query CompoundID (CID): `get_cid()`
    + Convert CID to SMILES: `cid_to_smiles()`
    + retrieve additional infos from CID: `cid_to_ext()`
  + [LOGKOW](http://logkow.cisti.nrc.ca/logkow/index.jsp)
    + Retrieve recommended log KOW values : `get_kow()`
    + **Currently not available** [link](http://codata.ca/eng/resources/logkow.html)
  + [ETOX](http://webetox.uba.de/webETOX/index.do)
    + Convert names to CAS : `etox_to_cas()`
  + [Allan Wood](http://www.alanwood.net/pesticides/index.html)
    + Search and retrieve CAS and pesticide groups: `allanwood()`


## Installation
`esmisc` is currently only available on github. To install `esmisc` use:

```r
install.packages('devtools')
require(devtools)
install_github('esmisc', 'EDiLD')
require(esmisc)
```


## Examples


### Convert CAS to SMILES
###### Via Cactus

```r
require(esmisc)
```

```
## Loading required package: esmisc
```

```r
casnr <- c("107-06-2", "107-13-1", "319-86-8")
cactus(casnr, output = 'smiles')
```

```
## [1] "C(Cl)CCl"                       "C(C#N)=C"                      
## [3] "C1(Cl)C(Cl)C(Cl)C(Cl)C(Cl)C1Cl"
```

###### Via Chemspider

```r
token <- '37bf5e57-9091-42f5-9274-650a64398aaf'
csid <- get_csid(casnr, token = token)
```

```
## Warning: internal error -3 in R_decompress1
```

```
## Error in eval(expr, envir, enclos): lazy-load database '/home/edisz/R_libs/all/esmisc/R/esmisc.rdb' is corrupt
```

```r
csid_to_smiles(csid, token)
```

```
## Error in lapply(csid, fnx, token, ...): object 'csid' not found
```

###### Via Pubchem

```r
cid <- get_cid(casnr)
```

```
## Warning: internal error -3 in R_decompress1
```

```
## Error in eval(expr, envir, enclos): lazy-load database '/home/edisz/R_libs/all/esmisc/R/esmisc.rdb' is corrupt
```

```r
cid_to_smiles(cid)
```

```
## Error in lapply(cid, fnx, ...): object 'cid' not found
```



### Retrieve additional infos
###### via Chemspider

```r
csid_to_ext(csid, token)
```

```
## Error in inherits(.data, "split"): object 'csid' not found
```

###### Molecular weight via cactus

```r
cactus(casnr, output = 'mw')
```

```
## [1] "98.9596"  "53.0634"  "290.8314"
```

###### Via Pubchem

```r
cid_to_ext(cid)
```

```
## Error in inherits(.data, "split"): object 'cid' not found
```

###### Retrieve log KOW values from LOGKOW

**Currently not available!** [link](http://codata.ca/eng/resources/logkow.html)

```r
get_kow(casnr)
```


### Convert common names to CAS and pesticides groups
###### CAS from [ETOX](http://webetox.uba.de/webETOX/index.do)

```r
etox_to_cas('2,4,5-Trichlorphenol')
```

```
## Warning: internal error -3 in R_decompress1
```

```
## Error in eval(expr, envir, enclos): lazy-load database '/home/edisz/R_libs/all/esmisc/R/esmisc.rdb' is corrupt
```

###### CAS and pesticides groups from [Allan Wood](http://www.alanwood.net/pesticides/index.html)

```r
sapply(c('Fluazinam', 'Diclofop'), allanwood)
```

```
## Querying fluazinam.html
## Querying diclofop.html
```

```
##          Fluazinam                         
## CAS      "79622-59-6"                      
## activity "fungicides (pyridine fungicides)"
##          Diclofop                                         
## CAS      "40843-25-2"                                     
## activity "herbicides (aryloxyphenoxypropionic herbicides)"
```



### Notes
Chemspider needs a security token. Please register at RSC (https://www.rsc.org/rsc-id/register) for a security token.


### TODOS
+ Promp for user input when more then one hit is found. 
+ Better info for user prompt.
