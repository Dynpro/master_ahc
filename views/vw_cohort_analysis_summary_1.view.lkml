view: vw_cohort_analysis_summary_1 {
  label: "Cohort Analysis"
  derived_table: {
    sql: select MEDICAL.PATIENT_ID as MEDICAL_PATIENT_ID,  /*All Dimension of MEDICAL tab */
        MEDICAL.PAID_YEAR as MEDICAL_PAID_YEAR,
        MEDICAL.PATIENT_GENDER as MEDICAL_PATIENT_GENDER,
        MEDICAL.RELATIONSHIP_TO_EMPLOYEE as MEDICAL_RELATIONSHIP_TO_EMPLOYEE,

      Grp1.MED1_PATIENT_ID_M_G1 as Unique_Id_M_G1,         /*All Dimension of Grp1 tab */
      Grp1.MED1_PAID_YEAR_G1 as PAID_YEAR_G1,
      Grp1.MED1_PATIENT_GENDER_G1 as PATIENT_GENDER_G1,
      Grp1.MED1_RELATIONSHIP_TO_EMPLOYEE_G1 as RELATIONSHIP_TO_EMPLOYEE_G1,
      SUM(Grp1.MED1_MED_Total_Billed_Amt_G1 ) as MED_Total_Billed_Amt_G1,
      SUM(Grp1.MED1_MED_Total_Paid_Amt_G1 ) as MED_Total_Paid_Amt_G1,
      AVG(Grp1.MED1_MED_Average_Paid_Amt_G1) as MED_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT Grp1.MED1_Diagnosis_Desc_List_G1, '| ') as Diagnosis_Description_List_G1,
      LISTAGG(DISTINCT Grp1.MED1_Diagnosis_Category_List_G1, '| ') as Diagnosis_Category_List_G1,
      SUM(Grp1.PHARMA1_PHARMA_Total_Billed_Amt_G1 ) as PHARMA_Total_Billed_Amt_G1,
      SUM(Grp1.PHARMA1_PHARMA_Total_Paid_Amt_G1 ) as PHARMA_Total_Paid_Amt_G1,
      AVG(Grp1.PHARMA1_PHARMA_Average_Paid_Amt_G1 ) as PHARMA_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT Grp1.PHARMA1_TEA_Cat_List_G1, '| ') as TEA_Cat_List_G1,
      LISTAGG(DISTINCT Grp1.PHARMA1_Drug_List_G1, '| ') as Drug_List_G1,

      Grp2.MED2_PATIENT_ID_M_G2 as Unique_Id_M_G2,          /*All Dimension of Grp2 tab */
      Grp2.MED2_PATIENT_GENDER_G2 as PATIENT_GENDER_G2,
      Grp2.MED2_RELATIONSHIP_TO_EMPLOYEE_G2 as RELATIONSHIP_TO_EMPLOYEE_G2,
      Grp2.MED2_PAID_YEAR_G2 as PAID_YEAR_G2,
      SUM(Grp2.MED2_MED_Total_Billed_Amt_G2) as MED_Total_Billed_Amt_G2,
      SUM(Grp2.MED2_MED_Total_Paid_Amt_G2) as MED_Total_Paid_Amt_G2,
      AVG(Grp2.MED2_MED_Average_Paid_Amt_G2) as MED_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT Grp2.MED2_Diagnosis_Desc_List_G2, '| ') as Diagnosis_Description_List_G2,
      LISTAGG(DISTINCT Grp2.MED2_Diagnosis_Category_List_G2, '| ') as Diagnosis_Category_List_G2,
      SUM(Grp2.PHARMA2_PHARMA_Total_Billed_Amt_G2) as PHARMA_Total_Billed_Amt_G2,
      SUM(Grp2.PHARMA2_PHARMA_Total_Paid_Amt_G2) as PHARMA_Total_Paid_Amt_G2,
      AVG(Grp2.PHARMA2_PHARMA_Average_Paid_Amt_G2 ) as PHARMA_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT Grp2.PHARMA2_Drug_List_G2, '| ') as Drug_List_G2,
      LISTAGG(DISTINCT Grp2.PHARMA2_TEA_Cat_List_G2, '| ') as TEA_Cat_List_G2

      FROM  (Select "UNIQUE_ID" as PATIENT_ID,
      substring("PAID_DATE", 1, 4) as PAID_YEAR,
      "PATIENT_GENDER" as PATIENT_GENDER,
      "RELATIONSHIP_TO_EMPLOYEE" as RELATIONSHIP_TO_EMPLOYEE
      from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      GROUP BY "UNIQUE_ID", substring("PAID_DATE", 1, 4), PATIENT_GENDER, RELATIONSHIP_TO_EMPLOYEE) MEDICAL

      LEFT JOIN
      (Select                                       /*All Dimension & Measure of Grp1*/
      MED1.PATIENT_ID_M_G1 as MED1_PATIENT_ID_M_G1,
      MED1.PATIENT_GENDER_G1 as MED1_PATIENT_GENDER_G1,
      MED1.RELATIONSHIP_TO_EMPLOYEE_G1 as MED1_RELATIONSHIP_TO_EMPLOYEE_G1,
      MED1.PAID_YEAR_G1 as MED1_PAID_YEAR_G1,
      SUM(MED1.MED_Total_Billed_Amt_G1) as MED1_MED_Total_Billed_Amt_G1,
      SUM(MED1.MED_Total_Paid_Amt_G1) as MED1_MED_Total_Paid_Amt_G1,
      AVG(MED1.MED_Average_Paid_Amt_G1) as MED1_MED_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT MED1.CHRONIC_CATEGORY_G1, '| ') as MED1_CHRONIC_CATEGORY_G1,
      LISTAGG(DISTINCT MED1.Diagnosis_Desc_List_G1, '| ') as MED1_Diagnosis_Desc_List_G1,
      LISTAGG(DISTINCT MED1.Diagnosis_Category_List_G1, '| ') as MED1_Diagnosis_Category_List_G1,

      PHARMA1.PATIENT_ID_P_G1 as PHARMA1_PATIENT_ID_P_G1,
      PHARMA1.SERVICE_DATE_G1 as PHARMA1_SERVICE_DATE_G1,
      SUM(PHARMA1.PHARMA_Total_Billed_Amt_G1) as PHARMA1_PHARMA_Total_Billed_Amt_G1,
      SUM(PHARMA1.PHARMA_Total_Paid_Amt_G1) as PHARMA1_PHARMA_Total_Paid_Amt_G1,
      AVG(PHARMA1.PHARMA_Average_Paid_Amt_G1) as PHARMA1_PHARMA_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT PHARMA1.Drug_List_G1, '| ') as PHARMA1_Drug_List_G1,
      LISTAGG(DISTINCT PHARMA1.TEA_Cat_List_G1, '| ') as PHARMA1_TEA_Cat_List_G1
      from
      (Select                             /*All Dimension & Measure of Grp1_Medical*/
      "UNIQUE_ID" as PATIENT_ID_M_G1,
      "PATIENT_GENDER" as PATIENT_GENDER_G1,
      "RELATIONSHIP_TO_EMPLOYEE" as RELATIONSHIP_TO_EMPLOYEE_G1,
      substring("PAID_DATE", 1, 4) as PAID_YEAR_G1,
      SUM("TOTAL_BILLED_AMT") as MED_Total_Billed_Amt_G1,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as MED_Total_Paid_Amt_G1,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as MED_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT "CCW_CHRONIC_CAT", '| ') within group (order by "CCW_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_G1,
      LISTAGG(DISTINCT "ICD_DESCRIPTION", '| ') within group (order by "ICD_DESCRIPTION" ASC) as Diagnosis_Desc_List_G1,
      LISTAGG(DISTINCT "ICD_DISEASE_CATEGORY", '| ') within group (order by "ICD_DISEASE_CATEGORY" ASC) as Diagnosis_Category_List_G1
      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL" as M1
      WHERE                             /*All Filters on Grp1_Medical*/
      {% condition DISEASE_CATEGORY_G1 %} M1."ICD_DISEASE_CATEGORY" {% endcondition %} AND
      {% condition DESCRIPTION_G1 %} M1."ICD_DESCRIPTION" {% endcondition %} AND
      {% condition RECONCILED_DIAGNOSIS_CODE_ICD10_G1 %} M1."RECONCILED_DIAGNOSIS_CODE_ICD10" {% endcondition %} AND
      {% condition CHRONIC_CATEGORY_G1 %} M1."CCW_CHRONIC_CAT" {% endcondition %} AND
      {% condition PATIENT_GENDER_G1 %} M1."PATIENT_GENDER" {% endcondition %} AND
      {% condition RELATIONSHIP_TO_EMPLOYEE_G1 %} M1."RELATIONSHIP_TO_EMPLOYEE" {% endcondition %} AND

      {% condition PATIENT_AGE_G1 %} M1."PATIENT_AGE" {% endcondition %} AND
      {% condition AGE_GROUP_1_G1 %} M1."AGE_GROUP_1" {% endcondition %} AND
      {% condition JOB_TYPE_G1 %} M1."JOB_TYPE" {% endcondition %} AND
      {% condition JOB_DESIGNATION_G1 %} M1."JOB_DESIGNATION" {% endcondition %} AND
      {% condition ADDRESS_ZIP_CODE_G1 %} M1."ADDRESS_ZIP_CODE" {% endcondition %} AND
      {% condition ADDRESS_CITY_G1 %} M1."ADDRESS_CITY" {% endcondition %} AND
      {% condition ADDRESS_STATE_G1 %} M1."ADDRESS_STATE" {% endcondition %} AND

      {% condition PLACE_OF_SERVICE_DESCRIPTION_G1 %} M1."PLACE_OF_SERVICE_DESCRIPTION" {% endcondition %} AND
      {% condition ICD_MAJOR_DISEASE_G1 %} M1."ICD_MAJOR_DISEASE" {% endcondition %} AND
      {% condition PROCEDURE_CODE_TYPE_G1 %} M1."PROCEDURE_CODE_TYPE" {% endcondition %} AND
      {% condition PROCEDURE_DESCRIPTION_G1 %} M1."PROCEDURE_DESCRIPTION" {% endcondition %} AND
      {% condition PRIMARY_PROCEDURE_CODE_G1 %} M1."PRIMARY_PROCEDURE_CODE" {% endcondition %} AND
      {% condition ICD_LS_MODIFY_G1 %} M1."ICD_LS_MODIFY" {% endcondition %} AND
      {% condition CHRONICITY_IDENTIFIER_G1 %} M1."CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition ICD_PREVENTATIVE_G1 %} M1."ICD_PREVENTATIVE" {% endcondition %} AND
      {% condition ICD_ACUTE_G1 %} M1."CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition ICD_AVOIDABLE_ER_G1 %} M1."ICD_AVOIDABLE_ER" {% endcondition %} AND
      {% condition ICD_DIGESTIVE_DISEASE_G1 %} M1."ICD_DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition RISK_GROUP_G1 %} M1."RISK_GROUP" {% endcondition %} AND
      {% condition MSK_MRS_CODE_CLASSIFICATION_G1 %} M1."MSK_MRS_CODE_CLASSIFICATION" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_G1 %} M1."PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_G1 %} M1."PARTICIPANT_PROGRAM_NAME" {% endcondition %} AND
      "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE {% condition PARTICIPANT_YEAR_G1 %} LEFT("PAID_DATE", 4) {% endcondition %} AND
      {% condition PARTICIPANT_Flag_G1 %} "PARTICIPANT_FLAG" {% endcondition %})


      GROUP BY PATIENT_ID_M_G1, PAID_YEAR_G1, PATIENT_GENDER_G1, RELATIONSHIP_TO_EMPLOYEE_G1) as MED1

      JOIN
      (Select                             /*All Dimension & Measure of Grp1_Pharmacy*/
      "UNIQUE_ID" as PATIENT_ID_P_G1,
      substring("DATE_FILLED", 1, 4) as SERVICE_DATE_G1,
      SUM("TOTAL_BILLED_AMT") as PHARMA_Total_Billed_Amt_G1,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as PHARMA_Total_Paid_Amt_G1,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as PHARMA_Average_Paid_Amt_G1,
      LISTAGG(DISTINCT "NON_PROPRIETARY_NAME", '| ') within group (order by "NON_PROPRIETARY_NAME" ASC) as Drug_List_G1,
      LISTAGG(DISTINCT "TEA_CATEGORY", '| ') within group (order by "TEA_CATEGORY" ASC) as TEA_Cat_List_G1
      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY" as P1
      WHERE                             /*All Filters on Grp1_Pharmacy*/
      {% condition DRUG_G1 %} P1."NON_PROPRIETARY_NAME" {% endcondition %} AND
      {% condition TEA_CATEGORY_G1 %} P1."TEA_CATEGORY" {% endcondition %} AND
      {% condition DRUG_CODE_G1 %} P1."DRUG_CODE" {% endcondition %} AND
      {% condition ACE_INHIBITOR_G1 %} P1."ACE_INHIBITOR" {% endcondition %} AND
      {% condition STATIN_G1 %} P1."STATIN" {% endcondition %} AND
      {% condition ARB_G1 %} P1."ARB" {% endcondition %} AND
      {% condition DRI_G1 %} P1."DRI" {% endcondition %} AND
      {% condition SPECIALTY_DRUGS_G1 %} P1."SPECIALTY_DRUGS" {% endcondition %} AND
      {% condition MAINTENANCE_G1 %} P1."MAINTENANCE" {% endcondition %} AND
      {% condition DIGESTIVE_DISEASE_G1 %} P1."DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition BRAND_OR_GENERIC_G1 %} P1."BRAND_OR_GENERIC" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_P_G1 %} P1."PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_G1 %} P1."PARTICIPANT_PROGRAM_NAME" {% endcondition %}

      GROUP BY PATIENT_ID_P_G1, SERVICE_DATE_G1) as PHARMA1

      ON                             /*Join condition on Grp1_Medical & Grp1_Pharmacy*/
      MED1.PATIENT_ID_M_G1 = PHARMA1.PATIENT_ID_P_G1 AND
      MED1.PAID_YEAR_G1 = PHARMA1.SERVICE_DATE_G1

      GROUP BY MED1_PATIENT_ID_M_G1, MED1_PAID_YEAR_G1, MED1_PATIENT_GENDER_G1, MED1_RELATIONSHIP_TO_EMPLOYEE_G1,
      PHARMA1_PATIENT_ID_P_G1, PHARMA1_SERVICE_DATE_G1) AS Grp1

      ON  MEDICAL.PATIENT_ID = Grp1.MED1_PATIENT_ID_M_G1 AND  /*Join condition on MEDICAL & Grp1*/
      MEDICAL.PAID_YEAR = Grp1.MED1_PAID_YEAR_G1

      LEFT JOIN
      (Select                                       /*All Dimension & Measure of Grp2 */
      MED2.PATIENT_ID_M_G2 as MED2_PATIENT_ID_M_G2,
      MED2.PATIENT_GENDER_G2 as MED2_PATIENT_GENDER_G2,
      MED2.RELATIONSHIP_TO_EMPLOYEE_G2 as MED2_RELATIONSHIP_TO_EMPLOYEE_G2,
      MED2.PAID_YEAR_G2 as MED2_PAID_YEAR_G2,
      SUM(MED2.MED_Total_Billed_Amt_G2) as MED2_MED_Total_Billed_Amt_G2,
      SUM(MED2.MED_Total_Paid_Amt_G2) as MED2_MED_Total_Paid_Amt_G2,
      AVG(MED2.MED_Average_Paid_Amt_G2) as MED2_MED_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT MED2.CHRONIC_CATEGORY_G2, '| ') as MED2_CHRONIC_CATEGORY_G2,
      LISTAGG(DISTINCT MED2.Diagnosis_Desc_List_G2, '| ') as MED2_Diagnosis_Desc_List_G2,
      LISTAGG(DISTINCT MED2.Diagnosis_Category_List_G2, '| ') as MED2_Diagnosis_Category_List_G2,

      PHARMA2.PATIENT_ID_P_G2 as PHARMA2_PATIENT_ID_P_G2,
      PHARMA2.SERVICE_DATE_G2 as PHARMA2_SERVICE_DATE_G2,
      SUM(PHARMA2.PHARMA_Total_Billed_Amt_G2) as PHARMA2_PHARMA_Total_Billed_Amt_G2,
      SUM(PHARMA2.PHARMA_Total_Paid_Amt_G2) as PHARMA2_PHARMA_Total_Paid_Amt_G2,
      AVG(PHARMA2.PHARMA_Average_Paid_Amt_G2) as PHARMA2_PHARMA_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT PHARMA2.Drug_List_G2, '| ') as PHARMA2_Drug_List_G2,
      LISTAGG(DISTINCT PHARMA2.TEA_Cat_List_G2, '| ') as PHARMA2_TEA_Cat_List_G2

      from
      (Select                                       /*All Dimension & Measure of Grp2_Medical */
      "UNIQUE_ID" as PATIENT_ID_M_G2,
      "PATIENT_GENDER" as PATIENT_GENDER_G2,
      "RELATIONSHIP_TO_EMPLOYEE" as RELATIONSHIP_TO_EMPLOYEE_G2,
      substring("PAID_DATE", 1, 4) as PAID_YEAR_G2,
      SUM("TOTAL_BILLED_AMT") as MED_Total_Billed_Amt_G2,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as MED_Total_Paid_Amt_G2,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as MED_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT "CCW_CHRONIC_CAT", '|') within group (order by "CCW_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_G2,
      LISTAGG(DISTINCT "ICD_DESCRIPTION", '|') within group (order by "ICD_DESCRIPTION" ASC) as Diagnosis_Desc_List_G2,
      LISTAGG(DISTINCT "ICD_DISEASE_CATEGORY", '|') within group (order by "ICD_DISEASE_CATEGORY" ASC) as Diagnosis_Category_List_G2
      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL" as M2
      WHERE                                       /*All Filters on Grp2_Medical */
      {% condition DISEASE_CATEGORY_G2 %} M2."ICD_DISEASE_CATEGORY" {% endcondition %} AND
      {% condition DESCRIPTION_G2 %} M2."ICD_DESCRIPTION" {% endcondition %} AND

      {% condition RECONCILED_DIAGNOSIS_CODE_ICD10_G2 %} M2."RECONCILED_DIAGNOSIS_CODE_ICD10" {% endcondition %} AND
      {% condition PATIENT_AGE_G2 %} M2."PATIENT_AGE" {% endcondition %} AND
      {% condition AGE_GROUP_1_G2 %} M2."AGE_GROUP_1" {% endcondition %} AND
      {% condition JOB_TYPE_G2 %} M2."JOB_TYPE" {% endcondition %} AND
      {% condition JOB_DESIGNATION_G2 %} M2."JOB_DESIGNATION" {% endcondition %} AND
      {% condition ADDRESS_ZIP_CODE_G2 %} M2."ADDRESS_ZIP_CODE" {% endcondition %} AND
      {% condition ADDRESS_CITY_G2 %} M2."ADDRESS_CITY" {% endcondition %} AND
      {% condition ADDRESS_STATE_G2 %} M2."ADDRESS_STATE" {% endcondition %} AND

      {% condition CHRONIC_CATEGORY_G2 %} M2."CCW_CHRONIC_CAT" {% endcondition %} AND
      {% condition PATIENT_GENDER_G2 %} M2."PATIENT_GENDER" {% endcondition %} AND
      {% condition RELATIONSHIP_TO_EMPLOYEE_G2 %} M2."RELATIONSHIP_TO_EMPLOYEE" {% endcondition %} AND
      {% condition PLACE_OF_SERVICE_DESCRIPTION_G2 %} M2."PLACE_OF_SERVICE_DESCRIPTION" {% endcondition %} AND
      {% condition ICD_MAJOR_DISEASE_G2 %} M2."ICD_MAJOR_DISEASE" {% endcondition %} AND
      {% condition PROCEDURE_CODE_TYPE_G2 %} M2."PROCEDURE_CODE_TYPE" {% endcondition %} AND
      {% condition PROCEDURE_DESCRIPTION_G2 %} M2."PROCEDURE_DESCRIPTION" {% endcondition %} AND
      {% condition PRIMARY_PROCEDURE_CODE_G2 %} M2."PRIMARY_PROCEDURE_CODE" {% endcondition %} AND
      {% condition ICD_LS_MODIFY_G2 %} M2."ICD_LS_MODIFY" {% endcondition %} AND
      {% condition ICD_ACUTE_G2 %} M2."CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition ICD_PREVENTATIVE_G2 %} M2."ICD_PREVENTATIVE" {% endcondition %} AND
      {% condition CHRONICITY_IDENTIFIER_G2 %} M2."CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition ICD_AVOIDABLE_ER_G2 %} M2."ICD_AVOIDABLE_ER" {% endcondition %} AND
      {% condition ICD_DIGESTIVE_DISEASE_G2 %} M2."ICD_DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition RISK_GROUP_G2 %} M2."RISK_GROUP" {% endcondition %} AND
      {% condition MSK_MRS_CODE_CLASSIFICATION_G2 %} M2."MSK_MRS_CODE_CLASSIFICATION" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_G2 %} M2."PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_G2 %} M2."PARTICIPANT_PROGRAM_NAME" {% endcondition %} AND
      "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE {% condition PARTICIPANT_YEAR_G2 %} LEFT("PAID_DATE", 4) {% endcondition %} AND
      {% condition PARTICIPANT_Flag_G2 %} "PARTICIPANT_FLAG" {% endcondition %})

      GROUP BY PATIENT_ID_M_G2, PAID_YEAR_G2, PATIENT_GENDER_G2, RELATIONSHIP_TO_EMPLOYEE_G2) AS MED2

      JOIN
      (Select                                      /*All Dimension & Measure of Grp2_Pharmacy */
      "UNIQUE_ID" as PATIENT_ID_P_G2,
      substring("DATE_FILLED", 1, 4) as SERVICE_DATE_G2,
      SUM("TOTAL_BILLED_AMT") as PHARMA_Total_Billed_Amt_G2,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as PHARMA_Total_Paid_Amt_G2,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as PHARMA_Average_Paid_Amt_G2,
      LISTAGG(DISTINCT "NON_PROPRIETARY_NAME", '| ') within group (order by "NON_PROPRIETARY_NAME" ASC) as Drug_List_G2,
      LISTAGG(DISTINCT "TEA_CATEGORY", '| ') within group (order by "TEA_CATEGORY" ASC) as TEA_Cat_List_G2
      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY" as P2
      WHERE                                       /*All Filters on Grp2_Pharmacy*/
      {% condition DRUG_G2 %} P2."NON_PROPRIETARY_NAME" {% endcondition %} AND
      {% condition TEA_CATEGORY_G2 %} P2."TEA_CATEGORY" {% endcondition %} AND
      {% condition DRUG_CODE_G2 %} P2."DRUG_CODE" {% endcondition %} AND
      {% condition ACE_INHIBITOR_G2 %} P2."ACE_INHIBITOR" {% endcondition %} AND
      {% condition STATIN_G2 %} P2."STATIN" {% endcondition %} AND
      {% condition ARB_G2 %} P2."ARB" {% endcondition %} AND
      {% condition DRI_G2 %} P2."DRI" {% endcondition %} AND
      {% condition SPECIALTY_DRUGS_G2 %} P2."SPECIALTY_DRUGS" {% endcondition %} AND
      {% condition MAINTENANCE_G2 %} P2."MAINTENANCE" {% endcondition %} AND
      {% condition DIGESTIVE_DISEASE_G2 %} P2."DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition BRAND_OR_GENERIC_G2 %} P2."BRAND_OR_GENERIC" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_P_G2 %} P2."PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_G2 %} P2."PARTICIPANT_PROGRAM_NAME" {% endcondition %}

      GROUP BY PATIENT_ID_P_G2, SERVICE_DATE_G2) AS PHARMA2

      ON                                       /*JOIN condition on Grp2_Medical & Grp2_Pharmacy */
      MED2.PATIENT_ID_M_G2 = PHARMA2.PATIENT_ID_P_G2 AND
      MED2.PAID_YEAR_G2 = PHARMA2.SERVICE_DATE_G2

      GROUP BY MED2_PATIENT_ID_M_G2, MED2_PAID_YEAR_G2, MED2_PATIENT_GENDER_G2, MED2_RELATIONSHIP_TO_EMPLOYEE_G2,
      PHARMA2_PATIENT_ID_P_G2, PHARMA2_SERVICE_DATE_G2) AS Grp2

      ON  MEDICAL.PATIENT_ID = Grp2.MED2_PATIENT_ID_M_G2 AND   /*JOIN condition on Medical & Grp2 */
      MEDICAL.PAID_YEAR = Grp2.MED2_PAID_YEAR_G2

      GROUP BY MEDICAL_PATIENT_ID, MEDICAL_PAID_YEAR, MEDICAL_PATIENT_GENDER, MEDICAL_RELATIONSHIP_TO_EMPLOYEE,
      Unique_Id_M_G1, PAID_YEAR_G1, PATIENT_GENDER_G1, RELATIONSHIP_TO_EMPLOYEE_G1, Unique_Id_M_G2, PATIENT_GENDER_G2,
      RELATIONSHIP_TO_EMPLOYEE_G2, PAID_YEAR_G2
      ;;
  }


  dimension: PATIENT_ID {
    type: string
    hidden: yes
    sql: ${TABLE}.MEDICAL_PATIENT_ID ;;
  }

  dimension: PAID_YEAR {
    type: string
    label: "Service Year"
    sql: ${TABLE}.MEDICAL_PAID_YEAR ;;
  }

  dimension: PATIENT_GENDER {
    type: string
    label: "Gender/Sex"
    sql: ${TABLE}.MEDICAL_PATIENT_GENDER ;;
  }

  dimension: RELATIONSHIP_TO_EMPLOYEE {
    type: string
    label: "Employee Relationship(Employee/Spouse/Dependent)"
    sql: ${TABLE}.MEDICAL_RELATIONSHIP_TO_EMPLOYEE ;;
  }

