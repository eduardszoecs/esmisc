esmisc
=============


[![Build Status](https://travis-ci.org/EDiLD/esmisc.png)](https://travis-ci.org/EDiLD/esmisc)

`esmisc` is a R package containing misc functions of Eduard Szöcs

### Functions
Currently the following functions are available:

+ Query [cactus](http://cactus.nci.nih.gov/chemical/structure_documentation) : `cactus()`
+ Chemspider
  + Query to ChemspiderID (CSID): `get_csid()`
  + Convert CSID to SMILES : `csid_to_smiles()`



Installation
==============
`esmisc` is currently only available on github. To install `esmisc` use:

```r
install.packages('devtools')
require(devtools)
install_github('esmisc', 'EDiLD')
require(esmisc)
```


Examples
=================

# Convert CAS to SMILES

### Using Cactus

```r
require(esmisc)
casnr <- c("107-06-2", "107-13-1", "319-84-6")
cactus(casnr, output = 'smiles')
```

```
## [1] "C(Cl)CCl"                       "C(C#N)=C"                      
## [3] "C1(Cl)C(Cl)C(Cl)C(Cl)C(Cl)C1Cl"
```

### Using Chemspider

```r
token <- '37bf5e57-9091-42f5-9274-650a64398aaf'
csid <- get_csid(casnr, token = token)
csid_to_smiles(csid, token)
```

```
## [1] "C(CCl)Cl"                                                  
## [2] "C=CC#N"                                                    
## [3] "[C@@H]1([C@@H]([C@@H]([C@H]([C@H]([C@@H]1Cl)Cl)Cl)Cl)Cl)Cl"
```





NOTES
=============

