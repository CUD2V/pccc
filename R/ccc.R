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
#' @param data a \code{data.frame} containing a patient id and all the ICD-9-CM
#' or ICD-10-CM codes.  The \code{data.frame} passed to the function should be
#' in wide format.
#' @param id bare name of the column containing the patient id
#' @param dx_cols,pc_cols column names with the diagnostic codes and procedure
#' codes respectively.  These argument are passed to \code{\link[dplyr]{select}}.
#' @param icdv ICD version 9 or 10
#'
#' @seealso \code{\link{get_codes}} to view the ICD codes used to define the
#' CCC.  \code{\link[dplyr]{select}} for more examples and details on how to
#' identify and select the diagnostic and procedure code columns.
#'
#' @return A \code{data.frame} with a column for the subject id and integer (0
#' or 1) columns for each each of the categories.
#'
#' @example examples/ccc.R
#'
#' @export
ccc <- function(data, id, dx_cols = NULL, pc_cols = NULL, icdv) { 
  UseMethod("ccc")
}

#' @method ccc data.frame
#' @export
ccc.data.frame <- function(data, id, dx_cols, pc_cols, icdv) { 

  if (missing(dx_cols) & missing(pc_cols)) {
    stop("dx_cols and pc_cols are both missing.  At least one need not be.",
         call. = FALSE)
  } 

  if (!missing(dx_cols)) {
    dxmat <- sapply(dplyr::select(data, !!dplyr::enquo(dx_cols)), as.character)
  } else {
    dxmat <- matrix("", nrow = nrow(data))
  }

  if (!missing(pc_cols)) {
    pcmat <- sapply(dplyr::select(data, !!dplyr::enquo(pc_cols)), as.character)
  } else {
    pcmat <- matrix("", nrow = nrow(data))
  }

  ids <- dplyr::select(data, !!dplyr::enquo(id))

  dplyr::bind_cols(ids, ccc_mat_rcpp(dxmat, pcmat, icdv))
}
