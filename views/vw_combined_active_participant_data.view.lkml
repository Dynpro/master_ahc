view: vw_combined_active_participant_data {
  derived_table: {
    sql: select * from SCH_AHC_COMMON.LKR_TAB_COMBINED_ACTIVE_PARTICIPANT_DATA ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."Affiliation" ;;
  }

  dimension: member_participant_flag {
    type: string
    label: "Member Participant Flag"
    sql: ${TABLE}."Member Participant Flag" ;;
  }

  dimension: ault_care_recommended_program {
    type: string
    label: "AultCare Recommended Program"
    sql: ${TABLE}."AultCare Recommended Program" ;;
  }

  dimension: analytics_recommended_program {
    type: string
    label: "Analytics Recommended Program"
    sql: ${TABLE}."Analytics Recommended Program" ;;
  }

  dimension: ahc_program {
    type: string
    label: "AHC Program"
    sql: ${TABLE}."AHC Program" ;;
  }

  dimension: primary_insured_first_name {
    type: string
    label: "Primary Insured First Name"
    sql: ${TABLE}."Primary Insured First Name" ;;
  }

  dimension: primary_insured_last_name {
    type: string
    label: "Primary Insured Last Name"
    sql: ${TABLE}."Primary Insured Last Name" ;;
  }

  dimension: member_unique_id {
    type: string
    label: "Member Unique ID"
    sql: ${TABLE}."Member Unique ID" ;;
  }

  dimension: member_first_name {
    type: string
    label: "Member First Name"
    sql: ${TABLE}."Member First Name" ;;
  }

  dimension: member_middle_name {
    type: string
    label: "Member Middle Name"
    sql: ${TABLE}."Member Middle Name" ;;
  }

  dimension: member_last_name {
    type: string
    label: "Member Last Name"
    sql: ${TABLE}."Member Last Name" ;;
  }

  dimension: member_date_of_birth {
    type: date
    label: "Member Date of Birth"
    sql: ${TABLE}."Member Date of Birth" ;;
  }

  dimension: member_relationship_to_employee {
    type: string
    label: "Member Relationship to Employee"
    sql: ${TABLE}."Member Relationship to Employee" ;;
  }

  dimension: member_gender {
    type: string
    label: "Member Gender"
    sql: ${TABLE}."Member Gender" ;;
  }

  dimension: member_eligibility_effective_date {
    type: date
    label: "Member Eligibility Effective Date"
    sql: ${TABLE}."Member Eligibility Effective Date" ;;
  }

  dimension: member_eligibility_termination_date {
    type: date
    label: "Member Eligibility Termination Date"
    sql: ${TABLE}."Member Eligibility Termination Date" ;;
  }

  dimension: member_address {
    type: string
    label: "Member Address"
    sql: ${TABLE}."Member Address" ;;
  }

  dimension: member_city {
    type: string
    label: "Member City"
    sql: ${TABLE}."Member City" ;;
  }

  dimension: member_state {
    type: string
    label: "Member State"
    sql: ${TABLE}."Member State" ;;
  }

  dimension: member_zip_code {
    type: string
    label: "Member Zip Code"
    sql: ${TABLE}."Member Zip Code" ;;
  }

  dimension: member_email_address {
    type: string
    label: "Member Email Address"
    sql: ${TABLE}."Member Email Address" ;;
  }

  dimension: member_phone_number {
    type: string
    label: "Member Phone Number"
    sql: ${TABLE}."Member Phone Number" ;;
  }

  dimension: chronic_icd10_code_list {
    type: string
    label: "Chronic ICD10 Code List"
    sql: ${TABLE}."Chronic ICD10 Code List" ;;
  }

  dimension: chronic_category_list {
    type: string
    label: "Chronic Category List"
    sql: ${TABLE}."Chronic Category List" ;;
  }

  dimension: health_score {
    type: string
    label: "Health Score"
    sql: ${TABLE}."Health Score" ;;
  }

  dimension: current_date {
    type: date
    sql: ${TABLE}."CURRENT_DATE" ;;
  }

  dimension: process_date {
    type: date
    sql: ${TABLE}."PROCESS_DATE" ;;
  }

  set: detail {
    fields: [
      affiliation,
      member_participant_flag,
      ault_care_recommended_program,
      analytics_recommended_program,
      ahc_program,
      primary_insured_first_name,
      primary_insured_last_name,
      member_unique_id,
      member_first_name,
      member_middle_name,
      member_last_name,
      member_date_of_birth,
      member_relationship_to_employee,
      member_gender,
      member_eligibility_effective_date,
      member_eligibility_termination_date,
      member_address,
      member_city,
      member_state,
      member_zip_code,
      member_email_address,
      member_phone_number,
      chronic_icd10_code_list,
      chronic_category_list,
      health_score,
      current_date,
      process_date
    ]
  }
  measure: unique_id_count {
    type: count_distinct
    label: "N"
    sql: ${member_unique_id} ;;
  }
}
