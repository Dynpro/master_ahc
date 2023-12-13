#This view is created for "Hospital visit Statistics" dashboard

view: hospital_visit_30_days {
  derived_table: {
    sql: SELECT
      UNIQUE_ID,
      DIAGNOSIS_MONTH,
      YEAR,
      COUNT(*) AS CNT_30_day_readmissions
      FROM
        (SELECT DISTINCT
            UNIQUE_ID,
            ADMIT_DATE,
            DISCHARGE_DATE,
            TO_CHAR(DATE_TRUNC('MONTH', DIAGNOSIS_DATE), 'YYYY-MM') AS DIAGNOSIS_MONTH,
            YEAR(DIAGNOSIS_DATE) AS YEAR,
            PLACE_OF_SERVICE
          FROM
            "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
             WHERE PLACE_OF_SERVICE IN ('21','31','32')
        ) AS admissions
      WHERE ADMIT_DATE BETWEEN DISCHARGE_DATE - INTERVAL '30 DAY' AND DISCHARGE_DATE
      GROUP BY UNIQUE_ID, DIAGNOSIS_MONTH, YEAR ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: diagnosis_month1 {
    type: string
    label: "Reporting Month"
    sql: ${TABLE}."DIAGNOSIS_MONTH" ;;
  }

  dimension: cnt_30_day_readmissions {
    type: number
    sql: ${TABLE}."CNT_30_DAY_READMISSIONS" ;;
  }

  measure: 30_day_readmissions {
    label: "Number of Hospital Inpatient 30-Day Readmissions"
    type: count_distinct
    sql: ${unique_id} ;;
  }
}
