  connection: "snowflake_prod"

# include all the views
include: "/views/**/*.view"

datagroup: crisp_regional_dashboards_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: crisp_regional_dashboards_default_datagroup


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
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${vw_vital_alert.unique_id} AND
      ${vw_medical.diagnosis_year} = ${vw_vital_alert.date_year};;
  }
  join : patient_migration_across_years_summary{
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_medical.unique_id} = ${patient_migration_across_years_summary.UNIQUE_ID}  ;;
  }
  join: zone_filter {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zone_filter.unique_id} = ${vw_medical.unique_id} ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_medical.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${vw_medical.Year} = ${medical_expense_top_and_bottom.year} ;;
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
  join: zone_filter {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zone_filter.unique_id} = ${vw_pharmacy.unique_id} ;;
  }
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_pharmacy.unique_id} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${vw_pharmacy.Year} = ${pharmacy_expense_top_and_bottom.year}  ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_med_and_pharma_summary_1.PATIENT_ID} = ${medical_expense_top_and_bottom.unique_id} and
      ${vw_med_and_pharma_summary_1.PAID_YEAR} = ${medical_expense_top_and_bottom.year};;
  }
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_med_and_pharma_summary_1.Unique_Id_P} = ${pharmacy_expense_top_and_bottom.unique_id}  and
      ${vw_med_and_pharma_summary_1.date_filled_year} = ${pharmacy_expense_top_and_bottom.year} ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${ad_hoc_query_tool_medical.PATIENT_ID} = ${medical_expense_top_and_bottom.unique_id}  AND
      ${ad_hoc_query_tool_medical.DIAGNOSIS_DATE_year} = ${medical_expense_top_and_bottom.year};;
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
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${ad_hoc_query_tool_pharmacy.Unique_Id_P} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${ad_hoc_query_tool_pharmacy.SERVICE_DATE_year} = ${pharmacy_expense_top_and_bottom.year}  ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_risk_group_migration.Unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${vw_risk_group_migration.File_year} = ${medical_expense_top_and_bottom.year} ;;
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
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_medication_possession_ratio.unique_id} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${vw_medication_possession_ratio.year} = ${pharmacy_expense_top_and_bottom.year}  ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_preventive_screening.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${vw_preventive_screening.year} = ${medical_expense_top_and_bottom.year} ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${hedis_measure.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${hedis_measure.year} = ${medical_expense_top_and_bottom.year} ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${ebr_measures.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${ebr_measures.year} = ${medical_expense_top_and_bottom.year} ;;
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
    sql_on: ${vw_patient_demographics.unique_id}  = ${vw_vital_alert.unique_id};;
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
    sql_on: ${vw_chronicity_details.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: zone_filter {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zone_filter.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_patient_demographics.unique_id} = ${medical_expense_top_and_bottom.unique_id}  ;;
  }
  join : pharmacy_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_patient_demographics.unique_id} = ${pharmacy_expense_top_and_bottom.unique_id}  ;;
  }
  join : stg_tab_participant_data{
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_patient_demographics.unique_id} = ${stg_tab_participant_data.unique_id}  ;;
  }
  join : vw_eligibility{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_patient_demographics.unique_id} = ${vw_eligibility.unique_id}  ;;
  }
  join: Vw_Biometric_data {
    type: left_outer
    relationship: one_to_many
    sql_on: ${Vw_Biometric_data.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: hospital_visit_30_days {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_patient_demographics.unique_id} =  ${hospital_visit_30_days.unique_id} ;;
  }
  join: patient_diagnosis_summary {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_patient_demographics.unique_id} =  ${patient_diagnosis_summary.PATIENT_ID} ;;
  }
  join: patient_drug_summary {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_patient_demographics.unique_id} =  ${patient_drug_summary.PATIENT_ID} ;;
  }
  join: stg_tab_hra_demographic_info {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${vw_patient_demographics.unique_id} =  ${stg_tab_hra_demographic_info.unique_id} ;;
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
    sql_on:  ${vw_predictive_healthscore_index.patient_id_l} =  ${vw_chronicity_details.unique_id} and
      ${vw_predictive_healthscore_index.year_file_date_l} = ${vw_chronicity_details.base_year};;
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
    sql_on:  ${patient_all_medical_pharmacy_summary.PATIENT_ID} =  ${vw_chronicity_details.unique_id} and
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${vw_chronicity_details.base_year};;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${medical_expense_top_and_bottom.unique_id}  and
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${medical_expense_top_and_bottom.year} ;;
  }
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${pharmacy_expense_top_and_bottom.year}  ;;
  }
  join: vw_vital_alert {
    type: left_outer
    relationship: one_to_many
    sql_on: ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${vw_vital_alert.unique_id} AND
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${vw_vital_alert.date_year};;
  }
  join: Vw_Biometric_data {
    type: left_outer
    relationship: one_to_many
    sql_on:  ${patient_all_medical_pharmacy_summary.PATIENT_ID} = ${Vw_Biometric_data.unique_id} AND
      ${patient_all_medical_pharmacy_summary.reporting_year} = ${Vw_Biometric_data.screening_year};;
  }
}


