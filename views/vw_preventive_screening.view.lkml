view: vw_preventive_screening {
  derived_table: {
    sql: select * from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PREVENTIVE_SCREENING"
      WHERE "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
        WHERE {% condition PARTICIPANT_YEAR %} LEFT("ON_BOARD_DATE", 4) {% endcondition %} AND
          {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})
    ;;
  }

  dimension: cancer_diagnosis {
    type: string
    label: "Cancer Diagnosis"
    sql: ${TABLE}."CANCER_DIAGNOSIS" ;;
  }

  dimension: cancer_screening {
    type: string
    label: "Cancer Screening"
    sql: ${TABLE}."CANCER_SCREENING" ;;
  }

  dimension_group: diagnosis_date_max {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    label: "DIAGNOSIS DATE"
    datatype: date
    sql: ${TABLE}."DIAGNOSIS_DATE_MAX" ;;
  }

  dimension_group: screening_date_min {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    label: "SCREENING DATE"
    datatype: date
    sql: ${TABLE}."SCREENING_DATE_MIN" ;;
  }

  dimension: unique_id {
    type: string
    hidden: yes
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: year {
    type: string
    label: "DIAGNOSIS YEAR"
    sql: ${TABLE}."YEAR" ;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql: ${unique_id} ;;
  }

  measure: Total_Breast_Cancer_Diagnosis {
    type: count_distinct
    label: "Breast Cancer Diagnosis - N"
    filters: [cancer_diagnosis: "BREAST CANCER"]
    sql: ${unique_id} ;;
  }

  measure: Total_Cervical_Cancer_Diagnosis {
    type: count_distinct
    label: "Cervical Cancer Diagnosis - N"
    filters: [cancer_diagnosis: "CERVICAL CANCER"]
    sql: ${unique_id} ;;
  }

  measure: Total_Colon_Cancer_Diagnosis {
    type: count_distinct
    label: "Colon Cancer Diagnosis - N"
    filters: [cancer_diagnosis: "COLON CANCER"]
    sql: ${unique_id} ;;
  }
  filter: PARTICIPANT_YEAR {
    type: string
    group_label: "PARTICIPANT FILTER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.participant_paid_year
  }

  filter: PARTICIPANT_Flag {
    type: string
    group_label: "PARTICIPANT FILTER"
    suggest_explore: vw_medical
    suggest_dimension: vw_medical.PARTICIPANT_NONPARTICIPANT_Flag
  }

}
