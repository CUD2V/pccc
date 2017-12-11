#' Randomly Generated ICD 9 Sample Data Set
#'
#' This dataset was produced from a tool available at
#' \url{https://github.com/magic-lantern/icd_file_generator}. ICD codes were taken
#' from CMS.  The ICD 9 diagnosis and procedure codes were generated with 20%
#' missing values. Code source:
#' \url{https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes.html}
#'
#' @format A data frame with 1000 rows and 31 variables.
#' There is a patient identifier, ten diagnosis codes, ten procedure codes, and
#' ten "other data" values, specifically:
#' \describe{
#'   \item{id}{Sequentially assigned patient identifier}
#'   \item{dx1}{a ICD 9 diagnosis code}
#'   \item{dx2}{a ICD 9 diagnosis code}
#'   \item{dx3}{a ICD 9 diagnosis code}
#'   \item{dx4}{a ICD 9 diagnosis code}
#'   \item{dx5}{a ICD 9 diagnosis code}
#'   \item{dx6}{a ICD 9 diagnosis code}
#'   \item{dx7}{a ICD 9 diagnosis code}
#'   \item{dx8}{a ICD 9 diagnosis code}
#'   \item{dx9}{a ICD 9 diagnosis code}
#'   \item{dx10}{a ICD 9 diagnosis code}
#'   \item{pc1}{a ICD 9 procedure codes}
#'   \item{pc2}{a ICD 9 procedure codes}
#'   \item{pc3}{a ICD 9 procedure codes}
#'   \item{pc4}{a ICD 9 procedure codes}
#'   \item{pc5}{a ICD 9 procedure codes}
#'   \item{pc6}{a ICD 9 procedure codes}
#'   \item{pc7}{a ICD 9 procedure codes}
#'   \item{pc8}{a ICD 9 procedure codes}
#'   \item{pc9}{a ICD 9 procedure codes}
#'   \item{pc10}{a ICD 9 procedure codes}
#'   \item{g1}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g2}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g3}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g4}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g5}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g6}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g7}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g8}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g9}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g10}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#' }
#'
"pccc_icd9_dataset"


#' Randomly Generated ICD 10 Sample Data Set
#'
#' This dataset was produced from a tool available at
#' \url{https://github.com/magic-lantern/icd_file_generator}. ICD codes were taken
#' from CMS.  The code source, for both the diagnosis and produced codes can be
#' found at \url{https://www.cms.gov/Medicare/Coding/ICD10/2017-ICD-10-CM-and-GEMs.html}
#'
#' @format A data frame with 1000 rows and 31 variables.
#' There is a patient identifier, ten diagnosis codes, ten procedure codes, and
#' ten "other data" values, specifically:
#' \describe{
#'   \item{id}{Sequentially assigned patient identifier}
#'   \item{dx1}{a ICD 10 diagnosis code}
#'   \item{dx2}{a ICD 10 diagnosis code}
#'   \item{dx3}{a ICD 10 diagnosis code}
#'   \item{dx4}{a ICD 10 diagnosis code}
#'   \item{dx5}{a ICD 10 diagnosis code}
#'   \item{dx6}{a ICD 10 diagnosis code}
#'   \item{dx7}{a ICD 10 diagnosis code}
#'   \item{dx8}{a ICD 10 diagnosis code}
#'   \item{dx9}{a ICD 10 diagnosis code}
#'   \item{dx10}{a ICD 10 diagnosis code}
#'   \item{pc1}{a ICD 10 procedure codes}
#'   \item{pc2}{a ICD 10 procedure codes}
#'   \item{pc3}{a ICD 10 procedure codes}
#'   \item{pc4}{a ICD 10 procedure codes}
#'   \item{pc5}{a ICD 10 procedure codes}
#'   \item{pc6}{a ICD 10 procedure codes}
#'   \item{pc7}{a ICD 10 procedure codes}
#'   \item{pc8}{a ICD 10 procedure codes}
#'   \item{pc9}{a ICD 10 procedure codes}
#'   \item{pc10}{a ICD 10 procedure codes}
#'   \item{g1}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g2}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g3}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g4}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g5}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g6}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g7}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g8}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g9}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#'   \item{g10}{Random data to simulate other data often present in export of patient data with 20\% of values missing.}
#' }
#'
"pccc_icd10_dataset"

#' Multiple Cause of Death (MCOD) file extract
#'
#' The Center for Disease Control has made publicly available death certificate data.
#' This data set is a subset of the 2006 MCOD file for decedents aged <= 21 showing just
#' the underlying cause of death diagnosis code in ICD-9-CM and ICD-10.
#'
#' See `vignette("pccc-example")` for more details about the MCOD source file.
#'
#' @format A data frame with 65037 rows and 3 variables.
#' \describe{
#'   \item{id}{Sequentially assigned patient identifier}
#'   \item{icd9}{Underlying Cause of Death ICD 9 CM diagnosis code}
#'   \item{icd10}{Underlying Cause of Death ICD 10 diagnosis code}
#' }
#'
"comparability"
