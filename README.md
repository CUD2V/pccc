# pccc
Pediatric Complex Chronic Conditions: An R Package

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/dewittpe/pccc.svg?branch=master)](https://travis-ci.org/dewittpe/pccc)
[![Coverage Status](https://img.shields.io/codecov/c/github/dewittpe/pccc/master.svg)](https://codecov.io/github/dewittpe/pccc?branch=master)

## Inspiration
The Pediatric Complex Conditions (CCC) was published 
["Pediatric complex chronic conditions classification system version
2: updated for ICD-10 and complex medical technology dependence and
transplantation" by Chris Feudtner, James A Feinstein, Wenjun Zhong, Matt Hall
and Dingwei Dai](http://bmcpediatr.biomedcentral.com/articles/10.1186/1471-2431-14-199),
and provided SAS and STATA code.

This package provides equivalent R functions to generate the CCC classifiers.

## Install
This package is currently only on github.  You can install the
development version of `pccc` directly from github via the 
[`devtools`](https://github.com/hadley/devtools/) package:

    if (!("devtools" %in% rownames(installed.packages()))) { 
      warning("installing devtools from https://cran.rstudio.com")
      install.packages("devtools", repo = "https://cran.rstudio.com")
    }

    devtools::install_github("dewittpe/pccc", build_vignettes = TRUE)

*NOTE:* If you are working on a Windows machine you will need to download and
install [`Rtools`](https://cran.r-project.org/bin/windows/Rtools/) before
`devtools` will work for you.

If you are on a Linux machine or have GNU `make` configured you should be able
to build and install this package by cloning the repository and running

    make install
