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
#' @export
ccc <- function(.data, id, dx_cols, pc_cols, icdv = 10) {

  df <- dplyr::group_by_(.data, .dots = lazyeval::interp( ~ d, d = substitute(id)))
  dx_cols <- names(dplyr::select_(.data, .dots = dx_cols))
  pc_cols <- names(dplyr::select_(.data, .dots = pc_cols))

  df <- dplyr::bind_rows(tidyr::gather_(df, key_col = "code", "value", dx_cols),
                         tidyr::gather_(df, key_col = "code", "value", pc_cols))

  df <-
    dplyr::summarize_at(df,
                        dplyr::vars(dplyr::matches("value")),
                        dplyr::funs(neuromusc_ccc       = as.integer(any(. %in% c(dxc("neuromusc", icdv),         pcc("neuromusc", icdv)))),
                                    cvd_ccc             = as.integer(any(. %in% c(dxc("cvd", icdv),               pcc("cvd", icdv)))),
                                    respiratory_ccc     = as.integer(any(. %in% c(dxc("respiratory", icdv),       pcc("respiratory", icdv)))),
                                    renal_ccc           = as.integer(any(. %in% c(dxc("renal", icdv),             pcc("renal", icdv)))),
                                    gi_ccc              = as.integer(any(. %in% c(dxc("gi", icdv),                pcc("gi", icdv)))),
                                    hemato_immu_ccc     = as.integer(any(. %in% c(dxc("hemato_immu", icdv),       pcc("hemato_immu", icdv)))),
                                    metabolic_ccc       = as.integer(any(. %in% c(dxc("metabolic", icdv),         pcc("metabolic", icdv)))),
                                    congeni_genetic_ccc = as.integer(any(. %in% c(dxc("congeni_genetic", icdv)))),
                                    malignancy_ccc      = as.integer(any(. %in% c(dxc("malignancy", icdv),        pcc("malignancy", icdv)))),
                                    neonatal_ccc        = as.integer(any(. %in% c(dxc("neonatal", icdv)))),
                                    tech_dep_ccc        = as.integer(any(. %in% c(dxc("tech_dep", icdv),          pcc("tech_dep", icdv)))),
                                    transplant_ccc      = as.integer(any(. %in% c(dxc("transplant", icdv),        pcc("transplant", icdv))))))
  df <-
    dplyr::mutate_(df, .dots = list("num_ccc" = ~ neuromusc_ccc + cvd_ccc + respiratory_ccc +
                                    renal_ccc + gi_ccc + hemato_immu_ccc +
                                    metabolic_ccc + congeni_genetic_ccc +
                                    malignancy_ccc + neuromusc_ccc,
                                    "ccc_flag" = ~ as.integer(num_ccc > 0 | tech_dep_ccc == 1 | transplant_ccc == 1)))
  df 
}

