view: vw_plan_year {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."ML_PLAN_YEAR_DETAILS"
    ;;
  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }


  dimension: plan_year {
    type: string
    sql: CAST(${TABLE}."PLAN_YEAR" as integer) ;;
  }

  dimension: file_year {
    type: string
    sql: CAST(${TABLE}."FILE_YEAR" as integer) ;;

  }

}
