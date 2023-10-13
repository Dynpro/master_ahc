view: Vw_Biometric_data {
  derived_table: {
    sql: SELECT
      UNIQUE_ID,
      AFFILIATION,
      BIOMETRIC_UNIQUE_ID,
      DEPENDENT_F_NAME,
      DEPENDENT_L_NAME,
      PATIENT_DOB,
      PATIENT_GENDER,
      SCREENING_DATE,
      BIOMETRIC_TYPE,
      BIOMETRIC_VALUE,
      PARTICIPANT_FLAG,
      RAW_LOAD_DATE,
      LAST_UPDATED_BY,
      SOURCE_FILE_PATH,
      SOURCE_FILE_ROW_NUMBER,
      SOURCE_LOAD_TIMESTAMP,
      TICKET_NO,
      TICKET_DESCRIPTION,
      ACTIVE,
      STAGE_FLAG,
      LAST_UPDATE_TIMESTAMP,
      ROW_NUMBER,
      STAGING_DATE
      FROM "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_BIOMETRIC_DATA"

      UNPIVOT (BIOMETRIC_VALUE FOR BIOMETRIC_TYPE
      IN (TOTAL_CHOLESTEROL, HDL_CHOLESTEROL, LDL_CHOLESTEROL, SYSTOLIC_BLOOD_PRESSURE, DIASTOLIC_BLOOD_PRESSURE,
      TRIGLYCERIDES,"FASTING_GLUCOSE (BLOOD_SUGAR)",TC_HDL_RATIO,SODIUM,POTASSIUM,TOBACCO_USE,FREE_T4,PULSE,CREATININE)) ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."AFFILIATION" ;;
  }

  dimension: biometric_unique_id {
    type: string
    sql: ${TABLE}."BIOMETRIC_UNIQUE_ID" ;;
  }

  dimension: dependent_f_name {
    type: string
    sql: ${TABLE}."DEPENDENT_F_NAME" ;;
  }

  dimension: dependent_l_name {
    type: string
    sql: ${TABLE}."DEPENDENT_L_NAME" ;;
  }

  dimension: patient_dob {
    type: date
    sql: ${TABLE}."PATIENT_DOB" ;;
  }

  dimension: patient_gender {
    type: string
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }


  dimension_group: screening {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."SCREENING_DATE" ;;
  }

  dimension: biometric_type {
    type: string
    sql: ${TABLE}."BIOMETRIC_TYPE" ;;
  }

  dimension: biometric_value {
    type: number
    sql: ${TABLE}."BIOMETRIC_VALUE" ;;
  }

  dimension: participant_flag {
    type: string
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: raw_load_date {
    type: date
    sql: ${TABLE}."RAW_LOAD_DATE" ;;
  }

  dimension: last_updated_by {
    type: string
    sql: ${TABLE}."LAST_UPDATED_BY" ;;
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
    sql: ${TABLE}."SOURCE_LOAD_TIMESTAMP" ;;
  }

  dimension: ticket_no {
    type: string
    sql: ${TABLE}."TICKET_NO" ;;
  }

  dimension: ticket_description {
    type: string
    sql: ${TABLE}."TICKET_DESCRIPTION" ;;
  }

  dimension: active {
    type: string
    sql: ${TABLE}."ACTIVE" ;;
  }

  dimension: stage_flag {
    type: yesno
    sql: ${TABLE}."STAGE_FLAG" ;;
  }

  dimension_group: last_update_timestamp {
    type: time
    sql: ${TABLE}."LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: row_number {
    type: string
    sql: ${TABLE}."ROW_NUMBER" ;;
  }

  dimension: staging_date {
    type: date
    sql: ${TABLE}."STAGING_DATE" ;;
  }


# TOTAL_CHOLESTEROL
  dimension: total_cholesterol{
    type: string
    sql: case when ${biometric_type} = 'TOTAL_CHOLESTEROL' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: total_cholesterolL_n {
    label: "TOTALCHOLESTEROL - N"
    type: sum
    filters: [biometric_type: "TOTAL_CHOLESTEROL"]
    sql: ${total_cholesterol} ;;
  }

  measure: total_cholesterol_total {
    label: "TOTAL CHOLESTEROL TOTAL"
    type: sum
    filters: [biometric_type: "TOTAL_CHOLESTEROL"]
    sql: ${biometric_value} ;;
  }

  measure: total_cholesterol_Mean {
    type: number
    label: "Average Total CholesterolL"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${total_cholesterol_total}/NULLIF(${total_cholesterolL_n},0);;
    value_format: "0.00"
  }

# LDL_CHOLESTEROL

  dimension: ldl_cholesterol{
    type: string
    sql: case when ${biometric_type} = 'LDL_CHOLESTEROL' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: ldl_cholesterol_n {
    label: "LDL CHOLESTEROL - N"
    type: sum
    filters: [biometric_type: "LDL_CHOLESTEROL"]
    sql: ${ldl_cholesterol} ;;
  }

  measure: ldl_cholesterol_total {
    label: "LDL CHOLESTEROL TOTAL"
    type: sum
    filters: [biometric_type: "LDL_CHOLESTEROL"]
    sql: ${biometric_value} ;;
  }

  measure: ldl_cholesterol_Mean {
    type: number
    label: "Average LDL Cholesterol"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${ldl_cholesterol_total}/NULLIF(${ldl_cholesterol_n},0);;
    value_format: "0.00"
  }

# SYSTOLIC_BLOOD_PRESSURE

  dimension: systolic_blood_pressure{
    type: string
    sql: case when ${biometric_type} = 'SYSTOLIC_BLOOD_PRESSURE' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: systolic_blood_pressure_n {
    label: "SYSTOLIC BLOOD PRESSURE - N"
    type: sum
    filters: [biometric_type: "SYSTOLIC_BLOOD_PRESSURE"]
    sql: ${systolic_blood_pressure} ;;
  }

  measure: systolic_blood_pressure_total {
    label: "SYSTOLIC BLOOD PRESSURE TOTAL"
    type: sum
    filters: [biometric_type: "SYSTOLIC_BLOOD_PRESSURE"]
    sql: ${biometric_value} ;;
  }

  measure: systolic_blood_pressure_Mean {
    type: number
    label: "Average Systolic Blood Pressure"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${systolic_blood_pressure_total}/NULLIF(${systolic_blood_pressure_n},0);;
    value_format: "0.00"
  }

# DIASTOLIC_BLOOD_PRESSURE

  dimension: diastolic_blood_pressure{
    type: string
    sql: case when ${biometric_type} = 'DIASTOLIC_BLOOD_PRESSURE' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: diastolic_blood_pressure_n {
    label: "DIASTOLIC BLOOD PRESSURE - N"
    type: sum
    filters: [biometric_type: "DIASTOLIC_BLOOD_PRESSURE"]
    sql: ${diastolic_blood_pressure} ;;
  }

  measure: diastolic_blood_pressure_total {
    label: "DIASTOLIC BLOOD PRESSURE TOTAL"
    type: sum
    filters: [biometric_type: "DIASTOLIC_BLOOD_PRESSURE"]
    sql: ${biometric_value} ;;
  }

  measure: diastolic_blood_pressure_Mean {
    type: number
    label: "Average Diastolic Blood Pressure"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${diastolic_blood_pressure_total}/NULLIF(${diastolic_blood_pressure_n},0);;
    value_format: "0.00"
  }

# HDL_CHOLESTEROL

  dimension: hdl_cholesterol{
    type: string
    sql: case when ${biometric_type} = 'HDL_CHOLESTEROL' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: hdl_cholesterol_n {
    label: "HDL CHOLESTEROL - N"
    type: sum
    filters: [biometric_type: "HDL_CHOLESTEROL"]
    sql: ${hdl_cholesterol} ;;
  }

  measure: hdl_cholesterol_total {
    label: "HDL CHOLESTEROL TOTAL"
    type: sum
    filters: [biometric_type: "c"]
    sql: ${biometric_value} ;;
  }

  measure: hdl_cholesterol_Mean {
    type: number
    label: "Average HDL Cholesterol"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${hdl_cholesterol_total}/NULLIF(${hdl_cholesterol_n},0);;
    value_format: "0.00"
  }

# TC_HDL_RATIO

  dimension: tc_hdl_ratio{
    type: string
    sql: case when ${biometric_type} = 'TC_HDL_RATIO' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: tc_hdl_ratio_n {
    label: "TC HDL RATIO - N"
    type: sum
    filters: [biometric_type: "TC_HDL_RATIO"]
    sql: ${tc_hdl_ratio} ;;
  }

  measure: tc_hdl_ratio_total {
    label: "TC HDL RATIO TOTAL"
    type: sum
    filters: [biometric_type: "TC_HDL_RATIO"]
    sql: ${biometric_value} ;;
  }

  measure: tc_hdl_ratio_Mean {
    type: number
    label: "Average TC:HDL Ratio"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${tc_hdl_ratio_total}/NULLIF(${tc_hdl_ratio_n},0);;
    value_format: "0.00"
  }

# FASTING_GLUCOSE (BLOOD_SUGAR)

  dimension: fasting_glucose_blood_sugar {
    type: string
    sql: case when ${biometric_type} = 'FASTING_GLUCOSE (BLOOD_SUGAR)' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: fasting_glucose_blood_sugar_n {
    label: "FASTING GLUCOSE (BLOOD_SUGAR) - N"
    type: sum
    filters: [biometric_type: "FASTING_GLUCOSE (BLOOD_SUGAR)"]
    sql: ${fasting_glucose_blood_sugar} ;;
  }

  measure: fasting_glucose_blood_sugar_total {
    label: "FASTING GLUCOSE (BLOOD_SUGAR) TOTAL"
    type: sum
    filters: [biometric_type: "FASTING_GLUCOSE (BLOOD_SUGAR)"]
    sql: ${biometric_value} ;;
  }

  measure: fasting_glucose_blood_sugar_Mean {
    type: number
    label: "Average Fasting Glucose (Blood Sugar)"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${fasting_glucose_blood_sugar_total}/NULLIF(${fasting_glucose_blood_sugar_n},0);;
    value_format: "0.00"
  }

# TRIGLYCERIDES

  dimension: triglycerides{
    type: string
    sql: case when ${biometric_type} = 'TRIGLYCERIDES' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: triglycerides_n {
    label: "TRIGLYCERIDES - N"
    type: sum
    filters: [biometric_type: "TRIGLYCERIDES"]
    sql: ${triglycerides} ;;
  }

  measure: triglycerides_total {
    label: "TRIGLYCERIDES TOTAL"
    type: sum
    filters: [biometric_type: "TRIGLYCERIDES"]
    sql: ${biometric_value} ;;
  }

  measure: triglycerides_Mean {
    type: number
    label: "Average Triglycerides"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${triglycerides_total}/NULLIF(${triglycerides_n},0);;
    value_format: "0.00"
  }

# sodium

  dimension: sodium{
    type: string
    sql: case when ${biometric_type} = 'sodium' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: sodium_n {
    label: "SODIUM - N"
    type: sum
    filters: [biometric_type: "sodium"]
    sql: ${sodium} ;;
  }

  measure: sodium_total {
    label: "SODIUM TOTAL"
    type: sum
    filters: [biometric_type: "sodium"]
    sql: ${biometric_value} ;;
  }

  measure: sodium_Mean {
    type: number
    label: "Average Sodium"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${sodium_total}/NULLIF(${sodium_n},0);;
    value_format: "0.00"
  }

# POTASSIUM


  dimension: Potassium{
    type: string
    sql: case when ${biometric_type} = 'POTASSIUM' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: Potassium_n {
    label: "POTASSIUM - N"
    type: sum
    filters: [biometric_type: "POTASSIUM"]
    sql: ${Potassium} ;;
  }

  measure: Potassium_total {
    label: "POTASSIUM TOTAL"
    type: sum
    filters: [biometric_type: "POTASSIUM"]
    sql: ${biometric_value} ;;
  }

  measure: Potassium_Mean {
    type: number
    label: "Average Potassium"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Potassium_total}/NULLIF(${Potassium_n},0);;
    value_format: "0.00"
  }

# Pulse


  dimension: Pulse{
    type: string
    sql: case when ${biometric_type} = 'PULSE' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: Pulse_n {
    label: "Pulse - N"
    type: sum
    filters: [biometric_type: "PULSE"]
    sql: ${Pulse} ;;
  }

  measure: Pulse_total {
    label: "PULSE TOTAL"
    type: sum
    filters: [biometric_type: "PULSE"]
    sql: ${biometric_value} ;;
  }

  measure: Pulse_Mean {
    type: number
    label: "Average Pulse"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${Potassium_total}/NULLIF(${Pulse_n},0);;
  }

# TOBACCO_USE


  dimension: tobacco_use{
    type: string
    sql: case when ${biometric_type} = 'TOBACCO_USE' and ${biometric_value} > 0 then 1
          else 0
          end;;
  }

  measure: tobacco_use_n {
    label: "TOBACCO USE - N"
    type: sum
    filters: [biometric_type: "TOBACCO_USE"]
    sql: ${tobacco_use} ;;
  }

  measure: tobacco_use_total {
    label: "TOBACCO USE TOTAL"
    type: sum
    filters: [biometric_type: "TOBACCO_USE"]
    sql: ${biometric_value} ;;
  }

  measure: tobacco_use_Mean {
    type: number
    label: "Average Tobacco Use"
    #drill_fields: [unique_id,dependent_f_name,dependent_l_name,patient_gender,patient_dob_date,member_id,program,date_date,time,vital,issue,systolic,diastolic,zone,zone_number,status,affiliation,source,checked_cleared_by,checked_cleared_date,row_no]
    sql:  ${tobacco_use_total}/NULLIF(${tobacco_use_n},0);;
    value_format: "0.00"
  }



#Date Range for vital report
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
    sql: CASE WHEN ${screening_date} BETWEEN {% date_start date_range_filter_1 %} AND {% date_end date_range_filter_1 %} THEN ${date_range_filter_dimension_1}
      WHEN ${screening_date} BETWEEN {% date_start date_range_filter_2 %} AND {% date_end date_range_filter_2 %} THEN ${date_range_filter_dimension_2}
      WHEN ${screening_date} BETWEEN {% date_start date_range_filter_3 %} AND {% date_end date_range_filter_3 %} THEN ${date_range_filter_dimension_3}
      ELSE NULL
      /*CONCAT('before  ', {% date_end date_range_filter_1 %}) */
      END ;;
  }

# FOR NEW VITAL REPORT (for format like "jan - 2022")
  dimension: year {
    type: string
    sql: ${screening_year} ;;
  }

  dimension: month {
    type: string
    sql: LEFT(${screening_month},3);;
  }

  dimension: month_year {
    label: "Screening Month-Year"
    type: string
    sql: concat(${month},' - ',${year}) ;;
  }

  dimension: biometric_type_filter {
    type: string
    label: "Biometric type"
    sql: case when ${biometric_type} = 'TOTAL_CHOLESTEROL' then 'Total Cholesterol'
              when ${biometric_type} = 'HDL_CHOLESTEROL' then 'HDL Cholesterol'
              when ${biometric_type} = 'LDL_CHOLESTEROL' then 'LDL Cholesterol'
              when ${biometric_type} = 'SYSTOLIC_BLOOD_PRESSURE' then 'Systolic Blood Pressure'
              when ${biometric_type} = 'DIASTOLIC_BLOOD_PRESSURE' then 'Diastolic Blood Pressure'
              when ${biometric_type} = 'TRIGLYCERIDES' then 'Triglycerides'
              when ${biometric_type} = 'FASTING_GLUCOSE (BLOOD_SUGAR)' then 'Fasting Glucose (Blood Sugar)'
              when ${biometric_type} = 'TC_HDL_RATIO' then 'TC:HDL Ratio'
         else 'Other'
         end;;
  }

###for At-Risk

  dimension: Total_Cholesterol_New {
    type: string
    sql:CASE WHEN ${TABLE}."BIOMETRIC_TYPE" = 'TOTAL_CHOLESTEROL' AND ${TABLE}."BIOMETRIC_VALUE" > 200 THEN 'Yes'
      ELSE 'No'
    END;;
  }

  dimension: Triglycerides_New {
    type: string
    sql:CASE WHEN ${TABLE}."BIOMETRIC_TYPE" = 'TRIGLYCERIDES' AND ${TABLE}."BIOMETRIC_VALUE" > 150 THEN 'Yes'
      ELSE 'No'
    END;;
  }

  dimension: HDL {
    type: string
    sql:CASE WHEN ${TABLE}."BIOMETRIC_TYPE" = 'HDL_CHOLESTEROL' AND ${TABLE}."PATIENT_GENDER" = 'M' AND ${TABLE}."BIOMETRIC_VALUE" < 40 THEN 'Yes'
                 WHEN ${TABLE}."BIOMETRIC_TYPE" = 'HDL_CHOLESTEROL' AND ${TABLE}."PATIENT_GENDER" = 'F' AND ${TABLE}."BIOMETRIC_VALUE" < 50 THEN 'Yes'
            ELSE 'No'
          END;;
  }

  dimension: Waist_Circumference {
    type: string
    sql: null ;;
  }

  dimension: Metabolic_Syndrome {
    type: string
    sql: null ;;
  }

  dimension: Blood_Suga_Fasting{
    type: string
    label: "Blood_Sugar(Fasting)"
    sql: CASE WHEN ${biometric_type} = 'FASTING_GLUCOSE (BLOOD_SUGAR)' AND (${biometric_value}  >= 100 OR ${biometric_value} < 131) THEN 'Yes'
            ELSE 'No'
            END;;
  }
  ##
}
