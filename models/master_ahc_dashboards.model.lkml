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
  join: vw_risk_group_migration {
    view_label: "Risk Group Migration"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${vw_risk_group_migration.Unique_id} AND
      ${vw_medical.diagnosis_year} = ${vw_risk_group_migration.File_year};;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
  join: vw_vital_alert {
    view_label: "Vital Report"
    type: left_outer
    relationship: many_to_many
    sql_on: ${vw_medical.unique_id} = ${vw_vital_alert.unique_id} AND
      ${vw_medical.diagnosis_year} = ${vw_vital_alert.date_year};;
  }

  join : patient_migration_across_years_summary{
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${patient_migration_across_years_summary.UNIQUE_ID}  ;;
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_pharmacy.unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
  join: vw_vital_alert {
    view_label: "Vital Report"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_pharmacy.unique_id} = ${vw_vital_alert.unique_id} AND
      LEFT(${vw_pharmacy.reporting_year}, 4) = ${vw_vital_alert.date_year};;
  }
  join: vw_stg_tab_pharma_classes {
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_pharmacy.drug_code} = ${vw_stg_tab_pharma_classes.ndc} ;;
  }
}

explore: vw_med_and_pharma_summary_1 {
  label: "Ad Hoc Query Tool"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_med_and_pharma_summary_1.PATIENT_ID} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_med_and_pharma_summary_1.PATIENT_ID} = ${vw_participant_trigger.unique_id} ;;
  }
}

explore: ad_hoc_query_tool_medical {
  label: "Ad Hoc Query Tool_MEDICAL"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${ad_hoc_query_tool_medical.PATIENT_ID} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ad_hoc_query_tool_medical.PATIENT_ID} = ${vw_participant_trigger.unique_id} ;;
  }
}

explore: ad_hoc_query_tool_pharmacy {
  label: "Ad Hoc Query Tool_PHARMACY"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${ad_hoc_query_tool_pharmacy.Unique_Id_P} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ad_hoc_query_tool_pharmacy.Unique_Id_P} = ${vw_participant_trigger.unique_id} ;;
  }
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_risk_group_migration.Unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
  join: patient_all_medical_pharmacy_summary {
    view_label: "Patient Medical & Pharmacy Summary"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${vw_risk_group_migration.Unique_id} AND
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${vw_risk_group_migration.File_year} ;;
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medication_possession_ratio.unique_id} = ${vw_participant_trigger.unique_id} ;;
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_preventive_screening.unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${hedis_measure.unique_id} = ${vw_participant_trigger.unique_id} AND
      ${hedis_measure.year} = ${vw_participant_trigger.Plan_Year} ;;

  }
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
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ebr_measures.unique_id} = ${vw_participant_trigger.unique_id} AND
      ${ebr_measures.year} = ${vw_participant_trigger.Plan_Year} ;;
  }
}
#primary explore vw_patient_demographics

