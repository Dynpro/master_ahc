view: stg_tab_eligibility_data {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."STG_TAB_ELIGIBILITY_DATA" ;;

  dimension: account {
    type: string
    sql: ${TABLE}."ACCOUNT" ;;
  }
  dimension: account_key {
    type: string
    sql: ${TABLE}."ACCOUNT_KEY" ;;
  }
  dimension: active {
    type: yesno
    sql: ${TABLE}."ACTIVE" ;;
  }
  dimension: benefit_plan_key {
    type: string
    sql: ${TABLE}."BENEFIT_PLAN_KEY" ;;
  }
  dimension: class_code {
    type: string
    sql: ${TABLE}."CLASS_CODE" ;;
  }
  dimension_group: department_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DEPARTMENT_END_DATE" ;;
  }
  dimension: department_name {
    type: string
    sql: ${TABLE}."DEPARTMENT_NAME" ;;
  }
  dimension_group: department_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DEPARTMENT_START_DATE" ;;
  }
  dimension_group: effective_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."EFFECTIVE_DATE" ;;
  }
  dimension: employee_address_1 {
    type: string
    sql: ${TABLE}."EMPLOYEE_ADDRESS_1" ;;
  }
  dimension: employee_address_2 {
    type: string
    sql: ${TABLE}."EMPLOYEE_ADDRESS_2" ;;
  }
  dimension_group: employee_birthdate {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."EMPLOYEE_BIRTHDATE" ;;
  }
  dimension: employee_city {
    type: string
    sql: ${TABLE}."EMPLOYEE_CITY" ;;
  }
  dimension: employee_email_address {
    type: string
    sql: ${TABLE}."EMPLOYEE_EMAIL_ADDRESS" ;;
  }
  dimension: employee_firstname {
    type: string
    sql: ${TABLE}."EMPLOYEE_FIRSTNAME" ;;
  }
  dimension: employee_gender {
    type: string
    sql: ${TABLE}."EMPLOYEE_GENDER" ;;
  }
  dimension: employee_lastname {
    type: string
    sql: ${TABLE}."EMPLOYEE_LASTNAME" ;;
  }
  dimension: employee_middle_name {
    type: string
    sql: ${TABLE}."EMPLOYEE_MIDDLE_NAME" ;;
  }
  dimension: employee_mobile_phonenumber {
    type: number
    sql: ${TABLE}."EMPLOYEE_MOBILE_PHONENUMBER" ;;
  }
  dimension: employee_phone_number {
    type: number
    sql: ${TABLE}."EMPLOYEE_PHONE_NUMBER" ;;
  }
  dimension: employee_sec_phone_number {
    type: number
    sql: ${TABLE}."EMPLOYEE_SEC_PHONE_NUMBER" ;;
  }
  dimension: employee_state {
    type: string
    sql: ${TABLE}."EMPLOYEE_STATE" ;;
  }
  dimension: employee_zip_code {
    type: number
    sql: ${TABLE}."EMPLOYEE_ZIP_CODE" ;;
  }
  dimension: groups {
    type: string
    sql: ${TABLE}."GROUPS" ;;
  }
  dimension: is_handicapped {
    type: string
    sql: ${TABLE}."IS_HANDICAPPED" ;;
  }
  dimension_group: load_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."LOAD_DATE" ;;
  }
  dimension: matital_status_code {
    type: string
    sql: ${TABLE}."MATITAL_STATUS_CODE" ;;
  }
  dimension: member_address_1 {
    type: string
    sql: ${TABLE}."MEMBER_ADDRESS_1" ;;
  }
  dimension: member_address_2 {
    type: string
    sql: ${TABLE}."MEMBER_ADDRESS_2" ;;
  }
  dimension: member_address_3 {
    type: string
    sql: ${TABLE}."MEMBER_ADDRESS_3" ;;
  }
  dimension: member_age {
    type: string
    sql: ${TABLE}."MEMBER_AGE" ;;
  }
  dimension: member_city {
    type: string
    sql: ${TABLE}."MEMBER_CITY" ;;
  }
  dimension: member_country {
    type: string
    sql: ${TABLE}."MEMBER_COUNTRY" ;;
  }
  dimension_group: member_dob {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."MEMBER_DOB" ;;
  }
  dimension: member_email_address {
    type: string
    sql: ${TABLE}."MEMBER_EMAIL_ADDRESS" ;;
  }
  dimension: member_f_name {
    type: string
    sql: ${TABLE}."MEMBER_F_NAME" ;;
  }
  dimension: member_gender {
    type: string
    sql: ${TABLE}."MEMBER_GENDER" ;;
  }
  dimension: member_hcc_id {
    type: string
    sql: ${TABLE}."MEMBER_HCC_ID" ;;
  }
  dimension_group: member_hire {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."MEMBER_HIRE_DATE" ;;
  }
  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }
  dimension: member_l_name {
    type: string
    sql: ${TABLE}."MEMBER_L_NAME" ;;
  }
  dimension: member_m_name {
    type: string
    sql: ${TABLE}."MEMBER_M_NAME" ;;
  }
  dimension: member_mobile_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_MOBILE_PHONE_NUMBER" ;;
  }
  dimension: member_name_prefix {
    type: string
    sql: ${TABLE}."MEMBER_NAME_PREFIX" ;;
  }
  dimension: member_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_PHONE_NUMBER" ;;
  }
  dimension: member_sec_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_SEC_PHONE_NUMBER" ;;
  }
  dimension: member_ssn {
    type: string
    sql: ${TABLE}."MEMBER_SSN" ;;
  }
  dimension: member_state {
    type: string
    sql: ${TABLE}."MEMBER_STATE" ;;
  }
  dimension: member_status {
    type: string
    sql: ${TABLE}."MEMBER_STATUS" ;;
  }
  dimension: member_work {
    type: string
    sql: ${TABLE}."MEMBER_WORK" ;;
  }
  dimension: member_work_ext {
    type: string
    sql: ${TABLE}."MEMBER_WORK_EXT" ;;
  }
  dimension: member_zip_4 {
    type: string
    sql: ${TABLE}."MEMBER_ZIP_4" ;;
  }
  dimension: member_zipcode {
    type: number
    sql: ${TABLE}."MEMBER_ZIPCODE" ;;
  }
  dimension: navtive_language_code {
    type: string
    sql: ${TABLE}."NAVTIVE_LANGUAGE_CODE" ;;
  }
  dimension_group: plan_effective {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."PLAN_EFFECTIVE_DATE" ;;
  }
  dimension: primary_language_code {
    type: string
    sql: ${TABLE}."PRIMARY_LANGUAGE_CODE" ;;
  }
  dimension: program {
    type: string
    sql: ${TABLE}."PROGRAM" ;;
  }
  dimension_group: raw_load {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."RAW_LOAD_DATE" ;;
  }
  dimension: smoking_status {
    type: string
    sql: ${TABLE}."SMOKING_STATUS" ;;
  }
  dimension: source_file_path {
    type: string
    sql: ${TABLE}."SOURCE_FILE_PATH" ;;
  }
  dimension: source_file_row_number {
    type: number
    sql: ${TABLE}."SOURCE_FILE_ROW_NUMBER" ;;
  }
  dimension_group: source_load_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."SOURCE_LOAD_TIMESTAMP" ;;
  }
  dimension_group: staging {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."STAGING_DATE" ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }
  dimension: student_status_code {
    type: string
    sql: ${TABLE}."STUDENT_STATUS_CODE" ;;
  }
  dimension: sub_account {
    type: string
    sql: ${TABLE}."SUB_ACCOUNT" ;;
  }
  dimension: sub_account_key {
    type: string
    sql: ${TABLE}."SUB_ACCOUNT_KEY" ;;
  }
  dimension: subscriber_tax_id {
    type: string
    sql: ${TABLE}."SUBSCRIBER_TAX_ID" ;;
  }
  dimension: subscription_hcc_id {
    type: string
    sql: ${TABLE}."SUBSCRIPTION_HCC_ID" ;;
  }
  dimension: temp_random_id {
    type: string
    sql: ${TABLE}."TEMP_RANDOM_ID" ;;
  }
  dimension_group: termination {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }
  dimension_group: termination_date_adjusted {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."TERMINATION_DATE_ADJUSTED" ;;
  }
  dimension: tier {
    type: string
    sql: ${TABLE}."TIER" ;;
  }
  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      member_f_name,
      member_l_name,
      department_name,
      employee_lastname,
      employee_middle_name,
      member_m_name,
      employee_firstname
    ]
  }

  dimension: termination_date_filter {
    type: string
    sql: CASE WHEN ${termination_raw} > CURRENT_DATE() OR ${termination_raw} IS NULL THEN 'After Current date'
      ELSE 'On/Before Current date'
      END;;
  }

  dimension: patient_current_age {
    type: number
    label: "Member Age"
    sql: DATEDIFF( year, ${member_dob_raw}, CURRENT_DATE()) ;;
  }

  measure: total_active_members {
    type: count_distinct
    label: "Total Active (Non-Termed) Members"
    filters: [active: "Yes",staging_year: "2023",status: "RECENT",termination_date_filter: "After Current date"]
    sql: ${unique_id} ;;
  }

  measure: total_active_members_age_greater_than_18{
    type: count_distinct
    label: "Total Active (Non-Termed) Members who are Age 18 and Older"
    filters: [active: "Yes",staging_year: "2023",status: "RECENT",patient_current_age: ">=18",termination_date_filter: "After Current date"]
    sql: ${unique_id} ;;
  }

}
