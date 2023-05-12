view: vw_vital_alert {
  sql_table_name: "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_VITAL_ALERT"
    ;;

  dimension: active {
    type: string
    sql: ${TABLE}."ACTIVE" ;;
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."AFFILIATION" ;;
  }

  dimension: care_recipient_first_name {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_FIRST_NAME" ;;
  }

  dimension: care_recipient_last_name {
    type: string
    sql: ${TABLE}."CARE_RECIPIENT_LAST_NAME" ;;
  }

  dimension: checked_cleared_by {
    type: string
    sql: ${TABLE}."CHECKED_CLEARED_BY" ;;
  }

  dimension_group: checked_cleared {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CHECKED_CLEARED_DATE" ;;
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

  dimension: diastolic {
    type: string
    sql: ${TABLE}."DIASTOLIC" ;;
  }

  dimension_group: dob {
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
    sql: ${TABLE}."DOB" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: issue {
    type: string
    sql: ${TABLE}."ISSUE" ;;
  }

  dimension_group: last_update_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: load_by {
    type: string
    sql: ${TABLE}."LOAD_BY" ;;
  }

  dimension_group: load {
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
    sql: ${TABLE}."LOAD_DATE" ;;
  }

  dimension: participant_program_name {
    type: string
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME" ;;
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

  dimension: program {
    type: string
    sql: ${TABLE}."PROGRAM" ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}."SOURCE" ;;
  }

  dimension: source_file_path {
    type: string
    sql: ${TABLE}."SOURCE_FILE_PATH" ;;
  }

  dimension: source_file_row_number {
    type: number
    sql: ${TABLE}."SOURCE_FILE_ROW_NUMBER" ;;
  }

  dimension_group: source_load_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_LOAD_TIMESTAMP" ;;
  }

  dimension: stage_flag {
    type: yesno
    sql: ${TABLE}."STAGE_FLAG" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: systolic {
    type: string
    sql: ${TABLE}."SYSTOLIC" ;;
  }

  dimension: ticket_description {
    type: string
    sql: ${TABLE}."TICKET_DESCRIPTION" ;;
  }

  dimension: ticket_no {
    type: string
    sql: ${TABLE}."TICKET_NO" ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}."TIME" ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${unique_id} ;;
  }

  dimension: vital {
    type: string
    sql: ${TABLE}."VITAL" ;;
  }

  dimension: zone {
    type: string
    sql: ${TABLE}."ZONE" ;;
  }

  dimension: zone_number {
    type: string
    sql: ${TABLE}."ZONE_NUMBER" ;;
  }

  dimension: vital_sign_measurements{
    type: string
    sql: case when ${systolic} < '120' and ${diastolic} < '80' then 'Normal'
              when ${systolic} IN('120','121','122','123','124','125','126','127','128','129') and ${diastolic} < '80' then 'Elevated'
              when ${systolic} >= '130' and ${diastolic} >= '80' then 'High Blood Presure (Hypertension)'
         else 'Other'
         END;;
  }

  dimension: row_no {
    type: string
    sql: ${TABLE}."ROW_NUMBER" ;;
  }

# BLOOD PRESSURE SYSTOLIC
  dimension: blood_pressure_systolic{
    type: string
    sql: case when ${systolic} IS NOT NULL then 1
          else 0
          end;;
  }

  measure: systolic_total {
    label: "SYSTOLIC TOTAL"
    type: sum
    filters: [blood_pressure_systolic: "1"]
    sql: ${systolic} ;;
  }

  measure: Total_systolic_Patients {
    label: "SYSTOLIC - N"
    type: sum
    filters: [blood_pressure_systolic: "1"]
    sql: ${blood_pressure_systolic} ;;
  }

  measure: systolic_Mean {
    type: number
    label: "Avg Systolic Blood Pressure"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${systolic_total}/NULLIF(${Total_systolic_Patients},0);;
    value_format: "0.00"
  }

# BLOOD PRESSURE DIASTOLIC
  dimension: blood_pressure_diastolic{
    type: string
    sql: case when ${vital} = 'BLOOD PRESSURE' then 1
          else 0
          end;;
  }

  measure: diastolic_total {
    label: "DIASTOLIC TOTAL"
    type: sum
    sql: ${diastolic} ;;
  }

  measure: Total_diastolic_Patients {
    label: "DIASTOLIC - N"
    type: sum
    filters: [blood_pressure_diastolic: "1"]
    sql: ${blood_pressure_diastolic} ;;
  }

  measure: diastolic_Mean {
    type: number
    label: "Avg Diastolic Blood Pressure"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${diastolic_total}/NULLIF(${Total_diastolic_Patients},0);;
    value_format: "0.00"
  }

# BLOOD SUGAR
  dimension: blood_sugar{
    type: string
    sql: case when ${vital} = 'BLOOD SUGAR' then 1
          else 0
          end;;
  }

  measure: blood_sugar_Patients {
    label: "BLOOD SUGAR - N"
    type: sum
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date]
    filters: [vital: "BLOOD SUGAR"]
    sql: ${blood_sugar} ;;
  }

  measure: blood_sugar_total {
    label: "BLOOD SUGAR TOTAL"
    type: sum
    filters: [vital: "BLOOD SUGAR"]
    sql: ${issue} ;;
  }

  measure: blood_sugar_Mean {
    type: number
    label: "Avg Blood Sugar"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql: ${blood_sugar_total}/NULLIF(${blood_sugar_Patients},0);;
    value_format: "0.00"
  }


# HEART RATE
  dimension: heart_rate{
    type: string
    sql: case when ${vital} = 'HEART RATE' then 1
          else 0
          end;;
  }

  measure: heart_rate_Patients {
    label: "HEART RATE - N"
    type: sum
    filters: [vital: "HEART RATE"]
    sql: ${heart_rate} ;;
  }

  measure: heart_rate_total {
    label: "HEART RATE TOTAL"
    type: sum
    filters: [vital: "HEART RATE"]
    sql: ${issue} ;;
  }

  measure: heart_rate_Mean {
    type: number
    label: "Avg Heart Rate"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${heart_rate_total}/NULLIF(${heart_rate_Patients},0);;
    value_format: "0.00"
  }

# HGBA1C
  dimension: HGBA1C{
    type: string
    sql: case when ${vital} = 'HGBA1C' then 1
          else 0
          end;;
  }

  measure: HGBA1C_Patients {
    label: "HGBA1C - N"
    type: sum
    filters: [vital: "HGBA1C"]
    sql: ${HGBA1C} ;;
  }

  measure: HGBA1C_total {
    label: "HGBA1C TOTAL"
    type: sum
    filters: [vital: "HGBA1C"]
    sql: ${issue} ;;
  }

  measure: HGBA1C_Mean {
    type: number
    label: "Avg HbA1c"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${HGBA1C_total}/NULLIF(${HGBA1C_Patients},0);;
    value_format: "0.00"
  }

# OXYGEN SATURATION
  dimension: oxygen_saturation{
    type: string
    sql: case when ${vital} = 'OXYGEN SATURATION' then 1
          else 0
          end;;
  }

  measure: oxygen_saturation_patients{
    label: "OXYGEN SATURATION - N"
    type: sum
    filters: [vital: "OXYGEN SATURATION"]
    sql: ${oxygen_saturation} ;;
  }

  measure: oxygen_saturation_total {
    label: "OXYGEN SATURATION TOTAL"
    type: sum
    filters: [vital: "OXYGEN SATURATION"]
    sql: ${issue} ;;
  }

  measure: oxygen_saturation_Mean {
    type: number
    label: "Avg Oxygen Saturation"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${oxygen_saturation_total}/NULLIF(${oxygen_saturation_patients},0);;
    value_format: "0.00"
  }

# OXYGEN USE
  dimension: oxygen_use{
    type: string
    sql: case when ${vital} = 'OXYGEN USE' then 1
          else 0
          end;;
  }

  measure: oxygen_use_patients{
    label: "OXYGEN USE - N"
    type: sum
    filters: [vital: "OXYGEN USE"]
    sql: ${oxygen_use} ;;
  }

  measure: oxygen_use_total {
    label: "OXYGEN USE TOTAL"
    type: sum
    filters: [vital: "OXYGEN USE"]
    sql: ${issue} ;;
  }

  measure: oxygen_use_Mean {
    type: number
    label: "Avg Oxygen Use"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${oxygen_use_total}/NULLIF(${oxygen_use_patients},0);;
    value_format: "0.00"
  }

# PAIN
  dimension: Pain{
    type: string
    sql: case when ${vital} = 'PAIN' then 1
          else 0
          end;;
  }

  measure: Pain_Patients {
    label: "PAIN - N"
    type: sum
    filters: [vital: "PAIN"]
    sql: ${Pain} ;;
  }

  measure: Pain_total {
    label: "PAIN TOTAL"
    type: sum
    filters: [vital: "PAIN"]
    sql: ${issue} ;;
  }

  measure: Pain_Mean {
    type: number
    label: "Avg Pain Rating"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Pain_total}/NULLIF(${Pain_Patients},0);;
    value_format: "0.00"
  }

