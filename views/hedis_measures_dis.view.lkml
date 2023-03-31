view: hedis_measures_dis {
  sql_table_name: "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."FINAL_HEDIS_MEASURES"
    ;;

  dimension: final_tag {
    type: string
    label: "Final Tag"
    sql: ${TABLE}."FINAL_TAG" ;;
  }

  dimension:  final_name {
    type: string
    sql:
     CASE WHEN ${TABLE}."FINAL_TAG"  = 'AMR_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Asthma Medication Ratio'
          WHEN ${TABLE}."FINAL_TAG"  = 'AMR_NON_Comp_2022' THEN 'Asthma Medication Ratio'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_Comp_2022' THEN 'Blood Pressure Control for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Blood Pressure Control for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_NON_Comp_2022' THEN 'Blood Pressure Control for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_Comp_2022' THEN 'Controling High Blood Pressure'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Controling High Blood Pressure'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_NON_Comp_2022' THEN 'Controling High Blood Pressure'
          WHEN ${TABLE}."FINAL_TAG"  = 'EED_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Eye Exam for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'EED_NON_Comp_2022' THEN 'Eye Exam for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_Comp_2022' THEN 'Hemoglobin A1C Control for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Hemoglobin A1C Control for Patients with Diabetes'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_NON_Comp_2022' THEN 'Hemoglobin A1C Control for Patients with Diabetes'
          ELSE 'Asthma Medication Ratio'
          END ;;
  }
  dimension:  final_tag1 {
    type: string
    sql:
     CASE WHEN ${TABLE}."FINAL_TAG"  = 'AMR_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Asthma Medication Ratio Eligible but no Compliancy and no Disease Record'
          WHEN ${TABLE}."FINAL_TAG"  = 'AMR_NON_Comp_2022' THEN 'Asthma Medication Ratio no Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_Comp_2022' THEN 'Blood Pressure Control for Patients with Diabetes Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Blood Pressure Control for Patients with Diabetes Eligible but no Compliancy and no Disease Record'
          WHEN ${TABLE}."FINAL_TAG"  = 'BPD_NON_Comp_2022' THEN 'Blood Pressure Control for Patients with Diabetes no Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_Comp_2022' THEN 'Controling High Blood Pressure Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Controling High Blood Pressure Eligible but no Compliancy and no Disease Record'
          WHEN ${TABLE}."FINAL_TAG"  = 'CBP_NON_Comp_2022' THEN 'Controling High Blood Pressure no Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'EED_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Eye Exam for Patients with Diabetes Eligible but no Compliancy and no Disease Record'
          WHEN ${TABLE}."FINAL_TAG"  = 'EED_NON_Comp_2022' THEN 'Eye Exam for Patients with Diabetes no Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_Comp_2022' THEN 'Hemoglobin A1C Control for Patients with Diabetes Compliancy in 2021'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_ELIGIBLE_BUT_NO_COMP_DEC_RECORD' THEN 'Hemoglobin A1C Control for Patients with Diabetes Eligible but no Compliancy and no Disease Record'
          WHEN ${TABLE}."FINAL_TAG"  = 'HPD_NON_Comp_2022' THEN 'Hemoglobin A1C Control for Patients with Diabetes no Compliancy in 2021'
          ELSE 'Non'
          END ;;
  }

  measure: unique_id_count {
    type: sum
    label: "Unique Id Count"
    sql: ${TABLE}."UNIQUE_ID_COUNT" ;;
  }

  measure: scale_score {
    type: sum
    label: "Average Health Score"
    sql: ${TABLE}."AVG_HEALTH_SCORE" ;;
  }

  measure: average_predicted_amount{
    type: sum
    label: "Average Predicted Amount"
    sql: ${TABLE}."AVG_PREDICTED_PAID_AMOUNT" ;;
    value_format: "#,##0.00"
  }

  measure: er_visit_2021 {
    type: sum
    label: "ER Visit 2021"
    sql: ${TABLE}."ER_VISIT_2021" ;;

  }

  measure: er_visit_2022 {
    type: sum
    label: "ER Visit 2022"
    sql: ${TABLE}."ER_VISIT_2022" ;;

  }

  dimension: redused_er_visit{
    type: number
    label: "Redused ER Visit"
    sql: ${TABLE}."ER_REDUCED_PERCENTAGE"*100 ;;
    value_format: "0\%"
  }


  measure: in_patient_visit_2021{
    type: sum
    label: "In Patient Visit 2021 "
    sql: ${TABLE}."IN_PATIENT_VISIT_2021" ;;
  }

  measure: in_patient_visit_2022{
    type: sum
    label: "In Patient Visit 2022 "
    sql: ${TABLE}."IN_PATIENT_VISIT_2022" ;;
  }

  measure: out_patient_visit_2021{
    type: sum
    label: "Out Patient Visit 2021 "
    sql: ${TABLE}."OUT_PATIENT_VISIT_2021" ;;
  }

  measure: out_patient_visit_2022{
    type: sum
    label: "Out Patient Visit 2022 "
    sql: ${TABLE}."OUT_PATIENT_VISIT_2022" ;;
  }

  measure: primary_care_service_2021{
    type: sum
    label: "Primary Care Service 2021"
    sql: ${TABLE}."PRIMARY_CARE_SERVICE_2021" ;;
  }

  measure: primary_care_service_2022{
    type: sum
    label: "Primary Care Service 2022"
    sql: ${TABLE}."PRIMARY_CARE_SERVICE_2022" ;;
  }

  measure: icd_avoidable_er_2021{
    type: sum
    label: "ICD Avoidable ER 2021"
    sql: ${TABLE}."ICD_AVOIDABLE_ER_2021" ;;
  }

  measure: icd_avoidable_er_2022{
    type: sum
    label: "ICD Avoidable ER 2022"
    sql: ${TABLE}."ICD_AVOIDABLE_ER_2022" ;;
  }

  dimension: icd_avoidable_er_reducable{
    type: number
    label: "ICD Avoidable ER Reducable"
    sql: ${TABLE}."ICD_AVOIDABLE_REDUCED_PERCENTAGE"*100 ;;
    value_format: "0\%"
  }

  measure: total_employer_paid_amt_2021{
    type: sum
    label: "Total Employer Paid Amount 2021"
    sql: ${TABLE}."TOTAL_EMPLOYER_PAID_AMT_2021" ;;
    value_format: "#,##0.00"
  }

  measure: total_employer_paid_amt_2022{
    type: sum
    label: "Total Employer Paid Amount 2022"
    sql: ${TABLE}."TOTAL_EMPLOYER_PAID_AMT_2022" ;;
    value_format: "#,##0.00"
  }


  measure: average_amount_2021{
    type: sum
    label: "Average Amount 2021"
    sql: ${TABLE}."AVG_AMT_2021" ;;
    value_format: "#,##0.00"
  }

  measure: average_amount_2022{
    type: sum
    label: "Average Amount 2022"
    sql: ${TABLE}."AVG_AMT_2022" ;;
    value_format: "#,##0.00"
  }

  dimension: flag {
    type: string
    label: "Flag"
    sql: ${TABLE}."FLAG" ;;
  }

  dimension: average_amount_reduced_percentage{
    type: number
    label:"Average Amount Reduced Percentage"
    sql: ${TABLE}."AVG_AMT_REDUCED_PERCENTAGE"*100 ;;
    value_format: "0\%"
  }

}
