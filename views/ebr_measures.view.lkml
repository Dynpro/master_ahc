view: ebr_measures {
  derived_table: {
  sql:select * from "SCH_AHC_CRISP_REGIONAL"."EBR_MEASURES"
      WHERE "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."VW_MEDICAL"
        WHERE {% condition PARTICIPANT_YEAR %} LEFT("PAID_DATE", 4) {% endcondition %} AND
        {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})
    ;;
  }

  dimension: individual_gets_diabetic_test_strips {
    type: string
    label: "Diabetes Test Strips"
    description: "INDIVIDUAL GETS DIABETIC TEST STRIPS"
    sql: ${TABLE}."INDIVIDUAL_GETS_DIABETIC_TEST_STRIPS" ;;
  }

  measure: individual_gets_diabetic_test_strips_patients {
    type: count_distinct
    filters: [individual_gets_diabetic_test_strips: "1"]
    label: "Diabetes Test Strips - N"
    description: "INDIVIDUAL GETS DIABETIC TEST STRIPS"
    sql: ${unique_id} ;;
  }

  dimension: individual_gets_diabetic_test_strips_every_quarter {
    type: string
    label: "Diabetes Test Strips Quaterly"
    description: "INDIVIDUAL GETS DIABETIC TEST STRIPS EVERY QUARTER"
    sql: ${TABLE}."INDIVIDUAL_GETS_DIABETIC_TEST_STRIPS_EVERY_QUARTER" ;;
  }

  measure: individual_gets_diabetic_test_strips_every_quarter_patients {
    type: count_distinct
    filters: [individual_gets_diabetic_test_strips_every_quarter: "1"]
    label: "Diabetes Test Strips Quaterly - N"
    description: "INDIVIDUAL GETS DIABETIC TEST STRIPS EVERY QUARTER"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_emergency_room_and_inpatient_visit {
    type: string
    label: "ER & Inpatient Visit"
    description: "INDIVIDUAL HAD EMERGENCY ROOM & SUBSEQUENT INPATIENT VISIT"
    sql: ${TABLE}."INDIVIDUAL_HAD_EMERGENCY_ROOM_AND_INPATIENT_VISIT" ;;
  }

  measure: individual_had_emergency_room_and_inpatient_visit_patients {
    type: count_distinct
    filters: [individual_had_emergency_room_and_inpatient_visit: "1"]
    label: "ER & Inpatient Visit - N"
    description: "INDIVIDUAL HAD EMERGENCY ROOM & SUBSEQUENT INPATIENT VISIT"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group {
    type: string
    hidden: yes
    sql: ${TABLE}."INDIVIDUAL_IS_IN_DISEASE_GROUP" ;;
  }

  dimension: individual_is_in_disease_group_three {
    type: string
    label: "Disease Grp-3"
    description: "ONE CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-3' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_three_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_three: "1"]
    label: "Disease Grp3 - N"
    description: "ONE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_four {
    type: string
    label: "Disease Grp-4"
    description: "TWO CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-4' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_four_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_four: "1"]
    label: "Disease Grp4 - N"
    description: "TWO CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_five {
    type: string
    label: "Disease Grp-5"
    description: "THREE CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-5' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_five_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_five: "1"]
    label: "Disease Grp5 - N"
    description: "THREE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_six {
    type: string
    label: "Disease Grp-6"
    description: "FOUR CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-6' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_six_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_six: "1"]
    label: "Disease Grp6 - N"
    description: "FOUR CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_seven {
    type: string
    label: "Disease Grp-7"
    description: "FIVE OR MORE CHRONIC DISEASES"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-7' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_seven_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_seven: "1"]
    label: "Disease Grp7 - N"
    description: "FIVE OR MORE CHRONIC DISEASES"
    sql: ${unique_id} ;;
  }

  dimension: individual_taking_drug_with_cost_greater_than_400 {
    type: string
    label: "Drug Cost (>400)"
    description: "INDIVIDUAL TAKING DRUG WITH COST GREATER THAN 400"
    sql: ${TABLE}."INDIVIDUAL_TAKING_DRUG_WITH_COST_GREATER_THAN_400" ;;
  }

  measure: individual_taking_drug_with_cost_greater_than_400_patients {
    type: count_distinct
    filters: [individual_taking_drug_with_cost_greater_than_400: "1"]
    label: "Drug Cost (>400) - N"
    description: "INDIVIDUAL TAKING DRUG WITH COST GREATER THAN 400"
    sql: ${unique_id} ;;
  }

  dimension: individual_taking_black_label_drug {
    type: string
    label: "Black Label Drug"
    description: "INDIVIDUAL TAKING BLACK LABEL DRUG"
    sql: ${TABLE}."INDIVIDUAL_TAKING_BLACK_LABEL_DRUG" ;;
  }

  measure: individual_taking_black_label_drug_patients {
    type: count_distinct
    filters: [individual_taking_black_label_drug: "1"]
    label: "Black Label Drug - N"
    description: "INDIVIDUAL TAKING BLACK LABEL DRUG"
    sql: ${unique_id} ;;
  }

  dimension: individual_taking_specialty_drug {
    type: string
    label: "Speciality Label Drug"
    description: "INDIVIDUAL TAKING SPECIALTY DRUGS DRUG"
    sql: ${TABLE}."INDIVIDUAL_TAKING_SPECIALTY_DRUGS_DRUG" ;;
  }

  measure: individual_taking_specialty_drug_patients {
    type: count_distinct
    filters: [individual_taking_specialty_drug: "1"]
    label: "Speciality Label Drug - N"
    description: "INDIVIDUAL TAKING SPECIALTY DRUGS DRUG"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_primary_care_physician_visit {
    type: string
    label: "Primary Care visit"
    description: "INDIVIDUAL HAD PRIMARY CARE PHYSICIAN VISIT"
    sql: ${TABLE}."INDIVIDUAL_HAD_PRIMARY_CARE_PHYSICIAN_VISIT" ;;
  }

  measure: individual_had_primary_care_physician_visit_patients {
    type: count_distinct
    filters: [individual_had_primary_care_physician_visit: "1"]
    label: "Primary Care visit - N"
    description: "INDIVIDUAL HAD PRIMARY CARE PHYSICIAN VISIT"
    sql: ${unique_id} ;;
  }

  dimension: individual_female_had_breast_cancer_screening {
    type: string
    label: "Breast Cancer Screening"
    description: "INDIVIDUAL FEMALE HAD BREAST CANCER SCREENING"
    sql: ${TABLE}."INDIVIDUAL_FEMALE_HAD_BREAST_CANCER_SCREENING" ;;
  }

  measure: individual_female_had_breast_cancer_screening_patients {
    type: count_distinct
    filters: [individual_female_had_breast_cancer_screening: "1"]
    label: "Breast Cancer Screening - N"
    description: "INDIVIDUAL FEMALE HAD BREAST CANCER SCREENING"
    sql: ${unique_id} ;;
  }

  dimension: individual_female_had_colon_cancer_screening {
    type: string
    label: "Colon Cancer Screening"
    description: "INDIVIDUAL FEMALE HAD COLON CANCER SCREENING"
    sql: ${TABLE}."INDIVIDUAL_FEMALE_HAD_COLON_CANCER_SCREENING" ;;
  }

  measure: individual_female_had_colon_cancer_screening_patients {
    type: count_distinct
    filters: [individual_female_had_colon_cancer_screening: "1"]
    label: "Colon Cancer Screening - N"
    description: "INDIVIDUAL FEMALE HAD COLON CANCER SCREENING"
    sql: ${unique_id} ;;
  }

  dimension: individual_female_had_cervical_cancer_screening {
    type: string
    label: "Cervical Cancer Screening"
    description: "INDIVIDUAL FEMALE HAD CERVICAL CANCER SCREENING"
    sql: ${TABLE}."INDIVIDUAL_FEMALE_HAD_CERVICAL_CANCER_SCREENING" ;;
  }

  measure: individual_female_had_cervical_cancer_screening_patients {
    type: count_distinct
    filters: [individual_female_had_cervical_cancer_screening: "1"]
    label: "Cervical Cancer Screening - N"
    description: "INDIVIDUAL FEMALE HAD CERVICAL CANCER SCREENING"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_diagnosis_of_cardiovascular_and_taking_statin_drug {
    type: string
    label: "Cardiovascular & STATIN Drug"
    description: "INDIVIDUAL HAD DIAGNOSIS OF CARDIOVASCULAR AND TAKING STATIN DRUG"
    sql: ${TABLE}."INDIVIDUAL_HAD_DIAGNOSIS_OF_CARDIOVASCULAR_AND_TAKING_STATIN_DRUG" ;;
  }

  measure: individual_had_diagnosis_of_cardiovascular_and_taking_statin_drug_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_cardiovascular_and_taking_statin_drug: "1"]
    label: "Cardiovascular & STATIN Drug - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF CARDIOVASCULAR AND TAKING STATIN DRUG"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_acute_myocardial_infarction_and_taking_beta_blocker {
    type: string
    label: "Myocardial Infraction & Beta-blocker drug"
    description: "INDIVIDUAL HAD ACUTE MYOCARDIAL INFARCTION AND TAKING BETA BLOCKER"
    sql: ${TABLE}."INDIVIDUAL_HAD_ACUTE_MYOCARDIAL_INFARCTION_AND_TAKING_BETA_BLOCKER" ;;
  }

  measure: individual_had_acute_myocardial_infarction_and_taking_beta_blocker_patients {
    type: count_distinct
    filters: [individual_had_acute_myocardial_infarction_and_taking_beta_blocker: "1"]
    label: "Myocardial Infraction & Beta-blocker drug - N"
    description: "INDIVIDUAL HAD ACUTE MYOCARDIAL INFARCTION AND TAKING BETA BLOCKER"
    sql: ${unique_id} ;;
  }

  dimension: individual_has_diabetes_diagnosis_and_screened_for_retinopathy {
    type: string
    label: "Diabetes & RETINOPATHY Screening"
    description: "INDIVIDUAL HAS DIABETES DIAGNOSIS AND SCREENED FOR RETINOPATHY"
    sql: ${TABLE}."INDIVIDUAL_HAS_DIABETES_DIAGNOSIS_AND_SCREENED_FOR_RETINOPATHY" ;;
  }

  measure: individual_has_diabetes_diagnosis_and_screened_for_retinopathy_patients {
    type: count_distinct
    filters: [individual_has_diabetes_diagnosis_and_screened_for_retinopathy: "1"]
    label: "Diabetes & RETINOPATHY Screening - N"
    description: "INDIVIDUAL HAS DIABETES DIAGNOSIS AND SCREENED FOR RETINOPATHY"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_diagnosis_of_diabetes_and_taking_ace_inhibitor_or_arb_drugs {
    type: string
    label: "Diabetes & ACE_INHIBITOR/ ARB Drug"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING ACE_INHIBITOR/ ARB DRUGS"
    sql: ${TABLE}."INDIVIDUAL_HAD_DIAGNOSIS_OF_DIABETES_AND_TAKING_ACE_INHIBITOR_OR_ARB_DRUGS" ;;
  }

  measure: individual_had_diagnosis_of_diabetes_and_taking_ace_inhibitor_or_arb_drugs_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_ace_inhibitor_or_arb_drugs: "1"]
    label: "Diabetes & ACE_INHIBITOR/ ARB Drug - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING ACE_INHIBITOR/ ARB DRUGS"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_diagnosis_of_diabetes_and_taking_statin_drugs {
    type: string
    label: "Diabetes & STATIN Drug"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING STATIN DRUGS"
    sql: ${TABLE}."INDIVIDUAL_HAD_DIAGNOSIS_OF_DIABETES_AND_TAKING_STATIN_DRUGS" ;;
  }

  measure: individual_had_diagnosis_of_diabetes_and_taking_statin_drugs_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_statin_drugs: "1"]
    label: "Diabetes & STATIN Drug - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING STATIN DRUGS"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs {
    type: string
    label: "Diabetes & ANTI-HYPERTENSIVE Drug"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING ANTIHYPERTENSIVE DRUGS"
    sql: ${TABLE}."INDIVIDUAL_HAD_DIAGNOSIS_OF_DIABETES_AND_TAKING_ANTIHYPERTENSIVE_DRUGS" ;;
  }

  measure: individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs: "1"]
    label: "Diabetes & ANTI-HYPERTENSIVE Drug - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING ANTIHYPERTENSIVE DRUGS"
    sql: ${unique_id} ;;
  }


  dimension: unique_id {
    type: string
    label: "Patient ID"
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: year {
    type: number
    label: "Year"
    sql: ${TABLE}."YEAR" ;;
    value_format: "0"
  }

  measure: total_patients {
    type: count_distinct
    label: "N"
    sql: ${unique_id} ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
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
