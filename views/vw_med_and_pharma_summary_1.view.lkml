view: vw_med_and_pharma_summary_1 {
  label: "Ad hoc Tool"
  derived_table: {
    sql: select MED.PATIENT_ID_M as Unique_Id_M,
        MED.PATIENT_GENDER as PATIENT_GENDER,
        MED.RELATIONSHIP_TO_EMPLOYEE as RELATIONSHIP_TO_EMPLOYEE,
        MED.PAID_YEAR as PAID_YEAR,
        MED.AGE_GROUP_List as AGE_GROUP_List,
        SUM(MED.Total_Billed_Amt_M ) as Total_Billed_Amt_M,
        SUM(MED.Total_Paid_Amt_M ) as Total_Paid_Amt_M,
        AVG(MED.Average_Paid_Amt_M) as Average_Paid_Amt_M,
        MED.Diagnosis_Desc_List as Diagnosis_Description_List,
        MED.Diagnosis_Category_List as Diagnosis_Category_List,
        MED.Chronic_Category_List as Chronic_Category_List,
        MED.PROCEDURE_DESCRIPTION_List as PROCEDURE_DESCRIPTION_List,
        MED.PROCEDURE_CODE_List as PROCEDURE_CODE_List,
        MED.PLACE_OF_SERVICE_DESCRIPTION as PLACE_OF_SERVICE_DESCRIPTION,
        MED.SPECIALITY_CODE_DESCRIPTION as SPECIALITY_CODE_DESCRIPTION,
        MED.DIAGNOSIS_CODE_List as DIAGNOSIS_CODE_List,
        MED.Diabetes_Flag as Diabetes_Flag,

      PHARMA.PATIENT_ID_P as Unique_Id_P,
      SUM(PHARMA.Total_Billed_Amt_P ) as Total_Billed_Amt_P,
      SUM(PHARMA.Total_Paid_Amt_P ) as Total_Paid_Amt_P,
      AVG(PHARMA.Average_Paid_Amt_P ) as Average_Paid_Amt_P,
      PHARMA.TEA_Cat_List as TEA_Cat_List,
      PHARMA.Drug_List as Drug_List,
      PHARMA.ACE_INHIBITOR_List as ACE_INHIBITOR_List,
      PHARMA.ARB_DRUGS_List as ARB_DRUGS_List,
      PHARMA.DRI_DRUGS_List as DRI_DRUGS_List,
      PHARMA.STATIN_DRUGS_List as STATIN_DRUGS_List

      FROM (Select                        /* Medical Summary*/
      "UNIQUE_ID" as PATIENT_ID_M,
      "PATIENT_GENDER" as PATIENT_GENDER,
      "RELATIONSHIP_TO_EMPLOYEE" as RELATIONSHIP_TO_EMPLOYEE,
      LEFT(({% if med_reporting_date_filter._parameter_value == "'Paid'" %} "PAID_DATE"
      {% elsif med_reporting_date_filter._parameter_value == "'Service'" %} "DIAGNOSIS_DATE"
      {% else %} "DIAGNOSIS_DATE"
      {% endif %}), 4) as PAID_YEAR,
      LISTAGG(DISTINCT "AGE_GROUP_1", '| ') within group (order by "AGE_GROUP_1" ASC) as AGE_GROUP_List,
      SUM ("TOTAL_BILLED_AMT") as Total_Billed_Amt_M,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as Total_Paid_Amt_M,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as Average_Paid_Amt_M,
      LISTAGG(DISTINCT "ICD_DESCRIPTION", '| ') within group (order by "ICD_DESCRIPTION" ASC) as Diagnosis_Desc_List,
      LISTAGG(DISTINCT "ICD_DISEASE_CATEGORY", '| ') within group (order by "ICD_DISEASE_CATEGORY" ASC) as Diagnosis_Category_List,
      LISTAGG(DISTINCT "RECONCILED_DIAGNOSIS_CODE_ICD10", '| ') within group (order by "RECONCILED_DIAGNOSIS_CODE_ICD10" ASC) as DIAGNOSIS_CODE_List,
      LISTAGG(DISTINCT "CCW_CHRONIC_CAT", '| ') within group (order by "CCW_CHRONIC_CAT" ASC) as Chronic_Category_List,

      LISTAGG(DISTINCT "PROCEDURE_DESCRIPTION", '| ') within group (order by "PROCEDURE_DESCRIPTION" ASC) as PROCEDURE_DESCRIPTION_List,
      LISTAGG(DISTINCT "PRIMARY_PROCEDURE_CODE", '| ') within group (order by "PRIMARY_PROCEDURE_CODE" ASC) as PROCEDURE_CODE_List,
      LISTAGG(DISTINCT "PLACE_OF_SERVICE_DESCRIPTION", '| ') within group (order by "PLACE_OF_SERVICE_DESCRIPTION" ASC) as PLACE_OF_SERVICE_DESCRIPTION,
      LISTAGG(DISTINCT "SERVICE_PROVIDER_SPECIALITY_CODE_DESC", '| ') within group (order by "SERVICE_PROVIDER_SPECIALITY_CODE_DESC" ASC) as SPECIALITY_CODE_DESCRIPTION,
      (CASE WHEN LISTAGG(DISTINCT "CCW_CHRONIC_CAT", ' ') LIKE '%DIABETES%' THEN 'TRUE'
      ELSE 'FALSE'
      END) as Diabetes_Flag

      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL" as M
      WHERE                                   /* Dynamic Filter condition*/
      {% condition DISEASE_CATEGORY %} "ICD_DISEASE_CATEGORY" {% endcondition %} AND
      {% condition DESCRIPTION %} "ICD_DESCRIPTION" {% endcondition %} AND
      {% condition DIAGNOSIS_CODE %} "RECONCILED_DIAGNOSIS_CODE_ICD10" {% endcondition %} AND
      {% condition CHRONIC_CATEGORY %} "CCW_CHRONIC_CAT" {% endcondition %} AND
      {% condition GENDER %} "PATIENT_GENDER" {% endcondition %} AND
      {% condition EMPLOYEE_RELATIONSHIP %} "RELATIONSHIP_TO_EMPLOYEE" {% endcondition %} AND
      {% condition PLACE_OF_SERVICE_DESC %} "PLACE_OF_SERVICE_DESCRIPTION" {% endcondition %} AND
      {% condition MAJOR_DISEASE_DIABETES %} "ICD_MAJOR_DISEASE" {% endcondition %} AND
      {% condition PROCEDURE_CODE_TYPE %} "PROCEDURE_CODE_TYPE" {% endcondition %} AND
      {% condition PROCEDURE_CODE_DESC %} "PROCEDURE_DESCRIPTION" {% endcondition %} AND
      {% condition PROCEDURE_CODE %} "PRIMARY_PROCEDURE_CODE" {% endcondition %} AND
      {% condition LS_MODIFY_OR_NOT %} "ICD_LS_MODIFY" {% endcondition %} AND
      {% condition ACUTE_OR_NOT %} "CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition PREVENTATIVE_OR_NOT %} "ICD_PREVENTATIVE" {% endcondition %} AND
      {% condition CHRONIC_OR_NOT %} "CHRONICITY_IDENTIFIER" {% endcondition %} AND
      {% condition AVOIDABLE_ER_OR_NOT %} "ICD_AVOIDABLE_ER" {% endcondition %} AND
      {% condition DIGESTIVE_DISEASE_OR_NOT %} "ICD_DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_M %} "PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_M %} "PARTICIPANT_PROGRAM_NAME" {% endcondition %} AND
      "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE {% condition PARTICIPANT_YEAR %} LEFT("ON_BOARD_DATE", 4) {% endcondition %} AND
      {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})


      GROUP BY PATIENT_ID_M, PATIENT_GENDER, RELATIONSHIP_TO_EMPLOYEE, PAID_YEAR) as MED

      LEFT JOIN

      (Select                         /* Pharma Summary*/
      "UNIQUE_ID" as PATIENT_ID_P,
      LEFT(({% if pharma_reporting_date_filter._parameter_value == "'Paid'" %} "PAID_DATE"
      substring("DATE_FILLED", 1, 4) as SERVICE_DATE,
      {% elsif pharma_reporting_date_filter._parameter_value == "'Service'" %} "DATE_FILLED"
      {% else %} "DATE_FILLED"
      {% endif %}), 4) as DATE_FILLED_YEAR,
      SUM("TOTAL_BILLED_AMT") as Total_Billed_Amt_P,
      SUM("TOTAL_EMPLOYER_PAID_AMT") as Total_Paid_Amt_P,
      AVG("TOTAL_EMPLOYER_PAID_AMT") as Average_Paid_Amt_P,
      LISTAGG(DISTINCT "NON_PROPRIETARY_NAME", '| ') within group (order by "NON_PROPRIETARY_NAME" ASC) as Drug_List,
      LISTAGG(DISTINCT "TEA_CATEGORY", '| ') within group (order by "TEA_CATEGORY" ASC) as TEA_Cat_List,
      (CASE WHEN LISTAGG(DISTINCT "ACE_INHIBITOR", ' ') LIKE '%TRUE%' THEN 'TRUE'
      ELSE 'FALSE'
      END) as ACE_INHIBITOR_List,
      (CASE WHEN LISTAGG(DISTINCT "ARB", ' ') LIKE '%TRUE%' THEN 'TRUE'
      ELSE 'FALSE'
      END) as ARB_DRUGS_List,
      (CASE WHEN LISTAGG(DISTINCT "DRI", ' ') LIKE '%TRUE%' THEN 'TRUE'
      ELSE 'FALSE'
      END) as DRI_DRUGS_List,
      (CASE WHEN LISTAGG(DISTINCT "STATIN", ' ') LIKE '%TRUE%' THEN 'TRUE'
      ELSE 'FALSE'
      END) as STATIN_DRUGS_List

      From "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY" as P
      WHERE                                   /* Dynamic Filter condition*/
      {% condition DRUG %} "NON_PROPRIETARY_NAME" {% endcondition %} AND
      {% condition DRUG_CODE %} "DRUG_CODE" {% endcondition %} AND
      {% condition TEA_CATEGORY %} "TEA_CATEGORY" {% endcondition %} AND
      {% condition ACE_INHIBITOR_DRUGS %} "ACE_INHIBITOR" {% endcondition %} AND
      {% condition STATIN_DRUGS %} "STATIN" {% endcondition %} AND
      {% condition BETA_BLOCKER_DRUGS %} "BETA_BLOCKER" {% endcondition %} AND
      {% condition ARB_DRUGS %} "ARB" {% endcondition %} AND
      {% condition DRI_DRUGS %} "DRI" {% endcondition %} AND
      {% condition SPECIALTY_DRUGS %} "SPECIALTY_DRUGS" {% endcondition %} AND
      {% condition MAINTENANCE_DRUGS %} "MAINTENANCE" {% endcondition %} AND
      {% condition DIGESTIVE_DISEASE_DRUGS %} "DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition BRAND_OR_GENERIC %} "BRAND_OR_GENERIC" {% endcondition %} AND
      {% condition PARTICIPANT_FLAG_P %} "PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME_P %} "PARTICIPANT_PROGRAM_NAME" {% endcondition %}

      GROUP BY PATIENT_ID_P, DATE_FILLED_YEAR) as PHARMA

      ON                                  /*Join condition on MED & PHARMA tab */
      MED.PATIENT_ID_M = PHARMA.PATIENT_ID_P AND
      MED.PAID_YEAR = PHARMA.DATE_FILLED_YEAR

      GROUP BY Unique_Id_M, PAID_YEAR, PATIENT_GENDER, RELATIONSHIP_TO_EMPLOYEE, Diagnosis_Description_List,
      Diagnosis_Category_List, Chronic_Category_List, AGE_GROUP_List, PROCEDURE_DESCRIPTION_List, PROCEDURE_CODE_List,
      PLACE_OF_SERVICE_DESCRIPTION, SPECIALITY_CODE_DESCRIPTION, DIAGNOSIS_CODE_List, Diabetes_Flag,
      Unique_Id_P, TEA_Cat_List, Drug_List, ACE_INHIBITOR_List, ARB_DRUGS_List, DRI_DRUGS_List, STATIN_DRUGS_List
      ;;
  }

  parameter: med_reporting_date_filter {
    type: string
    label: "Med-Reporting date"
    allowed_value: {
      value: "Service"
      label: "Service date"}
    allowed_value: {
      value: "Paid"
      label: "Paid date"}
  }

  parameter: pharma_reporting_date_filter {
    type: string
    label: "Pharma-Reporting date"
    allowed_value: {
      value: "Service"
      label: "Service date"}
    allowed_value: {
      value: "Paid"
      label: "Paid date"}
  }

  filter: DISEASE_CATEGORY {
    #default_value: "Diseases of the Musculoskeletal System and Connective Tissue"
    type: string
    label: "DIAGNOSTIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  filter: DESCRIPTION {
    type: string
    label: "DIAGNOSTIC DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
  }

  filter: DIAGNOSIS_CODE {
    type: string
    label: "DIAGNOSIS CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.reconciled_diagnosis_code_icd10
  }

  filter: PROCEDURE_CODE_DESC {
    type: string
    label: "PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
  }

  filter: PROCEDURE_CODE {
    type: string
    label: "PROCEDURE CODE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.primary_procedure_code
  }

  filter: CHRONIC_CATEGORY {
    type: string
    label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
  }

  filter: GENDER {
    type: string
    label: "GENDER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.patient_gender
  }

  filter: EMPLOYEE_RELATIONSHIP {
    type: string
    label: "EMPLOYEE/SPOUSE/DEPENDENT"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.relationship_to_employee
  }

  filter: MAJOR_DISEASE_DIABETES {
    type: string
    label: "DIABETES ?"
    hidden: yes
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.ICD_MAJOR_DISEASE
  }

  filter: PLACE_OF_SERVICE_DESC {
    type: string
    label: "PLACE OF SERVICE DESC"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.place_of_service_description
  }

  filter: PROCEDURE_CODE_TYPE {
    type: string
    label: "PROCEDURE CODE TYPE"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_code_type
  }

  filter: LS_MODIFY_OR_NOT {
    type: string
    label: "LIFESTYLE MODIFIABLE ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_ls_modify
  }

  filter: ACUTE_OR_NOT {
    type: string
    label: "ACUTE ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_acute
  }

  filter: PREVENTATIVE_OR_NOT {
    type: string
    label: "PREVENTATIVE ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_preventative
  }

  filter: CHRONIC_OR_NOT {
    type: string
    label: "CHRONIC ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.2012_chronic
  }

  filter: AVOIDABLE_ER_OR_NOT {
    type: string
    label: "AVOIDABLE ER ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_avoidable_er
  }

  filter: DIGESTIVE_DISEASE_OR_NOT {
    type: string
    label: "DIGESTIVE DISEASE ?"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_digestive_disease
  }
  filter: PARTICIPANT_FLAG_M {
    type: string
    hidden: yes
    label: "PARTICIPANT Flag M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_Flag
  }

  dimension: PATIENT_ID {
    type: string
    primary_key: yes
    label: "PATIENT ID"
    hidden: yes
    sql: ${TABLE}.Unique_Id_M ;;
  }

  dimension: PAID_YEAR {
    type: string
    label: "Service Year"
    sql: ${TABLE}.PAID_YEAR ;;
  }

  dimension: PATIENT_GENDER {
    type: string
    label: "PATIENT GENDER"
    can_filter: no
    sql: ${TABLE}.PATIENT_GENDER ;;
  }

  dimension: RELATIONSHIP_TO_EMPLOYEE {
    type: string
    can_filter: no
    label: "RELATIONSHIP TO EMPLOYEE"
    sql: ${TABLE}.RELATIONSHIP_TO_EMPLOYEE ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_LIST {
    type: string
    can_filter: no
    label: "DIAGNOSTIC DESCRIPTION LIST"
    sql: ${TABLE}.Diagnosis_Description_List ;;
  }

  dimension: DIAGNOSIS_CATEGORY_LIST {
    type: string
    can_filter: no
    label: "DIAGNOSTIC CATEGORY LIST"
    sql: ${TABLE}.Diagnosis_Category_List ;;
  }

  dimension: CHRONIC_CATEGORY_LIST {
    type: string
    can_filter: no
    label: "CHRONIC CATEGORY LIST"
    sql: ${TABLE}.Chronic_Category_List ;;
  }

  dimension: PROCEDURE_DESCRIPTION_List {
    type: string
    can_filter: no
    label: "PROCEDURE DESCRIPTION List"
    sql: ${TABLE}.PROCEDURE_DESCRIPTION_List ;;
  }

  dimension: DIAGNOSIS_CODE_List {
    type: string
    can_filter: no
    label: "DIAGNOSIS/ICD CODE List"
    sql: ${TABLE}.DIAGNOSIS_CODE_List ;;
  }

  dimension: PROCEDURE_CODE_List {
    type: string
    can_filter: no
    label: "PROCEDURE CODE List"
    sql: ${TABLE}.PROCEDURE_CODE_List ;;
  }

  dimension: PLACE_OF_SERVICE_DESCRIPTION {
    type: string
    can_filter: no
    label: "PLACE OF SERVICE DESCRIPTION"
    sql: ${TABLE}.PLACE_OF_SERVICE_DESCRIPTION ;;
  }

  dimension: SPECIALITY_CODE_DESCRIPTION {
    type: string
    can_filter: no
    label: "SPECIALITY CODE DESCRIPTION"
    sql: ${TABLE}.SPECIALITY_CODE_DESCRIPTION ;;
  }

  dimension: AGE_GROUP_List {
    type: string
    label: "AGE GROUP"
    sql: ${TABLE}.AGE_GROUP_List ;;
  }

  dimension: Diabetes_Flag {
    type: string
    label: "DIABETES Flag"
    sql: ${TABLE}.Diabetes_Flag ;;
  }

  measure: TOTAL_BILLED_AMT_M {
    type: sum
    label: "MED_TOTAL BILLED AMT"
    sql: ${TABLE}.Total_Billed_Amt_M ;;
    value_format: "$#,##0"
  }

  measure: TOTAL_PAID_AMT_M {
    type: sum
    label: "MED_TOTAL PAID AMT"
    sql: ${TABLE}.Total_Paid_Amt_M ;;
    value_format: "$#,##0.00"
  }

  measure: AVERAGE_PAID_AMT_M {
    type: number
    label: "MED_MEAN PAID AMT"
    sql: CASE WHEN ${TOTAL_PATIENTS} <> 0 THEN ${TOTAL_PAID_AMT_M}/${TOTAL_PATIENTS}
          ELSE 0
          END ;;
    value_format: "$#,##0.00"
  }

  measure: TOTAL_PATIENTS {
    type: count_distinct
    label: "N"
    sql: ${PATIENT_ID} ;;
  }



  #All the Pharmacy table Filter, Dimension & Measures.
  filter: DRUG {
    type: string
    label: "DRUGS"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.non_proprietary_name
  }

  filter: DRUG_CODE {
    type: string
    label: "DRUG CODE"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
  }

  filter: TEA_CATEGORY {
    type: string
    label: "TEA CATEGORY"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
  }

  filter: ACE_INHIBITOR_DRUGS {
    type: string
    label: "ACE INHIBITOR DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.ace_inhibitor
  }

  filter: STATIN_DRUGS {
    type: string
    label: "STATIN DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.statin
  }

  filter: BETA_BLOCKER_DRUGS {
    type: string
    label: "BETA BLOCKER DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.beta_blocker
  }

  filter: ARB_DRUGS {
    type: string
    label: "ARB DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.arb
  }

  filter: DRI_DRUGS {
    type: string
    label: "DRI DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.dri
  }

  filter: SPECIALTY_DRUGS {
    type: string
    label: "SPECIALTY DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.specialty_drugs
  }

  filter: MAINTENANCE_DRUGS {
    type: string
    label: "MAINTENANCE DRUGS ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.maintenance
  }

  filter: DIGESTIVE_DISEASE_DRUGS {
    type: string
    label: "DIGESTIVE DISEASE DRUG ?"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.digestive_disease
  }

  filter: BRAND_OR_GENERIC {
    type: string
    label: "BRAND OR GENERIC"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.brand_or_generic
  }

  filter: PARTICIPANT_FLAG_P {
    type: string
    hidden: yes
    label: "PARTICIPANT Flag P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_Flag
  }

  dimension: Unique_Id_P {
    type: string
    hidden: yes
    label: "Unique Id_P"
    sql: ${TABLE}.Unique_Id_P ;;
  }

  dimension: TEA_CAT_LIST {
    type: string
    can_filter: no
    label: "TEA CATEGORY LIST"
    sql: ${TABLE}.TEA_Cat_List ;;
  }

  dimension: DRUG_LIST {
    type: string
    can_filter: no
    label: "DRUG LIST"
    sql: ${TABLE}.Drug_List ;;
  }

  dimension: ACE_INHIBITOR_List {
    type: string
    hidden: yes
    label: "ACE INHIBITOR LIST"
    sql: ${TABLE}.ACE_INHIBITOR_List ;;
  }

  dimension: ARB_DRUGS_List {
    type: string
    hidden: yes
    label: "ARB DRUGS LIST"
    sql: ${TABLE}.ARB_DRUGS_List ;;
  }

  dimension: DRI_DRUGS_List {
    type: string
    hidden: yes
    label: "DRI DRUGS LIST"
    sql: ${TABLE}.DRI_DRUGS_List ;;
  }

  dimension: STATIN_DRUGS_List {
    type: string
    hidden: yes
    label: "STATIN DRUGS LIST"
    sql: ${TABLE}.STATIN_DRUGS_List ;;
  }

  measure: Total_Patients_P {
    type: count_distinct
    hidden: yes
    sql: ${Unique_Id_P} ;;
  }

  measure: TOTAL_BILLED_AMT_P {
    type: sum
    label: "PHARMA_TOTAL BILLED $"
    sql: ${TABLE}.Total_Billed_Amt_P ;;
    value_format: "$#,##0"
  }

  measure: TOTAL_PAID_AMT_P {
    type: sum
    label: "PHARMA-TOTAL $"
    sql: ${TABLE}.Total_Paid_Amt_P ;;
    value_format: "$#,##0"
  }

  measure: AVERAGE_PAID_AMT_P {
    type: number
    label: "PHARMA-MEAN $"
    sql: CASE WHEN ${Total_Patients_P} > 0 THEN ${TOTAL_PAID_AMT_P}/${Total_Patients_P}
        ELSE 0
        END ;;
    value_format: "$#,##0"
  }

  #PHM Measures:
  measure: Diabetes_and_No_Ace_Inhibitor_Drugs_List {
    type: count_distinct
    label: "Diabetes, No Ace Inhibiter"
    filters: [Diabetes_Flag: "TRUE", ACE_INHIBITOR_List: "FALSE"]
    sql: ${PATIENT_ID} ;;
  }

  measure: Diabetes_and_No_ARB_Drugs_List {
    type: count_distinct
    label: "Diabetes, No ARB"
    filters: [Diabetes_Flag: "TRUE", ARB_DRUGS_List: "FALSE"]
    sql: ${PATIENT_ID} ;;
  }

  measure: Diabetes_and_No_DRI_Drugs_List {
    type: count_distinct
    label: "Diabetes, No DRI"
    filters: [Diabetes_Flag: "TRUE", DRI_DRUGS_List: "FALSE"]
    sql: ${PATIENT_ID} ;;
  }

  measure: Diabetes_and_No_Statin_Drugs_List {
    type: count_distinct
    label: "Diabetes, No Statin Drug"
    filters: [Diabetes_Flag: "TRUE", STATIN_DRUGS_List: "FALSE"]
    sql: ${PATIENT_ID} ;;
  }

  filter:PARTICIPANT_PROGRAM_NAME_M {
    type: string
    label: "PARTICIPANT PROGRAM NAME M"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_PROGRAM_NAME
  }

  filter:PARTICIPANT_PROGRAM_NAME_P {
    type: string
    label: "PARTICIPANT PROGRAM NAME P"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.PARTICIPANT_PROGRAM_NAME
  }
  filter: PARTICIPANT_YEAR {
    type: string
    group_label: "PARTICIPANT FILTER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.participant_paid_year
  }
  filter: PARTICIPANT_Flag {
    type: string
    group_label: "PARTICIPANT FILTER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }
}
