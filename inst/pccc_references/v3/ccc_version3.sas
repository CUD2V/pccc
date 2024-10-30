/***************************************************************************************************
Macro Name: ccc_v3

Function:
This program will be used to create CCC categories flag and compute the number of ccc category 

Author: Matt Hall, PhD; Children's Hospital Association

Date: March 3, 2023

Load macro:

%INCLUDE "\path\ccc_v3.sas";

Call statement:

%ccc_v3(dt_in,dt_out,dx,n_dxs,pr,n_prs,icdv,subcat);

Parameter definitions:

   dt_in:  SAS input data set containing patient id and all ICD-9-CM or ICD-10-CM codes
   dt_out: SAS output data set containing all input data and new created CCC and CCC subcategories (if requested)
   dx: prefix for ICD-9-CM or ICD-10-CM diagnosis code 
   n_dxs: number of ICD-9-CM or ICD-10-CM diagnosis code 
   pr: prefix for ICD-9-CM or ICD-10-CM procedure code
   n_prs: number of ICD-9-CM or ICD-10-CM procedure code
   icdv: ICD version 9 or 10
   subcat: set to 1 if CCC subcategories should be assigned in the form "(CATEGORY) SUBCATEGORY"
		   If no subcategory is available, the CCC category will be used in the subcategory position. 
           The subcategories will be stored in dxcat1-dxcat&n_dxs. and prcat1-prcat&n_pcs.
***************************************************************************************************/

*PATHNAME specifies the location of the Excel file "Final V3 with Rev Code List 02282023.xlsx";

%LET PATHNAME=\\pr33e\SAS\Jobs\matt.hall\Desktop\CCC\v3.0;  *<===USER MUST modify;

/*Create CCC Body System Category Formats*/
PROC IMPORT FILE="&PATHNAME.\Final V3 with Rev Code List 02282023.xlsx" DBMS=xlsx OUT=ccc REPLACE;
RUN;
PROC SQL;
	CREATE TABLE ccc_categories AS
	SELECT DISTINCT ICD_Code, DX_PR, ICD9_ICD10, UPCASE(CCC_Category) AS CCC_Category
	FROM ccc
	WHERE Tech_Dep=0
	ORDER BY CCC_Category;
QUIT;
DATA ccc_bs_dxs ccc_bs_prs;
	FORMAT fmtname $20.;
	SET ccc_categories;
	IF DX_PR='DX' THEN fmtname=COMPRESS('$'||CCC_Category||ICD9_ICD10||'DX');
		ELSE IF DX_PR='PR' THEN fmtname=COMPRESS('$'||CCC_Category||ICD9_ICD10||'PR');
	IF DX_PR='DX' THEN OUTPUT ccc_bs_dxs;
		ELSE OUTPUT ccc_bs_prs;
	KEEP ICD_Code CCC_Category fmtname;
	RENAME ICD_Code=start CCC_Category=label;
RUN;
/*Create Tech Dependency Format*/
PROC SQL;
	CREATE TABLE Tech_Dep AS
	SELECT DISTINCT ICD_Code, DX_PR, ICD9_ICD10, COMPRESS(UPCASE(CCC_Category)||"_TECH") AS CCC_Category
	FROM ccc
	WHERE Tech_Dep=1;
QUIT;
DATA ccc_tech_dxs ccc_tech_prs;
	FORMAT fmtname $20.;
	SET Tech_Dep;
	IF DX_PR='DX' THEN fmtname=COMPRESS('$'||UPCASE(CCC_Category)||ICD9_ICD10||'DX');
		ELSE IF DX_PR='PR' THEN fmtname=COMPRESS('$'||UPCASE(CCC_Category)||ICD9_ICD10||'PR');
	IF DX_PR='DX' THEN OUTPUT ccc_tech_dxs;
		ELSE OUTPUT ccc_tech_prs;
	KEEP ICD_Code CCC_Category fmtname;
	RENAME ICD_Code=start CCC_Category=label;
RUN;
/*Combine diagnosis formats & output*/
DATA ccc_dx1;
	LENGTH label $50;
	SET ccc_bs_dxs ccc_tech_dxs;
	default=12;
RUN;
PROC SORT DATA=ccc_dx1;
	BY fmtname;
