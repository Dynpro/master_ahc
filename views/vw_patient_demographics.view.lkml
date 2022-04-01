view: vw_patient_demographics {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."VW_PATIENT_DEMOGRAPHICS"
    ;;

  dimension: dependent_f_name {
    type: string
    hidden: yes
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    type: string
    hidden: yes
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: dependent_m_name {
    type: string
    hidden: yes
    sql: ${TABLE}."DEPENDENT_M_NAME" ;;
  }

  dimension: patient_name {
    type: string
    sql: CONCAT(IFNULL(${dependent_f_name}, ''), ' ', IFNULL(${dependent_m_name}, ''), ' ', IFNULL(${dependent_l_name}, '')) ;;
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

  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
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
    hidden: yes
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: PARTICIPANT_Flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
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
}
