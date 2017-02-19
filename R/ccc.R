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
  dx <-
    .data %>%
    dplyr::rowwise() %>%
    dplyr::summarize_at(.cols = dx_cols,
                        .funs = dplyr::funs(neuromusc_ccc       = . %in% dxc("neuromusc", 10),
                                            cvd_ccc             = . %in% dxc("cvd", icdv),
                                            respiratory_ccc     = . %in% dxc("respiratory", icdv),
                                            renal_ccc           = . %in% dxc("renal", icdv),
                                            gi_ccc              = . %in% dxc("gi", icdv),
                                            hemato_immu_ccc     = . %in% dxc("hemato_immu", icdv),
                                            metabolic_ccc       = . %in% dxc("metabolic", icdv),
                                            congeni_genetic_ccc = . %in% dxc("congeni_genetic", icdv),
                                            malignancy_ccc      = . %in% dxc("malignancy", icdv),
                                            neonatal_ccc        = . %in% dxc("neonatal", icdv),
                                            tech_dep_ccc        = . %in% dxc("tech_dep", icdv),
                                            transplant_ccc      = . %in% dxc("transplant", icdv)))
    dx_neuromusc_ccc       <- dplyr::select(dx, dplyr::ends_with("neuromusc_ccc"))       %>% apply(1, any)
    dx_cvd_ccc             <- dplyr::select(dx, dplyr::ends_with("cvd_ccc"))             %>% apply(1, any)
    dx_respiratory_ccc     <- dplyr::select(dx, dplyr::ends_with("respiratory_ccc"))     %>% apply(1, any)
    dx_renal_ccc           <- dplyr::select(dx, dplyr::ends_with("renal_ccc"))           %>% apply(1, any)
    dx_gi_ccc              <- dplyr::select(dx, dplyr::ends_with("gi_ccc"))              %>% apply(1, any)
    dx_hemato_immu_ccc     <- dplyr::select(dx, dplyr::ends_with("hemato_immu_ccc"))     %>% apply(1, any)
    dx_metabolic_ccc       <- dplyr::select(dx, dplyr::ends_with("metabolic_ccc"))       %>% apply(1, any)
    dx_congeni_genetic_ccc <- dplyr::select(dx, dplyr::ends_with("congeni_genetic_ccc")) %>% apply(1, any)
    dx_malignancy_ccc      <- dplyr::select(dx, dplyr::ends_with("malgnancy_ccc"))       %>% apply(1, any)
    dx_neonatal_ccc        <- dplyr::select(dx, dplyr::ends_with("neonatal_ccc"))        %>% apply(1, any)
    dx_tech_dep_ccc        <- dplyr::select(dx, dplyr::ends_with("tech_dep_ccc"))        %>% apply(1, any)
    dx_transplant_ccc      <- dplyr::select(dx, dplyr::ends_with("transplant_ccc"))      %>% apply(1, any)

  pc <-
    .data %>%
    dplyr::rowwise() %>%
    dplyr::summarize_at(.cols = pc_cols,
                        .funs = dplyr::funs(neuromusc_ccc       = . %in% pcc("neuromusc", 10),
                                            cvd_ccc             = . %in% pcc("cvd", icdv),
                                            respiratory_ccc     = . %in% pcc("respiratory", icdv),
                                            renal_ccc           = . %in% pcc("renal", icdv),
                                            gi_ccc              = . %in% pcc("gi", icdv),
                                            hemato_immu_ccc     = . %in% pcc("hemato_immu", icdv),
                                            metabolic_ccc       = . %in% pcc("metabolic", icdv),
                                            malignancy_ccc      = . %in% pcc("malignancy", icdv),
                                            tech_dep_ccc        = . %in% pcc("tech_dep", icdv),
                                            transplant_ccc      = . %in% pcc("transplant", icdv)))
    pc_neuromusc_ccc       <- dplyr::select(pc, dplyr::ends_with("neuromusc_ccc"))       %>% apply(1, any)
    pc_cvd_ccc             <- dplyr::select(pc, dplyr::ends_with("cvd_ccc"))             %>% apply(1, any)
    pc_respiratory_ccc     <- dplyr::select(pc, dplyr::ends_with("respiratory_ccc"))     %>% apply(1, any)
    pc_renal_ccc           <- dplyr::select(pc, dplyr::ends_with("renal_ccc"))           %>% apply(1, any)
    pc_gi_ccc              <- dplyr::select(pc, dplyr::ends_with("gi_ccc"))              %>% apply(1, any)
    pc_hemato_immu_ccc     <- dplyr::select(pc, dplyr::ends_with("hemato_immu_ccc"))     %>% apply(1, any)
    pc_metabolic_ccc       <- dplyr::select(pc, dplyr::ends_with("metabolic_ccc"))       %>% apply(1, any)
    pc_malignancy_ccc      <- dplyr::select(pc, dplyr::ends_with("malgnancy_ccc"))       %>% apply(1, any)
    pc_tech_dep_ccc        <- dplyr::select(pc, dplyr::ends_with("tech_dep_ccc"))        %>% apply(1, any)
    pc_transplant_ccc      <- dplyr::select(pc, dplyr::ends_with("transplant_ccc"))      %>% apply(1, any)

  out <-
  .data %>%
  dplyr::select_(.dots = lazyeval::interp( ~ i, i = substitute(id))) %>%
  dplyr::mutate(neuromusc_ccc       = cbind(dx_neuromusc_ccc      ,  dx_neuromusc_ccc      ) %>% apply(1, any) %>% as.integer, 
                cvd_ccc             = cbind(dx_cvd_ccc            ,  dx_cvd_ccc            ) %>% apply(1, any) %>% as.integer, 
                respiratory_ccc     = cbind(dx_respiratory_ccc    ,  dx_respiratory_ccc    ) %>% apply(1, any) %>% as.integer, 
                renal_ccc           = cbind(dx_renal_ccc          ,  dx_renal_ccc          ) %>% apply(1, any) %>% as.integer, 
                gi_ccc              = cbind(dx_gi_ccc             ,  dx_gi_ccc             ) %>% apply(1, any) %>% as.integer, 
                hemato_immu_ccc     = cbind(dx_hemato_immu_ccc    ,  dx_hemato_immu_ccc    ) %>% apply(1, any) %>% as.integer, 
                metabolic_ccc       = cbind(dx_metabolic_ccc      ,  dx_metabolic_ccc      ) %>% apply(1, any) %>% as.integer, 
                congeni_genetic_ccc = cbind(dx_congeni_genetic_ccc,  dx_congeni_genetic_ccc) %>% apply(1, any) %>% as.integer, 
                malignancy_ccc      = cbind(dx_malignancy_ccc     ,  dx_malignancy_ccc     ) %>% apply(1, any) %>% as.integer, 
                neonatal_ccc        = cbind(dx_neonatal_ccc       ,  dx_neonatal_ccc       ) %>% apply(1, any) %>% as.integer, 
                tech_dep_ccc        = cbind(dx_tech_dep_ccc       ,  dx_tech_dep_ccc       ) %>% apply(1, any) %>% as.integer, 
                transplant_ccc      = cbind(dx_transplant_ccc     ,  dx_transplant_ccc     ) %>% apply(1, any) %>% as.integer)

  out 
}