RUN;
PROC FORMAT LIBRARY=work CNTLIN=ccc_dx1; 
RUN;
/*Combine procedure formats & output*/
DATA ccc_pr1;
	LENGTH label $50;
	SET ccc_bs_prs ccc_tech_prs;
	default=12;
RUN;
PROC SORT DATA=ccc_pr1;
	BY fmtname;
RUN;
PROC FORMAT LIBRARY=work CNTLIN=ccc_pr1; 
RUN;
/*Subcategory Format*/
DATA ccc;
	SET ccc;
	FORMAT CCC_Subcategory2 $100.;
	IF CCC_Subcategory='' THEN CCC_Subcategory2="("||TRIM(UPCASE(CCC_Category))||") "||TRIM(UPCASE(CCC_Category));
		ELSE CCC_Subcategory2="("||TRIM(UPCASE(CCC_Category))||") "||TRIM(UPCASE(CCC_Subcategory));
RUN;
PROC SQL;
	CREATE TABLE subcat AS
	SELECT DISTINCT ICD_Code, DX_PR, ICD9_ICD10, CCC_Subcategory2
	FROM ccc
	WHERE CCC_Subcategory2~='TRANSPLANTATION';
QUIT;
PROC SORT DATA=subcat;
	BY ICD_Code DX_PR ICD9_ICD10;
RUN;
PROC TRANSPOSE DATA=subcat OUT=t_subcat;
	VAR CCC_Subcategory2;
	BY ICD_Code DX_PR ICD9_ICD10;
RUN;
DATA t_subcat;
	FORMAT CCC_Subcategory2 $100.;
	SET t_subcat;
	IF COL2~='' THEN CCC_Subcategory2=TRIM(COL1)||"/"||TRIM(COL2);
		ELSE CCC_Subcategory2=TRIM(COL1);
	KEEP ICD_Code DX_PR ICD9_ICD10 CCC_Subcategory2;
RUN;
DATA ccc_subcat_dxs ccc_subcat_prs;
	FORMAT fmtname $20.;
	SET t_subcat;
	RENAME ICD_Code=start CCC_Subcategory2=label;
	IF DX_PR='DX' THEN fmtname=COMPRESS('$SUBCAT'||ICD9_ICD10||'DX');
		ELSE IF DX_PR='PR' THEN fmtname=COMPRESS('$SUBCAT'||ICD9_ICD10||'PR');
	KEEP ICD_Code CCC_Subcategory2 fmtname;
	IF DX_PR='DX' THEN OUTPUT ccc_subcat_dxs;
		ELSE OUTPUT ccc_subcat_prs;
RUN;
PROC SORT DATA=ccc_subcat_dxs;
	BY fmtname;
RUN;
PROC FORMAT LIBRARY=work CNTLIN=ccc_subcat_dxs; 
RUN;
PROC SORT DATA=ccc_subcat_prs;
	BY fmtname;
RUN;
PROC FORMAT LIBRARY=work CNTLIN=ccc_subcat_prs; 
RUN;


