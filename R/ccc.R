#' Complex Chronic Conditions (CCC)
#'
#' Generate CCC and CCC subcategory flags and the number of categories.
#'
#' The \code{data.frame} passed to the function should be in wide format.
#'
#' @references
#' Feudtner C, et al. Pediatric complex chronic conditions classification system
#' version 2: updated for ICD-10 and complex medical technology dependence and
#' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
#'
#' @author Peter DeWitt
#'
#' @param .data a \code{data.frame} containing a patient id and all the ICD-9-CM
#' or ICD-10-CM codes.
#' @param id bare name of the column containing the patient id
#' @param dx_cols using the select functions from dplyr.
#' @param px_cols the column(s) containing the procedure codes.
#' @param icdv ICD version 9 or 10, defaults to 10
#'
#' @export
ccc <- function(.data, id, dx_cols, px_cols, icdv = 10) {
}

