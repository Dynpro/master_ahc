view: icd_infographics {
  sql_table_name: "SCH_ALL_HEALTH_CHOICE"."ICD_INFOGRAPHICS_UPDATED" ;;

  dimension: chronic_flag {
    type: number
    sql: ${TABLE}."CHRONIC_FLAG" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }

  dimension: disease_category {
    type: string
    sql: ${TABLE}."DISEASE_CATEGORY" ;;
  }

  dimension: file_date {
    type: date
    sql: ${TABLE}."DIAGNOSIS_DATE" ;;
  }

  dimension: paid_amount {
    type: number
    sql: ${TABLE}."PAID_AMT" ;;
  }

  dimension: unique_id {
    type: string
    value_format_name: id
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: reconciled_prin_icd_diag_code {
    type: string
    sql: ${TABLE}."RECONCILED_DIAGNOSIS_CODE_ICD10" ;;
  }

  dimension: year_file_date_l {
    type: number
    sql: ${TABLE}."BASE_YEAR" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
