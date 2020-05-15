# pccc
Pediatric Complex Chronic Conditions: A R Package

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/CUD2V/pccc.svg?branch=master)](https://travis-ci.org/CUD2V/pccc)
[![Coverage Status](https://img.shields.io/codecov/c/github/cud2v/pccc/master.svg)](https://codecov.io/github/cud2v/pccc?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/pccc)](http://cran.r-project.org/package=pccc)

## Motivation
Version 2 of the Pediatric Complex Chronic Conditions (CCC) system was published 
["Pediatric complex chronic conditions classification system version
2: updated for ICD-10 and complex medical technology dependence and
transplantation" by Chris Feudtner, James A Feinstein, Wenjun Zhong, Matt Hall
and Dingwei Dai](http://bmcpediatr.biomedcentral.com/articles/10.1186/1471-2431-14-199).

SAS and STATA scripts to generate CCC categories from ICD codes were provided by Feudtner et al. 
as an appendix to the above manuscript. However, those scripts can take many hours to run
on large datasets. 

This package provides R functions to generate the CCC categories. Because the R functions
are built with a C++ back-end, they are very computationally efficient.

## Testing and Benchmarking

The PCCC package uses the R library [testthat](http://testthat.r-lib.org) for unit tests. All tests are automatically run upon running the `devtools::install_github()` command shown below.

Some additional tests on large datasets were developed by Peter DeWitt and are available at https://github.com/CUD2V/pccc-testing. As 2 of the 3 require special license agreements for data access, they are not included with this repository.

## Installation

### From CRAN
Version 1.0.2 is available on The Comprehensive R Archive Network at https://CRAN.R-project.org/package=pccc.


### Developmental version

You can install the
developmental version of `pccc` directly from github using the 
[`devtools`](https://github.com/hadley/devtools/) package:

```r
if (!("devtools" %in% rownames(installed.packages()))) {
  warning("installing devtools from https://cran.rstudio.com")
  install.packages("devtools", repo = "https://cran.rstudio.com")
}

devtools::install_github("CUD2V/pccc", build_vignettes = TRUE)
```

*NOTE:* If you are working on a Windows machine you will need to download and
install [`Rtools`](https://cran.r-project.org/bin/windows/Rtools/) before
`devtools` will work for you.

If you are on a Linux machine or have GNU `make` configured you should be able
to build and install this package by cloning the repository and running

```bash
make install
```

## Steps to prepare for release of new version on CRAN

First update all packages that pccc depends on.

```r
devtools::build()
devtools::install()
devtools::test()
devtools::check()
```

If all of the above are successful, then commit changes and verify CI builds have succeeded at https://travis-ci.org/github/CUD2V/pccc

Then, do the following:

```r
devtools::check_win_release()
devtools::check_win_devel()
devtools::check_win_oldrelease()

devtools::check_rhub()
```

*Note:* As of May 2020, R-hub Windows server requries some custom configuration:

```r
rhub::check(
  platform="windows-x86_64-devel",
  env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always")
)
```

If datafiles used for tests are updated, use this to check compression and potentially shrink file size:

```r
tools::checkRdaFiles('./data')
tools::resaveRdaFiles('./data')
```
