# See test_ccc_icd9.R for data setup
#
# Pverview of tests for ICD 10
#     X invalid input (not real ICD codes)
#     X check output for saved file - if it changes, I want to know
#     X no input
#     X need to test each category of CCC
#     performance test?
#
# run tests with Ctrl/Cmd + Shift + T or devtools::test()
# for manually running, execute
#   library(testthat)
library(pccc)

context("PCCC - ccc ICD10 function tests")

test_that("random data set with all parameters ICD10 - result should be unchanged.", {
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
          icdv    = 10),
      test_helper(random_data_test_result)
    )
  )
})

test_that("icd 10 data set with all parameters - result should be unchanged.", {
  # saved as icd10_test_result
  expect_true(
    dplyr::all_equal(
      ccc(pccc::pccc_icd10_dataset[, c(1:21)],
          id      = id,
          dx_cols = dplyr::starts_with("dx"),
          pc_cols = dplyr::starts_with("pc"),
          icdv    = 10),
      test_helper(icd10_test_result)
    )
  )
})

# This test case catches a bug (now resolved) that where if only 1 patient with 1 diagnosis code
# is passed, ccc fails.
# Test that one code results in just the one category getting flagged as true
for (row in rownames(get_codes(10))) {
  dx <- get_codes(10)[row,]$dx

  result <- ccc(dplyr::data_frame(id = 'a',
                                  dx1 = sample(dx, 1)),
                id      = id,
                dx_cols = dplyr::starts_with("dx"),
                icdv    = 10)
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
  pc <- get_codes(10)[row,]$pc
  if(length(pc) > 0) {
    result <- ccc(dplyr::data_frame(id = 'a',
                                    pc1 = sample(pc, 1)),
                  id      = id,
                  pc_cols = dplyr::starts_with("pc"),
                  icdv    = 10)
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
                      icdv    = 10) == 0))
})

test_that("1 patient with no procedure data - should have all CCCs as FALSE", {
  expect_true(all(ccc(dplyr::data_frame(id = 'a',
                                        pc1 = NA),
                      dx_cols = dplyr::starts_with("pc"),
                      icdv    = 10) == 0))
})