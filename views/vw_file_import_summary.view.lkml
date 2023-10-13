view: vw_file_import_summary{
  derived_table: {
    sql: select * from "SCH_AHC_CRISP_REGIONAL"."VW_FILE_IMPORT_SUMMARY" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."DATE" ;;
  }

  dimension: staging_date {
    type: date
    label: "File Import Date"
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  dimension: row_count {
    type: number
    sql: ${TABLE}."ROW_COUNT" ;;
  }

  dimension: total_n {
    type: number
    sql: ${TABLE}."TOTAL_N" ;;
  }

  dimension: total_paid {
    type: number
    label: "Total Paid $"
    sql: ${TABLE}."TOTAL_PAID" ;;
  }

  dimension: total_billed {
    type: number
    label: "Total Billed $"
    sql: ${TABLE}."TOTAL_BILLED" ;;
  }

  dimension: paid_date_range {
    type: string
    sql: ${TABLE}."PAID_DATE_RANGE" ;;
  }

  dimension: service_date_range {
    type: string
    sql: ${TABLE}."SERVICE_DATE_RANGE" ;;
  }

  dimension: eligible_n {
    type: number
    sql: ${TABLE}."ELIGIBLE_N" ;;
  }

  dimension: terminated_n {
    type: number
    sql: ${TABLE}."TERMINATED_N" ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}."DATA_TYPE" ;;
  }

  set: detail {
    fields: [
      date,
      staging_date,
      row_count,
      total_n,
      total_paid,
      total_billed,
      paid_date_range,
      service_date_range,
      eligible_n,
      terminated_n,
      data_type
    ]
  }
}