explore:patient_yearly_total_avg_spend_comparison{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient_yearly_total_avg_spend_comparison.patients_id} = ${vw_patient_demographics.unique_id};;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_yearly_total_avg_spend_comparison.patients_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${patient_yearly_total_avg_spend_comparison.service_year} = ${medical_expense_top_and_bottom.year} ;;
  }
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_yearly_total_avg_spend_comparison.patients_id} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${patient_yearly_total_avg_spend_comparison.service_year} = ${pharmacy_expense_top_and_bottom.year}  ;;
  }
}

explore : vw_vital_alert{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_vital_alert.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join: vw_medical{
    view_label: "Medical records"
    type: left_outer
    relationship: many_to_one
    sql_on: ${vw_vital_alert.unique_id} = ${vw_medical.unique_id} AND
      ${vw_vital_alert.date_year} = ${vw_medical.diagnosis_year};;
  }
  join: zone_filter {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zone_filter.unique_id} = ${vw_vital_alert.unique_id} AND
          ${zone_filter.date_month} = ${vw_vital_alert.date_month} AND
          ${zone_filter.date_year} = ${vw_vital_alert.date_year};;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_vital_alert.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${vw_vital_alert.date_year} = ${medical_expense_top_and_bottom.year} ;;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${patient_migration_across_years_summary.UNIQUE_ID} = ${medical_expense_top_and_bottom.unique_id}  and
      ${patient_migration_across_years_summary.REFERENCE_YEAR} = ${medical_expense_top_and_bottom.year} ;;
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
    sql_on:${vw_combine_data.unique_id} =${vw_chronicity_details.unique_id} and
      ${vw_combine_data.reporting_year} = ${vw_chronicity_details.base_year};;
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
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combine_data.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${vw_combine_data.service_year} = ${medical_expense_top_and_bottom.year} ;;
  }
  join: pharmacy_expense_top_and_bottom {
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combine_data.unique_id} = ${pharmacy_expense_top_and_bottom.unique_id} and
      ${vw_combine_data.service_year} = ${pharmacy_expense_top_and_bottom.year}  ;;
  }
  join: vw_vital_alert {
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combine_data.unique_id} = ${vw_vital_alert.unique_id} AND
      ${vw_combine_data.service_year} = ${vw_vital_alert.date_year};;
  }
}

explore: stg_tab_participant_data {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${stg_tab_participant_data.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }

}

explore: vw_stg_tab_pharma_classes {}
explore: patient_diagnosis_summary {}
explore: patient_drug_summary {}


explore: zone_filter{
  join: vw_patient_demographics {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zone_filter.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: hospital_visit_30_days {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${hospital_visit_30_days.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${hospital_visit_30_days.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${hospital_visit_30_days.year} = ${medical_expense_top_and_bottom.year} ;;
  }
}

explore: Office_Visits_within_30_days {
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${Office_Visits_within_30_days.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${Office_Visits_within_30_days.unique_id} = ${medical_expense_top_and_bottom.unique_id}  and
      ${Office_Visits_within_30_days.year} = ${medical_expense_top_and_bottom.year} ;;
  }
}

explore: Vw_Biometric_data{
  join: vw_patient_demographics {
    view_label: "Patient Demographics"
    type: left_outer
    relationship: one_to_many
    sql_on:  ${Vw_Biometric_data.unique_id} = ${vw_patient_demographics.unique_id} ;;
  }
}

explore: vw_eligibility {}
explore: stg_tab_hra_demographic_info {}

explore: vw_file_import_summary {}

explore: vw_combined_referral_data {
  join: patient_yearly_total_avg_spend_comparison {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_combined_referral_data.member_unique_id} = ${patient_yearly_total_avg_spend_comparison.patients_id}  ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combined_referral_data.member_unique_id} = ${medical_expense_top_and_bottom.unique_id}  ;;
  }
  join : pharmacy_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combined_referral_data.member_unique_id} = ${pharmacy_expense_top_and_bottom.unique_id}  ;;
  }
}

explore: vw_combined_active_participant_data {
  join: patient_yearly_total_avg_spend_comparison {
    type: left_outer
    relationship: one_to_many
    sql_on: ${vw_combined_active_participant_data.member_unique_id} = ${patient_yearly_total_avg_spend_comparison.patients_id}  ;;
  }
  join : medical_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combined_active_participant_data.member_unique_id} = ${medical_expense_top_and_bottom.unique_id}  ;;
  }
  join : pharmacy_expense_top_and_bottom{
    type: left_outer
    relationship: one_to_one
    sql_on: ${vw_combined_active_participant_data.member_unique_id} = ${pharmacy_expense_top_and_bottom.unique_id}  ;;
  }
}

explore: vw_at_risk_members{}
explore: stg_tab_eligibility_data {}