# RESPIRATORY RATE
  dimension: respiratory_rate{
    type: string
    sql: case when ${vital} = 'RESPIRATORY RATE' then 1
          else 0
          end;;
  }

  measure: respiratory_rate_Patients {
    label: "RESPIRATORY RATE - N"
    type: sum
    filters: [vital: "RESPIRATORY RATE"]
    sql: ${respiratory_rate} ;;
  }

  measure: respiratory_rate_total {
    label: "RESPIRATORY RATE TOTAL"
    type: sum
    filters: [vital: "RESPIRATORY RATE"]
    sql: ${issue} ;;
  }

  measure: respiratory_rate_Mean {
    type: number
    label: "Avg Respiratory Rate"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${respiratory_rate_total}/NULLIF(${respiratory_rate_Patients},0);;
    value_format: "0.00"
  }

# STEPS
  dimension: Steps{
    type: string
    sql: case when ${vital} = 'STEPS' then 1
          else 0
          end;;
  }

  measure: Steps_Patients {
    label: "STEPS - N"
    type: sum
    filters: [vital: "STEPS"]
    sql: ${Steps} ;;
  }

  measure: Steps_total {
    label: "STEPS TOTAL"
    type: sum
    filters: [vital: "STEPS"]
    sql: ${issue} ;;
  }

  measure:Steps_Mean {
    type: number
    label: "Avg Steps"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Steps_total}/NULLIF(${Steps_Patients},0);;
    value_format: "0.00"
  }

