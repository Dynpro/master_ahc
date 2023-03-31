view: vw_chronicity_details {

  sql_table_name: "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."ML_CHRONICITY_DETAILS" ;;

  dimension: UNIQUE_ID {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension:BASE_YEAR  {
    type: string
    sql: ${TABLE}."BASE_YEAR" ;;
  }

  dimension:CCW_CHRONIC_CAT  {
    type: string
    sql: ${TABLE}."CCW_CHRONIC_CAT" ;;
  }

}
