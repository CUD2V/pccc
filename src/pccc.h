#include <string>
#include <Rcpp.h>

#ifndef PCCC_H
#define PCCC_H

class ccc_codes {
  private:
    // ICD version
    int version;

    // Classificaitons
    std::vector<std::string> codes_neuromusc; 
    std::vector<std::string> codes_cvd; 
    std::vector<std::string> codes_respiratory;
    std::vector<std::string> codes_renal;
    std::vector<std::string> codes_gi;
    std::vector<std::string> codes_hemato_immu;
    std::vector<std::string> codes_metabolic;
    std::vector<std::string> codes_congeni_genetic;
    std::vector<std::string> codes_malignancy;
    std::vector<std::string> codes_neonatal;
    std::vector<std::string> codes_tech_dep;
    std::vector<std::string> codes_transplant; 

  public:
    // constructors
    ccc_codes(int v);
    
    // accessors
    int get_version() { return version; };

    std::vector<std::string> get_neuromusc()       { return codes_neuromusc; };
    std::vector<std::string> get_cvd()             { return codes_cvd; };
    std::vector<std::string> get_respiratory()     { return codes_respiratory; };
    std::vector<std::string> get_renal()           { return codes_renal; };
    std::vector<std::string> get_gi()              { return codes_gi; };
    std::vector<std::string> get_hemato_immu()     { return codes_hemato_immu; };
    std::vector<std::string> get_metabolic()       { return codes_metabolic; };
    std::vector<std::string> get_congeni_genetic() { return codes_congeni_genetic; };
    std::vector<std::string> get_malignancy()      { return codes_malignancy; };
    std::vector<std::string> get_neonatal()        { return codes_neonatal; };
    std::vector<std::string> get_tech_dep()        { return codes_tech_dep; };
    std::vector<std::string> get_transplant()      { return codes_transplant; };
                                                                           
    // Check for a code
    int neuromusc(      std::vector<std::string>& x);
    int cvd(            std::vector<std::string>& x);
    int respiratory(    std::vector<std::string>& x);
    int renal(          std::vector<std::string>& x);
    int gi(             std::vector<std::string>& x);
    int hemato_immu(    std::vector<std::string>& x);
    int metabolic(      std::vector<std::string>& x);
    int congeni_genetic(std::vector<std::string>& x);
    int malignancy(     std::vector<std::string>& x);
    int neonatal(       std::vector<std::string>& x);
    int tech_dep(       std::vector<std::string>& x);
    int transplant(     std::vector<std::string>& x);
};

#endif
