# Version 1.0.3

Added Rcpp::Shield<SEXP>() around Rcpp::wrap() calls inside Rcpp::List::create(). Apparently adding shield helps with some AddressSanitizer checks due to wrap calls inside List::create(). Thanks to Tomas Kalibera for pointing that out.

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
  the diagnostic and procedure codes seperately.

## Non-User Visible Changes
* Redesign of the C++ code.  Improved speed, fewer arguments, fewer operations.

# Version 0.1.1

## Bug Fixes

* ccc (#4)

# Version 0.1.0
First release.