%MACRO ccc_v3(dt_in,dt_out,dx,n_dxs,pr,n_prs,icdv,subcat);
	DATA &dt_out.;
		SET &dt_in.;
		ARRAY dxs(&n_dxs.) $12 &dx.1 - &dx.&n_dxs.;
		ARRAY dxc(&n_dxs.) $50 dxc1-dxc&n_dxs.;
		ARRAY prs(&n_prs.) $12 &pr.1 - &pr.&n_prs.;
		ARRAY prc(&n_prs.) $50 prc1-prc&n_prs.;
		%IF &subcat.=1 %THEN %DO;
			ARRAY dxcat(&n_dxs.) $100 dxcat1-dxcat&n_dxs.;
			ARRAY prcat(&n_prs.) $100 prcat1-prcat&n_prs.;
		%END;

		neuromusc_ccc=0;
		cvd_ccc=0;
		respiratory_ccc=0;
		renal_ccc=0;
		GI_ccc=0;
		hemato_immu_ccc=0;
		metabolic_ccc=0;
		congeni_genetic_ccc=0;
		malignancy_ccc=0;
		neonatal_ccc=0;
		transplant_ccc=0;

		cvd_tech=0;
		gi_tech=0; 
		metabolic_tech=0;
		misc_tech=0;
		neuromusc_tech=0;
		renal_tech=0;
		respiratory_tech=0;

		/*ICD 9 Version*/
		IF &icdv.=9 THEN DO;
			DO I = 1 TO &n_dxs.;
				IF dxs(I)~='' THEN DO;
					dxc(I)=PUT(dxs(I),$NEUROMUSC9DX.); IF dxc(I)~=dxs(I) THEN neuromusc_ccc=1;
					dxc(I)=PUT(dxs(I),$CVD9DX.); IF dxc(I)~=dxs(I) THEN cvd_ccc=1;
					dxc(I)=PUT(dxs(I),$RESPIRATORY9DX.); IF dxc(I)~=dxs(I) THEN respiratory_ccc=1;
					dxc(I)=PUT(dxs(I),$RENAL9DX.); IF dxc(I)~=dxs(I) THEN renal_ccc=1;
					dxc(I)=PUT(dxs(I),$GI9DX.); IF dxc(I)~=dxs(I) THEN GI_ccc=1;
					dxc(I)=PUT(dxs(I),$HEMATO_IMMU9DX.); IF dxc(I)~=dxs(I) THEN hemato_immu_ccc=1;
					dxc(I)=PUT(dxs(I),$METABOLIC9DX.); IF dxc(I)~=dxs(I) THEN metabolic_ccc=1;
					dxc(I)=PUT(dxs(I),$CONGENI_GENETIC9DX.); IF dxc(I)~=dxs(I) THEN congeni_genetic_ccc=1;
					dxc(I)=PUT(dxs(I),$MALIGNANCY9DX.); IF dxc(I)~=dxs(I) THEN malignancy_ccc=1;
					dxc(I)=PUT(dxs(I),$NEONATAL9DX.); IF dxc(I)~=dxs(I) THEN neonatal_ccc=1;
					dxc(I)=PUT(dxs(I),$TRANSPLANT9DX.); IF dxc(I)~=dxs(I) THEN transplant_ccc=1;
					%IF &subcat.=1 %THEN %DO;
						dxcat(I)=PUT(dxs(I),$SUBCAT9DX.); IF dxcat(I)=dxs(I) THEN dxcat(I)='';
					%END;
					IF PUT(dxs(I),$CVD_TECH9DX.)~=dxs(I) THEN cvd_tech=1;
						ELSE IF PUT(dxs(I),$GI_TECH9DX.)~=dxs(I) THEN gi_tech=1;
						ELSE IF PUT(dxs(I),$METABOLIC_TECH9DX.)~=dxs(I) THEN metabolic_tech=1;
						ELSE IF PUT(dxs(I),$MISC_TECH9DX.)~=dxs(I) THEN misc_tech=1;
						ELSE IF PUT(dxs(I),$NEUROMUSC_TECH9DX.)~=dxs(I) THEN neuromusc_tech=1;
						ELSE IF PUT(dxs(I),$RENAL_TECH9DX.)~=dxs(I) THEN renal_tech=1;
						ELSE IF PUT(dxs(I),$RESPIRATORY_TECH9DX.)~=dxs(I) THEN respiratory_tech=1;
				END;
			END;
			DO J = 1 TO &n_prs.;
				IF prs(J)~='' THEN DO;
					prc(J)=PUT(prs(J),$NEUROMUSC9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE neuromusc_ccc=1;
					prc(J)=PUT(prs(J),$CVD9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE cvd_ccc=1;
					prc(J)=PUT(prs(J),$RESPIRATORY9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE respiratory_ccc=1;
					prc(J)=PUT(prs(J),$RENAL9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE renal_ccc=1;
					prc(J)=PUT(prs(J),$GI9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE GI_ccc=1;
					prc(J)=PUT(prs(J),$HEMATO_IMMU9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE hemato_immu_ccc=1;
					prc(J)=PUT(prs(J),$METABOLIC9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE metabolic_ccc=1;
					prc(J)=PUT(prs(J),$MALIGNANCY9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE malignancy_ccc=1;
					prc(J)=PUT(prs(J),$TRANSPLANT9PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE transplant_ccc=1;
					%IF &subcat.=1 %THEN %DO;
						prcat(J)=PUT(prs(J),$SUBCAT9PR.); IF prcat(J)=prs(J) THEN prcat(J)='';
					%END;
					IF PUT(prs(J),$CVD_TECH9PR.)~=prs(J) THEN cvd_tech=1;
						ELSE IF PUT(prs(J),$GI_TECH9PR.)~=prs(J) THEN gi_tech=1;
						ELSE IF PUT(prs(J),$METABOLIC_TECH9PR.)~=prs(J) THEN metabolic_tech=1;
						ELSE IF PUT(prs(J),$MISC_TECH9PR.)~=prs(J) THEN misc_tech=1;
						ELSE IF PUT(prs(J),$NEUROMUSC_TECH9PR.)~=prs(J) THEN neuromusc_tech=1;
						ELSE IF PUT(prs(J),$RENAL_TECH9PR.)~=prs(J) THEN renal_tech=1;
						ELSE IF PUT(prs(J),$RESPIRATORY_TECH9PR.)~=prs(J) THEN respiratory_tech=1;
				END;
			END;
		END;
		/*ICD 10 Version*/
		IF &icdv.=10 THEN DO;
			DO I = 1 TO &n_dxs.;
				IF dxs(I)~='' THEN DO;
					dxc(I)=PUT(dxs(I),$NEUROMUSC0DX.); IF dxc(I)~=dxs(I) THEN neuromusc_ccc=1;
					dxc(I)=PUT(dxs(I),$CVD0DX.); IF dxc(I)~=dxs(I) THEN cvd_ccc=1;
					dxc(I)=PUT(dxs(I),$RESPIRATORY0DX.); IF dxc(I)~=dxs(I) THEN respiratory_ccc=1;
					dxc(I)=PUT(dxs(I),$RENAL0DX.); IF dxc(I)~=dxs(I) THEN renal_ccc=1;
					dxc(I)=PUT(dxs(I),$GI0DX.); IF dxc(I)~=dxs(I) THEN GI_ccc=1;
					dxc(I)=PUT(dxs(I),$HEMATO_IMMU0DX.); IF dxc(I)~=dxs(I) THEN hemato_immu_ccc=1;
					dxc(I)=PUT(dxs(I),$METABOLIC0DX.); IF dxc(I)~=dxs(I) THEN metabolic_ccc=1;
					dxc(I)=PUT(dxs(I),$CONGENI_GENETIC0DX.); IF dxc(I)~=dxs(I) THEN congeni_genetic_ccc=1;
					dxc(I)=PUT(dxs(I),$MALIGNANCY0DX.); IF dxc(I)~=dxs(I) THEN malignancy_ccc=1;
					dxc(I)=PUT(dxs(I),$NEONATAL0DX.); IF dxc(I)~=dxs(I) THEN neonatal_ccc=1;
					dxc(I)=PUT(dxs(I),$TRANSPLANT0DX.); IF dxc(I)~=dxs(I) THEN transplant_ccc=1;
					%IF &subcat.=1 %THEN %DO;
						dxcat(I)=PUT(dxs(I),$SUBCAT0DX.); IF dxcat(I)=dxs(I) THEN dxcat(I)='';
					%END;
					IF PUT(dxs(I),$CVD_TECH0DX.)~=dxs(I) THEN cvd_tech=1;
						ELSE IF PUT(dxs(I),$GI_TECH0DX.)~=dxs(I) THEN gi_tech=1;
						ELSE IF PUT(dxs(I),$METABOLIC_TECH0DX.)~=dxs(I) THEN metabolic_tech=1;
						ELSE IF PUT(dxs(I),$MISC_TECH0DX.)~=dxs(I) THEN misc_tech=1;
						ELSE IF PUT(dxs(I),$NEUROMUSC_TECH0DX.)~=dxs(I) THEN neuromusc_tech=1;
						ELSE IF PUT(dxs(I),$RENAL_TECH0DX.)~=dxs(I) THEN renal_tech=1;
						ELSE IF PUT(dxs(I),$RESPIRATORY_TECH0DX.)~=dxs(I) THEN respiratory_tech=1;
				END;
			END;
			DO J = 1 TO &n_prs.;
				IF prs(J)~='' THEN DO;
					prc(J)=PUT(prs(J),$NEUROMUSC0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE neuromusc_ccc=1;
					prc(J)=PUT(prs(J),$CVD0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE cvd_ccc=1;
					prc(J)=PUT(prs(J),$RESPIRATORY0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE respiratory_ccc=1;
					prc(J)=PUT(prs(J),$RENAL0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE renal_ccc=1;
					prc(J)=PUT(prs(J),$GI0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE GI_ccc=1;
					prc(J)=PUT(prs(J),$HEMATO_IMMU0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE hemato_immu_ccc=1;
					prc(J)=PUT(prs(J),$METABOLIC0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE metabolic_ccc=1;
					prc(J)=PUT(prs(J),$MALIGNANCY0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE malignancy_ccc=1;
					prc(J)=PUT(prs(J),$TRANSPLANT0PR.); IF prc(J)=prs(J) THEN prc(J)=""; ELSE transplant_ccc=1;
					%IF &subcat.=1 %THEN %DO;
						prcat(J)=PUT(prs(J),$SUBCAT0PR.); IF prcat(J)=prs(J) THEN prcat(J)='';
					%END;
					IF PUT(prs(J),$CVD_TECH0PR.)~=prs(J) THEN cvd_tech=1;
						ELSE IF PUT(prs(J),$GI_TECH0PR.)~=prs(J) THEN gi_tech=1;
						ELSE IF PUT(prs(J),$METABOLIC_TECH0PR.)~=prs(J) THEN metabolic_tech=1;
						ELSE IF PUT(prs(J),$MISC_TECH0PR.)~=prs(J) THEN misc_tech=1;
						ELSE IF PUT(prs(J),$NEUROMUSC_TECH0PR.)~=prs(J) THEN neuromusc_tech=1;
						ELSE IF PUT(prs(J),$RENAL_TECH0PR.)~=prs(J) THEN renal_tech=1;
						ELSE IF PUT(prs(J),$RESPIRATORY_TECH0PR.)~=prs(J) THEN respiratory_tech=1;
				END;
			END;
		END;

		IF MAX(neuromusc_ccc,cvd_ccc,respiratory_ccc,renal_ccc,GI_ccc,hemato_immu_ccc,metabolic_ccc,congeni_genetic_ccc,malignancy_ccc,neonatal_ccc)=1 OR transplant_ccc=1 THEN ccc_flag=1;
			ELSE ccc_flag=0;
		
		/*Retain tech codes for only the CCC population*/
		IF ccc_flag=0 THEN DO;
			cvd_tech=.;
			gi_tech=.; 
			metabolic_tech=.;
			misc_tech=.;
			neuromusc_tech=.;
			renal_tech=.;
			respiratory_tech=.;
		END;
		ELSE DO;
			IF cvd_tech=1 THEN cvd_ccc=1;
			IF gi_tech=1 THEN gi_ccc=1; 
			IF metabolic_tech=1 THEN metabolic_ccc=1;
			IF neuromusc_tech=1 THEN neuromusc_ccc=1;
			IF renal_tech=1 THEN renal_ccc=1;
			IF respiratory_tech=1 THEN respiratory_ccc=1;
		END;
		tech_dep_flag=MAX(0,cvd_tech,gi_tech,metabolic_tech,misc_tech,neuromusc_tech,renal_tech,respiratory_tech);

		num_ccc=SUM(neuromusc_ccc,cvd_ccc,respiratory_ccc,renal_ccc,GI_ccc,hemato_immu_ccc,metabolic_ccc,congeni_genetic_ccc,malignancy_ccc,neonatal_ccc);

		DROP I J dxc1-dxc&n_dxs. prc1-prc&n_prs.;
	RUN;
%MEND;

/*Clean up*/
PROC DATASETS;
	DELETE ccc Ccc_bs_dxs Ccc_bs_prs Ccc_categories Ccc_dx1 Ccc_dxs Ccc_pr1 Ccc_prs Ccc_subcat_dxs Ccc_subcat_prs Ccc_tech_dxs Ccc_tech_prs
		   Ccc_transp_dxs Ccc_transp_prs Subcat Tech_dep Transplant T_subcat;
RUN; QUIT;
