view: vw_patient_demographics {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PATIENT_DEMOGRAPHICS"
    ;;

  dimension: dependent_f_name {
    label: "Member First Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    label: "Member Last Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: dependent_m_name {
    label: "Member Middle Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_M_NAME" ;;
  }

  dimension: patient_name {
    type: string
    label: "Member Name"
    sql: CONCAT(IFNULL(${dependent_f_name}, ''), ' ',IFF(${dependent_m_name} is NULL,'',CONCAT(${dependent_m_name},' ')),IFNULL(${dependent_l_name}, '')) ;;
    # sql: CONCAT(IFNULL(${dependent_f_name}, ''), ' ', IFNULL(${dependent_m_name}, ''), ' ', IFNULL(${dependent_l_name}, '')) ;;
  }

  dimension: dependent_ssn {
    type: string
    hidden: yes
    sql: ${TABLE}."DEPENDENT_SSN" ;;
  }

  dimension: employee_id {
    type: string
    sql: ${TABLE}."EMPLOYEE_ID" ;;
  }

  dimension_group: patient_dob {
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
    label: "Member DOB"
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_dob1 {
    label: "Member DOB"
    type: string
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_gender {
    label: "Member Gender"
    type: string
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: patient_current_age {
    type: number
    label: "Member Age"
    sql: DATEDIFF( year, ${patient_dob_raw}, CURRENT_DATE()) ;;
  }

  dimension: patient_current_age1 {
    type: string
    label: "Current Patient Age"
    sql: DATEDIFF( year, ${patient_dob_raw}, CURRENT_DATE()) ;;
  }

  dimension: AgeGroup {
    type: tier
    label: "AGE GROUP"
    tiers: [20, 30, 40, 50, 60]
    description: "AGE Group>> 0-19, 20-29, 30-39, 40-49, 50-59 & >=60 yrs"
    style: integer
    sql:  ${patient_current_age};;
  }

  dimension: relationship_to_employee {
    type: string
    label: "RELATIONSHIP TO EMPLOYEE"
    sql: ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" ;;
  }

  dimension: unique_id {
    type: string
    hidden: no
    sql: ${TABLE}."UNIQUE_ID" ;;
  }


  measure: count {
    type: count
    hidden: yes
    drill_fields: [dependent_f_name, dependent_l_name, dependent_m_name]
  }

  dimension: PARTICIPANT_PROGRAM_NAME{
    type: string
    label: "PARTICIPANT PROGRAM NAME"
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME";;
  }

  dimension: PATIENT_ACTIVE_FLAG{
    type: string
    label: "MEMBER ACTIVE FLAG"
    sql: ${TABLE}."ACTIVE";;
  }

  dimension: member_id{
    type: string
    label: "MEMBER ID (Relationship)"
    sql: CONCAT(${TABLE}."MEMBER_ID", ' (', ${relationship_to_employee}, ')')  ;;
    # html: <b> {{ member_id._rendered_value }} </b> ({{ relationship_to_employee._rendered_value }})   ;;
  }
  dimension: member_id_without_relationship{
    type: string
    label: "MEMBER ID"
    sql: ${TABLE}."MEMBER_ID"  ;;
  }

  dimension: member_id_list {
    type: string
    sql: LISTAGG(DISTINCT ${TABLE}."MEMBER_ID") ;;
  }

  dimension: patient_name_member_id {
    label: "Member Name Member ID"
    type: string
    sql: CONCAT(${patient_name}, ' (', ${member_id_list}, ')')   ;;
  }

  dimension: client_name{
    type: string
    label: "Affiliation"
    sql: ${TABLE}."EMPLOYER_NAME" ;;
  }

  dimension: unique_id_demo {
    type: string
    sql: CONCAT(${dependent_f_name}, ${dependent_l_name}, ${patient_dob_raw}, ${patient_gender}) ;;
  }

  dimension: PARTICIPANT_FLAG {
    type: string
    label: "PARTICIPANT FLAG"
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: PARTICIPANT_YEAR {
    type: string
    label: "PARTICIPANT YEAR"
    sql: ${TABLE}."PARTICIPANT_YEAR" ;;
  }

  dimension: TERMINATION_DATE {
    type: date
    label: "Eligibility Termination Date"
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension: Current_date {
    type: date
    label: "Current date"
    sql: CURRENT_DATE() ;;
  }

  dimension: termination_date_filter {
    type: string
    sql: CASE WHEN ${TERMINATION_DATE} > ${Current_date} OR ${TERMINATION_DATE} IS NULL THEN 'After Current date'
      ELSE 'On/Before Current date'
      END;;
  }

  dimension: EFFECTIVE_DATE {
    type: date
    label: "Eligibility Effective Date"
    sql: ${TABLE}."EFFECTIVE_DATE" ;;
  }

  dimension: effective_date_filter {
    type: string
    sql: CASE WHEN DATEDIFF(day, ${Current_date}, ${EFFECTIVE_DATE}) >= -30 AND DATEDIFF(day, ${Current_date}, ${EFFECTIVE_DATE}) <= 30 THEN 'On or within 30 days before Current Date'
          ELSE 'Outside of 30 days before Current Date'
          END;;
  }

  dimension: Email {
    type: string
    label: "Member Email Address"
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: Address {
    type: string
    label: "Member Address"
    sql: ${TABLE}."ADDRESS" ;;
  }

  dimension: Phone {
    type: string
    label: "Member Phone Number"
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: State {
    type: string
    label: "Member State"
    sql: ${TABLE}."STATE" ;;
  }

  dimension: Zip_Code {
    type: string
    label: "Member Zip Code"
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: Class_Code {
    type: string
    label: "Class Code"
    sql: ${TABLE}."CLASS_CODE" ;;
  }

  dimension: City {
    type: string
    label: "Member City"
    sql: ${TABLE}."CITY" ;;
  }

  dimension: member_id_with_class_code{
    type: string
    label: "MEMBER ID (Class Code)"
    sql: CONCAT(${TABLE}."MEMBER_ID", ' (', ${Class_Code}, ')')  ;;

  }


  dimension: PRIMARY_INSURED_FIRSTNAME {
    type: string
    label: "Primary Insured First Name"
    sql: null ;;
  }

  dimension: PRIMARY_INSURED_LASTNAME {
    type: string
    label: "Primary Insured Last Name"
    sql: null ;;
  }

  dimension: Medical {
    type: string
    label: "Medical"
    sql: ${TABLE}."MEDICAL" ;;
  }

  dimension: Pharmacy {
    type: string
    label: "Pharmacy"
    sql: ${TABLE}."PHARMA" ;;
  }

  dimension: Eligibility {
    type: string
    label: "Eligibility"
    sql: ${TABLE}."ELIG" ;;
  }

  measure: Medical_Patients {
    type: sum
    label: "Medical - N"
    sql: ${Medical} ;;
  }

  measure: Pharmacy_Patients {
    type: sum
    label: "Pharmacy - N"
    sql: ${TABLE}."PHARMA" ;;
  }

  measure: Eligibility_Patients {
    type: sum
    label: "Eligibility - N"
    sql: ${TABLE}."ELIG" ;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    # value_format: "#,##0"
    sql:  ${unique_id} ;;
  }

  measure: PARTICIPANT_PROGRAM_NAME_1{
    type: string
    label: "PARTICIPANT PROGRAM NAME 1"
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME";;
  }

  dimension: onboard_status{
    type: string
    label: "Onboard Status"
    sql: ${TABLE}."ONBOARD_STATUS" ;;
  }

  dimension_group: ON_BOARD_DATE {
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
    label: "ON BOARD DATE"
    drill_fields: [ON_BOARD_DATE_year, ON_BOARD_DATE_quarter, ON_BOARD_DATE_month, ON_BOARD_DATE_raw]
    sql: ${TABLE}."ON_BOARD_DATE" ;;

  }
}
