view: vw_patient_demographics {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PATIENT_DEMOGRAPHICS"
    ;;

  dimension: dependent_f_name {
    label: "Patient First Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    label: "Patient Last Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: dependent_m_name {
    label: "Patient Middle Name"
    type: string
    hidden: no
    sql: ${TABLE}."DEPENDENT_M_NAME" ;;
  }

  dimension: patient_name {
    type: string
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
    label: "Patient DOB"
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_dob1 {
    label: "PATIENT DOB"
    type: string
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_gender {
    type: string
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: patient_current_age {
    type: number
    label: "Patient Age"
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

  dimension: member_id{
    type: string
    label: "MEMBER ID (Relationship)"
    sql: CONCAT(${TABLE}."MEMBER_ID", ' (', ${relationship_to_employee}, ')')  ;;
    #html: <b> {{ member_id._rendered_value }} </b> ({{ relationship_to_employee._rendered_value }})   ;;
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
    type: string
    sql: CONCAT(${patient_name}, ' (', ${member_id_list}, ')')   ;;
  }

  dimension: client_name{
    type: string
    label: "Affiliation"
    sql: 'Master AHC' ;;
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
    label: "Patient Email Address"
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: Address {
    type: string
    label: "Patient Address"
    sql: ${TABLE}."ADDRESS" ;;
  }

  dimension: Phone {
    type: string
    label: "Patient Phone Number"
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: State {
    type: string
    label: "Patient State"
    sql: ${TABLE}."STATE" ;;
  }

  dimension: Zip_Code {
    type: string
    label: "Patient Zip Code"
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: Class_Code {
    type: string
    label: "Class Code"
    sql: ${TABLE}."CLASS_CODE" ;;
  }

  dimension: City {
    type: string
    label: "Patient City"
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
}
