view: patient_migration_across_years_summary {
  label: "Patient Yearly Migration summary"
  derived_table: {
    sql: SELECT RISK_GROUP_MIGRATION.UNIQUE_ID as UNIQUE_ID,
        RISK_GROUP_MIGRATION.REFERENCE_YEAR as REFERENCE_YEAR,
        RISK_GROUP_MIGRATION.REFERENCE_RISK_GROUP as REFERENCE_RISK_GROUP,
        RISK_GROUP_MIGRATION.TARGET_YEAR as TARGET_YEAR,
        RISK_GROUP_MIGRATION.TARGET_RISK_GROUP as TARGET_RISK_GROUP,
        PARTICIPANT_PROGRAM_MIGRATION.REFERENCE_PARTICIPANT_PROGRAM_NAME as REFERENCE_PARTICIPANT_PROGRAM_NAME,
        PARTICIPANT_PROGRAM_MIGRATION.TARGET_PARTICIPANT_PROGRAM_NAME as TARGET_PARTICIPANT_PROGRAM_NAME,
        DEMOGRAPHICS.TERMINATION_DATE as TERMINATION_DATE
       FROM
          (SELECT YEAR_REFERENCE.UNIQUE_ID as UNIQUE_ID,
            YEAR_REFERENCE.FILE_YEAR as REFERENCE_YEAR,
            YEAR_REFERENCE.REFERENCE_RISK_GROUP as REFERENCE_RISK_GROUP,
            YEAR_TARGET.FILE_YEAR as TARGET_YEAR,
            YEAR_TARGET.TARGET_RISK_GROUP
            FROM
              (SELECT UNIQUE_ID, FILE_YEAR, RISK_GROUP as REFERENCE_RISK_GROUP from "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_RISK_GROUP_MIGRATION") as YEAR_REFERENCE
              LEFT JOIN
              (SELECT UNIQUE_ID, FILE_YEAR, RISK_GROUP as TARGET_RISK_GROUP from "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_RISK_GROUP_MIGRATION") as YEAR_TARGET
            ON YEAR_REFERENCE.UNIQUE_ID = YEAR_TARGET.UNIQUE_ID) as RISK_GROUP_MIGRATION
        LEFT JOIN
          (SELECT
            PARTICIPANT_PROGRAM_MIGRATION_REFERENCE.UNIQUE_ID,
            PARTICIPANT_PROGRAM_MIGRATION_REFERENCE.REFERENCE_YEAR,
            PARTICIPANT_PROGRAM_MIGRATION_REFERENCE.REFERENCE_PARTICIPANT_PROGRAM_NAME,
            PARTICIPANT_PROGRAM_MIGRATION_TARGET.TARGET_YEAR,
            PARTICIPANT_PROGRAM_MIGRATION_TARGET.TARGET_PARTICIPANT_PROGRAM_NAME
            FROM
              (SELECT DISTINCT UNIQUE_ID, YEAR(DIAGNOSIS_DATE) as REFERENCE_YEAR, PARTICIPANT_PROGRAM_NAME as REFERENCE_PARTICIPANT_PROGRAM_NAME FROM "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL") as PARTICIPANT_PROGRAM_MIGRATION_REFERENCE
              LEFT JOIN
              (SELECT DISTINCT UNIQUE_ID, YEAR(DIAGNOSIS_DATE) as TARGET_YEAR, PARTICIPANT_PROGRAM_NAME as TARGET_PARTICIPANT_PROGRAM_NAME FROM "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL") as PARTICIPANT_PROGRAM_MIGRATION_TARGET
            ON PARTICIPANT_PROGRAM_MIGRATION_REFERENCE.UNIQUE_ID = PARTICIPANT_PROGRAM_MIGRATION_TARGET.UNIQUE_ID) as PARTICIPANT_PROGRAM_MIGRATION
        ON RISK_GROUP_MIGRATION.UNIQUE_ID = PARTICIPANT_PROGRAM_MIGRATION.UNIQUE_ID
          AND RISK_GROUP_MIGRATION.REFERENCE_YEAR = PARTICIPANT_PROGRAM_MIGRATION.REFERENCE_YEAR
          AND RISK_GROUP_MIGRATION.TARGET_YEAR = PARTICIPANT_PROGRAM_MIGRATION.TARGET_YEAR

      LEFT JOIN
      (select UNIQUE_ID,TERMINATION_DATE from "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PATIENT_DEMOGRAPHICS") as DEMOGRAPHICS
      on RISK_GROUP_MIGRATION.UNIQUE_ID = DEMOGRAPHICS.UNIQUE_ID;;
  }

  dimension: UNIQUE_ID {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: REFERENCE_YEAR {
    type: string
    sql: ${TABLE}."REFERENCE_YEAR" ;;
  }

  dimension: reference_year_risk_group {
    label: "Reference year & Risk group"
    type: string
    sql: CONCAT(${REFERENCE_YEAR}, ' - ', ${REFERENCE_RISK_GROUP}) ;;
  }

  dimension: REFERENCE_RISK_GROUP {
    type: string
    sql: ${TABLE}."REFERENCE_RISK_GROUP" ;;
  }

  dimension: TARGET_YEAR {
    type: string
    sql: ${TABLE}."TARGET_YEAR" ;;
  }

  dimension: TARGET_RISK_GROUP {
    type: string
    sql: ${TABLE}."TARGET_RISK_GROUP" ;;
  }

  dimension: REFERENCE_PARTICIPANT_PROGRAM_NAME {
    type: string
    sql: ${TABLE}."REFERENCE_PARTICIPANT_PROGRAM_NAME" ;;
  }

  dimension: TARGET_PARTICIPANT_PROGRAM_NAME {
    type: string
    sql: ${TABLE}."TARGET_PARTICIPANT_PROGRAM_NAME" ;;
  }

  dimension: reference_year_participant_program_name {
    label: "Reference year & Participant Program Name "
    type: string
    sql: CONCAT(${REFERENCE_YEAR}, ' - ', ${REFERENCE_PARTICIPANT_PROGRAM_NAME}) ;;
  }

  dimension: TERMINATION_DATE {
    type: string
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension: Current_date {
    type: date
    label: "Current date"
    sql: CURRENT_DATE() ;;
  }

  dimension: termination_date_filter {
    type: string
    sql: CASE WHEN ${TERMINATION_DATE} > ${Current_date} OR ${TERMINATION_DATE} IS NULL THEN 'After Current date'
      ELSE 'On/Before Current date'
      END;;
  }

  measure: total_patients {
    type: count_distinct
    label: "Total Members"
    sql: ${UNIQUE_ID} ;;
    drill_fields: [vw_patient_demographics.patient_name, vw_patient_demographics.patient_dob_date, vw_patient_demographics.patient_gender, vw_patient_demographics.patient_current_age,
      vw_patient_demographics.relationship_to_employee, vw_patient_demographics.PARTICIPANT_PROGRAM_NAME, vw_patient_demographics.member_id_without_relationship, vw_patient_demographics.PARTICIPANT_FLAG,patient_migration_across_years_summary.REFERENCE_RISK_GROUP]
  }

  measure: excluded_patients {
    label: "Excluded Members"
    type: count_distinct
    filters: [termination_date_filter: "On/Before Current date"]
    sql: ${UNIQUE_ID};;
  }

  measure: n_after_exclusion{
    label: "N After Exclusion"
    type: number
    sql: ${total_patients} - ${excluded_patients} ;;
  }

  measure: percent_of_group{
    label: "% of Reference Risk Group"
    type: number
    value_format: "0.00\%"
    sql: (${excluded_patients}/${total_patients})*100 ;;
  }

}
