connection: "snowflake_prod"

# include all the views
include: "/views/**/*.view"

datagroup: master_ahc_dashboards_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: master_ahc_dashboards_default_datagroup


explore: vw_medical {
  label: "Medical records"
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      LEFT(${vw_medical.reporting_year}, 4) = ${patient_diagnosis_summary.reporting_year} ;;
  }
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: vw_pharmacy {
  label: "Pharmacy records"
  join: patient_drug_summary {
    view_label: "Patient Drug Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_pharmacy.unique_id} = ${patient_drug_summary.PATIENT_ID} AND
      LEFT(${vw_pharmacy.reporting_year}, 4) = ${patient_drug_summary.reporting_year} ;;
  }
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_pharmacy.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: vw_med_and_pharma_summary_1 {
  label: "Ad Hoc Query Tool"
}

explore: ad_hoc_query_tool_medical {
  label: "Ad Hoc Query Tool_MEDICAL"
}

explore: ad_hoc_query_tool_pharmacy {
  label: "Ad Hoc Query Tool_PHARMACY"
}

explore: vw_cohort_analysis_summary_1 {
  label: "Cohort Analysis"
}

explore: vw_risk_group_migration {
  label: "Risk Group Migration"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_risk_group_migration.Unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_risk_group_migration.Unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      ${vw_risk_group_migration.File_year} = ${patient_diagnosis_summary.reporting_year} ;;
  }
}

explore: vw_risk_group_med_pharma_summary {
  label: "Risk Group - Med & Pharma summary"
}

explore: vw_medication_possession_ratio {
  label: "Medication Possession Ratio"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medication_possession_ratio.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medication_possession_ratio.unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      ${vw_medication_possession_ratio.year} = ${patient_diagnosis_summary.reporting_year} ;;
  }
}

explore: vw_preventive_screening {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_preventive_screening.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_preventive_screening.unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      ${vw_preventive_screening.year} = ${patient_diagnosis_summary.reporting_year} ;;
  }
  label: "Preventive Screening"
}

explore: hedis_measure {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${hedis_measure.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${hedis_measure.unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      ${hedis_measure.year} = ${patient_diagnosis_summary.reporting_year} ;;
  }
  label: "HEDIS Measures"
}

explore: ebr_measures {
  label: "EBR Measures"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ebr_measures.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    view_label: "Patient Diagnosis Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ebr_measures.unique_id} = ${patient_diagnosis_summary.PATIENT_ID} AND
      ${ebr_measures.year} = ${patient_diagnosis_summary.reporting_year} ;;
  }
}

explore: vw_patient_demographics {}
explore: vw_predictive_healthscore_index {}
explore: icd_infographics {}
explore: cpt_infographics {}
