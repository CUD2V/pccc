#' Complex Chronic Conditions (CCC)
#'
#' Generate CCC and CCC subcategory flags and the number of categories.
#'
#' It is recommended that you view the codes defining the CCC via
#' \code{\link{get_codes}} and make sure that the ICD codes in your data set are
#' formatted in the same way.  The ICD codes used for CCC are character strings
#' must be formatted as follows:
#' \itemize{
#' \item *Do not* use decimal points or other separators
#' \item ICD 9 codes: Codes less than 10 should be left padded with 2 zeros. Codes
#' less than 100 should be left padded with 1 zero.
#' }
#'
#' See `vignette("pccc-overview")` for more details.
#'
#' @references
#' See \code{\link{pccc-package}} for published paper on the topic of identifying
#' Complex Chronic Conditions
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
    stop("dx_cols and pc_cols are both missing.  At least one must not be.",
         call. = FALSE)
  }

  # with around 200,000 rows of data previous use of sapply is equal to this new mutate method
  # however, due to how sapply simplifies and converts to a matrix, it doesn't always give the
  # output as expected by the rest of this applciation (sapply will convert rows to columns)
  # under 200k, sapply is faster
  # over 200k mutate is faster
  if (!missing(dx_cols)) {
    dxmat <- as.matrix(dplyr::mutate_all(dplyr::select(data, !!dplyr::enquo(dx_cols)), as.character))
  } else {
    dxmat <- matrix("", nrow = nrow(data))
  }

  if (!missing(pc_cols)) {
    pcmat <- as.matrix(dplyr::mutate_all(dplyr::select(data, !!dplyr::enquo(pc_cols)), as.character))
  } else {
    pcmat <- matrix("", nrow = nrow(data))
  }

  if (!missing(id)) {
    ids <- dplyr::select(data, !!dplyr::enquo(id))
  } else {
    ids <- NULL
  }

  dplyr::bind_cols(ids, ccc_mat_rcpp(dxmat, pcmat, icdv))
}
