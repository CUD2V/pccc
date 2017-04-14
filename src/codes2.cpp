// Enable C++11 via this plugin (Rcpp 0.10.3 or later)
// [[Rcpp::plugins(cpp11)]]
// [[Rcpp::depends(RcppParallel)]]
#include <string>
#include <Rcpp.h>
#include "pccc.h"
#include <RcppParallel.h>

struct ccc_mat : public RcppParallel::Worker
{
  // version
  int version;

  //input matrices
  const RcppParallel::RMatrix<std::string> Rmat_dx;
  const RcppParallel::RMatrix<std::string> Rmat_pc;

  //outputs
  std::vector<int> neuromusc;

  // constructors
  ccc_mat(const Rcpp::CharacterMatrix Rmat_dx,
          const Rcpp::CharacterMatrix Rmat_pc,
          Rcpp::IntegerMatrix out) 
    : Rmat_dx(Rmat_dx), Rmat_pc(Rmat_pc), version(version), neuromusc(0) {}

  void operator()(std::size_t begin, std::size_t end) {
    for (std::size_t i = begin; i < end; ++i) {
      codes cdv(version); 
      int neuromusc       = cdv.neuromusc(Rmat_dx.row(i), Rmat_pc.row(i));
    } 
  }
};

//  codes cdv(version);
//
//  int neuromusc       = cdv.neuromusc(dx, pc);
//  int cvd             = cdv.cvd(dx, pc);
//  int respiratory     = cdv.respiratory(dx, pc);
//  int renal           = cdv.renal(dx, pc);
//  int gi              = cdv.gi(dx, pc);
//  int hemato_immu     = cdv.hemato_immu(dx, pc);
//  int metabolic       = cdv.metabolic(dx, pc);
//  int congeni_genetic = cdv.congeni_genetic(dx);
//  int malignancy      = cdv.malignancy(dx, pc);
//  int neonatal        = cdv.neonatal(dx);
//  int tech_dep        = cdv.tech_dep(dx, pc);
//  int transplant      = cdv.transplant(dx, pc);
//  int ccc_flag        = 0;
//
//  if (neuromusc + cvd + respiratory + renal + gi + hemato_immu + metabolic + congeni_genetic + malignancy + neonatal + 
//      tech_dep + transplant) {
//    ccc_flag = 1;
//  } 
