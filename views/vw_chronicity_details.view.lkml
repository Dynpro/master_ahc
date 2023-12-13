view: vw_chronicity_details {

  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."ML_CHRONICITY_DETAILS";;
  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: ccw_chronic_cat {
    type: string
    sql: ${TABLE}."CCW_CHRONIC_CAT" ;;
  }

  dimension: base_year {
    type: string
    sql: CAST(${TABLE}."BASE_YEAR" as integer) ;;

  }

}
