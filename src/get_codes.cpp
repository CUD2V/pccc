// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]

#include <string>
#include <Rcpp.h>
#include "pccc.h"

const Rcpp::CharacterVector codes::col_names = Rcpp::CharacterVector::create("neuromusc", "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic", "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant");

//' Get (view) Diagnostic and Procedure Codes
//'
//' View the ICD, verion 9 or 10, for the Complex Chronic Conditions (CCC)
//' categories.
//'
//'  The CCC categories for diagnostic and procedure codes are:
//'  \tabular{lcc}{
//'  category        \tab \code{dx} \tab \code{pc} \cr
//'  neuromuscul     \tab      X    \tab      X    \cr
//'  cvd             \tab      X    \tab      X    \cr
//'  respiratory     \tab      X    \tab      X    \cr
//'  renal           \tab      X    \tab      X    \cr
//'  gi              \tab      X    \tab      X    \cr
//'  hemato_immu     \tab      X    \tab      X    \cr
//'  metabolic       \tab      X    \tab      X    \cr
//'  congeni_genetic \tab      X    \tab           \cr
//'  malignancy      \tab      X    \tab      X    \cr
//'  neonatal        \tab      X    \tab           \cr
//'  tech_dep        \tab      X    \tab      X    \cr
//'  transplant      \tab      X    \tab      X    \cr
//'  }
//'
//' The ICD codes were taken from the SAS macro provided by the reference paper.
//'
//' @references
//' Feudtner C, et al. Pediatric complex chronic conditions classification system
//' version 2: updated for ICD-10 and complex medical technology dependence and
//' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
//'
//' @param icdv and integer value specifying ICD verion.  Accepted values are 9
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
          Rcpp::wrap(cds.get_dx_neuromusc()),
          Rcpp::wrap(cds.get_dx_cvd()),
          Rcpp::wrap(cds.get_dx_respiratory()),
          Rcpp::wrap(cds.get_dx_renal()),
          Rcpp::wrap(cds.get_dx_gi()),
          Rcpp::wrap(cds.get_dx_hemato_immu()),
          Rcpp::wrap(cds.get_dx_metabolic()),
          Rcpp::wrap(cds.get_dx_congeni_genetic()),
          Rcpp::wrap(cds.get_dx_malignancy()),
          Rcpp::wrap(cds.get_dx_neonatal()),
          Rcpp::wrap(cds.get_dx_tech_dep()),
          Rcpp::wrap(cds.get_dx_transplant()));

  Rcpp::List pc = Rcpp::List::create(
          Rcpp::wrap(cds.get_pc_neuromusc()),
          Rcpp::wrap(cds.get_pc_cvd()),
          Rcpp::wrap(cds.get_pc_respiratory()),
          Rcpp::wrap(cds.get_pc_renal()),
          Rcpp::wrap(cds.get_pc_gi()),
          Rcpp::wrap(cds.get_pc_hemato_immu()),
          Rcpp::wrap(cds.get_pc_metabolic()),
          Rcpp::CharacterVector::create(),
          Rcpp::wrap(cds.get_pc_malignancy()),
          Rcpp::CharacterVector::create(),
          Rcpp::wrap(cds.get_pc_tech_dep()),
          Rcpp::wrap(cds.get_pc_transplant())
            );

  size_t i=0;
  Rcpp::List rtn(24);

  for(i=0; i<dx.length(); ++i) {
    rtn[i] = dx[i];
  }
  for(i=0; i<pc.length(); ++i) {
    rtn[12 + i] = pc[i];
  }

  rtn.attr("version") = icdv;
  rtn.attr("dim") = Rcpp::NumericVector::create(12, 2);
  rtn.attr("dimnames") = Rcpp::List::create(
      codes::col_names,
      Rcpp::CharacterVector::create("dx", "pc")
      );
  rtn.attr("class") = "pccc_codes";

  return(rtn);
}
