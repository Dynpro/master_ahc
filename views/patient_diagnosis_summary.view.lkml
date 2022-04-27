view: patient_diagnosis_summary {
  derived_table: {
    sql: Select
        "UNIQUE_ID" as PATIENT_ID_M,
        LEFT("PAID_DATE", 4) as PAID_YEAR,
        SUM("TOTAL_EMPLOYER_PAID_AMT") as TOTAL_PAID_AMT,
        LISTAGG(DISTINCT "ICD_DISEASE_CATEGORY", ' || ') within group (order by "ICD_DISEASE_CATEGORY" ASC) as DIAGNOSIS_CATEGORY_LIST,
        LISTAGG(DISTINCT "ICD_DESCRIPTION", ' || ') within group (order by "ICD_DESCRIPTION" ASC) as DIAGNOSIS_DESCRIPTION_LIST,
        LISTAGG(DISTINCT "ICD_CHRONIC_CAT", ' || ') within group (order by "ICD_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_LIST,
        LISTAGG(DISTINCT "PROCEDURE_DESCRIPTION", ' || ') within group (order by "PROCEDURE_DESCRIPTION" ASC) as PROCEDURE_DESCRIPTION_LIST,
        LISTAGG(DISTINCT "PROCEDURE_CATEGORY", ' || ') within group (order by "PROCEDURE_CATEGORY" ASC) as PROCEDURE_CATEGORY_LIST
        FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"

      GROUP BY PATIENT_ID_M, PAID_YEAR
      ;;
  }

  filter: Diagnosis_Category_1 {
    type: string
    group_label: "DIAGNOSIS CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
    sql: {% condition Diagnosis_Category_1 %} ${Diagnosis_Category_List_1} {% endcondition %} ;;
  }

  filter: Diagnosis_Category_2 {
    type: string
    group_label: "DIAGNOSIS CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
    sql: {% condition Diagnosis_Category_2 %} ${Diagnosis_Category_List_2} {% endcondition %} ;;
  }

  filter: Diagnosis_Category_3 {
    type: string
    group_label: "DIAGNOSIS CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_disease_category
    sql: {% condition Diagnosis_Category_3 %} ${Diagnosis_Category_List_3} {% endcondition %} ;;
  }

  filter: DIAGNOSIS_DESCRIPTION_1 {
    type: string
    group_label: "DIAGNOSIS DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
    sql: {% condition DIAGNOSIS_DESCRIPTION_1 %} ${DIAGNOSIS_DESCRIPTION_List_1} {% endcondition %} ;;
  }

  filter: DIAGNOSIS_DESCRIPTION_2 {
    type: string
    group_label: "DIAGNOSIS DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
    sql: {% condition DIAGNOSIS_DESCRIPTION_2 %} ${DIAGNOSIS_DESCRIPTION_List_2} {% endcondition %} ;;
  }

  filter: DIAGNOSIS_DESCRIPTION_3 {
    type: string
    group_label: "DIAGNOSIS DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_description
    sql: {% condition DIAGNOSIS_DESCRIPTION_3 %} ${DIAGNOSIS_DESCRIPTION_List_2} {% endcondition %} ;;
  }

  filter: PROCEDURE_DESCRIPTION_1 {
    type: string
    group_label: "PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
    sql: {% condition PROCEDURE_DESCRIPTION_1 %} ${PROCEDURE_DESCRIPTION_List_1} {% endcondition %} ;;
  }

  filter: PROCEDURE_DESCRIPTION_2 {
    type: string
    group_label: "PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
    sql: {% condition  %} ${PROCEDURE_DESCRIPTION_List_2} {% endcondition %} ;;
  }

  filter: PROCEDURE_DESCRIPTION_3 {
    type: string
    group_label: "PROCEDURE DESCRIPTION"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.procedure_description
    sql: {% condition  %} ${PROCEDURE_DESCRIPTION_List_3} {% endcondition %} ;;
  }

  filter: PROCEDURE_CATEGORY_1 {
    type: string
    group_label: "PROCEDURE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PROCEDURE_CATEGORY
    sql: {% condition PROCEDURE_CATEGORY_1 %} ${PROCEDURE_CATEGORY_List_1} {% endcondition %} ;;
  }

  filter: PROCEDURE_CATEGORY_2 {
    type: string
    group_label: "PROCEDURE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PROCEDURE_CATEGORY
    sql: {% condition PROCEDURE_CATEGORY_2 %} ${PROCEDURE_CATEGORY_List_2} {% endcondition %} ;;
  }

  filter: PROCEDURE_CATEGORY_3 {
    type: string
    group_label: "PROCEDURE CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PROCEDURE_CATEGORY
    sql: {% condition PROCEDURE_CATEGORY_3 %} ${PROCEDURE_CATEGORY_List_3} {% endcondition %} ;;
  }

  filter: Chronic_Category_1 {
    type: string
    group_label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
    sql: {% condition Chronic_Category_1 %} ${Chronic_Category_List_1} {% endcondition %} ;;
  }

  filter: Chronic_Category_2 {
    type: string
    group_label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
    sql: {% condition Chronic_Category_2 %} ${Chronic_Category_List_2} {% endcondition %} ;;
  }

  filter: Chronic_Category_3 {
    type: string
    group_label: "CHRONIC CATEGORY"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.icd_chronic_cat
    sql: {% condition Chronic_Category_3 %} ${Chronic_Category_List_3} {% endcondition %} ;;
  }


  dimension: Diagnosis_Category_List_1 {
    type: string
    hidden: no
    label: "Diagnosis Category List"
    sql: ${TABLE}.DIAGNOSIS_CATEGORY_LIST ;;
  }

  dimension: Diagnosis_Category_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.DIAGNOSIS_CATEGORY_LIST ;;
  }

  dimension: Diagnosis_Category_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.DIAGNOSIS_CATEGORY_LIST ;;
  }

  dimension: Chronic_Category_List_1 {
    type: string
    label: " Chronic Category list"
    drill_fields: [vw_medical.icd_chronic_cat]
    sql: ${TABLE}.CHRONIC_CATEGORY_LIST ;;
  }

  dimension: Chronic_Category_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.CHRONIC_CATEGORY_LIST ;;
  }

  dimension: Chronic_Category_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.CHRONIC_CATEGORY_LIST ;;
  }

  dimension: PROCEDURE_CATEGORY_List_1 {
    type: string
    label: "Procedure Category List"
    sql: ${TABLE}.PROCEDURE_CATEGORY_LIST ;;
  }

  dimension: PROCEDURE_CATEGORY_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCEDURE_CATEGORY_LIST ;;
  }

  dimension: PROCEDURE_CATEGORY_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCEDURE_CATEGORY_LIST ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_List_1 {
    type: string
    label: "Diagnosis Description List"
    sql: ${TABLE}.DIAGNOSIS_DESCRIPTION_LIST ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.DIAGNOSIS_DESCRIPTION_LIST ;;
  }

  dimension: DIAGNOSIS_DESCRIPTION_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.DIAGNOSIS_DESCRIPTION_LIST ;;
  }

  dimension: PROCEDURE_DESCRIPTION_List_1 {
    type: string
    label: "Procedure Description List"
    sql: ${TABLE}.PROCEDURE_DESCRIPTION_LIST ;;
  }

  dimension: PROCEDURE_DESCRIPTION_List_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCEDURE_DESCRIPTION_LIST ;;
  }

  dimension: PROCEDURE_DESCRIPTION_List_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCEDURE_DESCRIPTION_LIST ;;
  }

  dimension: PATIENT_ID {
    type: string
    hidden:  yes
    label: "PATIENT ID"
    drill_fields: [vw_medical.icd_disease_category, vw_medical.icd_chronic_cat]
    sql: ${TABLE}.PATIENT_ID_M ;;
  }

  dimension: PAID_YEAR {
    type: string
    hidden:  yes
    label: "PAID YEAR"
    sql: ${TABLE}.PAID_YEAR ;;
  }

  measure: total_summary_paid_amt {
    type: sum
    hidden:  yes
    label: "Total Summary $"
    sql: ${TABLE}.TOTAL_PAID_AMT ;;
  }

}
