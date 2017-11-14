# Contributing to and Extending pccc

## Current Contents of pccc
There are two functions that most end users will need

1. `ccc`: returns a `data.frame` with indicators for each of the complex chronic
   conditions (CCC), and
2. `get_codes`: to view the ICD codes for each of the categories of CCC.

The `ccc` function is defined in the `R/ccc.R` file.  `get_codes` is defined in
the `src/codes.cpp` file.  `ccc` depends on the `ccc_mat_rcpp` function which is
also defined in the `src/codes.cpp` file.

`get_codes` gives the end user a quick an easy way to view the codes defining
each of the CCC categories.

`ccc` is the tool the end user uses to generate ccc category and subcategory
flags.

## Basic Design of the pccc Package
The primary workhorse object in this package is the `ccc_codes` object defined in
`src/pccc.h` and `src/pccc.cpp`.  This class has private members for (ICD)
version and a vector of strings for each of the possible ccc categories.
Public members of the class include access for each of the categories' string
vectors and the version.  There are twelve member functions for determining if
a diagnostic or procedure code is in one of the CCC categories.

The constructor for the `ccc_codes` class sets the version and the vector of strings.
The vectors of ICD strings are defined by version number.  These vectors were
copied from the SAS code found in `inst/pccc_references/ccc_version2_sas.sas`.
In building this package, errors were discovered as described in the research letter
that reported this work: [insert citation here]. If/when ICD-11 is released the
`ccc_codes` class constructor will be extended.  All other functions should just work.

The functions for determining CCC categories, e.g., `int ccc_codes.neuromusc(x)`
all have a similar design.  Given a vector of diagnostic codes `x`, the function
compares the ith value of `x` to each of the j values of the defined ICD codes.
If a match is found the function returns 1, else, the comparison moves onto the
procedures codes.  If no match is found the function returns 0.  By design, the
comparisons stop once a match is found.

The `ccc_mat_rcpp` function creates one instance of a `codes` object and then
uses the member functions to determine if any CCC category exists in a vector of
diagnostic and procedure codes.

The exported `ccc` function passes the diagnostic and procedure codes for
multiple subsets to the `ccc_mat_rcpp` function and returns a `data.frame` with
the subject `id`s and CCC flags.
