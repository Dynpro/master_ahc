#This view is created for dashboard  - "Vital Sign Red Alert Report"

view: zone_filter {
  derived_table: {
    sql: select UNIQUE_ID,
          DATE,
          ZONE
          FROM DB_KAIROS_PROD.SCH_AHC_CRISP_REGIONAL.LKR_TAB_VITAL_ALERT
          ORDER BY UNIQUE_ID,ZONE ASC ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: zone {
    type: string
    sql: ${TABLE}."ZONE" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE" ;;
  }

}
