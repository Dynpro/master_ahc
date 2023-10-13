
view: vw_eligibility {
  derived_table: {
    sql: select * from  "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_ELIGIBILITY_DATA" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: member_l_name {
    type: string
    label: "Member Last Name"
    sql: ${TABLE}."MEMBER_L_NAME" ;;
  }

  dimension: member_m_name {
    type: string
    label: "Member Middle Name"
    sql: ${TABLE}."MEMBER_M_NAME" ;;
  }

  dimension: member_f_name {
    type: string
    label: "Member First Name"
    sql: ${TABLE}."MEMBER_F_NAME" ;;
  }

  dimension: member_dob {
    type: date
    sql: ${TABLE}."MEMBER_DOB" ;;
  }

  dimension: member_gender {
    type: string
    sql: ${TABLE}."MEMBER_GENDER" ;;
  }

  dimension: unique_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: effective_date {
    type: date
    sql: ${TABLE}."EFFECTIVE_DATE" ;;
  }

  dimension: termination_date {
    type: date
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension: load_date {
    type: date
    sql: ${TABLE}."LOAD_DATE" ;;
  }

  dimension: termination_date_adjusted {
    type: date
    sql: ${TABLE}."TERMINATION_DATE_ADJUSTED" ;;
  }

  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }

  dimension: class_code {
    type: string
    sql: ${TABLE}."CLASS_CODE" ;;
  }

  dimension: source_file_row_number {
    type: number
    sql: ${TABLE}."SOURCE_FILE_ROW_NUMBER" ;;
  }

  dimension: dir_code {
    type: string
    sql: ${TABLE}."DIR_CODE" ;;
  }

  dimension: elig_key {
    type: string
    sql: ${TABLE}."ELIG_KEY" ;;
  }

  dimension: mem_idx {
    type: string
    sql: ${TABLE}."MEM_IDX" ;;
  }

  dimension: mem_idx_dep {
    type: string
    sql: ${TABLE}."MEM_IDX_DEP" ;;
  }

  dimension: employee_gender {
    type: string
    sql: ${TABLE}."EMPLOYEE_GENDER" ;;
  }

  dimension: employee_birthdate {
    type: date
    sql: ${TABLE}."EMPLOYEE_BIRTHDATE" ;;
  }

  dimension: employee_lastname {
    type: string
    sql: ${TABLE}."EMPLOYEE_LASTNAME" ;;
  }

  dimension: employee_firstname {
    type: string
    sql: ${TABLE}."EMPLOYEE_FIRSTNAME" ;;
  }

  dimension: employee_zip_code {
    type: number
    sql: ${TABLE}."EMPLOYEE_ZIP_CODE" ;;
  }

  dimension: employee_address_1 {
    type: string
    sql: ${TABLE}."EMPLOYEE_ADDRESS_1" ;;
  }

  dimension: employee_address_2 {
    type: string
    sql: ${TABLE}."EMPLOYEE_ADDRESS_2" ;;
  }

  dimension: employee_city {
    type: string
    sql: ${TABLE}."EMPLOYEE_CITY" ;;
  }

  dimension: employee_state {
    type: string
    sql: ${TABLE}."EMPLOYEE_STATE" ;;
  }

  dimension: group_number {
    type: string
    sql: ${TABLE}."GROUP_NUMBER" ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}."GROUP_NAME" ;;
  }

  dimension: plan_number {
    type: string
    sql: ${TABLE}."PLAN_NUMBER" ;;
  }

  dimension: employee_status {
    type: string
    sql: ${TABLE}."EMPLOYEE_STATUS" ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}."LOCATION" ;;
  }

  dimension: location_name {
    type: string
    sql: ${TABLE}."LOCATION_NAME" ;;
  }

  dimension: company_zipcode {
    type: string
    sql: ${TABLE}."COMPANY_ZIPCODE" ;;
  }

  dimension: company_state {
    type: string
    sql: ${TABLE}."COMPANY_STATE" ;;
  }

  dimension: type_of_plan {
    type: string
    sql: ${TABLE}."TYPE_OF_PLAN" ;;
  }

  dimension: coverage_status {
    type: string
    sql: ${TABLE}."COVERAGE_STATUS" ;;
  }

  dimension: cobindicator {
    type: string
    sql: ${TABLE}."COBINDICATOR" ;;
  }

  dimension: medicare_indicator {
    type: string
    sql: ${TABLE}."MEDICARE_INDICATOR" ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}."CARRIER" ;;
  }

  dimension: medical_coverage {
    type: string
    sql: ${TABLE}."MEDICAL_COVERAGE" ;;
  }

  dimension: vision_coverage {
    type: string
    sql: ${TABLE}."VISION_COVERAGE" ;;
  }

  dimension: dental_coverage {
    type: string
    sql: ${TABLE}."DENTAL_COVERAGE" ;;
  }

  dimension: pharmacy_coverge {
    type: string
    sql: ${TABLE}."PHARMACY_COVERGE" ;;
  }

  dimension: allhealth_eff_date {
    type: date
    sql: ${TABLE}."ALLHEALTH_EFF_DATE" ;;
  }

  dimension: allhealth_years {
    type: date
    sql: ${TABLE}."ALLHEALTH_YEARS" ;;
  }

  dimension: employee_phone_number {
    type: number
    sql: ${TABLE}."EMPLOYEE_PHONE_NUMBER" ;;
  }

  dimension: employee_sec_phone_number {
    type: number
    sql: ${TABLE}."EMPLOYEE_SEC_PHONE_NUMBER" ;;
  }

  dimension: employee_mobile_phonenumber {
    type: number
    sql: ${TABLE}."EMPLOYEE_MOBILE_PHONENUMBER" ;;
  }

  dimension: employee_email_address {
    type: string
    sql: ${TABLE}."EMPLOYEE_EMAIL_ADDRESS" ;;
  }

  dimension: insured_flag {
    type: string
    sql: ${TABLE}."INSURED_FLAG" ;;
  }

  dimension: member_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_PHONE_NUMBER" ;;
  }

  dimension: member_sec_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_SEC_PHONE_NUMBER" ;;
  }

  dimension: member_mobile_phone_number {
    type: number
    sql: ${TABLE}."MEMBER_MOBILE_PHONE_NUMBER" ;;
  }

  dimension: member_email_address {
    type: string
    sql: ${TABLE}."MEMBER_EMAIL_ADDRESS" ;;
  }

  dimension: member_zipcode {
    type: number
    sql: ${TABLE}."MEMBER_ZIPCODE" ;;
  }

  dimension: member_address_1 {
    type: string
    sql: ${TABLE}."MEMBER_ADDRESS_1" ;;
  }

  dimension: member_address_2 {
    type: string
    sql: ${TABLE}."MEMBER_ADDRESS_2" ;;
  }

  dimension: member_city {
    type: string
    sql: ${TABLE}."MEMBER_CITY" ;;
  }

  dimension: member_state {
    type: string
    sql: ${TABLE}."MEMBER_STATE" ;;
  }

  dimension: program {
    type: string
    sql: ${TABLE}."PROGRAM" ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}."ACTIVE" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: raw_load_date {
    type: date
    sql: ${TABLE}."RAW_LOAD_DATE" ;;
  }

  dimension: staging_date {
    type: date
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  dimension: temp_random_id {
    type: string
    sql: ${TABLE}."TEMP_RANDOM_ID" ;;
  }

  dimension: source_file_path {
    type: string
    sql: ${TABLE}."SOURCE_FILE_PATH" ;;
  }

  dimension_group: source_load_timestamp {
    type: time
    sql: ${TABLE}."SOURCE_LOAD_TIMESTAMP" ;;
  }

  dimension: employee_middle_name {
    type: string
    sql: ${TABLE}."EMPLOYEE_MIDDLE_NAME" ;;
  }
  set: detail {
    fields: [
      member_l_name,
      member_m_name,
      member_f_name,
      member_dob,
      member_gender,
      unique_id,
      effective_date,
      termination_date,
      load_date,
      termination_date_adjusted,
      member_id,
      class_code,
      source_file_row_number,
      dir_code,
      elig_key,
      mem_idx,
      mem_idx_dep,
      employee_gender,
      employee_birthdate,
      employee_lastname,
      employee_firstname,
      employee_zip_code,
      employee_address_1,
      employee_address_2,
      employee_city,
      employee_state,
      group_number,
      group_name,
      plan_number,
      employee_status,
      location,
      location_name,
      company_zipcode,
      company_state,
      type_of_plan,
      coverage_status,
      cobindicator,
      medicare_indicator,
      carrier,
      medical_coverage,
      vision_coverage,
      dental_coverage,
      pharmacy_coverge,
      allhealth_eff_date,
      allhealth_years,
      employee_phone_number,
      employee_sec_phone_number,
      employee_mobile_phonenumber,
      employee_email_address,
      insured_flag,
      member_phone_number,
      member_sec_phone_number,
      member_mobile_phone_number,
      member_email_address,
      member_zipcode,
      member_address_1,
      member_address_2,
      member_city,
      member_state,
      program,
      active,
      status,
      raw_load_date,
      staging_date,
      temp_random_id,
      source_file_path,
      source_load_timestamp_time,
      employee_middle_name
    ]
  }
  dimension: relationship_to_employee {
    type: string
    sql:
    CASE WHEN ${class_code} ='E' THEN 'EMPLOYEE'
WHEN ${class_code} ='E00' THEN 'EMPLOYEE'
WHEN ${class_code} ='S' THEN 'SPOUSE'
WHEN ${class_code}='T' THEN 'SPOUSE'
WHEN ${class_code}='U' THEN 'SPOUSE'
WHEN ${class_code}='V' THEN 'SPOUSE'
WHEN substring(${TABLE}."CLASS_CODE", 1, 1) = 'S' AND (substring(${TABLE}."CLASS_CODE", 2, 2) >= 0 AND substring(${TABLE}."CLASS_CODE", 2, 2) <= 99) THEN 'SPOUSE'
WHEN ${class_code}='1' THEN 'DEPENDENT'
WHEN ${class_code}='2' THEN 'DEPENDENT'
WHEN ${class_code}='3' THEN 'DEPENDENT'
WHEN ${class_code}='4' THEN 'DEPENDENT'
WHEN ${class_code}='5' THEN 'DEPENDENT'
WHEN ${class_code}='6' THEN 'DEPENDENT'
WHEN ${class_code}='7' THEN 'DEPENDENT'
WHEN ${class_code}='8' THEN 'DEPENDENT'
WHEN ${class_code}='9' THEN 'DEPENDENT'
WHEN ${class_code}='A' THEN 'DEPENDENT'
WHEN ${class_code}='B' THEN 'DEPENDENT'
WHEN ${class_code}='C' THEN 'DEPENDENT'
WHEN ${class_code}='D' THEN 'DEPENDENT'
WHEN substring(${TABLE}."CLASS_CODE", 1, 1) = 'D' AND (substring(${TABLE}."CLASS_CODE", 2, 2) >= 0 AND substring(${TABLE}."CLASS_CODE", 2, 2) <= 99) THEN 'DEPENDENT'
ELSE 'OTHER'
END;;
  }

###for File Import Summary
  dimension: STAGING_DATE {
    type: date
    label: "Eligibility File Import Date"
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  dimension: Current_date {
    type: date
    label: "Current date"
    sql: CURRENT_DATE() ;;
  }

  dimension: termination_date_filter {
    type: string
    sql: CASE WHEN ${termination_date} > ${Current_date} OR ${termination_date} IS NULL THEN 'After Current date'
      ELSE 'On/Before Current date'
      END;;
  }

  measure: termination_after_current_date {
    type: count_distinct
    label: "Eligibility N"
    filters: [termination_date_filter: "After Current date"]
    sql: ${unique_id} ;;
  }

  measure: termination_onbefore_current_date {
    type: count_distinct
    label: "Terminated N"
    filters: [termination_date_filter: "On/Before Current date"]
    sql: ${unique_id} ;;
  }

  dimension: data_type {
    type: string
    sql: case when ${active} = 'true'  then 'Eligibility'
          else 'na'
          end;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${unique_id} ;;
  }
}
