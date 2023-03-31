view: vw_stg_tab_pharma_classes {
  sql_table_name: "SCH_KAIROS_MASTERS"."STG_TAB_PHARMA_CLASSES"
    ;;

  dimension: atc_lvl_1 {
    type: string
    sql: ${TABLE}."ATC_LVL_1" ;;
  }

  dimension: atc_lvl_1_classname {
    type: string
    label: "ATC Class 1 Name"
    sql: ${TABLE}."ATC_LVL_1_CLASSNAME" ;;
  }

  dimension: atc_lvl_2 {
    type: string
    sql: ${TABLE}."ATC_LVL_2" ;;
  }

  dimension: atc_lvl_2_classname {
    type: string
    label: "ATC Class 2 Name"
    sql: ${TABLE}."ATC_LVL_2_CLASSNAME" ;;
  }

  dimension: atc_lvl_3 {
    type: string
    sql: ${TABLE}."ATC_LVL_3" ;;
  }

  dimension: atc_lvl_3_classname {
    type: string
    label: "ATC Class 3 Name"
    sql: ${TABLE}."ATC_LVL_3_CLASSNAME" ;;
  }

  dimension: atc_lvl_4 {
    type: string
    sql: ${TABLE}."ATC_LVL_4" ;;
  }

  dimension: atc_lvl_4_classname {
    type: string
    label: "ATC Class 4 Name"
    sql: ${TABLE}."ATC_LVL_4_CLASSNAME" ;;
  }

  dimension: class_id {
    type: string
    sql: ${TABLE}."classId" ;;
  }

  dimension: ndc {
    type: string
    sql: ${TABLE}."NDC" ;;
  }

  dimension: package_ndc {
    type: string
    sql: ${TABLE}."package_ndc" ;;
  }

  measure: count {
    type: count
    drill_fields: [atc_lvl_2_classname, atc_lvl_1_classname, atc_lvl_4_classname, atc_lvl_3_classname]
  }

  dimension: atc_code {
    type: string
    sql: CONCAT(${atc_lvl_1}, ${atc_lvl_2}, ${atc_lvl_3}, ${atc_lvl_4}) ;;
  }
}
