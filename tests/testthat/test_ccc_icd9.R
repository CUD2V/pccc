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
# code used to setup and store data for tests #################################
# icd9_test_result <- ccc(pccc::pccc_icd9_dataset[, c(1:21)],
#                         id      = id,
#                         dx_cols = dplyr::starts_with("dx"),
#                         pc_cols = dplyr::starts_with("pc"),
#                         icdv    = 9)
# icd10_test_result <- ccc(pccc::pccc_icd10_dataset[, c(1:21)],
#                          id      = id,
#                          dx_cols = dplyr::starts_with("dx"),
#                          pc_cols = dplyr::starts_with("pc"),
#                          icdv    = 10)
# random_data_test_result <- ccc(dplyr::data_frame(id = letters[1:3],
#                                                  dx1 = c('sadcj89sa', '1,2.3.4,5', 'sdf 9'),
#                                                  pc1 = c('da89v#$%', ' 90v_', 'this is a super long string compared to standard ICD codes and shouldnt break anything - if it does, the world will come to an end... Ok, so maybe not, but that means I need to fix something in this package.'),
#                                                  other_col = LETTERS[1:3]),
#                                id      = id,
#                                dx_cols = dplyr::starts_with("dx"),
#                                pc_cols = dplyr::starts_with("pc"),
#                                icdv    = 9) # should be all non-matches for CCCs regardless of version
# devtools::use_data(icd9_test_result, icd10_test_result, random_data_test_result,
#                    internal = TRUE,
#                    overwrite = TRUE)
# rm(list=ls())
# gc()
###############################################################################
#
# run tests with Ctrl/Cmd + Shift + T or devtools::test()
# for manually running, execute
#   library(testthat)
library(pccc)

context("PCCC - ccc ICD9 function tests")

# Basic checks of standard output ---------------------------------------------

test_that("Correct number of rows (1 per patient) returned?", {
  expect_that(
    nrow(ccc(pccc::pccc_icd9_dataset[, c(1:21)],
             id      = id,
             dx_cols = dplyr::starts_with("dx"),
             pc_cols = dplyr::starts_with("pc"),
             icdv    = 9))
    , equals(1000))
})

test_that("Correct number of columns (1 per category + Id column + summary column) returned?", {
  expect_that(
    ncol(ccc(pccc::pccc_icd9_dataset[, c(1:21)],
             id      = id,
             dx_cols = dplyr::starts_with("dx"),
             pc_cols = dplyr::starts_with("pc"),
             icdv    = 9)),
    equals(14))
})