# TEMPERATURE
  dimension: Temperature{
    type: string
    sql: case when ${vital} = 'TEMPERATURE' then 1
          else 0
          end;;
  }

  measure: Temperature_Patients {
    label: "TEMPERATURE - N"
    type: sum
    filters: [vital: "TEMPERATURE"]
    sql: ${Temperature} ;;
  }

  measure: Temperature_total {
    label: "TEMPERATURE TOTAL"
    type: sum
    filters: [vital: "TEMPERATURE"]
    sql: ${issue} ;;
  }

  measure:Temperature_Mean {
    type: number
    label: "Avg Temperature"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Temperature_total}/NULLIF(${Temperature_Patients},0);;
    value_format: "0.00"
  }

# WEIGHT
  dimension: Weight{
    type: string
    sql: case when ${vital} = 'WEIGHT' then 1
          else 0
          end;;
  }

  measure: Weight_Patients {
    label: "Weight - N"
    type: sum
    filters: [vital: "WEIGHT"]
    sql: ${Weight} ;;
  }

  measure: Weight_total {
    label: "Weight TOTAL"
    type: sum
    filters: [vital: "WEIGHT"]
    sql: ${issue} ;;
  }

  measure:Weight_Mean {
    type: number
    label: "Avg Weight"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Weight_total}/NULLIF(${Weight_Patients},0);;
    value_format: "0.00"
  }

# PT/INR
  dimension: pt_inr{
    type: string
    sql: case when ${vital} = 'PT/INR' then 1
          else 0
          end;;
  }

  measure: pt_inr_Patients {
    label: "PT/INR - N"
    type: sum
    filters: [vital: "PT/INR"]
    sql: ${pt_inr} ;;
  }

  measure: pt_inr_total {
    label: "PT/INR TOTAL"
    type: sum
    filters: [vital:  "PT/INR"]
    sql: ${issue} ;;
  }

  measure:pt_inr_Mean {
    type: number
    label: "Avg PT/INR"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${pt_inr_total}/NULLIF(${pt_inr_Patients},0);;
    value_format: "0.00"
  }

# FOR NEW VITAL REPORT (for format likr "jan - 2022")
  dimension: year {
    type: string
    sql: ${date_year} ;;
  }

  dimension: month {
    type: string
    sql: LEFT(${date_month_name},3) ;;
  }

  dimension: month_year {
    label: "Reporting Month"
    type: string
    sql: concat(${month},' - ',${year}) ;;
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
    sql: CASE WHEN ${date_date} BETWEEN {% date_start date_range_filter_1 %} AND {% date_end date_range_filter_1 %} THEN ${date_range_filter_dimension_1}
        WHEN ${date_date} BETWEEN {% date_start date_range_filter_2 %} AND {% date_end date_range_filter_2 %} THEN ${date_range_filter_dimension_2}
        WHEN ${date_date} BETWEEN {% date_start date_range_filter_3 %} AND {% date_end date_range_filter_3 %} THEN ${date_range_filter_dimension_3}
        ELSE NULL
        /*CONCAT('before  ', {% date_end date_range_filter_1 %}) */
        END ;;
  }
#BMI Measure
  dimension: bmi{
    type: string
    label: "BMI"
    sql: ${TABLE}."BMI";;
  }

  dimension: Bmi_Patients {
    label: "BMI MEMBERS"
    type: string
    sql: CASE WHEN ${bmi} > 0 AND ${unique_id} IS NOT NULL THEN 1
              ELSE 0
         END;;
  }

  measure: bmi_total {
    label: "BMI TOTAL"
    type: sum
    filters: [Bmi_Patients: "1"]
    sql: ${bmi} ;;
  }

  measure: Bmi_Total_Patients_value_avalible{
    label: "BMI - N"
    type: sum
    filters: [Bmi_Patients: "1"]
    sql: ${Bmi_Patients} ;;
  }

  measure: Bmi_Mean {
    type: number
    label: "Avg BMI"
    drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${bmi_total}/NULLIF(${Bmi_Total_Patients_value_avalible},0);;
    value_format: "0.00"
  }


}
