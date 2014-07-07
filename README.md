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



# Retrieve additional infos
### Chemspider

```r
csid_to_ext(csid, token)
```

```
##       CSID               MF
## 1 13837650 C_{2}H_{4}Cl_{2}
## 2     7567      C_{3}H_{3}N
## 3 10468511 C_{6}H_{6}Cl_{6}
##                                                       SMILES
## 1                                                   C(CCl)Cl
## 2                                                     C=CC#N
## 3 [C@@H]1([C@@H]([C@@H]([C@H]([C@H]([C@@H]1Cl)Cl)Cl)Cl)Cl)Cl
##                                                                          InChI
## 1                                              InChI=1/C2H4Cl2/c3-1-2-4/h1-2H2
## 2                                               InChI=1/C3H3N/c1-2-3-4/h2H,1H2
## 3 InChI=1/C6H6Cl6/c7-1-2(8)4(10)6(12)5(11)3(1)9/h1-6H/t1-,2-,3-,4-,5+,6+/m1/s1
##                    InChIKey AverageMass MolecularWeight MonoisotopicMass
## 1 WSLDOOZREJYCGB-UHFFFAOYAL     98.9592        98.95916        97.969009
## 2 NLHHRLWOUZZQLW-UHFFFAOYAG     53.0626        53.06262         53.02655
## 3 JLYXXMFPNIAWKQ-SHFUYGGZBU    290.8298       290.82984       287.860077
##   NominalMass ALogP XLogP                    CommonName
## 1          98     0     0            1,2-dichloroethane
## 2          53     0     0                 acrylonitrile
## 3         288     0     0 l-alpha-Hexachlorocyclohexane
```


### Molecular weight via cactus

```r
cactus(casnr, output = 'mw')
```

```
## [1] "98.9596"  "53.0634"  "290.8314"
```


NOTE
=============
Chemspider needs a security token. Please register at RSC (https://www.rsc.org/rsc-id/register) for a security token.