# None of these should result in an error -------------------------------------
test_that("icd 9 data set with all parameters - result should be unchanged.", {
  # saved as icd9_test_result
  expect_true(
    dplyr::all_equal(
      ccc(pccc::pccc_icd9_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      test_helper(icd9_test_result))
  )
})

# should not be equal, and should have many differences
test_that("icd 9 data set with ICD10 parameter", {
  expect_that(
    typeof(dplyr::all_equal(
      ccc(pccc::pccc_icd9_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 10),
      test_helper(icd9_test_result))),
    equals("character")
  )
})

test_that("icd 9 data set with missing id parameter", {
  expect_true(
    dplyr::all_equal(
      ccc(pccc::pccc_icd9_dataset[, c(1:21)],
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      test_helper(icd9_test_result) %>% dplyr::select(-id))
  )
})

test_that("icd 9 data set with missing dx parameter", {
  expect_that(
    typeof(dplyr::all_equal(
      ccc(pccc::pccc_icd9_dataset[, c(1:21)],
          id      = id,
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      test_helper(icd9_test_result))),
    equals('character')
  )
})

test_that("icd 9 data set with missing pc parameter", {
  expect_that(
    typeof(dplyr::all_equal(
      ccc(pccc::pccc_icd9_dataset[, c(1:21)],
          id      = id,
          pc_cols = dplyr::starts_with("dx"),
          icdv    = 9),
      test_helper(icd9_test_result))),
    equals('character')
  )
})

# should not be equal, and should have many differences
test_that("icd 10 data set with ICD9 parameter", {
  expect_that(
    typeof(dplyr::all_equal(
      ccc(pccc::pccc_icd10_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      test_helper(icd10_test_result))),
    equals("character")
  )
})

# Cases that should result in an error ----------------------------------------
test_that("icd 9 data set with only version parameter", {
  expect_error(
    ccc(pccc::pccc_icd9_dataset[, c(1:21)],
        icdv    = 9),
    "dx_cols and pc_cols are both missing.  At least one must not be."
  )
})

test_that("icd 9 data set with no parameters", {
  expect_error(
    ccc(pccc::pccc_icd9_dataset[, c(1:21)]),
    "dx_cols and pc_cols are both missing.  At least one must not be."
  )
})

# -----------------------------------------------------------------------------
test_that("random data set with all parameters ICD9 - result should be unchanged.", {
  # saved as random_data_test_result
  expect_true(
    dplyr::all_equal(
      ccc(dplyr::data_frame(id = letters[1:3],
                            dx1 = c('sadcj89sa', '1,2.3.4,5', 'sdf 9'),
                            pc1 = c('da89v#$%', ' 90v_', 'this is a super long string compared to standard ICD codes and shouldnt break anything - if it does, the world will come to an end... Ok, so maybe not, but that means I need to fix something in this package.'),
                            other_col = LETTERS[1:3]),
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 9),
      test_helper(random_data_test_result)
    )
  )
})

# As the next block of tests rely on specific column names to be present, first validate they are as expected.
test_that("Column names returned from ccc are as expected", {
  expect_equal(
    c("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant", "ccc_flag"),
    colnames(
      ccc(dplyr::data_frame(id = 'a',
                            dx1 = NA),
          dx_cols = dplyr::starts_with("dx"),
          icdv    = 9))
    )
})


# This test case catches a bug (now resolved) that where if only 1 patient with 1 diagnosis code
# is passed, ccc fails.
# Test that one code results in just the one category getting flagged as true
for (row in rownames(get_codes(9))) {
  dx <- get_codes(9)[row,]$dx

  result <- ccc(dplyr::data_frame(id = 'a',
                                  dx1 = sample(dx, 1)),
                id      = id,
                dx_cols = dplyr::starts_with("dx"),
                icdv    = 9)

  test_that(paste0("Checking that dx code drawn from '", row, "' sets only that one category to true."), {
    expect_true(result[row] == 1)
  })

  if (!(row %in% c('tech_dep', 'transplant'))) {
    # look at other columns - should all be 0 except these 4
    tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]
    test_that(paste0("Checking that dx code drawn from '", row, "' has all other categories set to false."), {
      expect_true(all(tmp == 0))
    })
  }

  # not all categories have procedure codes
  pc <- get_codes(9)[row,]$pc
  if(length(pc) > 0) {
    result <- ccc(dplyr::data_frame(id = 'a',
                                    pc1 = sample(pc, 1)),
                  id      = id,
                  pc_cols = dplyr::starts_with("pc"),
                  icdv    = 9)
    test_that(paste0("Checking that pc code drawn from '", row, "' sets only that one category to true."), {
      expect_true(result[row] == 1)
    })

    if (!(row %in% c('tech_dep', 'transplant'))) {
      # look at other columns - should all be 0 except these 4
      tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]
      test_that(paste0("Checking that pc code drawn from '", row, "' has all other categories set to false."), {
        expect_true(all(tmp == 0))
      })
    }
  }
}

#######
# test 1 patient with no data - should have all CCCs as FALSE
#######
test_that("1 patient with no diagnosis data - should have all CCCs as FALSE", {
  expect_true(all(ccc(dplyr::data_frame(id = 'a',
                                        dx1 = NA),
                      dx_cols = dplyr::starts_with("dx"),
                      icdv    = 9) == 0))
})

test_that("1 patient with no procedure data - should have all CCCs as FALSE", {
  expect_true(all(ccc(dplyr::data_frame(id = 'a',
                                        pc1 = NA),
                      dx_cols = dplyr::starts_with("pc"),
                      icdv    = 9) == 0))
})

# Need to do some sort of performance test here - don't throw error,
# but keep track of about how long this takes to run
# test_that("test to only run locally", {
#   skip_on_cran()
#   expect_equal(ccc(), 99)
# })

