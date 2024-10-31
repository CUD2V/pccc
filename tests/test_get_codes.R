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

# context("PCCC - get_codes function tests")

# "Checking to see that correct CCC categories are returned."
stopifnot(
  identical(
    rownames(get_codes(9)),
    c("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant")
  )
  ,
  identical(
    rownames(get_codes(10)),
    c("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant")
  )
)

# "Checking to see that all CCCs the expected number of codes"
df9  <- as.data.frame(get_codes(9))
df10 <- as.data.frame(get_codes(10))
df <- rbind(cbind(df9, icdv = 9L), cbind(df10, icdv = 10L))

expected_counts <- read.table(sep = "|", header = TRUE, strip.white = TRUE,
                              text =
"       category |      type |  icdv |  icd
 congeni_genetic |        dx |     9 |   15
             cvd |        dx |     9 |   50
              gi |        dx |     9 |   29
     hemato_immu |        dx |     9 |   34
      malignancy |        dx |     9 |   10
       metabolic |        dx |     9 |   25
        neonatal |        dx |     9 |   33
       neuromusc |        dx |     9 |   54
           renal |        dx |     9 |   17
     respiratory |        dx |     9 |   17
        tech_dep |        dx |     9 |   43
      transplant |        dx |     9 |   21
             cvd |  dx_fixed |     9 |    1
       neuromusc |  dx_fixed |     9 |    2
     respiratory |  dx_fixed |     9 |    1
             cvd |        pc |     9 |   53
              gi |        pc |     9 |   41
     hemato_immu |        pc |     9 |   12
      malignancy |        pc |     9 |    2
       metabolic |        pc |     9 |   23
       neuromusc |        pc |     9 |   19
           renal |        pc |     9 |   42
     respiratory |        pc |     9 |   18
        tech_dep |        pc |     9 |  143
      transplant |        pc |     9 |   30
       metabolic |  pc_fixed |     9 |    1
 congeni_genetic |        dx |    10 |   55
             cvd |        dx |    10 |   97
              gi |        dx |    10 |   53
     hemato_immu |        dx |    10 |   42
      malignancy |        dx |    10 |   31
       metabolic |        dx |    10 |   73
        neonatal |        dx |    10 |   41
       neuromusc |        dx |    10 |   99
           renal |        dx |    10 |   30
     respiratory |        dx |    10 |   28
        tech_dep |        dx |    10 |  135
      transplant |        dx |    10 |   27
       neuromusc |  dx_fixed |    10 |    1
             cvd |        pc |    10 |  142
              gi |        pc |    10 |  139
     hemato_immu |        pc |    10 |   57
      malignancy |        pc |    10 |   45
       metabolic |        pc |    10 |   61
       neuromusc |        pc |    10 |  123
           renal |        pc |    10 |  259
     respiratory |        pc |    10 |   69
        tech_dep |        pc |    10 |  705
      transplant |        pc |    10 |  113
")

stopifnot(
  identical(
    aggregate(icd ~ category + type + icdv, data = df, FUN = length),
    expected_counts
  )
)


# "Checking to see that a code is returned - testing first for diagnosis code from first CCC."
stopifnot(all(grepl("\\w+", df$icd)))

# "Checking to see that correct CCC code types are returned."
stopifnot(
  identical(colnames(get_codes(9)), c("dx", "dx_fixed", "pc", "pc_fixed")),
  identical(colnames(get_codes(10)), c("dx", "dx_fixed", "pc", "pc_fixed"))
)

# "Checking for error if other than 9 or 10 passed in"
x <- tryCatch(get_codes(123), error = function(e) e)
stopifnot(inherits(x, "error"))
stopifnot(x$message == "Only ICD version 9 and 10 are supported.")

# "Checking for error if string passed in"
x <- tryCatch(get_codes("ABC"), error = function(e) e)
stopifnot(inherits(x, "error"))
stopifnot(inherits(x, "Rcpp::not_compatible"))
stopifnot(x$message == "Not compatible with requested type: [type=character; target=integer].")

# testing the S3 methods for as.tbl and as_tibble
x <- get_codes(9)
y <- tryCatch(dplyr::as.tbl(x), warning = function(w) w)
stopifnot(inherits(y, "warning"))
stopifnot(grepl("as\\.tbl.*\ was\ deprecated", y$message[1]))
z <- tibble::as_tibble(x)
y <- suppressWarnings(dplyr::as.tbl(x))
stopifnot(all.equal(y, z))
