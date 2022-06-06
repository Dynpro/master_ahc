view: patient_drug_summary {
  derived_table: {
    sql: Select
        "UNIQUE_ID" as PATIENT_ID_M,
        LEFT(({% if reporting_date_filter._parameter_value == "'Paid'" %} "PAID_DATE"
          {% elsif reporting_date_filter._parameter_value == "'Filled'" %} "DATE_FILLED"
          {% else %} "DATE_FILLED"
          {% endif %}), 4) as YEAR,
        SUM("TOTAL_EMPLOYER_PAID_AMT") as TOTAL_PAID_AMT,
        LISTAGG(DISTINCT "TEA_CATEGORY", ' || ') within group (order by "TEA_CATEGORY" ASC) as TEA_CATEGORY_LIST,
        LISTAGG(DISTINCT "DRUG_NAME", ' || ') within group (order by "DRUG_NAME" ASC) as DRUG_LIST,
        LISTAGG(DISTINCT "DRUG_CODE", ' || ') within group (order by "DRUG_CODE" ASC) as DRUG_CODE_LIST
        FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY"

      GROUP BY PATIENT_ID_M, YEAR
      ;;
  }


  dimension: PATIENT_ID {
    type: string
    drill_fields: [vw_pharmacy.tea_category, vw_pharmacy.drug_name]
    label: "Patient Id"
    sql: ${TABLE}.PATIENT_ID_M ;;
  }

  filter: Tea_Category_1 {
    type: string
    group_label: "TEA CATEGORY"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
    sql: {% condition Tea_Category_1 %} ${TEA_CATEGORY_List_1} {% endcondition %} ;;
  }

  filter: Tea_Category_2 {
    type: string
    group_label: "TEA CATEGORY"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
    sql: {% condition Tea_Category_2 %} ${TEA_CATEGORY_List_2} {% endcondition %} ;;
  }

  filter: Tea_Category_3 {
    type: string
    group_label: "TEA CATEGORY"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.tea_category
    sql: {% condition Tea_Category_3 %} ${TEA_CATEGORY_List_3} {% endcondition %} ;;
  }

  dimension: TEA_CATEGORY_List_1 {
    type: string
    label: "Tea Category List"
    sql: ${TABLE}.TEA_CATEGORY_LIST ;;
  }

  dimension: TEA_CATEGORY_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.TEA_CATEGORY_LIST ;;
  }

  dimension: TEA_CATEGORY_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.TEA_CATEGORY_LIST ;;
  }

  filter: Drug_1 {
    type: string
    group_label: "DRUGS"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_name
    sql: {% condition Drug_1 %} ${DRUG_List_1} {% endcondition %} ;;
  }

  filter: Drug_2 {
    type: string
    group_label: "DRUGS"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_name
    sql: {% condition Drug_2 %} ${DRUG_List_2} {% endcondition %} ;;
  }

  filter: Drug_3 {
    type: string
    group_label: "DRUGS"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_name
    sql: {% condition Drug_3 %} ${DRUG_List_3} {% endcondition %} ;;
  }

  dimension: DRUG_List_1 {
    type: string
    label: "Drug List"
    sql: ${TABLE}.DRUG_LIST ;;
  }

  dimension: DRUG_List_2 {
    type: string
    hidden: yes
    label: "DRUG List"
    sql: ${TABLE}.DRUG_LIST ;;
  }

  dimension: DRUG_List_3 {
    type: string
    hidden: yes
    label: "DRUG List"
    sql: ${TABLE}.DRUG_LIST ;;
  }

  filter: Drug_Code_1 {
    type: string
    group_label: "DRUG CODE"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
    sql: {% condition Drug_Code_1 %} ${DRUG_CODE_List_1} {% endcondition %} ;;
  }

  filter: Drug_Code_2 {
    type: string
    group_label: "DRUG CODE"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
    sql: {% condition Drug_Code_2 %} ${DRUG_CODE_List_2} {% endcondition %} ;;
  }

  filter: Drug_Code_3 {
    type: string
    group_label: "DRUG CODE"
    suggest_explore: vw_pharmacy
    suggest_dimension: vw_pharmacy.drug_code
    sql: {% condition Drug_Code_3 %} ${DRUG_CODE_List_3} {% endcondition %} ;;
  }

  dimension: DRUG_CODE_List_1{
    type: string
    label: "DRUG CODE List"
    sql: ${TABLE}.DRUG_CODE_LIST  ;;
  }

  dimension: DRUG_CODE_List_2{
    type: string
    hidden: yes
    label: "DRUG CODE List"
    sql: ${TABLE}.DRUG_CODE_LIST  ;;
  }

  dimension: DRUG_CODE_List_3{
    type: string
    hidden: yes
    label: "DRUG CODE"
    sql: ${TABLE}.DRUG_CODE_LIST ;;
  }


  dimension: PAID_YEAR {
    type: string
    label: "Paid Year"
    sql: ${TABLE}.YEAR ;;
  }

  measure: total_summary_paid_amt {
    type: sum
    label: "Total Summary $"
    sql: ${TABLE}.TOTAL_PAID_AMT ;;
  }
  parameter: reporting_date_filter {
    type: string
    label: "Reporting date"
    allowed_value: {
      value: "Filled"
      label: "Prescription Filled date"}
    allowed_value: {
      value: "Paid"
      label: "Claim Paid date"}
  }

  dimension: reporting_year {
    type: string
    label: "Reporting year"
    sql: ${TABLE}.YEAR ;;
  }
}
