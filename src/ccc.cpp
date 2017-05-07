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

// [[Rcpp::export]]
Rcpp::IntegerMatrix ccc_mat_rcpp(Rcpp::CharacterMatrix& dx, Rcpp::CharacterMatrix& pc, int version = 9)
{ 
  codes cdv(version);

  Rcpp::IntegerMatrix outmat(dx.nrow(), 13);

  size_t i=0;
  Rcpp::CharacterVector dx_row;
  Rcpp::CharacterVector pc_row;
  std::vector<std::string> dx_str;
  std::vector<std::string> pc_str;

  for (i; i < dx.nrow(); ++i) { 
    dx_row = dx.row(i);
    pc_row = pc.row(i);
    dx_str = Rcpp::as<std::vector<std::string>>(dx_row);
    pc_str = Rcpp::as<std::vector<std::string>>(pc_row);
    outmat(i,  0) = cdv.neuromusc(dx_str, pc_str);
    outmat(i,  1) = cdv.cvd(dx_str, pc_str);
    outmat(i,  2) = cdv.respiratory(dx_str, pc_str);
    outmat(i,  3) = cdv.renal(dx_str, pc_str);
    outmat(i,  4) = cdv.gi(dx_str, pc_str);
    outmat(i,  5) = cdv.hemato_immu(dx_str, pc_str);
    outmat(i,  6) = cdv.metabolic(dx_str, pc_str);
    outmat(i,  7) = cdv.congeni_genetic(dx_str);
    outmat(i,  8) = cdv.malignancy(dx_str, pc_str);
    outmat(i,  9) = cdv.neonatal(dx_str);
    outmat(i, 10) = cdv.tech_dep(dx_str, pc_str);
    outmat(i, 11) = cdv.transplant(dx_str, pc_str);
    outmat(i, 12) = 0; 

    if (sum(outmat.row(i))) {
      outmat(i, 12) = 1; 
    } 
  }

  return outmat; 
}
