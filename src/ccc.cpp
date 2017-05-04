// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]

#include <string>
#include <Rcpp.h>
#include "pccc.h"

// [[Rcpp::export]]
Rcpp::IntegerVector ccc_rcpp(std::vector<std::string>& dx, std::vector<std::string>& pc, int version = 9)
{ 
  codes cdv(version);

  int neuromusc       = cdv.neuromusc(dx, pc);
  int cvd             = cdv.cvd(dx, pc);
  int respiratory     = cdv.respiratory(dx, pc);
  int renal           = cdv.renal(dx, pc);
  int gi              = cdv.gi(dx, pc);
  int hemato_immu     = cdv.hemato_immu(dx, pc);
  int metabolic       = cdv.metabolic(dx, pc);
  int congeni_genetic = cdv.congeni_genetic(dx);
  int malignancy      = cdv.malignancy(dx, pc);
  int neonatal        = cdv.neonatal(dx);
  int tech_dep        = cdv.tech_dep(dx, pc);
  int transplant      = cdv.transplant(dx, pc);
  int ccc_flag        = 0;

  if (neuromusc + cvd + respiratory + renal + gi + hemato_immu + metabolic + congeni_genetic + malignancy + neonatal + 
      tech_dep + transplant) {
    ccc_flag = 1;
  } 

  return Rcpp::IntegerVector::create(
      Rcpp::Named("neuromusc")       = neuromusc,
      Rcpp::Named("cvd")             = cvd,
      Rcpp::Named("respiratory")     = respiratory,
      Rcpp::Named("renal")           = renal,
      Rcpp::Named("gi")              = gi,
      Rcpp::Named("hemato_immu")     = hemato_immu,
      Rcpp::Named("metabolic")       = metabolic,
      Rcpp::Named("congeni_genetic") = congeni_genetic,
      Rcpp::Named("malignancy")      = malignancy,
      Rcpp::Named("neonatal")        = neonatal,
      Rcpp::Named("tech_dep")        = tech_dep,
      Rcpp::Named("transplant")      = transplant,
      Rcpp::Named("ccc_flag")        = ccc_flag
      ); 
}

