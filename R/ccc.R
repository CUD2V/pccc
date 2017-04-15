#' Complex Chronic Conditions (CCC)
#'
#' Generate CCC and CCC subcategory flags and the number of categories.
#'
#' It is recommended that you view the codes defining the CCC via
#' \code{\link{get_codes}} and make sure that the ICD codes in your data set are
#' formatted in the same way.  The ICD codes used for CCC are character strings
#' and *do not* have decimal points.
#'
#' @references
#' Feudtner C, et al. Pediatric complex chronic conditions classification system
#' version 2: updated for ICD-10 and complex medical technology dependence and
#' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
#'
#' @author Peter DeWitt
#'
#' @param .data a \code{data.frame} containing a patient id and all the ICD-9-CM
#' or ICD-10-CM codes.  The \code{data.frame} passed to the function should be
#' in wide format.
#' @param id bare name of the column containing the patient id
#' @param codes column names with the diagnostic codes, use
#' \code{\link[dplyr]{vars}} from \code{dplyr} to identify the column(s).
#' @param icdv ICD version 9 or 10, defaults to 9
#'
#' @seealso \code{\link{get_codes}} to view the ICD codes used to define the
#' CCC.
#'
#' @example examples/ccc.R
#'
#' @export
ccc <- function(.data, id, codes, icdv = 9) {
  cmat <- as.matrix(dplyr::select_(.data, .dots = codes))
  ids <- dplyr::select_(.data, .dots = lazyeval::interp( ~ i, i = substitute(id)))
  dplyr::bind_cols(ids, ccc_rcpp(cmat, icdv))
}
