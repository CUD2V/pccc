#include <string>
#include <Rcpp.h>

#ifndef PCCC_H
#define PCCC_H

class codes {
  private:
    int version;

    std::vector<std::string> dx_neuromusc;
    std::vector<std::string> dx_fixed_neuromusc;
    std::vector<std::string> dx_cvd;
    std::vector<std::string> dx_fixed_cvd;
    std::vector<std::string> dx_respiratory;
    std::vector<std::string> dx_fixed_respiratory;
    std::vector<std::string> dx_renal;
    std::vector<std::string> dx_gi;
    std::vector<std::string> dx_hemato_immu;
    std::vector<std::string> dx_metabolic;
    std::vector<std::string> dx_congeni_genetic;
    std::vector<std::string> dx_malignancy;
    std::vector<std::string> dx_neonatal;
    std::vector<std::string> dx_tech_dep;
    std::vector<std::string> dx_transplant;

    std::vector<std::string> pc_neuromusc;
    std::vector<std::string> pc_cvd;
    std::vector<std::string> pc_respiratory;
    std::vector<std::string> pc_renal;
    std::vector<std::string> pc_gi;
    std::vector<std::string> pc_hemato_immu;
    std::vector<std::string> pc_metabolic;
    std::vector<std::string> pc_fixed_metabolic;
    // there are currently no procedure codes for this CCC
    //std::vector<std::string> pc_congeni_genetic;
    std::vector<std::string> pc_malignancy;
    // there are currently no procedure codes for this CCC
    //std::vector<std::string> pc_neonatal;
    std::vector<std::string> pc_tech_dep;
    std::vector<std::string> pc_transplant;

    const std::vector<std::string> empty;

    int find_match(const std::vector<std::string>& dx,
                   const std::vector<std::string>& pc,
                   const std::vector<std::string>& dx_codes,
                   const std::vector<std::string>& pc_codes);

    int find_fixed_match(const std::vector<std::string>& input,
                         const std::vector<std::string>& ccc);

  public:
    codes(int v);

    int get_version() { return version; };

    int neuromusc(      std::vector<std::string>& dx, std::vector<std::string>& pc);
    int cvd(            std::vector<std::string>& dx, std::vector<std::string>& pc);
    int respiratory(    std::vector<std::string>& dx, std::vector<std::string>& pc);
    int renal(          std::vector<std::string>& dx, std::vector<std::string>& pc);
    int gi(             std::vector<std::string>& dx, std::vector<std::string>& pc);
    int hemato_immu(    std::vector<std::string>& dx, std::vector<std::string>& pc);
    int metabolic(      std::vector<std::string>& dx, std::vector<std::string>& pc);
    int congeni_genetic(std::vector<std::string>& dx);
    int malignancy(     std::vector<std::string>& dx, std::vector<std::string>& pc);
    int neonatal(       std::vector<std::string>& dx);
    int tech_dep(       std::vector<std::string>& dx, std::vector<std::string>& pc);
    int transplant(     std::vector<std::string>& dx, std::vector<std::string>& pc);

    std::vector<std::string> get_dx_neuromusc()         { return dx_neuromusc; };
    std::vector<std::string> get_dx_fixed_neuromusc()   { return dx_fixed_neuromusc; };
    std::vector<std::string> get_dx_cvd()               { return dx_cvd; };
    std::vector<std::string> get_dx_fixed_cvd()         { return dx_fixed_cvd; };
    std::vector<std::string> get_dx_respiratory()       { return dx_respiratory; };
    std::vector<std::string> get_dx_fixed_respiratory() { return dx_fixed_respiratory; };
    std::vector<std::string> get_dx_renal()             { return dx_renal; };
    std::vector<std::string> get_dx_gi()                { return dx_gi; };
    std::vector<std::string> get_dx_hemato_immu()       { return dx_hemato_immu; };
    std::vector<std::string> get_dx_metabolic()         { return dx_metabolic; };
    std::vector<std::string> get_dx_congeni_genetic()   { return dx_congeni_genetic; };
    std::vector<std::string> get_dx_malignancy()        { return dx_malignancy; };
    std::vector<std::string> get_dx_neonatal()          { return dx_neonatal; };
    std::vector<std::string> get_dx_tech_dep()          { return dx_tech_dep; };
    std::vector<std::string> get_dx_transplant()        { return dx_transplant; };

    std::vector<std::string> get_pc_neuromusc()         { return pc_neuromusc; };
    std::vector<std::string> get_pc_cvd()               { return pc_cvd; };
    std::vector<std::string> get_pc_respiratory()       { return pc_respiratory; };
    std::vector<std::string> get_pc_renal()             { return pc_renal; };
    std::vector<std::string> get_pc_gi()                { return pc_gi; };
    std::vector<std::string> get_pc_hemato_immu()       { return pc_hemato_immu; };
    std::vector<std::string> get_pc_metabolic()         { return pc_metabolic; };
    std::vector<std::string> get_pc_fixed_metabolic()   { return pc_fixed_metabolic; };
    std::vector<std::string> get_pc_malignancy()        { return pc_malignancy; };
    std::vector<std::string> get_pc_tech_dep()          { return pc_tech_dep; };
    std::vector<std::string> get_pc_transplant()        { return pc_transplant; };

    const static Rcpp::CharacterVector col_names;
};

#endif
