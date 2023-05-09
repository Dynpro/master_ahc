
view: vw_participant_trigger {
  label: "Participant Trigger"
  sql_table_name:  "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PARTICIPANT_TRIGGER";;

  dimension: unique_id {
    type: string
    primary_key: yes
    hidden: no
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: Trigger_Year {
    type: string
    hidden: no
    sql: ${TABLE}."TRIGGERS" ;;
  }

  dimension: Plan_Year {
    type: string
    hidden: no
    sql: ${TABLE}."PLAN_YEAR" ;;
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
  dimension: PARTICIPANT_PROGRAM_NAME{
    type: string
    label: "PARTICIPANT PROGRAM NAME"
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME";;
  }

  dimension: PARTICIPANT_NONPARTICIPANT_Flag {
    type: string
    hidden:  no
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }
  dimension: Participant_Year {
    type: string
    hidden: no
    sql: ${TABLE}."PARTICIPANT_YEAR" ;;
  }
}
