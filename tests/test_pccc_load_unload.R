# This script just does basic loading and unloading of the pccc library
#
###############################################################################
#
# run tests with Ctrl/Cmd + Shift + T or devtools::test()
# for manually running, execute
#   library(testthat)
#context("PCCC - Loading and unloading Package")

stopifnot(identical(capture.output(library(pccc)), character(0)))

# Unloading shouldn't result in any errors or warnings
stopifnot(identical(capture.output(detach("package:pccc", unload=TRUE)), character(0)))
