// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]

#include <string>
#include <Rcpp.h>
#include "pccc.h"

//' Get (view) Diagnostic and Procedure Codes
//'
//' View the ICD, verion 9 or 10, for the Complex Chronic Conditions (CCC)
//' categories.
//'
//'  The CCC categories for diagnostic and procedure codes are:
//'  \tabular{lcc}{                                            
//'  category        \tab \code{dxc} \tab \code{pcc} \cr       
//'  neuromuscul     \tab      X     \tab      X     \cr       
//'  cvd             \tab      X     \tab      X     \cr       
//'  respiratory     \tab      X     \tab      X     \cr       
//'  renal           \tab      X     \tab      X     \cr       
//'  gi              \tab      X     \tab      X     \cr       
//'  hemato_immu     \tab      X     \tab      X     \cr       
//'  metabolic       \tab      X     \tab      X     \cr       
//'  congeni_genetic \tab      X     \tab            \cr       
//'  malignancy      \tab      X     \tab      X     \cr       
//'  neonatal        \tab      X     \tab            \cr       
//'  tech_dep        \tab      X     \tab      X     \cr       
//'  transplant      \tab      X     \tab      X     \cr       
//'  }                                                         
//'
//' The ICD codes were taken from the SAS macro provided by the reference paper.
//'
//' @references
//' Feudtner C, et al. Pediatric complex chronic conditions classification system
//' version 2: updated for ICD-10 and complex medical technology dependence and
//' transplantation, BMC Pediatrics, 2014, 14:199, DOI: 10.1186/1471-2431-14-199
//'
//' @author Peter DeWitt
//'
//' @param version and integer value specifying ICD version 9 (default) or 10.
//'
//' @return
//' A list with three elements
//' \describe{
//'   \item{version}{ICD version}
//'   \item{dx}{A list of diagnostic codes.  Each element is for a CCC category
//'    as noted in the details}
//'   \item{pc}{A list of diagnostic codes.  Each element is for a CCC category
//'    as noted in the details}
//' }
//'
//' @export
// [[Rcpp::export]]
Rcpp::List get_codes(int version = 9) {
  ccc_codes cds(version);
  return Rcpp::List::create(
      Rcpp::Named("version")         = cds.get_version(),
      Rcpp::Named("neuromusc")       = Rcpp::wrap(cds.get_neuromusc()),
      Rcpp::Named("cvd")             = Rcpp::wrap(cds.get_cvd()),
      Rcpp::Named("respiratory")     = Rcpp::wrap(cds.get_respiratory()),
      Rcpp::Named("renal")           = Rcpp::wrap(cds.get_renal()),
      Rcpp::Named("gi")              = Rcpp::wrap(cds.get_gi()),
      Rcpp::Named("hemato_immu")     = Rcpp::wrap(cds.get_hemato_immu()),
      Rcpp::Named("metabolic")       = Rcpp::wrap(cds.get_metabolic()),
      Rcpp::Named("congeni_genetic") = Rcpp::wrap(cds.get_congeni_genetic()),
      Rcpp::Named("malignancy")      = Rcpp::wrap(cds.get_malignancy()),
      Rcpp::Named("neonatal")        = Rcpp::wrap(cds.get_neonatal()),
      Rcpp::Named("tech_dep")        = Rcpp::wrap(cds.get_tech_dep()),
      Rcpp::Named("transplant")      = Rcpp::wrap(cds.get_transplant())
    );
}

// [[Rcpp::export]]
Rcpp::DataFrame ccc_rcpp(Rcpp::CharacterMatrix& MAT, int version) {
  ccc_codes cds(version);

  Rcpp::NumericMatrix OUT(MAT.nrow(), 13);
  std::vector<std::string> these_codes(MAT.ncol());

  size_t i, j;

    
  for (size_t i = 0; i < MAT.nrow(); ++i) {
    for(j = 0; j < MAT.ncol(); ++j) {
      these_codes[j] = MAT(i, j);
    }

    OUT(i,  0) = cds.neuromusc(these_codes);
    OUT(i,  1) = cds.cvd(these_codes);
    OUT(i,  2) = cds.respiratory(these_codes);
    OUT(i,  3) = cds.renal(these_codes);
    OUT(i,  4) = cds.gi(these_codes);
    OUT(i,  5) = cds.hemato_immu(these_codes);
    OUT(i,  6) = cds.metabolic(these_codes);
    OUT(i,  7) = cds.congeni_genetic(these_codes);
    OUT(i,  8) = cds.malignancy(these_codes);
    OUT(i,  9) = cds.neonatal(these_codes);
    OUT(i, 10) = cds.tech_dep(these_codes);
    OUT(i, 11) = cds.transplant(these_codes);

    if (OUT(i,  0) + OUT(i,  1) + OUT(i,  2) + OUT(i,  3) + 
        OUT(i,  4) + OUT(i,  5) + OUT(i,  6) + OUT(i,  7) +
        OUT(i,  8) + OUT(i,  9) + OUT(i, 10) + OUT(i, 11)) {
      OUT(i, 12) = 1;
    } else {
      OUT(i, 12) = 0;
    }
  }

  Rcpp::DataFrame OUTD = Rcpp::internal::convert_using_rfunction(OUT, "as.data.frame");

  OUTD.attr("names") = Rcpp::CharacterVector::create("neuromusc",
      "cvd", "respiratory", "renal", "gi", "hemato_immu", "metabolic",
      "congeni_genetic", "malignancy", "neonatal", "tech_dep", "transplant",
      "ccc_flag");

  return OUTD;
}
