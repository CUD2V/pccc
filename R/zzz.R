.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "
    The pccc package implements PCCC version 2 [Feudtner et.al. (2014) https://doi.org/10.1186/1471-2431-14-199].

    PCCC version 3 [Feinstein et.al. (2024) https://doi.org/10.1001/jamanetworkopen.2024.20579]
    has been implimented in another R package: medicalcoder [https://CRAN.R-project.org/package=medicalcoder]

    An improved implementation of PCCC version 2 has also been implemented in medicalcoder.

    Details and examples on transitioning from the pccc package to medicalcoder can be found here:
    https://www.peteredewitt.com/medicalcoder/articles/transition-pccc-to-medicalcoder.html
    "
  )
}
