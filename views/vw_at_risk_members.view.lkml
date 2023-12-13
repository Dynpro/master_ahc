
view: vw_at_risk_members {
  derived_table: {
    sql: select * from SCH_AHC_CRISP_REGIONAL.VW_AT_RISK_MEMBERS
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: unique_id {
    type: string
    label: "Unique Id"
    sql: ${TABLE}."Unique Id" ;;
  }

  dimension: member_first_name {
    type: string
    label: "Member First Name"
    sql: ${TABLE}."Member First Name" ;;
  }

  dimension: member_last_name {
    type: string
    label: "Member Last Name"
    sql: ${TABLE}."Member Last Name" ;;
  }

  dimension: dob {
    type: date
    label: "DOB"
    sql: ${TABLE}."DOB" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."Gender" ;;
  }

  dimension: relationship_to_employee {
    type: string
    label: "Relationship To Employee"
    sql: ${TABLE}."Relationship To Employee" ;;
  }

  dimension: hra_high_risk {
    type: string
    label: "HRA High Risk"
    sql: null ;;
  }


  dimension: new_diagnoses {
    type: string
    sql: ${TABLE}."NEW_DIAGNOSES" ;;
  }

  dimension: new_medications {
    type: string
    sql: ${TABLE}."NEW_MEDICATIONS" ;;
  }

  dimension: opioid_medications {
    type: string
    sql: ${TABLE}."OPIOID_MEDICATIONS" ;;
  }

  dimension: mpr_below_100 {
    type: string
    label: "MPR Below 100"
    sql:  ${TABLE}."MPR_BELOW_100" ;;
  }

  dimension: specialty_medications {
    type: string
    sql: ${TABLE}."SPECIALTY_MEDICATIONS" ;;
  }

  dimension: vital_sign_average_red_zone {
    type: string
    sql: ${TABLE}."VITAL_SIGN_AVERAGE_RED_ZONE" ;;
  }

  dimension: inpatient_hospitalization {
    type: string
    sql: ${TABLE}."INPATIENT_HOSPITALIZATION" ;;
  }

  dimension: emergency_room {
    type: string
    sql: ${TABLE}."EMERGENCY_ROOM" ;;
  }

  dimension: urgent_care {
    type: string
    sql: ${TABLE}."URGENT_CARE" ;;
  }

  dimension: surgical_and_diagnostic {
    type: string
    sql: ${TABLE}."SURGICAL_AND_DIAGNOSTIC" ;;
  }

  dimension: social_determinants_of_health {
    type: string
    sql: ${TABLE}."SOCIAL_DETERMINANTS_OF_HEALTH" ;;
  }

  dimension: medical_average_spend_yearly {
    type: number
    sql: ${TABLE}."MEDICAL_AVERAGE_SPEND_YEARLY" ;;
  }

  dimension: pharmacy_average_spend_yearly {
    type: number
    sql: ${TABLE}."PHARMACY_AVERAGE_SPEND_YEARLY" ;;
  }

  dimension: health_score_decreases {
    type: string
    sql: ${TABLE}."HEALTH_SCORE_DECREASES" ;;
  }

  dimension: obesity {
    type: string
    sql: CASE WHEN OBESITY LIKE '%YES%' THEN 'YES'
         WHEN OBESITY = 'YES' THEN 'YES'
         WHEN OBESITY = 'NO' THEN 'NO'
         ELSE NULL
         END  ;;
  }

  dimension: waist_circumference {
    type: string
    sql: ${TABLE}."WAIST_CIRCUMFERENCE" ;;
  }

  dimension: total_cholesterol {
    type: string
    sql: CASE WHEN TOTAL_CHOLESTEROL LIKE '%YES%' THEN 'YES'
         WHEN TOTAL_CHOLESTEROL = 'YES' THEN 'YES'
         WHEN TOTAL_CHOLESTEROL = 'NO' THEN 'NO'
         ELSE NULL
         END ;;
  }

  dimension: triglycerides {
    type: string
    sql: CASE WHEN TRIGLYCERIDES LIKE '%YES%' THEN 'YES'
         WHEN TRIGLYCERIDES = 'YES' THEN 'YES'
         WHEN TRIGLYCERIDES = 'NO' THEN 'NO'
         ELSE NULL
         END ;;
  }

  dimension: hdl {
    type: string
    label: "HDL"
    sql: CASE WHEN HDL LIKE '%YES%' THEN 'YES'
         WHEN HDL = 'YES' THEN 'YES'
         WHEN HDL = 'NO' THEN 'NO'
         ELSE NULL
         END  ;;
  }

  dimension: hba1_c {
    type: string
    label: "HbA1c"
    sql: CASE WHEN HBA1C LIKE '%YES%' THEN 'YES'
         WHEN HBA1C = 'YES' THEN 'YES'
         WHEN HBA1C = 'NO' THEN 'NO'
         ELSE NULL
         END  ;;
  }

  dimension: blood_sugar_fasting {
    type: string
    label: "Blood Sugar (Fasting)"
    sql:  CASE WHEN BLOOD_SUGAR_FASTING LIKE '%YES%' THEN 'YES'
         WHEN BLOOD_SUGAR_FASTING = 'YES' THEN 'YES'
         WHEN BLOOD_SUGAR_FASTING = 'NO' THEN 'NO'
         ELSE NULL
         END ;;
  }

  dimension: metabolic_syndrome {
    type: string
    sql: ${TABLE}."METABOLIC_SYNDROME" ;;
  }

  dimension: adult_access_to_preventiveambulatory_health_services {
    type: string
    label: "Adult access to Preventive/Ambulatory health services"
    sql: ${TABLE}."ADULT_ACCESS_TO_PREVENTIVE/AMBULATORY_HEALTH_SERVICES" ;;
  }

  dimension: adult_bmi_assessment {
    type: string
    label: "Adult BMI assessment"
    sql: ${TABLE}."ADULT_BMI_ASSESSMENT" ;;
  }

  dimension: antidepressant_medication_management {
    type: string
    sql: ${TABLE}."ANTIDEPRESSANT_MEDICATION_MANAGEMENT" ;;
  }

  dimension: asthma_medication_ratio {
    type: string
    sql: ${TABLE}."ASTHMA_MEDICATION_RATIO" ;;
  }

  dimension: breast_cancer_screening {
    type: string
    sql: ${TABLE}."BREAST_CANCER_SCREENING" ;;
  }

  dimension: controlling_high_blood_pressure {
    type: string
    sql: ${TABLE}."CONTROLLING_HIGH_BLOOD_PRESSURE" ;;
  }

  dimension: cervical_cancer_screening {
    type: string
    sql: ${TABLE}."CERVICAL_CANCER_SCREENING" ;;
  }

  dimension: comprenhensive_diabetes_care {
    type: string
    label: "Comprehensive Diabetes care"
    sql: ${TABLE}."COMPRENHENSIVE_DIABETES_CARE" ;;
  }

  dimension: colorectal_cancer_screening {
    type: string
    sql: ${TABLE}."COLORECTAL_CANCER_SCREENING" ;;
  }

  dimension: medicatione_management_for_people_with_asthma {
    type: string
    sql: ${TABLE}."MEDICATIONE_MANAGEMENT_FOR_PEOPLE_WITH_ASTHMA" ;;
  }

  dimension: osteoporosis_management_in_women_who_had_a_fracture {
    type: string
    sql: ${TABLE}."OSTEOPOROSIS_MANAGEMENT_IN_WOMEN_WHO_HAD_A_FRACTURE" ;;
  }

  dimension: persistence_of_beta_blocker_treatment_after_a_heart_attack {
    type: string
    sql: ${TABLE}."PERSISTENCE_OF_BETA_BLOCKER_TREATMENT_AFTER_A_HEART_ATTACK" ;;
  }

  dimension: pharmacotherapy_management_of_copd_exacerbation {
    type: string
    label: "Pharmacotherapy management of COPD exacerbation"
    sql: ${TABLE}."PHARMACOTHERAPY_MANAGEMENT_OF_COPD_EXACERBATION" ;;
  }

  dimension: diabetes_monitoring_for_people_with_diabetes_and_schizophrenia {
    type: string
    sql: ${TABLE}."DIABETES_MONITORING_FOR_PEOPLE_WITH_DIABETES_AND_SCHIZOPHRENIA" ;;
  }

  dimension: use_of_spirometry_testing_in_the_assessment_and_diagnosis_of_copd {
    type: string
    label: "Use of Spirometry testing in the assessment and diagnosis of COPD"
    sql: ${TABLE}."USE_OF_SPIROMETRY_TESTING_IN_THE_ASSESSMENT_AND_DIAGNOSIS_OF_COPD" ;;
  }

  dimension: fda_black_box_drug {
    type: string
    label: "FDA Black Box Drug"
    sql: ${TABLE}."FDA_BLACK_BOX_DRUG" ;;
  }

  dimension: cardiovascular_statin_drug {
    type: string
    label: "Cardiovascular - Statin Drug"
    sql: ${TABLE}."CARDIOVASCULAR_STATIN_DRUG" ;;
  }

  dimension: diabetes_ace_inhibitor_arb_drug {
    type: string
    label: "Diabetes - ACE Inhibitor / ARB Drug"
    sql: ${TABLE}."DIABETES_ACE_INHIBITOR_ARB_DRUG" ;;
  }

  dimension: diabetes_antihypertensive_drug {
    type: string
    label: "Diabetes - ANTIHYPERTENSIVE Drug"
    sql: ${TABLE}."DIABETES_ANTIHYPERTENSIVE_DRUG" ;;
  }

  dimension: diabetes_retinopathy_screening {
    type: string
    label: "Diabetes - RETINOPATHY Screening"
    sql: ${TABLE}."DIABETES_RETINOPATHY_SCREENING" ;;
  }

  dimension: diabetes_statin_drug {
    type: string
    label: "Diabetes - STATIN Drug"
    sql: ${TABLE}."DIABETES_STATIN_DRUG" ;;
  }

  dimension: diabetes_test_strips {
    type: string
    label: "Diabetes - Test Strips"
    sql: ${TABLE}."DIABETES_TEST_STRIPS" ;;
  }

  dimension: diabetes_podiatry_screening {
    type: string
    label: "Diabetes - Podiatry Screening"
    sql: ${TABLE}."DIABETES_PODIATRY_SCREENING" ;;
  }

  dimension: risk_group_1 {
    type: string
    label: "Risk Group 1"
    sql: ${TABLE}."RISK_GROUP_1" ;;
  }

  dimension: risk_group_2 {
    type: string
    label: "Risk Group 2"
    sql: ${TABLE}."RISK_GROUP_2" ;;
  }

  dimension: risk_group_3 {
    type: string
    label: "Risk Group 3"
    sql: ${TABLE}."RISK_GROUP_3" ;;
  }

  dimension: risk_group_4 {
    type: string
    label: "Risk Group 4"
    sql: ${TABLE}."RISK_GROUP_4" ;;
  }

  dimension: risk_group_5 {
    type: string
    label: "Risk Group 5"
    sql: ${TABLE}."RISK_GROUP_5" ;;
  }

  dimension: risk_group_6 {
    type: string
    label: "Risk Group 6"
    sql: ${TABLE}."RISK_GROUP_6" ;;
  }

  dimension: risk_group_7 {
    type: string
    label: "Risk Group 7"
    sql: ${TABLE}."RISK_GROUP_7" ;;
  }

  dimension: drug_cost_greator_than_400 {
    type: string
    label: "Drug Cost >$400"
    sql: ${TABLE}."DRUG_COST_GREATOR_THAN_400";;
  }

  dimension: catastrophic_claims {
    type: string
    sql: CASE WHEN CATASTROPHIC_CLAIMS LIKE '%YES%' THEN 'YES'
         WHEN CATASTROPHIC_CLAIMS = 'YES' THEN 'YES'
         WHEN CATASTROPHIC_CLAIMS = 'NO' THEN 'NO'
         ELSE NULL
         END ;;
  }

  dimension: er_visit_but_no_subsequent_inpatient_visit {
    type: string
    label: "ER Visit but No Subsequent Inpatient Visit"
    sql: ${TABLE}."ER_VISIT_BUT_NO_SUBSEQUENT_INPATIENT_VISIT" ;;
  }

  dimension: inpatient_hospital_visit {
    type: string
    sql: ${TABLE}."INPATIENT_HOSPITAL_VISIT" ;;
  }

  dimension: myocardial_infraction_and_beta_blocker_drug {
    type: string
    label: "Myocardial Infraction & Beta-Blocker Drug"
    sql: ${TABLE}."MYOCARDIAL_INFRACTION_AND_BETA_BLOCKER_DRUG" ;;
  }

  dimension: primary_care_physician_visit {
    type: string
    sql: ${TABLE}."PRIMARY_CARE_PHYSICIAN_VISIT" ;;
  }

  dimension: participant_flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: participant_program_name {
    type: string
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME" ;;
  }

  dimension: elig_status {
    type: string
    sql: ${TABLE}."ELIG_STATUS" ;;
  }

  dimension: on_board_date {
    type: date
    sql: ${TABLE}."ON_BOARD_DATE" ;;
  }

  dimension: file_input_date {
    type: date
    sql: ${TABLE}."FILE_INPUT_DATE" ;;
  }

  dimension_group: FILE_INPUT_DATE {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    label: "FILE INPUT DATE"
    sql: DATEADD(MONTH,1,${TABLE}."FILE_INPUT_DATE") ;;
  }

  dimension:PARTICIPANT_FILE_MONTH{
    type: string
    label: "File Input Month"
    sql: ${FILE_INPUT_DATE_month} ;;
  }

  dimension: service_year {
    type: string
    sql: ${TABLE}."SERVICE_YEAR" ;;
  }

  dimension: service_year_new {
    type: number
    sql: ${TABLE}."SERVICE_YEAR" ;;
  }

  dimension_group: SERVICE{
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    label: "Service"
    drill_fields: [SERVICE_year, SERVICE_quarter, SERVICE_month, SERVICE_raw]
    sql: ${TABLE}."SERVICE_YEAR" ;;
  }

  dimension: medical_paid_amount_above_average {
    type: string
    sql: CASE WHEN ${TABLE}."MEDICAL_PAID_AMOUNT_ABOVE_AVERAGE" = 'Greater than Year Average Spend' THEN 'Yes'
      ELSE 'No'
      END;;
  }

  dimension: pharmacy_paid_amount_above_average {
    type: string
    sql: CASE WHEN  ${TABLE}."PHARMACY_PAID_AMOUNT_ABOVE_AVERAGE" = 'Greater than Year Average Spend' THEN 'Yes'
        ELSE 'No'
            END ;;
  }

  measure: new_medications1 {
    label: "New Medications"
    sql: LISTAGG(DISTINCT ${new_medications}, ' || ') within group (order by ${new_medications} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: new_diagnosis1 {
    label: "New Diagnosis"
    sql: LISTAGG(DISTINCT ${new_diagnoses}, ' || ') within group (order by ${new_diagnoses} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }



  measure: surgical_and_diagnostic1 {
    label: "Surgical and Diagnostic"
    sql: LISTAGG(DISTINCT ${surgical_and_diagnostic}, ' || ') within group (order by ${surgical_and_diagnostic} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: opioid_medications1 {
    label: "Opioid Medications"
    sql: LISTAGG(DISTINCT ${opioid_medications}, ' || ') within group (order by ${opioid_medications} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: specialty_medications1 {
    label: "Specialty Medications"
    sql: LISTAGG(DISTINCT ${specialty_medications}, ' || ') within group (order by ${specialty_medications} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: vital_sign_average_red_zone1 {
    label: "Vital Sign Average Red Zone"
    sql: LISTAGG(DISTINCT ${vital_sign_average_red_zone}, ' || ') within group (order by ${vital_sign_average_red_zone} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: social_determinants_of_health1 {
    label: "Social Determination of Health"
    sql: LISTAGG(DISTINCT ${social_determinants_of_health}, ' || ') within group (order by ${social_determinants_of_health} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  measure: drug_cost_greator_than_fourhundred {
    type: string
    label: "Drug Cost >$400"
    sql: LISTAGG(DISTINCT ${drug_cost_greator_than_400}, ' || ') within group (order by ${drug_cost_greator_than_400} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  dimension: care_manager {
    type: string
    sql: ${TABLE}."CARE_MANAGER" ;;
  }

  set: detail {
    fields: [
      unique_id,
      member_first_name,
      member_last_name,
      dob,
      gender,
      relationship_to_employee,
      hra_high_risk,
      new_diagnoses,
      new_medications,
      opioid_medications,
      mpr_below_100,
      specialty_medications,
      vital_sign_average_red_zone,
      inpatient_hospitalization,
      emergency_room,
      urgent_care,
      surgical_and_diagnostic,
      social_determinants_of_health,
      medical_average_spend_yearly,
      pharmacy_average_spend_yearly,
      health_score_decreases,
      obesity,
      waist_circumference,
      total_cholesterol,
      triglycerides,
      hdl,
      hba1_c,
      blood_sugar_fasting,
      metabolic_syndrome,
      adult_access_to_preventiveambulatory_health_services,
      adult_bmi_assessment,
      antidepressant_medication_management,
      asthma_medication_ratio,
      breast_cancer_screening,
      controlling_high_blood_pressure,
      cervical_cancer_screening,
      comprenhensive_diabetes_care,
      colorectal_cancer_screening,
      medicatione_management_for_people_with_asthma,
      osteoporosis_management_in_women_who_had_a_fracture,
      persistence_of_beta_blocker_treatment_after_a_heart_attack,
      pharmacotherapy_management_of_copd_exacerbation,
      diabetes_monitoring_for_people_with_diabetes_and_schizophrenia,
      use_of_spirometry_testing_in_the_assessment_and_diagnosis_of_copd,
      fda_black_box_drug,
      cardiovascular_statin_drug,
      diabetes_ace_inhibitor_arb_drug,
      diabetes_antihypertensive_drug,
      diabetes_retinopathy_screening,
      diabetes_statin_drug,
      diabetes_test_strips,
      diabetes_podiatry_screening,
      risk_group_1,
      risk_group_2,
      risk_group_3,
      risk_group_4,
      risk_group_5,
      risk_group_6,
      risk_group_7,
      drug_cost_greator_than_400,
      catastrophic_claims,
      er_visit_but_no_subsequent_inpatient_visit,
      inpatient_hospital_visit,
      myocardial_infraction_and_beta_blocker_drug,
      primary_care_physician_visit,
      participant_flag,
      participant_program_name,
      elig_status,
      on_board_date,
      file_input_date,
      service_year,
      medical_paid_amount_above_average,
      pharmacy_paid_amount_above_average,
      care_manager
    ]
  }
}
