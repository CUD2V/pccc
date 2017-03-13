// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]

#include <string>
#include <Rcpp.h>
#include "pccc.h"

// [[Rcpp::export]]
Rcpp::List get_codes(int version = 9) {
  codes cds(version);
  return Rcpp::List::create(
      Rcpp::Named("version")            = cds.get_version(),
      Rcpp::Named("dx") = 
        Rcpp::List::create( 
          Rcpp::Named("neuromusc")       = Rcpp::wrap(cds.get_dx_neuromusc()),
          Rcpp::Named("cvd")             = Rcpp::wrap(cds.get_dx_cvd()),
          Rcpp::Named("respiratory")     = Rcpp::wrap(cds.get_dx_respiratory()),
          Rcpp::Named("renal")           = Rcpp::wrap(cds.get_dx_renal()),
          Rcpp::Named("gi")              = Rcpp::wrap(cds.get_dx_gi()),
          Rcpp::Named("hemato_immu")     = Rcpp::wrap(cds.get_dx_hemato_immu()),
          Rcpp::Named("metabolic")       = Rcpp::wrap(cds.get_dx_metabolic()),
          Rcpp::Named("congeni_genetic") = Rcpp::wrap(cds.get_dx_congeni_genetic()),
          Rcpp::Named("malignancy")      = Rcpp::wrap(cds.get_dx_malignancy()),
          Rcpp::Named("neonatal")        = Rcpp::wrap(cds.get_dx_neonatal()),
          Rcpp::Named("tech_dep")        = Rcpp::wrap(cds.get_dx_tech_dep()),
          Rcpp::Named("transplant")      = Rcpp::wrap(cds.get_dx_transplant())),
      Rcpp::Named("pc") =
        Rcpp::List::create(
           Rcpp::Named("neuromusc")       = Rcpp::wrap(cds.get_pc_neuromusc()),
           Rcpp::Named("cvd")             = Rcpp::wrap(cds.get_pc_cvd()),
           Rcpp::Named("respiratory")     = Rcpp::wrap(cds.get_pc_respiratory()),
           Rcpp::Named("renal")           = Rcpp::wrap(cds.get_pc_renal()),
           Rcpp::Named("gi")              = Rcpp::wrap(cds.get_pc_gi()),
           Rcpp::Named("hemato_immu")     = Rcpp::wrap(cds.get_pc_hemato_immu()),
           Rcpp::Named("metabolic")       = Rcpp::wrap(cds.get_pc_metabolic()),
           Rcpp::Named("malignancy")      = Rcpp::wrap(cds.get_pc_malignancy()),
           Rcpp::Named("tech_dep")        = Rcpp::wrap(cds.get_pc_tech_dep()),
           Rcpp::Named("transplant")      = Rcpp::wrap(cds.get_pc_transplant()))
      );
}

// [[Rcpp::export]]
Rcpp::NumericVector ccc_rcpp(std::vector<std::string> dx, std::vector<std::string> pc, int version = 9) {
  int neuromusc = 0;
  int cvd = 0;
  int respiratory = 0;
  int renal = 0;
  int gi = 0;
  int hemato_immu = 0;
  int metabolic = 0;
  int congeni_genetic = 0;
  int malignancy = 0;
  int tech_dep = 0;
  int transplant = 0;

  codes cdv(version);

  int dxitr, pcitr, itr;

  // neuromusc via dx?
  for (dxitr = 0; dxitr < dx.size(); ++dxitr) { 
    for (itr = 0; itr < cdv.get_dx_neuromusc().size(); ++itr) {
      if (dx[dxitr].compare(cdv.get_dx_neuromusc()[itr]) == 0) {
        neuromusc = 1;
        break;
      }
    } 
    if (neuromusc) break;
  }

  // neuromusc via procedure, only if not already found in diagnostics
  if (neuromusc == 0) {
    for (pcitr = 0; pcitr < pc.size(); ++pcitr) { 
      for (itr = 0; itr < cdv.get_pc_neuromusc().size(); ++itr) {
        if (pc[pcitr].compare(cdv.get_pc_neuromusc()[itr]) == 0) {
          neuromusc = 1;
          break;
        }
      } 
      if (neuromusc) break;
    }
  }

  return Rcpp::NumericVector::create(Rcpp::Named("neuromusc") = neuromusc);

}
