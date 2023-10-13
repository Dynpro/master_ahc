view: stg_tab_participant_data {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."STG_TAB_PARTICIPANT_DATA"
    ;;

  dimension: active {
    type: number
    sql: ${TABLE}."ACTIVE" ;;
  }

  dimension: active_program_activity {
    type: string
    sql: ${TABLE}."ACTIVE_PROGRAM_ACTIVITY" ;;
  }

  dimension: active_program_minutes {
    type: string
    sql: ${TABLE}."ACTIVE_PROGRAM_MINUTES" ;;
  }

  dimension: active_programs {
    type: string
    sql: ${TABLE}."ACTIVE_PROGRAMS" ;;
  }

  dimension: addiction_program_activity {
    type: string
    sql: ${TABLE}."ADDICTION_PROGRAM_ACTIVITY" ;;
  }

  dimension: addiction_program_minutes {
    type: string
    sql: ${TABLE}."ADDICTION_PROGRAM_MINUTES" ;;
  }

  dimension: adm_program_activity {
    type: string
    sql: ${TABLE}."ADM_PROGRAM_ACTIVITY" ;;
  }

  dimension: adm_program_minutes {
    type: string
    sql: ${TABLE}."ADM_PROGRAM_MINUTES" ;;
  }

  dimension: adm_tier_one_program_activity {
    type: string
    sql: ${TABLE}."ADM_TIER_ONE_PROGRAM_ACTIVITY" ;;
  }

  dimension: adm_tier_one_program_minutes {
    type: string
    sql: ${TABLE}."ADM_TIER_ONE_PROGRAM_MINUTES" ;;
  }

  dimension: adm_tier_two_program_activity {
    type: string
    sql: ${TABLE}."ADM_TIER_TWO_PROGRAM_ACTIVITY" ;;
  }

  dimension: adm_tier_two_program_minutes {
    type: string
    sql: ${TABLE}."ADM_TIER_TWO_PROGRAM_MINUTES" ;;
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."AFFILIATION" ;;
  }

  dimension: as_care_lead {
    type: string
    sql: ${TABLE}."AS_CARE_LEAD" ;;
  }

  dimension: care_manager {
    type: string
    sql: ${TABLE}."CARE_MANAGER" ;;
  }

  dimension: care_recipient_firstname {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_FIRSTNAME" ;;
  }

  dimension: care_recipient_lastname {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_LASTNAME" ;;
  }

  dimension: ccm_program_activity {
    type: string
    sql: ${TABLE}."CCM_PROGRAM_ACTIVITY" ;;
  }

  dimension: ccm_program_minutes {
    type: string
    sql: ${TABLE}."CCM_PROGRAM_MINUTES" ;;
  }

  dimension: ccm_tier_three_program_activity {
    type: string
    sql: ${TABLE}."CCM_TIER_THREE_PROGRAM_ACTIVITY" ;;
  }

  dimension: ccm_tier_three_program_minutes {
    type: string
    sql: ${TABLE}."CCM_TIER_THREE_PROGRAM_MINUTES" ;;
  }

  dimension: covidadvanced_program_activity {
    type: string
    sql: ${TABLE}."COVIDADVANCED_PROGRAM_ACTIVITY" ;;
  }

  dimension: covidadvanced_program_minutes {
    type: string
    sql: ${TABLE}."COVIDADVANCED_PROGRAM_MINUTES" ;;
  }

  dimension: covidbasic_program_activity {
    type: string
    sql: ${TABLE}."COVIDBASIC_PROGRAM_ACTIVITY" ;;
  }

  dimension: covidbasic_program_minutes {
    type: string
    sql: ${TABLE}."COVIDBASIC_PROGRAM_MINUTES" ;;
  }

  dimension: currentstatus {
    type: string
    sql: ${TABLE}."CURRENTSTATUS" ;;
  }

  dimension: demographic {
    type: string
    sql: ${TABLE}."DEMOGRAPHIC" ;;
  }

  dimension: diet {
    type: string
    sql: ${TABLE}."DIET" ;;
  }

  dimension: diseased_base_1 {
    type: string
    sql: ${TABLE}."DISEASED_BASE_1" ;;
  }

  dimension: diseased_base_2 {
    type: string
    sql: ${TABLE}."DISEASED_BASE_2" ;;
  }

  dimension: diseased_base_3 {
    type: string
    sql: ${TABLE}."DISEASED_BASE_3" ;;
  }

  dimension: diseased_base_4 {
    type: string
    sql: ${TABLE}."DISEASED_BASE_4" ;;
  }

  dimension: emr_ids {
    type: string
    sql: ${TABLE}."EMR_IDS" ;;
  }

  dimension: file_input_date {
    type: string
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

  dimension: flag_need_attention {
    type: string
    sql: ${TABLE}."FLAG_NEED_ATTENTION" ;;
  }

  dimension: geography {
    type: string
    sql: ${TABLE}."GEOGRAPHY" ;;
  }

  dimension: goals {
    type: string
    sql: ${TABLE}."GOALS" ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}."GROUP_NAME" ;;
  }

  dimension: group_number {
    type: string
    sql: ${TABLE}."GROUP_NUMBER" ;;
  }

  dimension: hra_program_activity {
    type: string
    sql: ${TABLE}."HRA_PROGRAM_ACTIVITY" ;;
  }

  dimension: hra_program_minutes {
    type: string
    sql: ${TABLE}."HRA_PROGRAM_MINUTES" ;;
  }

  dimension: insureflag {
    type: string
    sql: ${TABLE}."INSUREFLAG" ;;
  }

  dimension_group: last_login {
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
    sql: ${TABLE}."LAST_LOGIN_DATE" ;;
  }

  dimension: lhr_issues {
    type: string
    sql: ${TABLE}."LHR_ISSUES" ;;
  }

  dimension: lhr_tasks {
    type: string
    sql: ${TABLE}."LHR_TASKS" ;;
  }

  dimension: lifestyle_program_activity {
    type: string
    sql: ${TABLE}."LIFESTYLE_PROGRAM_ACTIVITY" ;;
  }

  dimension: lifestyle_program_minutes {
    type: string
    sql: ${TABLE}."LIFESTYLE_PROGRAM_MINUTES" ;;
  }

  dimension: member_id {
    label: "Member ID"
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }

  dimension: officework_program_activity {
    type: string
    sql: ${TABLE}."OFFICEWORK_PROGRAM_ACTIVITY" ;;
  }

  dimension: officework_program_minutes {
    type: string
    sql: ${TABLE}."OFFICEWORK_PROGRAM_MINUTES" ;;
  }

  dimension: on_board_date {
    type: string
    sql: ${TABLE}."ON_BOARD_DATE" ;;
  }

  dimension: onboard_status {
    type: string
    sql: ${TABLE}."ONBOARD_STATUS" ;;
  }

  dimension: participant_flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: patient_address {
    label: "Member Address"
    type: string
    sql: ${TABLE}."PATIENT_ADDRESS" ;;
  }

  dimension: patient_city {
    label: "Member City"
    type: string
    sql: ${TABLE}."PATIENT_CITY" ;;
  }

  dimension: patient_dob {
    type: string
    label: "Member DOB"
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_email {
    label: "Member Email"
    type: string
    sql: ${TABLE}."PATIENT_EMAIL" ;;
  }

  dimension: patient_gender {
    label: "Member Gender"
    type: string
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: patient_phone_number {
    label: "Member Phone Number"
    type: string
    sql: ${TABLE}."PATIENT_PHONE_NUMBER" ;;
  }

  dimension: patient_state {
    label: "Member State"
    type: string
    sql: ${TABLE}."PATIENT_STATE" ;;
  }

  dimension: patient_zip {
    label: "Member Zip"
    type: string
    sql: ${TABLE}."PATIENT_ZIP" ;;
  }

  dimension: physician_in_charge {
    type: string
    sql: ${TABLE}."PHYSICIAN_IN_CHARGE" ;;
  }

  dimension: primary_care_physician {
    type: string
    sql: ${TABLE}."PRIMARY_CARE_PHYSICIAN" ;;
  }

  dimension: program_name {
    type: string
    sql: ${TABLE}."PROGRAM_NAME" ;;
  }

  dimension: provider {
    type: string
    sql: ${TABLE}."PROVIDER" ;;
  }

  dimension: raw_load_date {
    type: string
    sql: ${TABLE}."RAW_LOAD_DATE" ;;
  }

  dimension: risk_profile {
    type: string
    sql: ${TABLE}."RISK_PROFILE" ;;
  }

  dimension: rpm120_program_activity {
    type: string
    sql: ${TABLE}."RPM120_PROGRAM_ACTIVITY" ;;
  }

  dimension: rpm120_program_minutes {
    type: string
    sql: ${TABLE}."RPM120_PROGRAM_MINUTES" ;;
  }

  dimension: rpm30_program_activity {
    type: string
    sql: ${TABLE}."RPM30_PROGRAM_ACTIVITY" ;;
  }

  dimension: rpm30_program_minutes {
    type: string
    sql: ${TABLE}."RPM30_PROGRAM_MINUTES" ;;
  }

  dimension: rpm90_program_activity {
    type: string
    sql: ${TABLE}."RPM90_PROGRAM_ACTIVITY" ;;
  }

  dimension: rpm90_program_minutes {
    type: string
    sql: ${TABLE}."RPM90_PROGRAM_MINUTES" ;;
  }

  dimension: rpm_program_activity {
    type: string
    sql: ${TABLE}."RPM_PROGRAM_ACTIVITY" ;;
  }

  dimension: rpm_program_minutes {
    type: string
    sql: ${TABLE}."RPM_PROGRAM_MINUTES" ;;
  }

  dimension: special_needs {
    type: string
    sql: ${TABLE}."SPECIAL_NEEDS" ;;
  }

  dimension_group: staging {
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
    label: "Participant File Import Date"
    drill_fields: [staging_year, staging_quarter, staging_month, staging_raw]
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: system_id {
    type: string
    sql: ${TABLE}."SYSTEM_ID" ;;
  }

  dimension: triggers {
    type: string
    sql: ${TABLE}."TRIGGERS" ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [care_recipient_firstname, program_name, care_recipient_lastname, group_name]
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${unique_id} ;;
  }

  dimension: STAGING_DATE {
    type: date
    label: "Participant File Import Date"
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  measure: participant_N {
    type: count_distinct
    filters: [status: "RECENT", active: "1", participant_flag: "PARTICIPANT"]
    sql: ${unique_id} ;;
  }
}
