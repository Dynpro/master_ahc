
view: pharmacy_expense_top_and_bottom {
  derived_table: {
    sql: WITH TOP_CTE AS (
                SELECT UNIQUE_ID,YEAR,AMT
              FROM (
                SELECT UNIQUE_ID, SUM(TOTAL_EMPLOYER_PAID_AMT) AS AMT,YEAR(DATE_FILLED) AS YEAR,
                       NTILE(100) OVER (PARTITION BY YEAR ORDER BY AMT DESC) AS percentile
                FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
                where TOTAL_EMPLOYER_PAID_AMT != '0'
                GROUP BY UNIQUE_ID,YEAR
              ) AS ranked
              WHERE percentile = 1
              GROUP BY UNIQUE_ID,YEAR,AMT ORDER BY AMT DESC),

      BOTTOM_CTE AS (
      SELECT UNIQUE_ID,YEAR,AMT
      FROM (
      SELECT UNIQUE_ID, SUM(TOTAL_EMPLOYER_PAID_AMT) AS AMT,YEAR(DATE_FILLED) AS YEAR,
      NTILE(100) OVER (PARTITION BY YEAR ORDER BY AMT ASC) AS percentile
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      where TOTAL_EMPLOYER_PAID_AMT != '0' GROUP BY UNIQUE_ID,YEAR
      ) AS ranked
      WHERE percentile = 1
      GROUP BY UNIQUE_ID,YEAR,AMT ORDER BY AMT
      ),
      FINAL_CTE AS (
      SELECT *,'1' AS STATUS FROM TOP_CTE
      UNION
      SELECT *,'0' AS STATUS FROM BOTTOM_CTE
      )
      SELECT * FROM FINAL_CTE ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: amt {
    type: number
    sql: ${TABLE}."AMT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: pharma_spend_top_and_bottom_1_percent {
    type: string
    sql: case when ${status}= '1' then 'spend top 1%'
           when ${status}= '0' then 'spend bottom 1%'
          ELSE 'other'
              END;;
  }


  set: detail {
    fields: [
      unique_id,
      year,
      amt,
      status
    ]
  }
}