explore: vw_patient_demographics {
  join: vw_risk_group_migration {
    view_label: "Risk Group Migration"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_patient_demographics.unique_id} = ${vw_risk_group_migration.Unique_id} ;;
  }
  join: patient_all_medical_pharmacy_summary  {
    view_label: "Patient Medical & Pharmacy Summary"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_patient_demographics.unique_id} = ${patient_all_medical_pharmacy_summary.PATIENT_ID} and
      ${vw_risk_group_migration.File_year} =  ${patient_all_medical_pharmacy_summary.reporting_year};;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_patient_demographics.unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
  join : chronic_cat_list{
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_patient_demographics.unique_id} = ${chronic_cat_list.PATIENT_ID}  ;;
  }
  join:vw_medical {
    view_label: "Medical records"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_medical.unique_id} = ${vw_patient_demographics.unique_id};;
  }
  join: vw_pharmacy {
    view_label: "Pharmacy records"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_pharmacy.unique_id} = ${vw_patient_demographics.unique_id};;
  }
  join: vw_medication_possession_ratio {
    view_label: "Medication Possession Ratio"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_medication_possession_ratio.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: hedis_measure {
    view_label: "HEDIS Measures"
    type: left_outer
    relationship: one_to_many
    sql_on: ${hedis_measure.unique_id} = ${vw_patient_demographics.unique_id};;
  }
  join: ebr_measures {
    view_label: "EBR Measures"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ebr_measures.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_med_and_pharma_summary_1 {
    view_label: "Ad Hoc Query Tool"
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_med_and_pharma_summary_1.Unique_Id_P} = ${vw_patient_demographics.unique_id} ;;
  }
  join: ad_hoc_query_tool_medical {
    view_label: "Ad Hoc Query Tool_MEDICAL"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ad_hoc_query_tool_medical.PATIENT_ID} = ${vw_patient_demographics.unique_id} ;;
  }
  join: ad_hoc_query_tool_pharmacy {
    view_label: "Ad Hoc Query Tool_PHARMACY"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ad_hoc_query_tool_pharmacy.Unique_Id_P} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_predictive_healthscore_index {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_predictive_healthscore_index.patient_id_l} = ${vw_patient_demographics.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l}=${patient_all_medical_pharmacy_summary.reporting_year};;
  }
  join: vw_plan_year {
    type: left_outer
    relationship: one_to_one
    sql_on:${vw_patient_demographics.unique_id} =${vw_plan_year.unique_id} ;;
  }
  join: patient_yearly_total_avg_spend_comparison {
    type: left_outer
    relationship: one_to_many
    sql_on: ${patient_yearly_total_avg_spend_comparison.patients_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_vital_alert {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_vital_alert.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: patient_migration_across_years_summary {
    type: left_outer
    relationship: one_to_many
    sql_on: ${patient_migration_across_years_summary.UNIQUE_ID} = ${vw_patient_demographics.unique_id} ;;
  }
  join: compliance_summary {
    type: left_outer
    relationship: one_to_many
    sql_on: ${compliance_summary.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_combine_data {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_combine_data.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_chronicity_details {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_chronicity_details.UNIQUE_ID} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: vw_plan_year {}
explore: vw_chronic_list {}
explore: hedis_measures_dis {}

explore: vw_predictive_healthscore_index {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} = ${vw_patient_demographics.unique_id} ;;
  }
# FOR DATA SCIENCE
  join: vw_chronic_category_test {
    type: inner
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${vw_chronic_category_test.patient_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_chronic_category_test.year_file_date_l};;
  }

# cpt,icd infographics changes
  join: icd_infographics {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${icd_infographics.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${icd_infographics.year_file_date_l};;
  }
  join: cpt_infographics {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${cpt_infographics.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${cpt_infographics.year_file_date_l};;
  }

  join: vw_chronicity_details {
    type: inner
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${vw_chronicity_details.UNIQUE_ID} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_chronicity_details.BASE_YEAR};;
  }
  # for plan Year
  join: vw_plan_year {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${vw_plan_year.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_plan_year.file_year};;
  }
#for chronic category list
  join: vw_chronic_list {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${vw_chronic_list.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_chronic_list.file_year};;
  }
}

explore: icd_infographics {}
explore: cpt_infographics {}
explore: vw_chronic_category_test {}
explore: vw_chronicity_details {}

explore: vw_participant_trigger {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_participant_trigger.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: patient_all_medical_pharmacy_summary { #designed for Claim Analysis summary dashboard.
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${vw_participant_trigger.unique_id}  ;;
  }
  join: vw_predictive_healthscore_index {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${patient_all_medical_pharmacy_summary.PATIENT_ID} AND
      ${vw_predictive_healthscore_index.year_file_date_l} = ${patient_all_medical_pharmacy_summary.reporting_year};;
  }
  join: vw_plan_year {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${patient_all_medical_pharmacy_summary.PATIENT_ID} =  ${vw_plan_year.unique_id} and
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${vw_plan_year.file_year};;
  }
  join: vw_chronicity_details {
    type: inner
    relationship: one_to_one
    sql_on:  ${patient_all_medical_pharmacy_summary.PATIENT_ID} =  ${vw_chronicity_details.UNIQUE_ID} and
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${vw_chronicity_details.BASE_YEAR};;
  }
}

explore:patient_yearly_total_avg_spend_comparison{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_yearly_total_avg_spend_comparison.patients_id} = ${vw_patient_demographics.unique_id};;
  }
}

explore : vw_vital_alert{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_vital_alert.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: patient_migration_across_years_summary {
  label: "Patient Yearly Migration summary"
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_migration_across_years_summary.UNIQUE_ID} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: hedis_compliance_percent{}

explore: compliance_summary{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${compliance_summary.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore:chronic_cat_list {}

explore: vw_combine_data {
  join : chronic_cat_list{
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_combine_data.unique_id} = ${chronic_cat_list.PATIENT_ID}  ;;
  }
  join: vw_participant_trigger {
    view_label: "Participant Trigger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_combine_data.unique_id} = ${vw_participant_trigger.unique_id} ;;
  }
  join: vw_predictive_healthscore_index {
    type: left_outer
    relationship: one_to_one
    sql_on:${vw_predictive_healthscore_index.patient_id_l} =${vw_combine_data.unique_id} AND
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_combine_data.reporting_year};;
  }
  join: vw_plan_year {
    type: left_outer
    relationship: one_to_one
    sql_on:${vw_combine_data.unique_id} =${vw_plan_year.unique_id} and
      ${vw_combine_data.reporting_year} = ${vw_plan_year.file_year};;
  }
  join: vw_chronicity_details {
    type: inner
    relationship: one_to_one
    sql_on:${vw_combine_data.unique_id} =${vw_chronicity_details.UNIQUE_ID} and
      ${vw_combine_data.reporting_year} = ${vw_chronicity_details.BASE_YEAR};;
  }
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_combine_data.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_risk_group_migration {
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_combine_data.unique_id} = ${vw_risk_group_migration.Unique_id} and
      ${vw_combine_data.reporting_year} = ${vw_risk_group_migration.File_year};;
  }
}

explore: vw_stg_tab_pharma_classes {}
explore: patient_diagnosis_summary {}
explore: patient_drug_summary {}
