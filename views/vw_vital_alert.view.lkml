view: vw_vital_alert {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_VITAL_ALERT"
    ;;

  dimension: active {
    type: string
    sql: ${TABLE}."ACTIVE" ;;
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."AFFILIATION" ;;
  }

  dimension: care_recipient_first_name {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_FIRST_NAME" ;;
  }

  dimension: care_recipient_last_name {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_LAST_NAME" ;;
  }

  dimension: checked_cleared_by {
    type: string
    sql: ${TABLE}."CHECKED_CLEARED_BY" ;;
  }

  dimension_group: checked_cleared {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CHECKED_CLEARED_DATE" ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}."DATE" ;;
  }

  dimension: dependent_f_name {
    type: string
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    type: string
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: diastolic {
    type: string
    sql: ${TABLE}."DIASTOLIC" ;;
  }

  dimension_group: dob {
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
    sql: ${TABLE}."DOB" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: issue {
    type: string
    sql: ${TABLE}."ISSUE" ;;
  }

  dimension_group: last_update_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: load_by {
    type: string
    sql: ${TABLE}."LOAD_BY" ;;
  }

  dimension_group: load {
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
    sql: ${TABLE}."LOAD_DATE" ;;
  }

  dimension: participant_program_name {
    type: string
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME" ;;
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
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_gender {
    type: string
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: program {
    type: string
    sql: ${TABLE}."PROGRAM" ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}."SOURCE" ;;
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
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_LOAD_TIMESTAMP" ;;
  }

  dimension: stage_flag {
    type: yesno
    sql: ${TABLE}."STAGE_FLAG" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: systolic {
    type: string
    sql: ${TABLE}."SYSTOLIC" ;;
  }

  dimension: ticket_description {
    type: string
    sql: ${TABLE}."TICKET_DESCRIPTION" ;;
  }

  dimension: ticket_no {
    type: string
    sql: ${TABLE}."TICKET_NO" ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}."TIME" ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${unique_id} ;;
  }

  dimension: vital {
    type: string
    sql: ${TABLE}."VITAL" ;;
  }

  dimension: zone {
    type: string
    sql: ${TABLE}."ZONE" ;;
  }

  measure: count {
    type: count
    drill_fields: [care_recipient_last_name, care_recipient_first_name, dependent_f_name, participant_program_name, dependent_l_name]
  }

  dimension: vital_sign_measurements{
    type: string
    sql: case when ${systolic} < '120' and ${diastolic} < '80' then 'Normal'
              when ${systolic} IN('120','121','122','123','124','125','126','127','128','129') and ${diastolic} < '80' then 'Elevated'
              when ${systolic} >= '130' and ${diastolic} >= '80' then 'High Blood Presure (Hypertension)'
         else 'Other'
         END;;
  }
}
