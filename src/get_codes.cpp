// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]

#include <string>
#include <Rcpp.h>
#include "pccc.h"

const Rcpp::CharacterVector codes::col_names = Rcpp::CharacterVector::create("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant");

//' Get (view) Diagnostic and Procedure Codes
//'
//' View the ICD, version 9 or 10, for the Complex Chronic Conditions (CCC)
//' categories.
//'
//'  The CCC categories for diagnostic and procedure codes are:
//'  \tabular{lcccc}{
//'  category        \tab \code{dx} \tab \code{dx_fixed} \tab \code{pc} \tab \code{pc_fixed} \cr
//'  neuromuscul     \tab      X    \tab      X           \tab     X    \tab        \cr
//'  cvd             \tab      X    \tab      X           \tab     X    \tab        \cr
//'  respiratory     \tab      X    \tab      X           \tab     X    \tab        \cr
//'  renal           \tab      X    \tab                  \tab     X    \tab        \cr
//'  gi              \tab      X    \tab                  \tab     X    \tab        \cr
//'  hemato_immu     \tab      X    \tab                  \tab     X    \tab        \cr
//'  metabolic       \tab      X    \tab                  \tab     X    \tab      X \cr
//'  congeni_genetic \tab      X    \tab                  \tab          \tab        \cr
//'  malignancy      \tab      X    \tab                  \tab     X    \tab        \cr
//'  neonatal        \tab      X    \tab                  \tab          \tab        \cr
//'  tech_dep        \tab      X    \tab                  \tab     X    \tab        \cr
//'  transplant      \tab      X    \tab                  \tab     X    \tab        \cr
//'  }
//'
//' The ICD codes were taken from the SAS macro provided by the reference paper.
//'
//' @references
//' Feudtner C, et al. Pediatric complex chronic conditions classification system
//' version 2: updated for ICD-10 and complex medical technology dependence and
//' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
//'
//' @param icdv and integer value specifying ICD version.  Accepted values are 9
//' or 10.
//'
//' @example examples/get_codes.R
//'
//' @return
//' A matrix of character vectors.  Rows are the categories and columns for
//' diagnostic and procedure codes.
//'
//' @export
// [[Rcpp::export]]
Rcpp::List get_codes(int icdv) {
  codes cds(icdv);

  Rcpp::List dx = Rcpp::List::create(
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_neuromusc())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_cvd())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_respiratory())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_renal())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_gi())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_hemato_immu())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_metabolic())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_congeni_genetic())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_malignancy())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_neonatal())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_tech_dep())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_transplant())));

  Rcpp::List dx_fixed = Rcpp::List::create(
    Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_fixed_neuromusc())),
    Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_fixed_cvd())),
    Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_dx_fixed_respiratory())),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create());

  Rcpp::List pc = Rcpp::List::create(
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_neuromusc())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_cvd())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_respiratory())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_renal())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_gi())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_hemato_immu())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_metabolic())),
          Rcpp::CharacterVector::create(),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_malignancy())),
          Rcpp::CharacterVector::create(),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_tech_dep())),
          Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_transplant())));

  Rcpp::List pc_fixed = Rcpp::List::create(
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::Shield<SEXP>(Rcpp::wrap(cds.get_pc_fixed_metabolic())),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create(),
    Rcpp::CharacterVector::create());

  Rcpp::List rtn(48);

  for(int i=0; i<dx.length(); ++i) {
    rtn[i]      = dx[i];
    rtn[12 + i] = dx_fixed[i];
    rtn[24 + i] = pc[i];
    rtn[36 + i] = pc_fixed[i];
  }

  rtn.attr("version") = icdv;
  rtn.attr("dim") = Rcpp::NumericVector::create(12, 4);
  rtn.attr("dimnames") = Rcpp::List::create(
      codes::col_names,
      Rcpp::CharacterVector::create("dx", "dx_fixed", "pc", "pc_fixed")
      );
  rtn.attr("class") = "pccc_codes";

  return(rtn);
}
