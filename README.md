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

See (https://github.com/dewittpe/pccc-testing)

## Installation
This package is currently only on github.  Adding to The Comprehensive R Archive
Network might occur.  For now, you can install a released version or the
developmental version from github.

### Released version
Starting with version 0.2.2 we are placing the source R package in the releases.
You can view the releases at https://github.com/CUD2V/pccc/releases.  Drill
into the release you are interested in and download the `pccc_X.Y.Z.tar.gz`
file.  (`X.Y.Z` represents the version number string).

On you computer you can install the packge via command line

    R CMD INSTALL <path>/pccc_<version>.tar.gz

Or in R via

    install.packages("<path>/pccc_<version>.tar.gz", repos = NULL)

Or in RStudio by using the menu `Tools > Install Packages...`

### Developmental 

You can install the
development version of `pccc` directly from github via the 
[`devtools`](https://github.com/hadley/devtools/) package:

    if (!("devtools" %in% rownames(installed.packages()))) { 
      warning("installing devtools from https://cran.rstudio.com")
      install.packages("devtools", repo = "https://cran.rstudio.com")
    }

    devtools::install_github("CUD2V/pccc", build_vignettes = TRUE)

*NOTE:* If you are working on a Windows machine you will need to download and
install [`Rtools`](https://cran.r-project.org/bin/windows/Rtools/) before
`devtools` will work for you.

If you are on a Linux machine or have GNU `make` configured you should be able
to build and install this package by cloning the repository and running

    make install
