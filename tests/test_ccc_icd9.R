# Overview of tests for ccc():
#   ICD 9
#     X invalid input (not real ICD codes)
#     X check output for saved file - if it changes, I want to know
#     X missing diagnoses list
#     X missing procedure list
#     X missing ID column
#     X no input
#     X need to test each category of CCC - one code from each category
#       Neuro
#       ....
#     performance test?
#
###############################################################################
#
# run tests with Ctrl/Cmd + Shift + T or devtools::test()
# for manually running, execute
library(pccc)

# set useFancyQuotes = FALSE so that in both interactive and non-interactive
# modes output will be consistent.  Without this the double quote will be
# unicode 34 in non-interactie and unicode 8802 in interactive.
options(useFancyQuotes = FALSE)


# context("PCCC - ccc ICD9 function tests")

# Basic checks of standard output ---------------------------------------------

# "Correct number of rows (1 per patient) returned?"
df <-
  ccc(pccc_icd9_dataset[, c(1:21)],
      id      = id,
      dx_cols = dplyr::starts_with("dx"),
      pc_cols = dplyr::starts_with("pc"),
      icdv    = 9)

stopifnot(identical(nrow(df), 1000L))

# "Correct number of columns (1 per category + Id column + summary column) returned?",
stopifnot(identical(ncol(df), 14L))

# None of these should result in an error -------------------------------------
# "icd 9 data set with all parameters - result should be unchanged."
expected <- readRDS("icd9_test_result.rds")
stopifnot(isTRUE(all.equal(df, expected)))

# "icd 9 data set with missing id parameter"
stopifnot(
    all.equal(
      ccc(pccc_icd9_dataset[, c(1:21)],
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9)
      ,
     readRDS("icd9_test_result.rds")[, -1]
  )
)

# "icd 9 data set with missing dx parameter",
df <- ccc(pccc_icd9_dataset[, c(1:21)],
          id      = id,
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9)

# this test will pass in non-interactive mode, the strings are slightly
# different in interactive mode.  The difference is the quotation marks used.
# SOLUTION TO THE QUOTE ISSUE: options(useFancyQuotes = FALSE)
stopifnot(
  identical(
    all.equal(df, readRDS("icd9_test_result.rds"))
    ,
    c("Component \"neuromusc\": Mean absolute difference: 1",
      "Component \"cvd\": Mean absolute difference: 1",
      "Component \"respiratory\": Mean absolute difference: 1",
      "Component \"renal\": Mean absolute difference: 1",
      "Component \"gi\": Mean absolute difference: 1",
      "Component \"hemato_immu\": Mean absolute difference: 1",
      "Component \"metabolic\": Mean absolute difference: 1",
      "Component \"congeni_genetic\": Mean absolute difference: 1",
      "Component \"malignancy\": Mean absolute difference: 1",
      "Component \"neonatal\": Mean absolute difference: 1",
      "Component \"tech_dep\": Mean absolute difference: 1",
      "Component \"transplant\": Mean absolute difference: 1",
      "Component \"ccc_flag\": Mean absolute difference: 1")
  )
)


# "icd 9 data set with missing pc parameter"
out <-
  all.equal(
            ccc(pccc_icd9_dataset[, c(1:21)],
                id      = id,
                pc_cols = dplyr::starts_with("dx"),
                icdv    = 9),
            readRDS("icd9_test_result.rds"))

stopifnot(
    grepl("^Component \"neuromusc\": Mean relative difference: 35",      out[1])
  , grepl("^Component \"cvd\": Mean relative difference: 3",             out[2])
  , grepl("^Component \"respiratory\": Mean relative difference: 2",     out[3])
  , grepl("^Component \"renal\": Mean relative difference: 8",           out[4])
  , grepl("^Component \"gi\": Mean relative difference: 3",              out[5])
  , grepl("^Component \"hemato_immu\": Mean relative difference: 3",     out[6])
  , grepl("^Component \"metabolic\": Mean relative difference: 6",       out[7])
  , grepl("^Component \"congeni_genetic\": Mean absolute difference: 1", out[8])
  , grepl("^Component \"malignancy\": Mean absolute difference: 1",      out[9])
  , grepl("^Component \"neonatal\": Mean absolute difference: 1",        out[10])
  , grepl("^Component \"tech_dep\": Mean relative difference: 4",        out[11])
  , grepl("^Component \"transplant\": Mean relative difference: 2",      out[12])
  , grepl("^Component \"ccc_flag\": Mean relative difference: 9",        out[13])
)

# should not be equal, and should have many differences
# "icd 10 data set with ICD9 parameter"
stopifnot(
    typeof(all.equal(
      ccc(pccc_icd10_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      readRDS("icd10_test_result.rds"))) == "character"
  )

# Cases that should result in an error ----------------------------------------
# "icd 9 data set with only version parameter"
x <- tryCatch(ccc(pccc_icd9_dataset[, c(1:21)], icdv = 9),
              error = function(e) e)
stopifnot(inherits(x, "error"))
stopifnot(x$message == "dx_cols and pc_cols are both missing.  At least one must not be.")

# "icd 9 data set with no parameters"
x <- tryCatch(ccc(pccc_icd9_dataset[, c(1:21)]), error = function(e) e)
stopifnot(inherits(x, "error"))
stopifnot(x$message == "dx_cols and pc_cols are both missing.  At least one must not be.")

# -----------------------------------------------------------------------------
# "random data set with all parameters ICD9 - result should be unchanged."
ccc_out <- ccc(data.frame(id = letters[1:3],
                          dx1 = c('sadcj89sa', '1,2.3.4,5', 'sdf 9'),
                          pc1 = c('da89v#$%', ' 90v_', 'this is a super long string compared to standard ICD codes and shouldnt break anything - if it does, the world will come to an end... Ok, so maybe not, but that means I need to fix something in this package.'),
                          other_col = LETTERS[1:3]),
               id      = id,
               dx_cols = dplyr::starts_with("dx"),
               pc_cols = dplyr::starts_with("pc"),
               icdv    = 9)
ccc_out$id <- as.factor(ccc_out$id)
rnd_test <- readRDS("random_data_test_result.rds")
rnd_test$id <- as.factor(rnd_test$id)
stopifnot(isTRUE(all.equal(ccc_out, rnd_test)))

# Need to do some sort of performance test here - don't throw error,
# but keep track of about how long this takes to run
# test_that("test to only run locally", {
#   skip_on_cran()
#   expect_equal(ccc(), 99)
# })




# should not be equal, and should have many differences
# "icd 9 data set with ICD10 parameter"
stopifnot(
    typeof(all.equal(
      ccc(pccc_icd9_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 10),
      readRDS("icd9_test_result.rds"))) == "character"
  )
