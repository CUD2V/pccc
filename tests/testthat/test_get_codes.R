# Whenever you are tempted to type something into a print statement or a
# de-bugger expression, write it as a test instead. — Martin Fowler
#
# Tests for get_codes():
#    pass in ICD version - 9, 10, number, letter
#    ??? Not sure what else I should test...
#
# run tests with Ctrl/Cmd + Shift + T or devtools::test()
# for manually running, execute
#   library(testthat)
library(pccc)

context("PCCC - get_codes function tests")

for (code in c(9, 10)) {
  test_that("Checking to see that correct CCC categories are returned.", {
    expect_equal(
      rownames((get_codes(code))),
      c("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant")
    )
  })

  test_that("Checking to see that correct CCC code types are returned.", {
    expect_equal(
      colnames((get_codes(code))),
      c("dx", "pc")
    )
  })
}

test_that("Checking for error if other than 9 or 10 passed in", {
  expect_error(
    get_codes(123),
    "Only ICD version 9 and 10 are supported."
  )
})

test_that("Checking for error if string passed in", {
  expect_error(
    get_codes('ABC'),
    "Not compatible with requested type"
  )
})
