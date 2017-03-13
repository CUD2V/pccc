// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// get_codes
Rcpp::List get_codes(int version);
RcppExport SEXP pccc_get_codes(SEXP versionSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type version(versionSEXP);
    rcpp_result_gen = Rcpp::wrap(get_codes(version));
    return rcpp_result_gen;
END_RCPP
}
// ccc_rcpp
Rcpp::NumericVector ccc_rcpp(std::vector<std::string> dx, std::vector<std::string> pc, int version);
RcppExport SEXP pccc_ccc_rcpp(SEXP dxSEXP, SEXP pcSEXP, SEXP versionSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector<std::string> >::type dx(dxSEXP);
    Rcpp::traits::input_parameter< std::vector<std::string> >::type pc(pcSEXP);
    Rcpp::traits::input_parameter< int >::type version(versionSEXP);
    rcpp_result_gen = Rcpp::wrap(ccc_rcpp(dx, pc, version));
    return rcpp_result_gen;
END_RCPP
}
