view: vw_medication_possession_ratio {
  label: "Medication Possession Ratio"
  derived_table: {
    sql: select * from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICATION_POSSESSION_RATIO"
          WHERE "UNIQUE_ID" IN (Select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
            WHERE {% condition ACE_INHIBITOR_Drugs %} "ACE_INHIBITOR" {% endcondition %} AND
            {% condition STATIN_Drugs %} "STATIN" {% endcondition %} AND
            {% condition ARB_Drugs %} "ARB" {% endcondition %} AND
            {% condition DRI_Drugs %} "DRI" {% endcondition %} AND
            {% condition BETA_BLOCKER_Drugs %} "BETA_BLOCKER" {% endcondition %} AND
            {% condition BLACK_LABEL_Drugs %} "BLACK_LABEL_DRUG" {% endcondition %} AND
            {% condition SPECIALTY_Drugs %} "SPECIALTY_DRUGS" {% endcondition %} AND
            {% condition MAINTENANCE_Drugs %} "MAINTENANCE" {% endcondition %})

      AND
      "UNIQUE_ID" IN (Select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE
      {% condition DISEASE_CATEGORY %} "ICD_DISEASE_CATEGORY" {% endcondition %} AND
      {% condition DISEASE_SUB_CATEGORY %} "DISEASE_SUB_CATEGORY" {% endcondition %} AND
      {% condition PROCEDURE_CATEGORY %} "PROCEDURE_CATEGORY" {% endcondition %} AND
      {% condition PROCEDURE_SUBCATEGORY %} "PROCEDURE_SUBCATEGORY" {% endcondition %} AND
      {% condition CHRONIC_CATEGORY %} "CCW_CHRONIC_CAT" {% endcondition %} AND
      {% condition PARTICIPANT_YEAR %} LEFT("ON_BOARD_DATE", 4) {% endcondition %} AND
      {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})
      ;;
  }


  filter: ACE_INHIBITOR_Drugs {
    type: string
    label: "ACE INHIBITOR Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.ace_inhibitor
  }

  filter: STATIN_Drugs {
    type: string
    label: "STATIN Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.statin
  }

  filter: ARB_Drugs {
    type: string
    label: "ARB Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.arb
  }

  filter: DRI_Drugs {
    type: string
    label: "DRI Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.dri
  }

  filter: BETA_BLOCKER_Drugs {
    type: string
    label: "BETA BLOCKER Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.beta_blocker
  }

  filter: BLACK_LABEL_Drugs {
    type: string
    label: "BLACK LABEL Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.black_label_drug
  }

  filter: SPECIALTY_Drugs {
    type: string
    label: "SPECIALTY Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.specialty_drugs
  }

  filter: MAINTENANCE_Drugs {
    type: string
    label: "MAINTENANCE Drugs"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.maintenance
  }


  filter: DISEASE_CATEGORY {
    type: string
    label: "DISEASE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  filter: DISEASE_SUB_CATEGORY {
    type: string
    label: "DISEASE SUB-CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.DIAGNOSIS_SUB_CATEGORY
  }

  filter: PROCEDURE_CATEGORY {
    type: string
    label: "PROCEDURE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PROCEDURE_CATEGORY
  }

  filter: PROCEDURE_SUBCATEGORY {
    type: string
    label: "PROCEDURE SUB-CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PROCEDURE_SUBCATEGORY
  }

  filter: CHRONIC_CATEGORY {
    type: string
    label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
  }


  dimension: date_diff {
    type: number
    hidden: yes
    sql: ${TABLE}."DATE_DIFF" ;;
  }

  dimension: drug_code {
    type: string
    sql: ${TABLE}."DRUG_CODE" ;;
  }

  dimension: drug_name {
    type: string
    sql: ${TABLE}."DRUG_NAME" ;;
  }

  dimension: duration {
    type: number
    hidden: yes
    sql: ${TABLE}."DURATION" ;;
  }

  dimension: employee_gender {
    type: string
    label: "GENDER"
    sql: ${TABLE}."EMPLOYEE_GENDER" ;;
  }

  dimension: mpr {
    type: number
    hidden: yes
    sql: ${TABLE}."MPR" ;;
  }

  measure: mpr_final {
    type: average
    label: "Medication Possession Ratio"
    value_format: "0.0%"
    sql: ${TABLE}."MPR_FINAL" ;;
  }

  dimension: relationship_to_employee {
    type: string
    label: "Relationship to Employee"
    sql: ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" ;;
  }

  dimension: tea_category {
    type: string
    label: "TEA Category"
    sql: ${TABLE}."TEA_CATEGORY" ;;
  }

  dimension: total_days_supply {
    type: number
    hidden: yes
    sql: ${TABLE}."TOTAL_DAYS_SUPPLY" ;;
  }

  dimension: unique_id {
    type: string
    hidden: yes
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: year {
    type: number
    label: "YEAR"
    sql: ${TABLE}."YEAR" ;;
    value_format: "0"
  }

  measure: Total_Patients {
    label: "Total Members"
    type: count_distinct
    sql: ${unique_id} ;;
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
