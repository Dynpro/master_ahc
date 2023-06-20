view: ebr_measures {
  label: "EBR Measures"
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_EBR_MEASURES" ;;

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

  measure: individual_gets_diabetic_test_strips_eligible_patients {
    type: count_distinct
    filters: [individual_gets_diabetic_test_strips: "0,1"]
    label: "Diabetes Test Strips (Eligible) - N"
    description: "INDIVIDUAL IS ELIGIBLE TO GET DIABETIC TEST STRIPS"
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

  measure: individual_gets_diabetic_test_strips_every_quarter_eligible_patients {
    type: count_distinct
    filters: [individual_gets_diabetic_test_strips_every_quarter: "0,1"]
    label: "Diabetes Test Strips Quaterly (Eligible) - N"
    description: "INDIVIDUAL GETS DIABETIC TEST STRIPS EVERY QUARTER"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_emergency_room_and_inpatient_visit {
    type: string
    label: "ER Visit but No Subsequent Inpatient Visit"
    description: "INDIVIDUAL HAD EMERGENCY ROOM VISIT but NO SUBSEQUENT INPATIENT VISIT"
    sql: ${TABLE}."INDIVIDUAL_HAD_EMERGENCY_ROOM_AND_INPATIENT_VISIT" ;;
  }

  measure: individual_had_emergency_room_and_inpatient_visit_patients {
    type: count_distinct
    filters: [individual_had_emergency_room_and_inpatient_visit: "1"]
    label: "ER Visit but No Subsequent Inpatient Visit - N"
    description: "INDIVIDUAL HAD EMERGENCY ROOM VISIT but NO SUBSEQUENT INPATIENT VISIT"
    sql: ${unique_id} ;;
  }

  measure: individual_had_emergency_room_and_inpatient_visit_eligible_patients {
    type: count_distinct
    filters: [individual_had_emergency_room_and_inpatient_visit: "0,1"]
    label: "ER Visit but No Subsequent Inpatient Visit (Eligible) - N"
    description: "INDIVIDUAL HAD EMERGENCY ROOM VISIT but NO SUBSEQUENT INPATIENT VISIT"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group {
    type: string
    hidden: yes
    sql: ${TABLE}."INDIVIDUAL_IS_IN_DISEASE_GROUP" ;;
  }

  dimension: individual_is_in_disease_group_one {
    type: string
    label: "Disease Grp-1 (NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-1' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_one_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_one: "1"]
    label: "Disease Grp1 - N (NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_one_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_one: "0,1"]
    label: "Disease Grp1 (Eligible) - N (NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND LESS THAN $1500 MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_two {
    type: string
    label: "Disease Grp-2 (NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-2' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_two_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_two: "1"]
    label: "Disease Grp2 - N (NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_two_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_two: "0,1"]
    label: "Disease Grp2 (Eligible) - N (NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS)"
    description: "NO CHRONIC DISEASE AND $1500 OR MORE MEDICAL EXPENDITURES PER 12 MONTHS"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_three {
    type: string
    label: "Disease Grp-3 (ONE CHRONIC DISEASE)"
    description: "ONE CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-3' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_three_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_three: "1"]
    label: "Disease Grp3 - N (ONE CHRONIC DISEASE)"
    description: "ONE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_three_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_three: "0,1"]
    label: "Disease Grp3 (Eligible) - N (ONE CHRONIC DISEASE)"
    description: "ONE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_four {
    type: string
    label: "Disease Grp-4 (TWO CHRONIC DISEASE)"
    description: "TWO CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-4' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_four_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_four: "1"]
    label: "Disease Grp4 - N (TWO CHRONIC DISEASE)"
    description: "TWO CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_four_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_four: "0,1"]
    label: "Disease Grp4 (Eligible) - N (TWO CHRONIC DISEASE)"
    description: "TWO CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_five {
    type: string
    label: "Disease Grp-5 (THREE CHRONIC DISEASES)"
    description: "THREE CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-5' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_five_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_five: "1"]
    label: "Disease Grp5 - N (THREE CHRONIC DISEASES)"
    description: "THREE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_five_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_five: "0,1"]
    label: "Disease Grp5 (Eligible) - N (THREE CHRONIC DISEASE)"
    description: "THREE CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_six {
    type: string
    label: "Disease Grp-6 (FOUR CHRONIC DISEASES)"
    description: "FOUR CHRONIC DISEASE"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-6' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_six_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_six: "1"]
    label: "Disease Grp6 - N (FOUR CHRONIC DISEASES)"
    description: "FOUR CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_six_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_six: "0,1",]
    label: "Disease Grp6 (Eligible) - N (FOUR CHRONIC DISEASE)"
    description: "FOUR CHRONIC DISEASE"
    sql: ${unique_id} ;;
  }

  dimension: individual_is_in_disease_group_seven {
    type: string
    label: "Disease Grp-7 (FIVE OR MORE CHRONIC DISEASES)"
    description: "FIVE OR MORE CHRONIC DISEASES"
    sql: CASE WHEN ${individual_is_in_disease_group} = 'GROUP-7' THEN '1'
      ELSE '0'
      END ;;
  }

  measure: individual_is_in_disease_group_seven_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_seven: "1"]
    label: "Disease Grp7 - N (FIVE OR MORE CHRONIC DISEASES)"
    description: "FIVE OR MORE CHRONIC DISEASES"
    sql: ${unique_id} ;;
  }

  measure: individual_is_in_disease_group_seven_eligible_patients {
    type: count_distinct
    filters: [individual_is_in_disease_group_seven: "0,1"]
    label: "Disease Grp7 (Eligible) - N (FIVE OR MORE CHRONIC DISEASES)"
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

  measure: individual_taking_drug_with_cost_greater_than_400_eligible_patients {
    type: count_distinct
    filters: [individual_taking_drug_with_cost_greater_than_400: "0,1"]
    label: "Drug Cost (>400)(Eligible) - N"
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

  measure: individual_taking_black_label_drug_eligible_patients {
    type: count_distinct
    filters: [individual_taking_black_label_drug: "1", individual_taking_black_label_drug: "0"]
    label: "Black Label Drug (Eligible) - N"
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

  measure: individual_taking_specialty_drug_eligible_patients {
    type: count_distinct
    filters: [individual_taking_specialty_drug: "0,1"]
    label: "Speciality Label Drug (Eligible) - N"
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

  measure: individual_had_primary_care_physician_visit_eligible_patients {
    type: count_distinct
    filters: [individual_had_primary_care_physician_visit: "0,1"]
    label: "Primary Care visit (Eligible) - N"
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

  measure: individual_female_had_breast_cancer_screening_eligible_patients {
    type: count_distinct
    filters: [individual_female_had_breast_cancer_screening: "0,1"]
    label: "Breast Cancer Screening (Eligible) - N"
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

  measure: individual_female_had_colon_cancer_screening_eligible_patients {
    type: count_distinct
    filters: [individual_female_had_colon_cancer_screening: "0,1"]
    label: "Colon Cancer Screening (Eligible) - N"
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

  measure: individual_female_had_cervical_cancer_screening_eligible_patients {
    type: count_distinct
    filters: [individual_female_had_cervical_cancer_screening: "0,1"]
    label: "Cervical Cancer Screening (Eligible) - N"
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

  measure: individual_had_diagnosis_of_cardiovascular_and_taking_statin_drug_eligible_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_cardiovascular_and_taking_statin_drug: "0,1"]
    label: "Cardiovascular & STATIN Drug (Eligible) - N"
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

  measure: individual_had_acute_myocardial_infarction_and_taking_beta_blocker_eligible_patients {
    type: count_distinct
    filters: [individual_had_acute_myocardial_infarction_and_taking_beta_blocker: "0,1"]
    label: "Myocardial Infraction & Beta-blocker drug (Eligible) - N"
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

  measure: individual_has_diabetes_diagnosis_and_screened_for_retinopathy_eligible_patients {
    type: count_distinct
    filters: [individual_has_diabetes_diagnosis_and_screened_for_retinopathy: "0,1"]
    label: "Diabetes & RETINOPATHY Screening (Eligible) - N"
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

  measure: individual_had_diagnosis_of_diabetes_and_taking_ace_inhibitor_or_arb_drugs_eligible_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_ace_inhibitor_or_arb_drugs: "0,1"]
    label: "Diabetes & ACE_INHIBITOR/ ARB Drug (Eligible)- N"
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

  measure: individual_had_diagnosis_of_diabetes_and_taking_statin_drugs_eligible_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_statin_drugs: "0,1"]
    label: "Diabetes & STATIN Drug (Eligible)- N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF DIABETES AND TAKING STATIN DRUGS"
    sql: ${unique_id} ;;
  }

  dimension: individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs {
    type: string
    label: "HYPERTENSION & ANTI-HYPERTENSIVE Drug"
    description: "INDIVIDUAL HAD DIAGNOSIS OF HYPERTENSION AND TAKING ANTIHYPERTENSIVE DRUGS"
    sql: ${TABLE}."INDIVIDUAL_HAD_DIAGNOSIS_OF_HYPERTENSION_AND_TAKING_ANTIHYPERTENSIVE_DRUGS" ;;
  }

  measure: individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs: "1"]
    label: "HYPERTENSION & ANTI-HYPERTENSIVE Drug - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF HYPERTENSION AND TAKING ANTIHYPERTENSIVE DRUGS"
    sql: ${unique_id} ;;
  }

  measure: individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs_eligible_patients {
    type: count_distinct
    filters: [individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs: "0,1"]
    label: "HYPERTENSION & ANTI-HYPERTENSIVE Drug (Eligible) - N"
    description: "INDIVIDUAL HAD DIAGNOSIS OF HYPERTENSION AND TAKING ANTIHYPERTENSIVE DRUGS"
    sql: ${unique_id} ;;
  }

  dimension: individual_has_daibetes_diagnosis_and_screened_for_podiatry {
    type: string
    label: "Diabetes Podiatry Screening"
    description: "INDIVIDUAL HAS DIABETES DIAGNOSIS AND SCREENED FOR PODIATRY"
    sql: ${TABLE}."INDIVIDUAL_HAS_DIABETES_DIAGNOSIS_AND_SCREENED_FOR_PODIATRY" ;;
  }

  measure: individual_has_daibetes_diagnosis_and_screened_for_podiatry_patients {
    type: count_distinct
    filters: [individual_has_daibetes_diagnosis_and_screened_for_podiatry: "1"]
    label: "Diabetes Podiatry Screening - N"
    description: "INDIVIDUAL HAS DIABETES DIAGNOSIS AND SCREENED FOR PODIATRY"
    sql: ${unique_id} ;;
  }

  measure: individual_has_daibetes_diagnosis_and_screened_for_podiatry_eligible_patients {
    type: count_distinct
    filters: [individual_has_daibetes_diagnosis_and_screened_for_podiatry: "0,1"]
    label: "Diabetes Podiatry Screening(Eligible) - N"
    description: "INDIVIDUAL HAS DIABETES DIAGNOSIS AND SCREENED FOR PODIATRY"
    sql: ${unique_id} ;;
  }


  dimension: unique_id {
    type: string
    label: "Member ID"
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

  dimension: HOSPITALIZED_OR_NOT {
    type: string
    label: "HOSPITALIZED OR NOT"
    sql:  ${TABLE}."HOSPITALIZED_OR_NOT" ;;
  }

  dimension: Inpatient_Hospitalization {
    type: string
    label: "Inpatient Hospitalization"
    sql:  case when ${HOSPITALIZED_OR_NOT} = 'YES' then '1'
               when ${HOSPITALIZED_OR_NOT} = 'NO' then '0'
          else null
          end;;
  }

  measure: Inpatient_Hospitalization1 {
    type: count_distinct
    filters: [individual_is_in_disease_group_one: "1"]
    label: "Inpatient Hospitalization - N"
    description: "Inpatient Hospitalization"
    sql: ${unique_id} ;;
  }

  measure: Inpatient_Hospitalization_eligible {
    type: count_distinct
    filters: [individual_is_in_disease_group_one: "0,1"]
    label: "Inpatient Hospitalization (Eligible) - N"
    description: "Inpatient Hospitalization Eligible"
    sql: ${unique_id} ;;
  }
#Care Management dashboard dimension & measures: Benchmark labelling, HEDIS list of defined measures, Rendering & $ based on previous months
  dimension: benchmark_year_filter_suggestion {
    type: string
    hidden: yes
    sql: CAST(${year} as number) - 1 ;;
  }

  parameter: benchmark_year_filter {
    type: string
    suggest_dimension: ebr_measures.benchmark_year_filter_suggestion
  }

  dimension: reporting_benchmark_year {
    type: string
    label: "SERVICE Year"
    sql: CASE WHEN ${year} = CAST({% parameter benchmark_year_filter %} as int) THEN CAST(concat(${year}, ' ', '(Benchmark)') as string)
      ELSE CAST(${year} as string)
      END;;
  }

  dimension: compliant_measures_list {
    type: string
    hidden: yes
    sql: CONCAT((CASE WHEN ${individual_is_in_disease_group_three} = '1' THEN 'Disease Group 3 (1 Chronic disease)' ELSE '' END), ' || ',
      (CASE WHEN ${individual_is_in_disease_group_four} = '1' THEN 'Disease Group 4 (2 Chronic disease)' ELSE '' END), ' || ',
      (CASE WHEN ${individual_is_in_disease_group_five} = '1' THEN 'Disease Group 5 (3 Chronic disease)' ELSE '' END), ' || ',
      (CASE WHEN ${individual_is_in_disease_group_six} = '1' THEN 'Disease Group 6 (4 Chronic disease)' ELSE '' END), ' || ',
      (CASE WHEN ${individual_is_in_disease_group_seven} = '1' THEN 'Disease Group 7 (5 or more Chronic disease)' ELSE '' END), ' || ',
      (CASE WHEN ${individual_taking_black_label_drug} = '1' THEN 'Black label drug' ELSE '' END), ' || ',
      (CASE WHEN ${individual_female_had_breast_cancer_screening} = '1' THEN 'Brest Cancer Screening' ELSE '' END), ' || ',
      (CASE WHEN ${individual_taking_specialty_drug} = '1' THEN 'Individual taking Specialty drugs' ELSE '' END), ' || ',
      (CASE WHEN ${individual_female_had_colon_cancer_screening} = '1' THEN 'Colon Cancer Screening' ELSE '' END), ' || ',
      (CASE WHEN ${individual_female_had_cervical_cancer_screening} = '1' THEN 'Cervical Cancer Screening' ELSE '' END), ' || ',
      (CASE WHEN ${individual_had_acute_myocardial_infarction_and_taking_beta_blocker} = '1' THEN 'Individual had Acute Myocardial Infraction & taking Beta-blocker drugs' ELSE '' END), ' || ',
      (CASE WHEN ${individual_had_diagnosis_of_diabetes_and_taking_statin_drugs} = '1' THEN 'Individual had diagnosis of Diabetes & taking STATIN drugs' ELSE '' END), ' || ',
      (CASE WHEN ${individual_had_diagnosis_of_diabetes_and_taking_antihypertensive_drugs} = '1' THEN 'Individual had diagnosis of Hypertension & taking anti-hypertensive drugs' ELSE '' END))
      ;;
  }

  measure: compliant_hedis_measures_list {
    label: "Risk Factor Identified"
    sql: LISTAGG(DISTINCT ${compliant_measures_list},  ' || ') ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
        {% if word <> '' %}
        <li>{{ word }}</li>
        {% endif %}
      {% endfor %} ;;
  }

#Cancer Screening Rate for PHM
  measure: Breast_Cancer_Screening_Rate{
    type: number
    value_format: "0.0\%"
    label: "Breast Cancer Screening Rate"
    sql: ${individual_female_had_breast_cancer_screening_patients}/NULLIF(${individual_female_had_breast_cancer_screening_eligible_patients},0)*100 ;;
  }

  measure: Cervical_Cancer_Screening_Rate{
    type: number
    value_format: "0.0\%"
    label: "Cervical Cancer Screening Rate"
    sql: ${individual_female_had_cervical_cancer_screening_patients}/NULLIF(${individual_female_had_cervical_cancer_screening_eligible_patients},0)*100 ;;
  }

  measure: Colon_Cancer_Screening_Rate{
    type: number
    value_format: "0.0\%"
    label: "Colon Cancer Screening Rate"
    sql: ${individual_female_had_colon_cancer_screening_patients}/NULLIF(${individual_female_had_colon_cancer_screening_eligible_patients},0)*100 ;;
  }

}
