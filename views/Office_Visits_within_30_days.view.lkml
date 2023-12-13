#This view is created for "Hospital visit Statistics" dashboard

view: Office_Visits_within_30_days {
  derived_table: {
    sql: SELECT
      UNIQUE_ID,
      DIAGNOSIS_MONTH,
      YEAR,
      COUNT(*) AS CNT_30_day_readmissions
      FROM (SELECT
            DISTINCT UNIQUE_ID,
            DIAGNOSIS_DATE,
            DISCHARGE_DATE,
            YEAR(DIAGNOSIS_DATE) AS YEAR,
            TO_CHAR(DATE_TRUNC('MONTH', DIAGNOSIS_DATE), 'YYYY-MM') AS DIAGNOSIS_MONTH,
            (CASE WHEN RECONCILED_DIAGNOSIS_CODE_ICD10 IN ('Z0000', 'Z0001') OR
              PRIMARY_PROCEDURE_CODE IN ('99214', '99381', '99382', '99383', '99384', '99385', '99386', '99387', '99391', '99392', '99393',
                                        '99394', '99395', '99396', '99397', '99401', '99402', '99403', '99404', '99411', '99412', '99461',
                                        '99497', '99497', '99497', 'G0296', 'G0402', 'G0438', 'G0439', 'G0445', 'G0468', 'S0610', 'S0612', 'S0613') OR
              SERVICE_PROVIDER_SPECIALITY_CODE IN ('01', '08', '11', '16', '50', '97') OR
              PLACE_OF_SERVICE IN ('5', '6', '7', '8', '11', '17', '18', '49', '71', '72') THEN 'PRIMARY CARE PHYSICIAN SERVICES'
              ELSE 'OTHER SERVICES'
              END) as PCP
              FROM "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
        ) AS admissions
      WHERE DIAGNOSIS_DATE BETWEEN DISCHARGE_DATE - INTERVAL '30 DAY' AND DISCHARGE_DATE AND PCP = 'PRIMARY CARE PHYSICIAN SERVICES'
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

  measure: office_visits_30_day_readmissions {
    label: "Office Visits within 30 days after Hospital Inpatient Admission"
    type: count_distinct
    sql: ${unique_id} ;;
  }

}
