#' @title pccc: Pediatric Complex Chronic Conditions
#'
#' @description
#' An implementation of the pediatric complex chronic conditions (CCC)
#' classification system.  Implemented for the International Classification of
#' Disease (ICD) 9th and 10th revisions.
#'
#' @references
#' Feudtner C, et al. Pediatric complex chronic conditions classification system
#' version 2: updated for ICD-10 and complex medical technology dependence and
#' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
#'
#' @section Reference Material:
#' The original paper, Feudtner C, et al. (2014), was publish with open access.
#' For ease, a copy of the paper is included in this package.  See the examples
#' below for instructions on opening this pdf from within R or outside of R.
#' You can view the publication online at
#' \url{http://bmcpediatr.biomedcentral.com/articles/10.1186/1471-2431-14-199}.
#'
#' Feudtner et. al. provided a SAS macro and STATA program to implement the CCC.
#' These files are also provided for reference.  See the Examples for
#' instructions on opening these files.
#'
#' Lastly, the appendix tables in the file
#' Categories_of_CCCv2_and_Corresponding_ICD.docx have also been included with
#' this package.
#'
#' @examples
#' \dontrun{
#' # To open the Feudtner et.al. pdf from within R use the following
#' if (!is.null(getOption("pdfviewer"))) {
#'   system(paste0(getOption("pdfviewer"), " ",
#'                 file.path(system.file("pccc_references", package = "pccc")), "/",
#'                 "Feudtner_etal_2014.pdf"))
#' }
#'
#' # If the pdf cannot be opened, you should be able to open it manually by
#' # navagating to
#' file.path(system.file("pccc_references", package = "pccc"))
#'
#' # To view the original SAS program
#' file.show(system.file("pccc_references", "ccc_version2_sas.sas", package = "pccc"))
#'
#' # To view the original STATA program
#' file.show(system.file("pccc_references", "ccc.do", package = "pccc"))
#' }
#'
#' @docType package
#' @name pccc-package
#' @useDynLib pccc
#' @importFrom Rcpp sourceCpp
#' @importFrom dplyr as.tbl
NULL

#' @importFrom dplyr "%>%"
# Define globalVariables so R CMD check doesn't freak out
utils::globalVariables(".")

.onUnload <- function(libpath) {
  library.dynam.unload("pccc", libpath)
}