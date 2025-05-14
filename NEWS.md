# Version 1.0.6

## Bug fixes

* Code fixes -- most of these codes were flagging transplant but not the primary organ system; these were present in original publication but missing from this package
    * 996.83 added to CVD - it was flagging transplant but not CVD
    * 996.84 added to respiratory
    * 996.81 added to renal
    * 996.82, 996.86, 996.87 added to gi
    * ICD10 codes added to CVD: T86.20, T86.21, T86.22
    * M4330 is not a valid code, corrected to M433 (impacts congeni_genetic)
    * Add Z94.0 to transplant

## Extenstions
* Update old urls and adding some links to wayback machine snapshots
* Add key files to the package for reference

## New functions:
* S3 method `as_tibble.pccc_codes` has been added to the package to replace the
  deprecated `as.tbl` method since `dplyr::as.tbl` has been deprecated in favor
  of `tibble::as_tibble`

## Deprecations:
* `as.tbl.pccc_codes` has been deprecated since `dplyr::as.tbl` has been
  deprecated in favor of `tibble::as_tibble`

## Defunct functions:
* `test_helper` was an exported function that was used in the testing suite but
  not needed by any end user.  It is now defunct.

# Version 1.0.5

Changed included datafiles to be of type data.frame to avoid some libraries trying to load data.table unnecessarily. Similarly removed dependencies on dplyr::data_frame() due to deprecation.

Increased R dependency to version 3.5.0 and greater due to change in how rds/rda files are created. Sample data included with package requires newer R.

# Version 1.0.4

Updates to make code work with 1.0 version of dplyr and new vctrs (dplyr dependency). Removed use of dplyr from many tests.

Also update test cases to work with new R 4.0.x feature to account for changed default to stringsAsFactors = FALSE.

# Version 1.0.3

Added Rcpp::Shield<SEXP>() around Rcpp::wrap() calls inside Rcpp::List::create(). Apparently adding shield helps with some AddressSanitizer checks due to wrap calls inside List::create(). Thanks to Tomas Kalibera for pointing that out.

Also updated a few tests to address deprecations in dplyr and changes in testthat.

# Version 1.0.2

Removed unnecessary initializer that causes problems with older pre-C++11 compilers

# Version 1.0.1

Minor update to address problem introduced by downstream dependency package rlang 0.2.0. Unit tests identified that a null argument that previously worked with enquo() now throws an error. Now check for argument and set sane default if missing.

# Version 1.0.0

After careful review of which ICD codes should flag which CCCs, we have made tweaks to the overall logic as well as the various CCC categories.

# Version 0.2.2.9000

## API Change
* With the move to `dplyr (>= 0.7.0)` (#20) the API is cleaner and easier to
  use.  See the vignette and examples.  The major change is that `dplyr::vars`
  is no longer needed.

# Version 0.2.0

## API Change
* The `ccc` function only takes one entry for codes.  There is no need to input
  the diagnostic and procedure codes separately.

## Non-User Visible Changes
* Redesign of the C++ code.  Improved speed, fewer arguments, fewer operations.

# Version 0.1.1

## Bug Fixes

* ccc (#4)

# Version 0.1.0
First release.
