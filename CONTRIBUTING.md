# Contributing and Extending pccc

## Current Contents of pccc
As of version 0.1.0 there are only two functions exported in the `pccc`
namespace.

1. `ccc`
2. `get_codes`

The `ccc` function is defined in the `R/` directory.  `get_codes` is defined in
the `src/codes.cpp` file.  `ccc` depends on the `ccc_rcpp` function which is
also defined in the `src/codes.cpp` file.

`get_codes` gives the end user a quick an easy way to view the codes defining
eacch of the CCC categories.

`ccc` is the tool the end user uses to generate ccc category and subcategory
flags.

## Basic Design of the pccc Package
The primary workhorse object in this package is the `codes` object defined in
`src/pccc.h` and `src/pccc.cpp`.  This class has private members for (ICD)
version and a vector of strings for each of the possible ccc categories.
Public members of the class include access for each of the categories string
vectors and the version.  There are tweleve member functions for determining if
a diagnostic or procedure code is in one of the CCC categories.

The constructor for the `codes` class set the version and the vector of strings.
The vectors of ICD strings are defined by version number.  These vectors were
copied from the SAS code found in `inst/pccc_references/ccc_version2_sas.sas`.
Edit accordingly.  If/when ICD-11 is released extend this constructor.  All
other functions should just work.

The functions for determining ccc categories, e.g.,
`int codes.neuromusc(dx, pc)` all have a similar design.
Given a vector of diagnostic codes `dx` and a vector of procedure codes `pc` the
function compares the ith value of dx to each of the j values of the defined ICD
codes.  If a match is found the function returns 1, else, the comparison moves
onto the procedures codes.  If a match is found the function returns 1. If no
match is found the function returns 0.  By design, the comparisons stop once a
match is found.

The `ccc_rcpp` function creates one instance of a `codes` object and then use
the member functions to determine if any ccc category exists in a vector of
diagnostic and procedure codes.

The exported `ccc` function passess the diagnostic and procedure codes for
multiple subects to the `ccc_rcpp` function and returns a `data.frame` with the
subject `id`s and ccc flags.
