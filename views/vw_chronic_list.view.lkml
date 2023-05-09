view: vw_chronic_list {

  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."ML_CHRONICITY_DATA_GROUPED"
    ;;
  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }


  dimension: chronic_cat_list {
    type: string
    sql: ${TABLE}."CCW_CHRONIC_CAT" ;;
  }

  dimension: file_year {
    type: string
    sql: CAST(${TABLE}."FILE_YEAR" as integer) ;;

  }

}
