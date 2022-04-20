view: cpt_infographics {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."CPT_INFOGRAPHICS_UPDATED"
    ;;

  dimension: chronic_flag {
    type: number
    sql: ${TABLE}."CHRONIC_FLAG" ;;
  }

  dimension: file_date {
    type: string
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

  dimension: proc_code__hcpcs_code {
    type: string
    sql: ${TABLE}."PRIMARY_PROCEDURE_CODE" ;;
  }

  dimension: proc_group {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: proc_subgroup {
    type: string
    sql: ${TABLE}."SUB_CATEGORY" ;;
  }

  dimension: unnamed_0 {
    type: number
    sql: ${TABLE}."Unnamed: 0"
      ;;
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
