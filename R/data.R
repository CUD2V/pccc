#' Randomly Generated ICD 9 Sample Data Set
#'
#' This dataset was produced from a tool available at
#' \url{https://github.com/magic-lantern/icd_file_generator}. ICD codes were taken
#' from CMS.
#'
#' @format A data frame with 1000 rows and 31 variables
#' \describe{
#'   \item{id}{Sequentialy assigned patient identifier}
#'   \item{dx1:dx10}{ICD 9 diagnosis codes; 20\% of values are missing, see
#'     \url{https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes.html}
#'     for source of codes.}
#'   \item{pc1:pc10}{ICD 9 procedure codes; 20\% of values are missing, see
#'     \url{https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes.html}
#'     for source of codes.}
#'   \item{g1:g10}{Random data to simulate other data often present in export of
#'     patient data with 20\% of values missing.}
#' }
#'
"pccc_icd9_dataset"


#' Randomly Generated ICD 10 Sample Data Set
#'
#' This dataset was produced from a tool available at
#' \url{https://github.com/magic-lantern/icd_file_generator}. ICD codes were taken
#' from CMS.
#'
#' @format A data frame with 1000 rows and 31 variables
#' \describe{
#'   \item{id}{Sequentialy assigned patient identifier}
#'   \item{dx1:dx10}{ICD 10 diagnosis codes; 20\% of values are missing, see
#'     \url{https://www.cms.gov/Medicare/Coding/ICD10/2017-ICD-10-CM-and-GEMs.html}
#'     for source of codes.}
#'   \item{pc1:pc10}{ICD 10 procedure codes; 20\% of values are missing, see
#'     \url{https://www.cms.gov/Medicare/Coding/ICD10/2017-ICD-10-CM-and-GEMs.html}
#'     for source of codes.}
#'   \item{g1:g10}{random data to simulate other data often present in export of
#'     patient data with 20\% of values missing.}
#' }
#'
"pccc_icd10_dataset"