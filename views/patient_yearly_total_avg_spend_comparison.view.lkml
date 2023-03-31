view: patient_yearly_total_avg_spend_comparison {
  label: "Patient Avergae comparison (Yearly)"
  derived_table: {
    sql: SELECT
          MP.UNIQUE_ID as UNIQUE_ID,
          MP.SERVICE_YEAR as SERVICE_YEAR,

      MEDICAL_SUMMARY.TOTAL_PATIENT_YEARLY_PAID_AMT as TOTAL_PATIENT_YEARLY_PAID_AMT_M,
      MEDICAL_SUMMARY.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY_M,
      MEDICAL_SUMMARY.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY_M,
      MEDICAL_SUMMARY.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY_M,
      MEDICAL_SUMMARY.TOTAL_PAID_AMT_ALL_YEARS as TOTAL_PAID_AMT_ALL_YEARS_M,
      MEDICAL_SUMMARY.TOTAL_PATIENTS_ALL_YEARS as TOTAL_PATIENTS_ALL_YEARS_M,
      MEDICAL_SUMMARY.AVERAGE_SPEND_ALL_YEARS as AVERAGE_SPEND_ALL_YEARS_M,
      MEDICAL_SUMMARY.PARTICIPANT_FLAG as PARTICIPANT_FLAG,
      MEDICAL_SUMMARY.PARTICIPANT_PROGRAM_NAME as PARTICIPANT_PROGRAM_NAME,
      MEDICAL_SUMMARY.CHRONIC_CATEGORY_LIST as CHRONIC_CATEGORY_LIST,

      PHARMA_SUMMARY.TOTAL_PATIENT_YEARLY_PAID_AMT as TOTAL_PATIENT_YEARLY_PAID_AMT_P,
      PHARMA_SUMMARY.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY_P,
      PHARMA_SUMMARY.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY_P,
      PHARMA_SUMMARY.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY_P,
      PHARMA_SUMMARY.TOTAL_PAID_AMT_ALL_YEARS as TOTAL_PAID_AMT_ALL_YEARS_P,
      PHARMA_SUMMARY.TOTAL_PATIENTS_ALL_YEARS as TOTAL_PATIENTS_ALL_YEARS_P,
      PHARMA_SUMMARY.AVERAGE_SPEND_ALL_YEARS as AVERAGE_SPEND_ALL_YEARS_P,

      CHRONIC_AVG.CHRONIC_TOTAL_SPEND_YEARLY AS CHRONIC_TOTAL_SPEND_YEARLY,
      CHRONIC_AVG.CHRONIC_TOTAL_PATIENTS_YEARLY AS CHRONIC_TOTAL_PATIENTS_YEARLY,
      CHRONIC_AVG.CHRONIC_AVERAGE_SPEND_YEARLY AS CHRONIC_AVERAGE_SPEND_YEARLY,
      CHRONIC_AVG.CHRONIC_TOTAL_PATIENT_YEARLY_PAID_AMT AS CHRONIC_TOTAL_PATIENT_YEARLY_PAID_AMT

      FROM
      (SELECT SERVICE_YEAR, UNIQUE_ID FROM /*To get all Patient's ID from both medical & pharmacy data*/
      ((SELECT LEFT("DIAGNOSIS_DATE", 4) AS SERVICE_YEAR, "UNIQUE_ID" FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      GROUP BY SERVICE_YEAR, "UNIQUE_ID")
      UNION
      (select DISTINCT LEFT("DATE_FILLED", 4) as SERVICE_YEAR, UNIQUE_ID from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      GROUP BY SERVICE_YEAR, "UNIQUE_ID"))
      GROUP BY SERVICE_YEAR, UNIQUE_ID) AS MP

      JOIN

      (Select DISTINCT
      "UNIQUE_ID" as PATIENT_ID_M,
      LEFT("DIAGNOSIS_DATE", 4) as SERVICE_YEAR,
      "PARTICIPANT_FLAG" as PARTICIPANT_FLAG,
      "PARTICIPANT_PROGRAM_NAME" as PARTICIPANT_PROGRAM_NAME,
      LISTAGG(DISTINCT "CCW_CHRONIC_CAT", ' || ') within group (order by "CCW_CHRONIC_CAT" ASC) OVER (PARTITION BY SERVICE_YEAR, PATIENT_ID_M) as CHRONIC_CATEGORY_LIST,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR, PATIENT_ID_M) as TOTAL_PATIENT_YEARLY_PAID_AMT,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_SPEND_YEARLY,
      COUNT(DISTINCT "UNIQUE_ID") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_PATIENTS_YEARLY,
      (CASE WHEN TOTAL_PATIENTS_YEARLY <> 0 THEN TOTAL_SPEND_YEARLY/TOTAL_PATIENTS_YEARLY
      ELSE 0
      END) as AVERAGE_SPEND_YEARLY,
      (select SUM("TOTAL_EMPLOYER_PAID_AMT") from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL") as TOTAL_PAID_AMT_ALL_YEARS,
      (select COUNT(DISTINCT "UNIQUE_ID") from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL") as TOTAL_PATIENTS_ALL_YEARS,
      (CASE WHEN TOTAL_PATIENTS_ALL_YEARS <> 0 THEN TOTAL_PAID_AMT_ALL_YEARS/TOTAL_PATIENTS_ALL_YEARS
      ELSE 0
      END) as AVERAGE_SPEND_ALL_YEARS
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE {% condition PARTICIPANT_FLAG %} "PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME %} "PARTICIPANT_PROGRAM_NAME" {% endcondition %}) as MEDICAL_SUMMARY
      ON MP.SERVICE_YEAR = MEDICAL_SUMMARY.SERVICE_YEAR
      AND MP.UNIQUE_ID = MEDICAL_SUMMARY.PATIENT_ID_M

      JOIN

      (Select DISTINCT
      "UNIQUE_ID" as PATIENT_ID_M,
      LEFT("DATE_FILLED", 4) as SERVICE_YEAR,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR, PATIENT_ID_M) as TOTAL_PATIENT_YEARLY_PAID_AMT,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_SPEND_YEARLY,
      COUNT(DISTINCT "UNIQUE_ID") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_PATIENTS_YEARLY,
      (CASE WHEN TOTAL_PATIENTS_YEARLY <> 0 THEN TOTAL_SPEND_YEARLY/TOTAL_PATIENTS_YEARLY
      ELSE 0
      END) as AVERAGE_SPEND_YEARLY,
      (select SUM("TOTAL_EMPLOYER_PAID_AMT") from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY") as TOTAL_PAID_AMT_ALL_YEARS,
      (select COUNT(DISTINCT "UNIQUE_ID") from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY") as TOTAL_PATIENTS_ALL_YEARS,
      (CASE WHEN TOTAL_PATIENTS_ALL_YEARS <> 0 THEN TOTAL_PAID_AMT_ALL_YEARS/TOTAL_PATIENTS_ALL_YEARS
      ELSE 0
      END) as AVERAGE_SPEND_ALL_YEARS
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      WHERE {% condition PARTICIPANT_FLAG %} "PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME %} "PARTICIPANT_PROGRAM_NAME" {% endcondition %}) as PHARMA_SUMMARY
      ON MP.SERVICE_YEAR = PHARMA_SUMMARY.SERVICE_YEAR
      AND MP.UNIQUE_ID = PHARMA_SUMMARY.PATIENT_ID_M

      JOIN

      (Select DISTINCT
      "UNIQUE_ID" as PATIENT_ID_M,
      LEFT("DIAGNOSIS_DATE", 4) as SERVICE_YEAR,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR, PATIENT_ID_M) as CHRONIC_TOTAL_PATIENT_YEARLY_PAID_AMT,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR) AS CHRONIC_TOTAL_SPEND_YEARLY,
      COUNT(DISTINCT "UNIQUE_ID") OVER (PARTITION BY SERVICE_YEAR) AS CHRONIC_TOTAL_PATIENTS_YEARLY,
      (CASE WHEN CHRONIC_TOTAL_PATIENTS_YEARLY <> 0 THEN CHRONIC_TOTAL_SPEND_YEARLY/CHRONIC_TOTAL_PATIENTS_YEARLY
      ELSE 0
      END) as CHRONIC_AVERAGE_SPEND_YEARLY
      FROM "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE "CCW_CHRONIC_CAT" IS NOT NULL AND
      {% condition PARTICIPANT_FLAG %} "PARTICIPANT_FLAG" {% endcondition %} AND
      {% condition PARTICIPANT_PROGRAM_NAME %} "PARTICIPANT_PROGRAM_NAME" {% endcondition %}) AS CHRONIC_AVG
      ON MP.SERVICE_YEAR = CHRONIC_AVG.SERVICE_YEAR
      AND MP.UNIQUE_ID = CHRONIC_AVG.PATIENT_ID_M
      ;;
  }

  dimension: chronic_total_amount {
    type: string
    sql: ${TABLE}."CHRONIC_TOTAL_PATIENT_YEARLY_PAID_AMT" ;;
    value_format: "$#,##0"
  }

  dimension: chronic_total_amount_yearly {
    type: string
    sql: ${TABLE}."CHRONIC_TOTAL_SPEND_YEARLY" ;;
  }

  dimension: chronic_total_patients_yearly {
    type: string
    sql: ${TABLE}."CHRONIC_TOTAL_PATIENTS_YEARLY" ;;
  }

  dimension: chronic_average_amount_yearly {
    type: string
    sql: ${TABLE}."CHRONIC_AVERAGE_SPEND_YEARLY" ;;
    value_format: "$#,##0.00"
  }

  dimension: patient_total_chronic_spend_vs_avg_chronic_spend_medical {
    type: string
    sql: CASE WHEN ${chronic_total_amount} >= ${chronic_average_amount_yearly} THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }

  filter: PARTICIPANT_FLAG {
    type: string
    label: "PARTICIPANT FLAG"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }

  filter: PARTICIPANT_PROGRAM_NAME {
    type: string
    label: "PARTICIPANT PROGRAM NAME"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_PROGRAM_NAME
  }

  dimension: patients_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: service_year {
    type: string
    sql: ${TABLE}."SERVICE_YEAR" ;;
  }

  dimension: participant_flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: participant_program_name {
    type: string
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME" ;;
  }

  dimension: chronic_Category_list {
    type: string
    sql: ${TABLE}."CHRONIC_CATEGORY_LIST" ;;
    html: {% assign words = value | split: ' || ' %}
      <ul>
      {% for word in words %}
      <li>{{ word }}</li>
      {% endfor %} ;;
  }

  dimension: total_patient_yearly_paid_amt_medical {
    type: string
    sql: ${TABLE}."TOTAL_PATIENT_YEARLY_PAID_AMT_M" ;;
    value_format: "$#,##0"
  }

  dimension: total_spend_yearly_medical {
    type: string
    sql: ${TABLE}."TOTAL_SPEND_YEARLY_M" ;;
  }

  dimension: total_patients_yearly_medical {
    type: string
    sql: ${TABLE}."TOTAL_PATIENTS_YEARLY_M" ;;
  }

  dimension: average_spend_yearly_medical {
    type: string
    sql: ${TABLE}."AVERAGE_SPEND_YEARLY_M" ;;
    value_format: "$#,##0.00"
  }

  dimension: total_paid_amt_all_years_medical {
    type: string
    sql: ${TABLE}."TOTAL_PAID_AMT_ALL_YEARS_M" ;;
  }

  dimension: total_patients_all_years_medical {
    type: string
    sql: ${TABLE}."TOTAL_PATIENTS_ALL_YEARS_M" ;;
  }

  dimension: average_spend_all_years_medical {
    type: string
    sql: ${TABLE}."AVERAGE_SPEND_ALL_YEARS_M" ;;
  }

  dimension: patient_total_spend_vs_yearly_avg_spend_medical {
    type: string
    sql: CASE WHEN ${total_patient_yearly_paid_amt_medical} >= ${average_spend_yearly_medical} THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }

  dimension: total_patient_yearly_paid_amt_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_PATIENT_YEARLY_PAID_AMT_P" ;;
    value_format: "$#,##0"
  }

  dimension: total_spend_yearly_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_SPEND_YEARLY_P" ;;
  }

  dimension: total_patients_yearly_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_PATIENTS_YEARLY_P" ;;
  }

  dimension: average_spend_yearly_pharmacy {
    type: string
    sql: ${TABLE}."AVERAGE_SPEND_YEARLY_P" ;;
    value_format: "$#,##0.00"
  }

  dimension: total_paid_amt_all_years_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_PAID_AMT_ALL_YEARS_P" ;;
  }

  dimension: total_patients_all_years_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_PATIENTS_ALL_YEARS_P" ;;
  }

  dimension: average_spend_all_years_pharmacy {
    type: string
    sql: ${TABLE}."AVERAGE_SPEND_ALL_YEARS_P" ;;
  }

  dimension: patient_total_spend_vs_yearly_avg_spend_pharmacy {
    type: string
    sql: CASE WHEN ${total_patient_yearly_paid_amt_pharmacy} >= ${average_spend_yearly_pharmacy} THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }

  dimension: patient_total_spend_vs_avg_spend_medical_pharmacy {
    type: string
    hidden: yes
    sql: CASE WHEN ${patient_total_spend_vs_yearly_avg_spend_medical} = 'Greater than Year Average Spend' AND ${patient_total_spend_vs_yearly_avg_spend_pharmacy} = 'Greater than Year Average Spend' THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }

}
