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
#' @param dx_cols column names with the diagnostic codes, use
#' \code{\link[dplyr]{vars}} from \code{dplyr} to identify the column(s).
#' @param pc_cols the column(s) containing the procedure codes.  Use
#' \code{\link[dplyr]{vars}} from \code{dplyr} to identify the column(s).
#' @param icdv ICD version 9 or 10, defaults to 10
#'
#' @example examples/ccc.R
#'
#' @export
ccc <- function(.data, id, dx_cols, pc_cols, icdv = 10) {
  dxmat <- as.matrix(dplyr::select_(.data, .dots = dx_cols))
  pcmat <- as.matrix(dplyr::select_(.data, .dots = dx_cols))
  ids <- dplyr::select_(.data, .dots = lazyeval::interp( ~ i, i = substitute(id)))[[1]]

  Map(ccc_rcpp,
      dx = split(dxmat, seq(1, nrow(dxmat))),
      pc = split(pcmat, seq(1, nrow(pcmat))),
      MoreArgs = list(version = icdv)) %>%
  do.call(rbind, .) %>%
  dplyr::as_data_frame() %>%
  tibble::add_column(., ids, .before = 1) 
}

