view: patient_all_medical_pharmacy_summary {
  derived_table: {
    sql: select
      MP.UNIQUE_ID as UNIQUE_ID,
      MP.SERVICE_YEAR as YEAR,
      M1.RISK_GROUP as RISK_GROUP,
      M1.CCW_CHRONIC_CAT_LIST as CCW_CHRONIC_CAT_LIST,
      M1.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY_M,
      M1.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY_M,
      M1.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY_M,
      P1.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY_P,
      P1.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY_P,
      P1.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY_P,
      SUM(M1.TOTAL_PAID_AMT) as TOTAL_PAID_AMT_M,
      SUM(M1.CHRONIC_TOTAL_PAID_AMT) as CHRONIC_TOTAL_PAID_AMT,
      M2.DIAGNOSIS_CATEGORY_LIST as DIAGNOSIS_CATEGORY_LIST,
      M2.DIAGNOSIS_DESCRIPTION_LIST as DIAGNOSIS_DESCRIPTION_LIST,
      M2.CHRONIC_CATEGORY_LIST as CHRONIC_CATEGORY_LIST,
      M2.PROCEDURE_DESCRIPTION_LIST as PROCEDURE_DESCRIPTION_LIST,
      M2.PROCEDURE_CATEGORY_LIST as PROCEDURE_CATEGORY_LIST,
      SUM(P1.TOTAL_PAID_AMT) as TOTAL_PAID_AMT_P,
      P2.TEA_CATEGORY_LIST as TEA_CATEGORY_LIST,
      P2.DRUG_LIST as DRUG_LIST,
      P2.DRUG_CODE_LIST as DRUG_CODE_LIST
    from

      (SELECT SERVICE_YEAR, UNIQUE_ID FROM /*To get all Patient's ID from both medical & pharmacy data*/
      ((SELECT LEFT("DIAGNOSIS_DATE", 4) AS SERVICE_YEAR, "UNIQUE_ID" FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      GROUP BY SERVICE_YEAR, "UNIQUE_ID")
      UNION
      (select DISTINCT LEFT("DATE_FILLED", 4) as SERVICE_YEAR, UNIQUE_ID from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      GROUP BY SERVICE_YEAR, "UNIQUE_ID"))
      GROUP BY SERVICE_YEAR, UNIQUE_ID) AS MP

      LEFT JOIN /*To get the Patient's yearwise medical summary*/

      (select M1_1.PATIENT_ID_M as PATIENT_ID_M,
      M1_1.SERVICE_YEAR as SERVICE_YEAR,
      M1_1.RISK_GROUP as RISK_GROUP,
      LISTAGG(DISTINCT M1_1.CCW_CHRONIC_CAT, ' || ') within group (order by M1_1.CCW_CHRONIC_CAT ASC) as CCW_CHRONIC_CAT_LIST,
      SUM(M1_1.TOTAL_PAID_AMT) as TOTAL_PAID_AMT,
      SUM(CASE WHEN M1_1.CCW_CHRONIC_CAT IS NULL THEN 0
      ELSE M1_1.TOTAL_PAID_AMT
      END) AS CHRONIC_TOTAL_PAID_AMT,
      M1_1.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY,
      M1_1.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY,
      M1_1.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY
      FROM
      (Select
      "UNIQUE_ID" as PATIENT_ID_M,
      LEFT("DIAGNOSIS_DATE", 4) as SERVICE_YEAR,
      "RISK_GROUP" as RISK_GROUP,
      "CCW_CHRONIC_CAT" as CCW_CHRONIC_CAT,
      "TOTAL_EMPLOYER_PAID_AMT" as TOTAL_PAID_AMT,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR) as TOTAL_SPEND_YEARLY,
      COUNT(DISTINCT "UNIQUE_ID") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_PATIENTS_YEARLY,
      (CASE WHEN TOTAL_PATIENTS_YEARLY <> 0 THEN TOTAL_SPEND_YEARLY/TOTAL_PATIENTS_YEARLY
      ELSE 0
      END) as AVERAGE_SPEND_YEARLY
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE
      {% condition CHRONIC_CATEGORY %} "CCW_CHRONIC_CAT" {% endcondition %} AND
      {% condition DIAGNOSIS_CATEGORY %} "ICD_DISEASE_CATEGORY" {% endcondition %}) as M1_1
      GROUP BY M1_1.PATIENT_ID_M, M1_1.SERVICE_YEAR, M1_1.RISK_GROUP, M1_1.TOTAL_SPEND_YEARLY,
      M1_1.TOTAL_PATIENTS_YEARLY, M1_1.AVERAGE_SPEND_YEARLY) as M1

      ON MP.UNIQUE_ID = M1.PATIENT_ID_M AND
      MP.SERVICE_YEAR = M1.SERVICE_YEAR

      LEFT JOIN /*To get the Patient's yearwise pharmacy summary*/

      (Select P1_1.PATIENT_ID_P as PATIENT_ID_P,
      P1_1.SERVICE_YEAR as SERVICE_YEAR,
      SUM(P1_1.TOTAL_PAID_AMT) as TOTAL_PAID_AMT,
      P1_1.TOTAL_SPEND_YEARLY as TOTAL_SPEND_YEARLY,
      P1_1.TOTAL_PATIENTS_YEARLY as TOTAL_PATIENTS_YEARLY,
      P1_1.AVERAGE_SPEND_YEARLY as AVERAGE_SPEND_YEARLY
      FROM
      (Select
      "UNIQUE_ID" as PATIENT_ID_P,
      LEFT("DATE_FILLED", 4) as SERVICE_YEAR,
      "TOTAL_EMPLOYER_PAID_AMT" as TOTAL_PAID_AMT,
      SUM("TOTAL_EMPLOYER_PAID_AMT") OVER (PARTITION BY SERVICE_YEAR) as TOTAL_SPEND_YEARLY,
      COUNT(DISTINCT "UNIQUE_ID") OVER (PARTITION BY SERVICE_YEAR) AS TOTAL_PATIENTS_YEARLY,
      (CASE WHEN TOTAL_PATIENTS_YEARLY <> 0 THEN TOTAL_SPEND_YEARLY/TOTAL_PATIENTS_YEARLY
      ELSE 0
      END) as AVERAGE_SPEND_YEARLY
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY") as P1_1
      GROUP BY  P1_1.PATIENT_ID_P, P1_1.SERVICE_YEAR, P1_1.TOTAL_SPEND_YEARLY,
      P1_1.TOTAL_PATIENTS_YEARLY, P1_1.AVERAGE_SPEND_YEARLY) as P1

      ON MP.UNIQUE_ID = P1.PATIENT_ID_P AND
      MP.SERVICE_YEAR = P1.SERVICE_YEAR


      LEFT JOIN /*To get the Diagnosis/Chronic category list for Patient's entire medical summary*/
      (Select
      "UNIQUE_ID" as PATIENT_ID_M,
      LISTAGG(DISTINCT "ICD_DISEASE_CATEGORY", ' || ') within group (order by "ICD_DISEASE_CATEGORY" ASC) as DIAGNOSIS_CATEGORY_LIST,
      LISTAGG(DISTINCT "ICD_DESCRIPTION", ' || ') within group (order by "ICD_DESCRIPTION" ASC) as DIAGNOSIS_DESCRIPTION_LIST,
      LISTAGG(DISTINCT "CCW_CHRONIC_CAT", ' || ') within group (order by "CCW_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_LIST,
      LISTAGG(DISTINCT "PROCEDURE_DESCRIPTION", ' || ') within group (order by "PROCEDURE_DESCRIPTION" ASC) as PROCEDURE_DESCRIPTION_LIST,
      LISTAGG(DISTINCT "PROCEDURE_CATEGORY", ' || ') within group (order by "PROCEDURE_CATEGORY" ASC) as PROCEDURE_CATEGORY_LIST
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
      WHERE {% condition CHRONIC_CATEGORY %} "CCW_CHRONIC_CAT" {% endcondition %}
      GROUP BY PATIENT_ID_M) as M2
      ON MP.UNIQUE_ID = M2.PATIENT_ID_M

      LEFT JOIN /*To get the Drugs & Tea category list for Patient's entire pharma summary*/
      (Select
      "UNIQUE_ID" as PATIENT_ID_P,
      LISTAGG(DISTINCT "TEA_CATEGORY", ' || ') within group (order by "TEA_CATEGORY" ASC) as TEA_CATEGORY_LIST,
      LISTAGG(DISTINCT "DRUG_NAME", ' || ') within group (order by "DRUG_NAME" ASC) as DRUG_LIST,
      LISTAGG(DISTINCT "DRUG_CODE", ' || ') within group (order by "DRUG_CODE" ASC) as DRUG_CODE_LIST
      FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"
      GROUP BY PATIENT_ID_P) as P2
      ON MP.UNIQUE_ID = P2.PATIENT_ID_P

      GROUP BY UNIQUE_ID, YEAR, RISK_GROUP,CCW_CHRONIC_CAT_LIST, DIAGNOSIS_CATEGORY_LIST, DIAGNOSIS_DESCRIPTION_LIST, CHRONIC_CATEGORY_LIST, PROCEDURE_DESCRIPTION_LIST,
      PROCEDURE_CATEGORY_LIST, TEA_CATEGORY_LIST, DRUG_LIST, DRUG_CODE_LIST, TOTAL_SPEND_YEARLY_M, TOTAL_PATIENTS_YEARLY_M, AVERAGE_SPEND_YEARLY_M, TOTAL_SPEND_YEARLY_P, TOTAL_PATIENTS_YEARLY_P, AVERAGE_SPEND_YEARLY_P
      ;;
  }


#Patient Id from both Medical & Pharmacy data:
  dimension: PATIENT_ID {
    type: string
    primary_key: yes
    label: "Member Id"
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: reporting_year {
    type: number
    label: "Service year"
    sql: ${TABLE}.YEAR ;;
  }

#Pharmacy filters, dimension & measures:
  dimension: TEA_CATEGORY_List {
    type: string
    label: "Tea Category List"
    sql: ${TABLE}.TEA_CATEGORY_LIST ;;
  }

  dimension: DRUG_List {
    type: string
    label: "Drug List"
    sql: ${TABLE}.DRUG_LIST ;;
    html: {% assign words = value | split: ' || ' %}
          <ul>
          {% for word in words %}
          <li>{{ word }}</li>
          {% endfor %} ;;
  }

  dimension: DRUG_CODE_List{
    type: string
    label: "DRUG CODE List"
    sql: ${TABLE}.DRUG_CODE_LIST  ;;
  }

  measure: total_pharma_paid_amt {
    type: sum
    label: "Total Pharma $"
    sql: ${TABLE}.TOTAL_PAID_AMT_P ;;
  }
  dimension: total_spend_yearly_pharmacy {
    type: string
    sql: ${TABLE}."TOTAL_SPEND_YEARLY_P" ;;
  }

  dimension: total_patients_yearly_pharmacy {
    type: string
    label: "Total Members Yearly Pharmacy"
    sql: ${TABLE}."TOTAL_PATIENTS_YEARLY_P" ;;
  }

  dimension: average_spend_yearly_pharmacy {
    type: number
    sql: ${TABLE}."AVERAGE_SPEND_YEARLY_P" ;;
    value_format: "$#,##0.00"
  }

  dimension: total_pharmacy_paid_amount {
    type: number
    sql: ${TABLE}."TOTAL_PAID_AMT_P" ;;
  }

  dimension: patient_total_spend_vs_yearly_avg_spend_pharmacy {
    type: string
    label: "Member Total Spend vs Yearly Avg Spend Pharmacy"
    sql: CASE WHEN ${total_pharmacy_paid_amount} >= ${average_spend_yearly_pharmacy} THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }
#Medical filters, dimension & measures:
  filter: CHRONIC_CATEGORY {
    type: string
    group_label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
  }

  filter: DIAGNOSIS_CATEGORY {
    type: string
    group_label: "DIAGNOSIS CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
  }

  dimension: Diagnosis_Category_List {
    type: string
    hidden: no
    label: "Diagnosis Category List"
    sql: ${TABLE}.DIAGNOSIS_CATEGORY_LIST ;;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

  dimension: Chronic_Category_List {
    type: string
    label: " Chronic Category list"
    drill_fields: [vw_medical.icd_chronic_cat]
    sql: ${TABLE}.CHRONIC_CATEGORY_LIST ;;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

  dimension: PROCEDURE_CATEGORY_List {
    type: string
    label: "Procedure Category List"
    sql: ${TABLE}.PROCEDURE_CATEGORY_LIST ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_List {
    type: string
    label: "Diagnosis Description List"
    sql: ${TABLE}.DIAGNOSIS_DESCRIPTION_LIST ;;
  }

  dimension: PROCEDURE_DESCRIPTION_List {
    type: string
    label: "Procedure Description List"
    sql: ${TABLE}.PROCEDURE_DESCRIPTION_LIST ;;
  }

  dimension: RISK_GROUP {
    type: string
    sql: ${TABLE}.RISK_GROUP ;;
  }

  dimension: CCW_CHRONIC_CAT_LIST {
    type: string
    label: "Chronic Category"
    sql: ${TABLE}.CCW_CHRONIC_CAT_LIST ;;
  }

  measure: total_medical_paid_amt {
    type: sum
    label: "Total Med $"
    sql: ${TABLE}.TOTAL_PAID_AMT_M ;;
  }
  dimension: total_spend_yearly_medical {
    type: string
    sql: ${TABLE}."TOTAL_SPEND_YEARLY_M" ;;
  }

  dimension: total_patients_yearly_medical {
    type: string
    label: "Total Members Yearly Medical"
    sql: ${TABLE}."TOTAL_PATIENTS_YEARLY_M" ;;
  }

  dimension: average_spend_yearly_medical {
    type: number
    sql: ${TABLE}."AVERAGE_SPEND_YEARLY_M" ;;
    value_format: "$#,##0.00"
  }

  dimension: total_medical_paid_amount {
    type: number
    sql: ${TABLE}."TOTAL_PAID_AMT_M" ;;
  }

  dimension: patient_total_spend_vs_yearly_avg_spend_medical {
    type: string
    label: "Member Total Spend vs Yearly Avg Spend Medical"
    sql: CASE WHEN ${total_medical_paid_amount} >= ${average_spend_yearly_medical} THEN 'Greater than Year Average Spend'
      ELSE 'Less than Year Average Spend'
      END ;;
  }
  measure: chronic_total_amt {
    type: sum
    label: "CHRONIC TOTAL $"
    sql: ${TABLE}."CHRONIC_TOTAL_PAID_AMT" ;;
  }

  measure: RISK_GROUP_list {
    type: string
    label: "RISK Group"
    sql: LISTAGG(DISTINCT ${RISK_GROUP}, ' || ') within group (order by ${RISK_GROUP} ASC) ;;
  }

  measure: Chronic_Category_list_2 {
    type: string
    label: "Chronic Category list"
    sql: LISTAGG(DISTINCT ${CCW_CHRONIC_CAT_LIST}, ' || ') within group (order by ${CCW_CHRONIC_CAT_LIST} ASC) ;;
    html: {% assign words = value | split: ' || ' %}
          <ul>
          {% for word in words %}
          <li>{{ word }}</li>
          {% endfor %} ;;
  }

}
