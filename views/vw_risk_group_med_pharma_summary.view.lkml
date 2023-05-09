view: vw_risk_group_med_pharma_summary {
  label: "Risk Group Summary - MED & PHARMA Unique population"
  derived_table: {
    sql: select * from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_RISK_GROUP_MIGRATION"
          WHERE
            UNIQUE_ID IN (select DISTINCT UNIQUE_ID from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
            WHERE
                {% condition DISEASE_CATEGORY %} "ICD_DISEASE_CATEGORY" {% endcondition %} AND
                {% condition DISEASE_DESCRIPTION %} "ICD_DESCRIPTION" {% endcondition %} AND
                {% condition DIAGNOSIS_CODE %} "RECONCILED_DIAGNOSIS_CODE_ICD10" {% endcondition %} AND
                {% condition PROCEDURE_CODE_DESC %} "PROCEDURE_DESCRIPTION" {% endcondition %} AND
                {% condition PROCEDURE_CODE %} "PRIMARY_PROCEDURE_CODE" {% endcondition %} AND
                {% condition CHRONIC_CATEGORY %} "CCW_CHRONIC_CAT" {% endcondition %} AND
                {% condition GENDER %} "PATIENT_GENDER" {% endcondition %} AND
                {% condition EMPLOYEE_RELATIONSHIP %} "RELATIONSHIP_TO_EMPLOYEE" {% endcondition %} AND
                {% condition MAJOR_DISEASE_DIABETES %} "ICD_MAJOR_DISEASE" {% endcondition %} AND
                {% condition ACUTE_OR_NOT %} "CHRONICITY_IDENTIFIER" {% endcondition %} AND
                {% condition PREVENTATIVE_OR_NOT %} "ICD_PREVENTATIVE" {% endcondition %} AND
                {% condition CHRONIC_OR_NOT %} "CHRONICITY_IDENTIFIER" {% endcondition %} AND
                {% condition AVOIDABLE_ER_OR_NOT %} "ICD_AVOIDABLE_ER" {% endcondition %} AND
                {% condition DIGESTIVE_DISEASE_OR_NOT %} "ICD_DIGESTIVE_DISEASE" {% endcondition %} AND
                {% condition PARTICIPANT_YEAR %} LEFT("PAID_DATE", 4) {% endcondition %} AND
                {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})
          AND


      UNIQUE_ID IN (select DISTINCT UNIQUE_ID from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      WHERE
      {% condition ACE_INHIBITOR_DRUGS %} "ACE_INHIBITOR" {% endcondition %} AND
      {% condition STATIN_DRUGS %} "STATIN" {% endcondition %} AND
      {% condition BETA_BLOCKER_DRUGS %} "BETA_BLOCKER" {% endcondition %} AND
      {% condition ARB_DRUGS %} "ARB" {% endcondition %} AND
      {% condition DRI_DRUGS %} "DRI" {% endcondition %} AND
      {% condition BLACK_LABEL_DRUG %} "BLACK_LABEL_DRUG" {% endcondition %} AND
      {% condition SPECIALTY_DRUGS %} "SPECIALTY_DRUGS" {% endcondition %} AND
      {% condition MAINTENANCE_DRUGS %} "MAINTENANCE" {% endcondition %} AND
      {% condition DIGESTIVE_DISEASE_DRUGS %} "DIGESTIVE_DISEASE" {% endcondition %} AND
      {% condition BRAND_OR_GENERIC %} "BRAND_OR_GENERIC" {% endcondition %})

      ;;
  }
  drill_fields: [Unique_id, File_year, Risk_group, Total_paid_amt, Mean_paid_amt, Chronic, Chronic_count, Comorbid, Comorbid_count]


  dimension: Unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: Chronic {
    type: yesno
    sql: ${TABLE}."CHRONIC" ;;
  }

  dimension: Chronic_count {
    type: number
    sql: ${TABLE}."CHRONIC_COUNT" ;;
  }

  dimension: Comorbid {
    type: yesno
    sql: ${TABLE}."COMORBID" ;;
  }

  dimension: Comorbid_count {
    type: number
    sql: ${TABLE}."COMORBID_COUNT" ;;
  }

  dimension: File_year {
    type: string
    label: "Year"
    sql: ${TABLE}."FILE_YEAR" ;;
  }

  dimension: Risk_group {
    type: string
    sql: ${TABLE}."RISK_GROUP" ;;
  }

  measure: Total_paid_amt {
    type: sum
    label: "Total $"
    sql: ${TABLE}."TOTAL_PAID_AMT" ;;
    value_format: "$#,##0"
  }

  measure: Mean_paid_amt {
    type: number
    label: "Mean $"
    sql: CASE WHEN ${Total_Patients} <> 0 THEN ${Total_paid_amt}/${Total_Patients}
        ELSE 0
        END;;
    value_format: "$#,##0"
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${Unique_id};;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }

  dimension: Comorbid_Group {
    type: string
    label: "COMORBID GROUP"
    sql: CASE WHEN ${Comorbid_count} < '2' THEN '0-1'
        WHEN ${Comorbid_count} >= '2' AND ${Comorbid_count} < '4' THEN '2 to 3'
        ELSE '4 or more'
        END ;;
  }

  #Medical filters applied on vw_medical tab.
  filter: DISEASE_CATEGORY {
    #default_value: "Diseases of the Musculoskeletal System and Connective Tissue"
    type: string
    label: "DISEASE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  filter: DISEASE_DESCRIPTION {
    type: string
    label: "DISEASE DESCRIPTION"
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
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.ICD_MAJOR_DISEASE
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



  #Pharmacy filters applied on vw_pharmacy tab.
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

  filter: BLACK_LABEL_DRUG {
    type: string
    label: "BLACK LABEL DRUG"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.black_label_drug
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
