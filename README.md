# pccc
Pediatric Complex Chronic Conditions: A R Package

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![R-CMD-check](https://github.com/CUD2V/pccc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CUD2V/pccc/actions/workflows/R-CMD-check.yaml)

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/pccc)](https://cran.r-project.org/package=pccc)
[![CRAN mirror downloads](https://cranlogs.r-pkg.org/badges/pccc)](https://www.r-pkg.org/pkg/pccc)
[![Total CRAN mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/pccc)](https://www.r-pkg.org/pkg/pccc)

## Motivation

### Version 2 of PCCC Criteria
[Pediatric complex chronic conditions classification system version 2:](http://bmcpediatr.biomedcentral.com/articles/10.1186/1471-2431-14-199).

        Feudtner, C., Feinstein, J.A., Zhong, W. et al. Pediatric complex
        chronic conditions classification system version 2: updated for ICD-10
        and complex medical technology dependence and transplantation. BMC
        Pediatr 14, 199 (2014). https://doi.org/10.1186/1471-2431-14-199


["Pediatric complex chronic conditions classification system version
2: updated for ICD-10 and complex medical technology dependence and
transplantation" by Chris Feudtner, James A Feinstein, Wenjun Zhong, Matt Hall
and Dingwei Dai]

SAS and STATA scripts to generate CCC categories from ICD codes were provided by Feudtner et al.
as an appendix to the above manuscript. However, those scripts can take many hours to run
on large datasets.

This package provides R functions to generate the CCC categories. Because the R functions
are built with a C++ back-end, they are very computationally efficient.

The pccc package version 1.0.z implemented this version of the PCCC criteria.

### Version 3 of the PCCC Criteria
[Pediatric Complex Chronic Condition System Version 3](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2821158)

        Feinstein JA, Hall M, Davidson A, Feudtner C. Pediatric Complex Chronic
        Condition System Version 3. JAMA Netw Open. 2024;7(7):e2420579.
        doi:10.1001/jamanetworkopen.2024.20579

The criteria has been updated and there is a major conceptual change in the way
technology dependencies are accounted for.

Version 3 of the pccc R package (skipping version 2 so the package version will
match the system version) will implement version 3 of the PCCC.

## Installation

### From CRAN
Released version available on The Comprehensive R Archive Network at https://CRAN.R-project.org/package=pccc.

### Developmental version

You can install the
developmental version of `pccc` directly from github using the
[`remotes`](https://remotes.r-lib.org) package:

```r
if (!("remotes" %in% rownames(installed.packages()))) {
  warning("installing remotes from https://cran.rstudio.com")
  install.packages("remotes", repo = "https://cran.rstudio.com")
}
remotes::install_github("CUD2V/pccc", build_vignettes = TRUE)
```

*NOTE:* If you are working on a Windows machine you will likely need
[`Rtools`](https://cran.r-project.org/bin/windows/Rtools/).

If you are on a Linux machine or have GNU `make` configured you should be able
to build and install this package by cloning the repository and running

```bash
make install
```
