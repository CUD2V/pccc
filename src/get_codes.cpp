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
//' @param icdv and integer value specifying ICD verion.  Accepted values are 9
//' or 10.
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
Rcpp::List get_codes(int icdv) {
  codes cds(icdv);
  return Rcpp::List::create(
      Rcpp::Named("version") = cds.get_version(),
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
