# Overview of tests for ccc():
#   code that is generic to ICD 9 & 10
#     X Small data set tests
#     X No data tests
#
###############################################################################
#
library(pccc)

# This test case catches a bug (now resolved) that where if only 1 patient with 1 diagnosis code
# is passed, ccc fails.
# Test that one code results in just the one category getting flagged as true
for (code in c(9, 10)) {
  for (row in rownames(get_codes(code))) {
    dx <- get_codes(code)[row,]$dx

    d <- data.frame(id = 'a', dx1 = sample(dx, 1))
    result <- ccc(data    = d,
                  id      = id,
                  dx_cols = grep("^dx", names(d), value = TRUE),#dplyr::starts_with("dx"),
                  icdv    = code)

                  stopifnot(result[row] == 1L)

    if (!(row %in% c('tech_dep', 'transplant'))) {
      # look at other columns - should all be 0 except these 4
      tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]

      #paste0("Checking that ICD", code, " dx code drawn from '", row, "' has all other categories set to false.")
      stopifnot(all(tmp == 0))
    }

    # not all categories have procedure codes
    pc <- get_codes(code)[row,]$pc
    if(length(pc) > 0) {
      d <- data.frame(id = 'a', pc1 = sample(pc, 1))
      result <- ccc(data    = d,
                    id      = id,
                    pc_cols = grep("^pc", names(d), value = TRUE), #dplyr::starts_with("pc"),
                    icdv    = code)
      #paste0("Checking that ICD", code, " pc code drawn from '", row, "' sets only that one category to true.")
      stopifnot(result[row] == 1)

      if (!(row %in% c('tech_dep', 'transplant'))) {
        # look at other columns - should all be 0 except these 4
        tmp <- result[,!names(result) %in% c(row, 'id', 'tech_dep', 'transplant', 'ccc_flag')]
        #paste0("Checking that ICD", code, " pc code drawn from '", row, "' has all other categories set to false.")
        stopifnot(all(tmp == 0))
      }
    }
  }

  #######
  # test 1 patient with no data - should have all CCCs as FALSE
  #######
  #"1 patient with no diagnosis data - should have all CCCs as FALSE",
  stopifnot(all(ccc(data.frame(id = 'a', dx1 = NA),
                    dx_cols = dplyr::starts_with("dx"),
                    icdv    = code) == 0))

  # Due to previous use of sapply in ccc.R, this would fail - fixed now
  #"1 patient with multiple rows of no diagnosis data - should have all CCCs as FALSE"
  stopifnot(all(ccc(data.frame(id = 'a', dx1 = NA, dx2 = NA),
                    dx_cols = dplyr::starts_with("dx"),
                    icdv    = code) == 0))

  #"1 patient with no procedure data - should have all CCCs as FALSE"
  stopifnot(all(ccc(data.frame(id = 'a', pc1 = NA),
                    dx_cols = dplyr::starts_with("pc"),
                    icdv    = code) == 0))

  # As the next block of tests rely on specific column names to be present, first validate they are as expected.
  #"Column names returned from ccc are as expected"
  stopifnot(
    identical(
      c("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant", "ccc_flag"),
      colnames(ccc(data.frame(id = 'a', dx1 = NA), dx_cols = dplyr::starts_with("dx"), icdv = code))
    )
  )
}
