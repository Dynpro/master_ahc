view: vw_combine_data {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."VW_CLAIM_ANALYSIS_SUMMARY"
    ;;

  dimension: address {
    type: string
    sql: ${TABLE}."ADDRESS" ;;
  }

  dimension: ccw_chronic_cat {
    type: string
    sql: ${TABLE}."CCW_CHRONIC_CAT" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: class_code {
    type: string
    sql: ${TABLE}."CLASS_CODE" ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}."DATA_TYPE" ;;
  }

  dimension: dependent_f_name {
    type: string
    label: "Member First Name"
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    type: string
    label: "Member Last Name"
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: dependent_m_name {
    type: string
    label: "Member Middle Name"
    sql: ${TABLE}."DEPENDENT_M_NAME" ;;
  }

  dimension_group: effective {
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
    datatype: date
    sql: ${TABLE}."EFFECTIVE_DATE" ;;
  }

  dimension_group: eligibility_file {
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
    datatype: date
    sql: ${TABLE}."ELIGIBILITY_FILE_DATE" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: employer_group_name {
    type: string
    sql: ${TABLE}."EMPLOYER_GROUP_NAME" ;;
  }

  dimension: employer_name {
    type: string
    sql: ${TABLE}."EMPLOYER_NAME" ;;
  }

  dimension: insured_flag {
    type: string
    sql: ${TABLE}."INSURED_FLAG" ;;
  }

  dimension: medical {
    type: number
    sql: ${TABLE}."MEDICAL" ;;
  }

  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }

  dimension_group: on_board {
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
    datatype: date
    sql: ${TABLE}."ON_BOARD_DATE" ;;
  }

  dimension_group: paid {
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
    datatype: date
    sql: ${TABLE}."PAID_DATE" ;;
  }

  dimension: participant_flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: participant_program_name {
    type: string
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME" ;;
  }

  dimension: participant_year {
    type: string
    sql: ${TABLE}."PARTICIPANT_YEAR" ;;
  }

  dimension: patient_age {
    type: number
    label: "Member Age"
    sql: ${TABLE}."PATIENT_AGE" ;;
  }

  dimension_group: patient_dob {
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
    datatype: date
    label: "Member DOB"
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_gender {
    type: string
    label: "Member Gender"
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: pharma {
    type: number
    sql: ${TABLE}."PHARMA" ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: relationship_to_employee {
    type: string
    sql: ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" ;;
  }

  dimension: rnk {
    type: number
    sql: ${TABLE}."RNK" ;;
  }

  dimension: rnk_uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}."RNK_UUID" ;;
  }

  dimension_group: service {
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
    datatype: date
    sql: ${TABLE}."SERVICE_DATE" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension_group: termination {
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
    datatype: date
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension: total_employer_paid_amt {
    type: number
    sql: ${TABLE}."TOTAL_EMPLOYER_PAID_AMT" ;;
  }

  dimension: triggers {
    type: string
    sql: ${TABLE}."TRIGGERS" ;;
  }

  dimension: unique_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

#Date Range for Executive summery

  filter: date_range_filter_1 {
    type: date
    datatype: date
  }

  filter: date_range_filter_2 {
    type: date
    datatype: date
  }

  filter: date_range_filter_3 {
    type: date
    datatype: date
  }

  dimension: date_range_filter_dimension_1 {
    type: string
    sql: CONCAT({% date_start date_range_filter_1 %}, ' - ', IFNULL({% date_end date_range_filter_1 %}, '')) ;;
  }

  dimension: date_range_filter_dimension_2 {
    type: string
    sql: CONCAT({% date_start date_range_filter_2 %}, ' - ', IFNULL({% date_end date_range_filter_2 %}, '')) ;;
  }

  dimension: date_range_filter_dimension_3 {
    type: string
    sql: CONCAT({% date_start date_range_filter_3 %}, ' - ', IFNULL({% date_end date_range_filter_3 %}, '')) ;;
  }

  dimension: date_range {
    type: string
    sql: CASE WHEN ${reporting_date} BETWEEN {% date_start date_range_filter_1 %} AND {% date_end date_range_filter_1 %} THEN ${date_range_filter_dimension_1}
        WHEN ${reporting_date} BETWEEN {% date_start date_range_filter_2 %} AND {% date_end date_range_filter_2 %} THEN ${date_range_filter_dimension_2}
        WHEN ${reporting_date} BETWEEN {% date_start date_range_filter_3 %} AND {% date_end date_range_filter_3 %} THEN ${date_range_filter_dimension_3}
        ELSE NULL
        /*CONCAT('before  ', {% date_end date_range_filter_1 %}) */
        END ;;
  }

  measure: Total_Paid_Amt {
    type: sum
    filters: [data_type: "MED"]
    label: "MEDICAL TOTAL $"
    sql:  ${total_employer_paid_amt} ;;
    value_format: "$#,##0"
  }

  measure: employer_paid_amount {
    type: sum
    filters: [data_type: "PHR"]
    label: "PHARMACY TOTAL $"
    sql: ${total_employer_paid_amt} ;;
    value_format: "$#,##0"
  }

  dimension: CHRONIC_TOTAL_PAID_AMT {
    type: string
    label: "CHRONIC TOTAL PAID AMT"
    sql:CASE WHEN "CCW_CHRONIC_CAT" IS NULL THEN 0
      ELSE "TOTAL_EMPLOYER_PAID_AMT"
      END;;
  }

  measure: chronic_total_amt {
    type: sum
    value_format: "$#,##0"
    label: "CHRONIC TOTAL $"
    sql: ${CHRONIC_TOTAL_PAID_AMT};;
  }

  measure: Chronic_Category_list_1 {
    type: string
    label: "Chronic Category list"
    sql:  LISTAGG(DISTINCT "CCW_CHRONIC_CAT", ' || ') within group (order by "CCW_CHRONIC_CAT" ASC);;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

  parameter: reporting_date_filter {
    type: string
    label: "Reporting date"
    allowed_value: {
      value: "Service"
      label: "Service date"}
    allowed_value: {
      value: "Paid"
      label: "Paid date"}
  }

  dimension_group: reporting {
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
    datatype: date
    label: "Reporting"
    drill_fields: [reporting_year, reporting_quarter, reporting_month, reporting_raw]
    sql: CASE WHEN {% parameter reporting_date_filter %} = 'Paid' THEN ${TABLE}."PAID_DATE"
      WHEN {% parameter reporting_date_filter %} = 'Service' THEN ${TABLE}."SERVICE_DATE"
      ELSE ${TABLE}."SERVICE_DATE"
      END ;;
  }

  measure: PARTICIPANT_PROGRAM_NAME_1{
    type: string
    label: "PARTICIPANT PROGRAM NAME 1"
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME";;
  }

}