#Group-1 Dimension, Measures & Filters
  filter: DISEASE_CATEGORY_G1 {
    type: string
    label: "G1 - Diagnostic Category"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  filter: DESCRIPTION_G1 {
    type: string
    label: "G1 - Diagnosis Description"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
  }

  filter:CHRONIC_CATEGORY_G1 {
    type: string
    label: "G1 - Chronic Category"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
  }

  filter:PATIENT_GENDER_G1 {
    type: string
    label: "G1 - MEMBER GENDER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.patient_gender
  }

  filter: RECONCILED_DIAGNOSIS_CODE_ICD10_G1 {
    type: string
    label: "G1 - DIAGNOSIS CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.reconciled_diagnosis_code_icd10
  }

  filter: PRIMARY_PROCEDURE_CODE_G1 {
    type: string
    label: "G1 - PROCEDURE CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.primary_procedure_code
  }

  filter: RELATIONSHIP_TO_EMPLOYEE_G1 {
    type: string
    label: "G1 - RELATIONSHIP TO EMPLOYEE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.relationship_to_employee
  }

  filter: PLACE_OF_SERVICE_DESCRIPTION_G1 {
    type: string
    label: "G1 - PLACE OF SERVICE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.place_of_service_description
  }

  filter: ICD_MAJOR_DISEASE_G1 {
    type: string
    label: "G1 - DIABETES?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.ICD_MAJOR_DISEASE
  }

  filter: PROCEDURE_CODE_TYPE_G1 {
    type: string
    label: "G1 - PROCEDURE CODE TYPE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_code_type
  }

  filter: PATIENT_AGE_G1 {
    type: number
    label: "G1 - MEMBER AGE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.patient_age
  }

  filter: AGE_GROUP_1_G1 {
    type: string
    label: "G1 - AGE GROUP"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.age_group_1
  }

  filter: JOB_TYPE_G1 {
    type: string
    label: "G1 - JOB TYPE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.job_type
  }

  filter: JOB_DESIGNATION_G1 {
    type: string
    label: "G1 - JOB DESIGNATION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.job_designation
  }

  filter: ADDRESS_ZIP_CODE_G1 {
    type: string
    label: "G1 - ADDRESS ZIP CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_zip_code
  }

  filter: ADDRESS_STATE_G1 {
    type: string
    label: "G1 - ADDRESS STATE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_state
  }

  filter: ADDRESS_CITY_G1 {
    type: string
    label: "G1 - ADDRESS CITY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_city
  }

  filter: PROCEDURE_DESCRIPTION_G1 {
    type: string
    label: "G1 - PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
  }

  filter: ICD_LS_MODIFY_G1 {
    type: string
    label: "G1 - LIFESTYLE MODIFIABLE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_ls_modify
  }

  filter: ICD_ACUTE_G1 {
    type: string
    label: "G1 - ICD ACUTE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_acute
  }

  filter: ICD_PREVENTATIVE_G1 {
    type: string
    label: "G1 - PREVENTATIVE DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_preventative
  }

  filter: CHRONICITY_IDENTIFIER_G1 {
    type: string
    label: "G1 - CHRONIC DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.2012_chronic
  }

  filter: ICD_AVOIDABLE_ER_G1 {
    type: string
    label: "G1 - AVOIDABLE ER DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_avoidable_er
  }

  filter: ICD_DIGESTIVE_DISEASE_G1 {
    type: string
    label: "G1 - DIGESTIVE DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_digestive_disease
  }

  filter: RISK_GROUP_G1 {
    type: string
    label: "G1 - RISK GROUP"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.RISK_GROUP
  }

  filter: MSK_MRS_CODE_CLASSIFICATION_G1 {
    type: string
    label: "G1 - MSK MRS Codes Classification"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.MSK_MRS_CODE_CLASSIFICATION
  }

  filter: PARTICIPANT_FLAG_G1 {
    type: string
    hidden: yes
    label: "G1 - PARTICIPANT Flag M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }

  filter: PARTICIPANT_YEAR_G1 {
    type: string
    label: "G1 - PARTICIPANT YEAR"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.participant_paid_year
  }

  filter: PARTICIPANT_Flag_G1 {
    type: string
    label: "G1 - PARTICIPANT Flag"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }

  dimension: PATIENT_ID_G1 {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.Unique_Id_M_G1 ;;
  }

  measure: Total_Patient_G1 {
    type: count_distinct
    sql: ${PATIENT_ID_G1} ;;
    label: "G1 - Total Members"
  }

  dimension: PAID_YEAR_G1 {
    type: string
    label: "G1 - Year"
    hidden: yes
    sql: ${TABLE}.PAID_YEAR_G1 ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_LIST_G1 {
    type: string
    hidden: yes
    label: "G1 - Diagnosis Description"
    sql: ${TABLE}.Diagnosis_Description_List_G1 ;;
  }

  dimension: DIAG_CATEGORY_LIST_G1 {
    type: string
    hidden: yes
    label: "G1 - Diagnosis Category"
    sql: ${TABLE}.Diagnosis_Category_List_G1 ;;
  }

  measure: MED_TOTAL_BILLED_AMT_G1 {
    type: sum
    hidden: yes
    sql: ${TABLE}.MED_Total_Billed_Amt_G1 ;;
    value_format: "$#,##0"
  }

  measure: MED_TOTAL_PAID_AMT_G1 {
    type: sum
    label: "G1 - Total Paid Amt_MEDICAL"
    sql: ${TABLE}.MED_Total_Paid_Amt_G1 ;;
    value_format: "$#,##0"
  }

  measure: MED_AVERAGE_PAID_AMT_G1 {
    type: number
    label: "G1 - Mean Paid Amt_MEDICAL"
    sql: CASE WHEN ${Total_Patient_G1} <> 0 THEN ${MED_TOTAL_PAID_AMT_G1}/${Total_Patient_G1}
        ELSE 0
        END;;
    value_format: "$#,##0"
  }



  #All the Pharmacy table Filter, Dimension & Measures.
  filter: DRUG_G1 {
    type: string
    label: "G1 - Drug"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.non_proprietary_name
  }

  filter: DRUG_CODE_G1 {
    type: string
    label: "G1 - Drug Code"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
  }

  filter: TEA_CATEGORY_G1 {
    type: string
    label: "G1 - TEA Category"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
  }

  filter: ACE_INHIBITOR_G1 {
    type: string
    label: "G1 - ACE INHIBITOR DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.ace_inhibitor
  }

  filter: STATIN_G1 {
    type: string
    label: "G1 - STATIN DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.statin
  }

  filter: ARB_G1 {
    type: string
    label: "G1 - ARB DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.arb
  }

  filter: DRI_G1 {
    type: string
    label: "G1 - DRI DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.dri
  }

  filter: SPECIALTY_DRUGS_G1 {
    type: string
    label: "G1 - SPECIALTY DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.specialty_drugs
  }

  filter: MAINTENANCE_G1 {
    type: string
    label: "G1 - MAINTENANCE DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.maintenance
  }

  filter: DIGESTIVE_DISEASE_G1 {
    type: string
    label: "G1 - DIGESTIVE DISEASE DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.digestive_disease
  }

  filter: BRAND_OR_GENERIC_G1 {
    type: string
    label: "G1 - BRAND/GENERIC"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.brand_or_generic
  }

  filter: PARTICIPANT_FLAG_P_G1 {
    type: string
    hidden: yes
    label: "G1 - PARTICIPANT Flag P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_Flag
  }


  dimension: TEA_CAT_LIST_G1 {
    type: string
    hidden: yes
    label: "G1 - TEA Category"
    sql: ${TABLE}.TEA_Cat_List_G1 ;;
  }

  dimension: DRUG_LIST_G1 {
    type: string
    hidden: yes
    label: "G1 - Drug"
    sql: ${TABLE}.Drug_List_G1 ;;
  }

  measure: PHARMA_TOTAL_BILLED_AMT_G1 {
    type: sum
    hidden: yes
    sql: ${TABLE}.PHARMA_Total_Billed_Amt_G1 ;;
    value_format: "$#,##0"
  }

  measure: PHARMA_TOTAL_PAID_AMT_G1 {
    type: sum
    label: "G1 - Total Paid Amt_PHARMA"
    sql: ${TABLE}.PHARMA_Total_Paid_Amt_G1 ;;
    value_format: "$#,##0"
  }

  measure: PHARMA_AVERAGE_PAID_AMT_G1 {
    type: number
    label: "G1 - Mean Paid Amt_PHARMA"
    sql: CASE WHEN ${Total_Patient_G1} <> 0 THEN ${PHARMA_TOTAL_PAID_AMT_G1}/${Total_Patient_G1}
            ELSE 0
            END ;;
    value_format: "$#,##0"
  }


# Group 2 Dimension, Measures & Filters
  #G2-Medical Dimension, Measures & Filters
  filter: DISEASE_CATEGORY_G2 {
    type: string
    label: "G2 - Diagnostic Category"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  filter: DESCRIPTION_G2 {
    type: string
    label: "G2 - Diagnosis Description"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
  }

  filter: CHRONIC_CATEGORY_G2 {
    type: string
    label: "G2 - Chronic Category"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
  }

  filter:PATIENT_GENDER_G2 {
    type: string
    label: "G2 - MEMBER GENDER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.patient_gender
  }

  filter: RECONCILED_DIAGNOSIS_CODE_ICD10_G2 {
    type: string
    label: "G2 - DIAGNOSIS CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.reconciled_diagnosis_code_icd10
  }

  filter: PRIMARY_PROCEDURE_CODE_G2 {
    type: string
    label: "G2 - PROCEDURE CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.primary_procedure_code
  }

  filter: PATIENT_AGE_G2 {
    type: number
    label: "G2 - MEMBER AGE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.patient_age
  }

  filter: AGE_GROUP_1_G2 {
    type: string
    label: "G2 - AGE GROUP"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.age_group_1
  }

  filter: JOB_TYPE_G2 {
    type: string
    label: "G2 - JOB TYPE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.job_type
  }

  filter: JOB_DESIGNATION_G2 {
    type: string
    label: "G2 - JOB DESIGNATION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.job_designation
  }

  filter: ADDRESS_ZIP_CODE_G2 {
    type: string
    label: "G2 - ADDRESS ZIP CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_zip_code
  }

  filter: ADDRESS_STATE_G2 {
    type: string
    label: "G2 - ADDRESS STATE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_state
  }

  filter: ADDRESS_CITY_G2 {
    type: string
    label: "G2 - ADDRESS CITY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.address_city
  }

  filter: RELATIONSHIP_TO_EMPLOYEE_G2 {
    type: string
    label: "G2 - RELATIONSHIP TO EMPLOYEE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.relationship_to_employee
  }

  filter: PLACE_OF_SERVICE_DESCRIPTION_G2 {
    type: string
    label: "G2 - PLACE OF SERVICE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.place_of_service_description
  }

  filter: ICD_MAJOR_DISEASE_G2 {
    type: string
    label: "G2 - DIABETES?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.ICD_MAJOR_DISEASE
  }

  filter: PROCEDURE_CODE_TYPE_G2 {
    type: string
    label: "G2 - PROCEDURE CODE TYPE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_code_type
  }

  filter: PROCEDURE_DESCRIPTION_G2 {
    type: string
    label: "G2 - PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
  }

  filter: ICD_LS_MODIFY_G2 {
    type: string
    label: "G2 - LIFESTYLE MODIFIABLE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_ls_modify
  }

  filter: ICD_ACUTE_G2 {
    type: string
    label: "G2 - ICD ACUTE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_acute
  }

  filter: ICD_PREVENTATIVE_G2 {
    type: string
    label: "G2 - PREVENTATIVE DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_preventative
  }

  filter: CHRONICITY_IDENTIFIER_G2 {
    type: string
    label: "G2 - CHRONIC DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.2012_chronic
  }

  filter: ICD_AVOIDABLE_ER_G2 {
    type: string
    label: "G2 - AVOIDABLE ER DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_avoidable_er
  }

  filter: ICD_DIGESTIVE_DISEASE_G2 {
    type: string
    label: "G2 - DIGESTIVE DISEASE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_digestive_disease
  }

  filter: RISK_GROUP_G2 {
    type: string
    label: "G2 - RISK GROUP"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.RISK_GROUP
  }

  filter: MSK_MRS_CODE_CLASSIFICATION_G2 {
    type: string
    label: "G2 - MSK MRS Codes Classification"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.MSK_MRS_CODE_CLASSIFICATION
  }

  filter: PARTICIPANT_FLAG_G2 {
    type: string
    hidden: yes
    label: "G2 - PARTICIPANT Flag M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_Flag
  }

  filter: PARTICIPANT_YEAR_G2 {
    type: string
    label: "G2 - PARTICIPANT YEAR"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.participant_paid_year
  }

  filter: PARTICIPANT_Flag_G2 {
    type: string
    label: "G2 - PARTICIPANT Flag"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }

  dimension: PATIENT_ID_G2 {
    type: string
    hidden: yes
    sql: ${TABLE}.Unique_Id_M_G2 ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_LIST_G2 {
    type: string
    hidden: yes
    label: "G2 - Diagnosis Description"
    sql: ${TABLE}.Diagnosis_Description_List_G2 ;;
  }

  dimension: DIAGNOSIS_CATEGORY_LIST_G2 {
    type: string
    hidden: yes
    label: "G2 - Diagnostic Category"
    sql: ${TABLE}.Diagnosis_Category_List_G2 ;;
  }

  measure: MED_Total_Billed_Amt_G2 {
    type: sum
    hidden: yes
    sql: ${TABLE}.MED_Total_Billed_Amt_G2 ;;
    value_format: "$#,##0"
  }

  measure: MED_Total_Paid_Amt_G2 {
    type: sum
    label: "G2 - Total Paid Amt_MEDICAL"
    sql: ${TABLE}.MED_Total_Paid_Amt_G2 ;;
    value_format: "$#,##0"
  }

  measure: MED_AVERAGE_PAID_AMT_G2 {
    type: number
    label: "G2 - Mean Paid Amt_MEDICAL"
    sql: CASE WHEN ${Total_Patient_G2} <> 0 THEN ${MED_Total_Paid_Amt_G2}/${Total_Patient_G2}
          ELSE 0
          END ;;
    value_format: "$#,##0"
  }

  measure: Total_Patient_G2 {
    type: count_distinct
    label: "G2 - Total Members"
    sql: ${PATIENT_ID_G2} ;;
  }

  dimension: PAID_YEAR_G2 {
    type: string
    label: "G2 - Year"
    hidden: yes
    sql: ${TABLE}.PAID_YEAR_G2 ;;
  }


  #G2-Pharmacy Dimention, Filters & Measures
  filter: DRUG_G2 {
    type: string
    label: "G2 - Drug"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.non_proprietary_name
  }

  filter: DRUG_CODE_G2 {
    type: string
    label: "G2 - Drug Code"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
  }

  filter:TEA_CATEGORY_G2 {
    type: string
    label: "G2 - TEA Category"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
  }

  filter: ACE_INHIBITOR_G2 {
    type: string
    label: "G2 - ACE INHIBITOR DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.ace_inhibitor
  }

  filter: STATIN_G2 {
    type: string
    label: "G2 - STATIN DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.statin
  }

  filter: ARB_G2 {
    type: string
    label: "G2 - ARB DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.arb
  }

  filter: DRI_G2 {
    type: string
    label: "G2 - DRI DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.dri
  }

  filter: SPECIALTY_DRUGS_G2 {
    type: string
    label: "G2 - SPECIALTY DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.specialty_drugs
  }

  filter: MAINTENANCE_G2 {
    type: string
    label: "G2 - MAINTENANCE DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.maintenance
  }

  filter: DIGESTIVE_DISEASE_G2 {
    type: string
    label: "G2 - DIGESTIVE DISEASE DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.digestive_disease
  }

  filter: BRAND_OR_GENERIC_G2 {
    type: string
    label: "G2 - BRAND/GENERIC"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.brand_or_generic
  }

  dimension: Drug_List_G2 {
    type: string
    hidden: yes
    label: "G2 - Drug"
    sql: ${TABLE}.Drug_List ;;
  }

  filter: PARTICIPANT_FLAG_P_G2 {
    type: string
    hidden: yes
    label: "G2 - PARTICIPANT Flag P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_Flag
  }

  dimension: TEA_Cat_List_G2 {
    type: string
    hidden: yes
    label: "G2 - TEA Category"
    sql: ${TABLE}.TEA_Cat_List_G2 ;;
  }

  measure: PHARMA_Total_Billed_Amt_G2 {
    type: sum
    hidden: yes
    sql: ${TABLE}.PHARMA_Total_Billed_Amt_G2 ;;
  }

  measure: PHARMA_Total_Paid_Amt_G2 {
    type: sum
    label: "G2 - Total Paid Amt_PHARMA"
    sql: ${TABLE}.PHARMA_Total_Paid_Amt_G2 ;;
    value_format: "$#,##0"
  }

  measure: PHARMA_AVERAGE_PAID_AMT_G2 {
    type: number
    label: "G2 - Mean Paid Amt_PHARMA"
    sql: CASE WHEN ${Total_Patient_G2} <> 0 THEN ${PHARMA_Total_Paid_Amt_G2}/${Total_Patient_G2}
          ELSE 0
          END ;;
    value_format: "$#,##0"
  }
  filter:PARTICIPANT_PROGRAM_NAME_G1 {
    type: string
    label: "G1 - PARTICIPANT PROGRAM NAME M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_PROGRAM_NAME
  }

  filter:PARTICIPANT_PROGRAM_NAME_G2 {
    type: string
    label: "G2 - PARTICIPANT PROGRAM NAME M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_PROGRAM_NAME
  }

  filter:PARTICIPANT_PROGRAM_NAME_P1 {
    type: string
    label: "G1 - PARTICIPANT PROGRAM NAME P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_PROGRAM_NAME
  }

  filter:PARTICIPANT_PROGRAM_NAME_P2 {
    type: string
    label: "G2 - PARTICIPANT PROGRAM NAME P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_PROGRAM_NAME
  }
}
