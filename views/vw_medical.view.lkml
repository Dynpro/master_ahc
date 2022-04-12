view: vw_medical {
  label: "Medical records"
  derived_table: {
    sql: select * from "SCH_AHC_CRISP_REGIONAL"."VW_MEDICAL"
      WHERE "UNIQUE_ID" IN (select DISTINCT "UNIQUE_ID" from "SCH_AHC_CRISP_REGIONAL"."VW_MEDICAL"
        WHERE {% condition PARTICIPANT_YEAR %} LEFT("PAID_DATE", 4) {% endcondition %} AND
        {% condition PARTICIPANT_Flag %} "PARTICIPANT_FLAG" {% endcondition %})
      ;;
  }
  dimension: 2012_chronic {
    type: string
    label: "CHRONIC ?"
    sql: ${TABLE}."CHRONICITY_IDENTIFIER" ;;
  }

  dimension: address_city {
    type: string
    label: "ADDRESS- CITY"
    sql: ${TABLE}."ADDRESS_CITY" ;;
  }

  dimension: address_state {
    type: string
    label: "ADDRESS- STATE"
    sql: ${TABLE}."ADDRESS_STATE" ;;
  }

  dimension: address_zip_code {
    type: string
    label: "ADDRESS- ZIP CODE"
    sql: ${TABLE}."ADDRESS_ZIP_CODE" ;;
  }

  dimension: age_group_1 {
    type: string
    label: "AGE GROUP-1"
    sql: ${TABLE}."AGE_GROUP_1" ;;
  }

  dimension: claim_number {
    type: string
    label: "CLAIM No"
    hidden: yes
    sql: ${TABLE}."CLAIM_NUMBER" ;;
  }

  dimension: class_code {
    type: string
    label: "CLASS CODE"
    hidden: yes
    sql: ${TABLE}."CLASS_CODE" ;;
  }

  dimension: co_payment_amt {
    type: number
    hidden: yes
    sql: ${TABLE}."CO_PAYMENT_AMT" ;;
  }

  dimension: coverage_type {
    type: string
    hidden: yes
    sql: ${TABLE}."COVERAGE_TYPE" ;;
  }

  dimension_group: date_claim_received {
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
    hidden: yes
    sql: ${TABLE}."DATE_CLAIM_RECEIVED" ;;
  }

  dimension: dependent_relationship_code {
    type: string
    hidden: yes
    sql: ${TABLE}."DEPENDENT_RELATIONSHIP_CODE" ;;
  }

  dimension: diagnosis_code_2 {
    type: string
    hidden: yes
    sql: ${TABLE}."DIAGNOSIS_CODE_2" ;;
  }

  dimension: diagnosis_code_3 {
    type: string
    hidden: yes
    sql: ${TABLE}."DIAGNOSIS_CODE_3" ;;
  }

  dimension: diagnosis_code_4 {
    type: string
    hidden: yes
    sql: ${TABLE}."DIAGNOSIS_CODE_4" ;;
  }

  dimension_group: diagnosis {
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
    label: "DIAGOSIS"
    drill_fields: [diagnosis_year, diagnosis_quarter, diagnosis_month, diagnosis_raw]
    sql: ${TABLE}."DIAGNOSIS_DATE" ;;
  }

  dimension_group: Paid {
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
    label: "PAID"
    drill_fields: [Paid_year, Paid_quarter, Paid_month, Paid_raw]
    sql: ${TABLE}."PAID_DATE" ;;
  }

  dimension: disease_group {
    type: string
    hidden: yes
    sql: ${TABLE}."DISEASE_GROUP" ;;
  }

  dimension: employer_name {
    type: string
    sql: ${TABLE}."EMPLOYER_NAME" ;;
  }

  dimension: icd_acute {
    type: string
    label: "ACUTE ?"
    sql: ${TABLE}."CHRONICITY_IDENTIFIER" ;;
  }

  dimension: avoidable_er {
    type: string
    hidden: yes
    label: "AVOIDABLE ER ?"
    sql: ${TABLE}."ICD_AVOIDABLE_ER" ;;
  }

  dimension: icd_avoidable_er {
    type: string
    label: "AVOIDABLE ER ?"
    sql: CASE WHEN ${avoidable_er} = 'TRUE' AND (${place_of_service} = '23' OR ${primary_procedure_code} IN ('99281',
          '99282', '99283', '99284', '99285')) THEN 'TRUE'
          ELSE 'FALSE'
          END ;;
  }

  dimension: icd_chronic_cat {
    type: string
    label: "CHRONIC CATEGORY"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description]
    sql: ${TABLE}."CCW_CHRONIC_CAT" ;;
  }

  dimension: icd_chronic_cat_new {
    type: string
    hidden: yes
    sql: ${TABLE}."ICD_CHRONIC_CAT_NEW" ;;
  }

  dimension: icd_description {
    type: string
    label: "DIAGNOSIS DESCRIPTION"
    sql: ${TABLE}."ICD_DESCRIPTION" ;;
  }

  dimension: icd_digestive_disease {
    type: string
    label: "DIGESTIVE DISEASE ?"
    sql: ${TABLE}."ICD_DIGESTIVE_DISEASE" ;;
  }

  dimension: icd_disease_category {
    type: string
    label: "DIAGNOSTIC CATEGORY"
    drill_fields: [DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    sql: ${TABLE}."ICD_DISEASE_CATEGORY" ;;
  }

  dimension: icd_indicator {
    type: string
    hidden: yes
    sql: ${TABLE}."ICD_INDICATOR" ;;
  }

  dimension: icd_ls_modify {
    type: string
    label: "LIFESTYLE MODIFIABLE ?"
    sql: ${TABLE}."ICD_LS_MODIFY" ;;
  }

  dimension: icd_lt_all_absences_midrange {
    type: string
    hidden: yes
    sql: ${TABLE}."ICD_LT_ALL_ABSENCES_MIDRANGE" ;;
  }

  dimension: icd_preventative {
    type: string
    label: "PREVENTIVE ?"
    sql: ${TABLE}."ICD_PREVENTATIVE" ;;
  }

  dimension: icd_rh_chronic {
    type: string
    hidden: yes
    sql: ${TABLE}."ICD_RH_CHRONIC" ;;
  }

  dimension: ineligable_amt {
    type: number
    hidden: yes
    sql: ${TABLE}."INELIGABLE_AMT" ;;
  }

  dimension: insured_out_of_pocket_amt {
    type: number
    hidden: yes
    sql: ${TABLE}."INSURED_OUT_OF_POCKET_AMT" ;;
  }

  dimension: job_designation {
    type: string
    label: "JOB DESIGNATION"
    sql: ${TABLE}."JOB_DESIGNATION" ;;
  }

  dimension: job_type {
    type: string
    label: "JOB TYPE"
    sql: ${TABLE}."JOB_TYPE" ;;
  }

  dimension: patient_age {
    type: number
    label: "PATIENT AGE"
    sql: ${TABLE}."PATIENT_AGE" ;;
  }

  dimension: patient_gender {
    type: string
    label: "PATIENT GENDER"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    sql: ${TABLE}."PATIENT_GENDER" ;;
  }

  dimension: payee_provider_id {
    type: string
    hidden: yes
    sql: ${TABLE}."PAYEE_PROVIDER_ID" ;;
  }

  dimension: place_of_service {
    type: string
    label: "PLACE OF SERVICE"
    sql: ${TABLE}."PLACE_OF_SERVICE" ;;
  }

  dimension: place_of_service_description {
    type: string
    label: "PLACE OF SERVICE DESCRIPTION"
    sql: ${TABLE}."PLACE_OF_SERVICE_DESCRIPTION" ;;
  }

  dimension: primary_diagnosis_code {
    type: string
    hidden: yes
    sql: ${TABLE}."PRIMARY_DIAGNOSIS_CODE" ;;
  }

  dimension: primary_procedure_code {
    type: string
    label: "PROCEDURE CODE"
    sql: ${TABLE}."PRIMARY_PROCEDURE_CODE" ;;
  }

  dimension: procedure_code_2 {
    type: string
    hidden: yes
    sql: ${TABLE}."PROCEDURE_CODE_2" ;;
  }

  dimension: procedure_code_3 {
    type: string
    hidden: yes
    sql: ${TABLE}."PROCEDURE_CODE_3" ;;
  }

  dimension: procedure_code_4 {
    type: string
    hidden: yes
    sql: ${TABLE}."PROCEDURE_CODE_4" ;;
  }

  dimension: procedure_code_type {
    type: string
    label: "PROCEDURE CODE TYPE"
    sql: ${TABLE}."PROCEDURE_CODE_TYPE" ;;
  }

  dimension: procedure_consumer_description {
    type: string
    label: "PROCEDURE CONSUMER DESCRIPTION"
    sql: ${TABLE}."PROCEDURE_CONSUMER_DESCRIPTION" ;;
  }

  dimension: procedure_description {
    type: string
    label: "PROCEDURE DESCRIPTION"
    sql: ${TABLE}."PROCEDURE_DESCRIPTION" ;;
  }

  dimension: reconciled_diagnosis_code_icd10 {
    type: string
    label: "DIAGNOSIS CODE"
    sql: ${TABLE}."RECONCILED_DIAGNOSIS_CODE_ICD10" ;;
  }

  dimension: relationship_to_employee {
    type: string
    label: "RELATIONSHIP TO EMPLOYEE"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    sql: ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" ;;
  }

  dimension: service_code {
    type: string
    hidden: yes
    sql: ${TABLE}."SERVICE_CODE" ;;
  }

  dimension: service_provider_city {
    type: string
    label: "SERVICE PROVIDER CITY"
    sql: ${TABLE}."SERVICE_PROVIDER_CITY" ;;
  }

  dimension: service_provider_id {
    type: string
    hidden: yes
    sql: ${TABLE}."SERVICE_PROVIDER_ID" ;;
  }

  dimension: service_provider_name {
    type: string
    label: "SERVICE PROVIDER NAME"
    sql: ${TABLE}."SERVICE_PROVIDER_NAME" ;;
  }

  dimension: service_provider_speciality_code {
    type: string
    label: "SERVICE PROVIDER SPECIALITY CODE"
    sql: ${TABLE}."SERVICE_PROVIDER_SPECIALITY_CODE" ;;
  }

  dimension: service_provider_speciality_code_desc {
    type: string
    label: "SERVICE PROVIDER SPECIALITY CODE DESCRIPTION"
    sql: ${TABLE}."SERVICE_PROVIDER_SPECIALITY_CODE_DESC" ;;
  }

  dimension: service_provider_state {
    type: string
    label: "SERVICE PROVIDER STATE"
    sql: ${TABLE}."SERVICE_PROVIDER_STATE" ;;
  }

  dimension: tooth_number {
    type: string
    label: "TOOTH NUMBER"
    sql: ${TABLE}."TOOTH_NUMBER" ;;
  }

  dimension: total_billed_amt {
    type: number
    label: "TOTAL BILLED AMT"
    hidden: yes
    sql: ${TABLE}."TOTAL_BILLED_AMT" ;;
  }

  dimension: total_employer_paid_amt {
    type: number
    label: "TOTAL PAID AMT"
    hidden: yes
    sql: ${TABLE}."TOTAL_EMPLOYER_PAID_AMT" ;;
  }

  dimension: total_patient_paid_amt {
    type: number
    hidden: yes
    sql: ${TABLE}."TOTAL_PATIENT_PAID_AMT" ;;
  }

  dimension: type_of_service_code {
    type: string
    label: "TYPE OF SERVICE CODE"
    sql: ${TABLE}."TYPE_OF_SERVICE_CODE" ;;
  }

  dimension: type_of_service_description {
    type: string
    label: "TYPE OF SERVICE DESCRIPTION"
    sql: ${TABLE}."TYPE_OF_SERVICE_DESCRIPTION" ;;
  }

  dimension: unique_id {
    type: string
    primary_key: yes
    hidden: no
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: Chroni_vs_NonChronic {
    type: string
    label: "CHRONIC/NON-CHRONIC"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    sql: CASE WHEN ${icd_chronic_cat} IS NULL THEN 'Non-Chronic'
      ELSE 'Chronic'
      END ;;
  }

  dimension: Work_related_MSK_Disease  {
    type: string
    label: "WORK RELATED MSK DIAGNOSIS"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    sql:  CASE WHEN ${primary_diagnosis_code} IN ('72210', '72273', '72400', '72420', '72430', '72450', '847', '8471', '8472',
        '8473', '8471', '8472', '8473', '8474', '8479', 'M4800', 'M5106', 'M5127', 'M5442', 'M549', 'S138XXA',  'S138XXD',
        'S138XXS',  'S139XXA',  'S139XXD', 'S139XXS',  'S233XXA',  'S233XXD',  'S233XXS',  'S335XXA',  'S335XXD',  'S335XXS',
        'S338XXA',  'S338XXD',  'S338XXS', 'S339XXA',  'S339XXD',  'S339XXS',  'S39012A',  'S39012D',  'S39012S')
        THEN 'BACK'
        WHEN ${primary_diagnosis_code} IN ('7261', '72610', '72611', '72612', '72613', '72619', '72631', '72632', '72761', '84040',
        '8404', 'M65821', 'M65822', 'M65829', 'M70811', 'M70812', 'M70819', 'M70911', 'M70912', 'M70919', 'M7101',  'M71011',
        'M71012', 'M71019', 'M71111', 'M71112', 'M71119', 'M71311', 'M71312', 'M71319', 'M71811', 'M71812', 'M71819', 'M75100',
        'M75101', 'M75102', 'M75110', 'M75111', 'M75112', 'M75120', 'M75121', 'M75122', 'M7520',  'M7521',  'M7522',  'M7530',
        'M7531',  'M7532', 'M7700',  'M7701',  'M7702',  'M7710',  'M7711',  'M7712',  'M7812',  'S43421A',  'S43421D',
        'S43421S', 'S43422A', 'S43422D',  'S43422S',  'S43429A',  'S43429D',  'S43429S')
        THEN 'UPPER EXTREMITY'
        WHEN ${primary_diagnosis_code} IN ('72703', '72704', '72705', '7274', '72740', '72741', '72742', '72743', '72749', 'M6530',
        'M65321', 'M65322', 'M65329', 'M65331', 'M65332', 'M65339', 'M65341', 'M65342', 'M65349', 'M65351', 'M65352', 'M65359',
        'M654', 'M65831', 'M65841', 'M65842', 'M67241', 'M67242', 'M67249', 'M67429', 'M67431', 'M67432', 'M67439', 'M67441',
        'M67442', 'M67449')
        THEN 'HAND & WRIST'
        ELSE 'OTHERS'
        END    ;;
  }

  dimension: ageGroup {
    type: tier
    label: "AGE GROUP-2"
    tiers: [20, 30, 40, 50, 60]
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description, icd_chronic_cat]
    description: "AGE Group>> 0-19, 20-29, 30-39, 40-49, 50-59 & >=60 yrs"
    style: integer
    sql:  ${patient_age};;
  }

  dimension: Total_Paid_Amount {
    type: number
    hidden: yes
    sql:  ${total_employer_paid_amt} ;;
  }

#Total Visits logic.
  dimension: Total_Visit_Unique_Id {
    type: string
    hidden: yes
    sql: concat(${unique_id}, ${Paid_year}, ${Paid_month}, ${claim_number}, ${reconciled_diagnosis_code_icd10}) ;;
  }

  measure: Total_Visit {
    type: count_distinct
    label: "TOTAL VISITS"
    sql: ${Total_Visit_Unique_Id} ;;
  }

#Total Lost Days & Spend logic.
  dimension: Lost_Days_Unique_Id {
    type: string
    sql: concat(${unique_id}, ${Paid_year}, ${reconciled_diagnosis_code_icd10}) ;;
  }

  measure: Total_Lost_Days {
    type: sum_distinct
    label: "TOTAL LOST DAYS"
    sql_distinct_key: ${Lost_Days_Unique_Id} ;;
    sql: ${icd_lt_all_absences_midrange} ;;
  }

  measure: Total_Lost_Day_Expense {
    type: sum_distinct
    label: "TOTAL LOST DAYS SPEND"
    sql_distinct_key: ${Lost_Days_Unique_Id} ;;
    sql: ${icd_lt_all_absences_midrange}*8*19 ;;
    #Lost days expense logic as per PHM report: Lost_Days*8*19 (hours - 8, Cost/perhour - $19)
    value_format: "$#,##0"
  }

  # Catastrophic Claim flag (Paid Amt/Claim > $100,000)
  dimension: CATASTROPHIC_FLAG {
    type: string
    label: "CATASTROPHIC/NON-CATASTROPHIC CLAIM"
    sql: ${TABLE}."CATASTROPHIC_FLAG" ;;
  }

  measure: Total_Patients {
    type: count_distinct
    label: "N"
    sql:  ${unique_id} ;;
  }

  measure: Patient_percentage {
    type: percent_of_total
    label: "% of TOTAL N"
    value_format: "0.0\%"
    sql: ${Total_Patients} ;;
  }

  measure: Total_Paid_Amt {
    type: sum
    label: "TOTAL $"
    sql:  ${Total_Paid_Amount} ;;
    value_format: "$#,##0"
  }

  measure: Total_Paid_Amt_percentage {
    type: percent_of_total
    label: "% of TOTAL $"
    value_format: "0.0\%"
    sql: ${Total_Paid_Amt} ;;
  }

  measure: Avg_Total_Paid_amount {
    type: number
    label: "MEAN $"
    sql: CASE WHEN ${Total_Patients} <> 0 THEN ${Total_Paid_Amt}/${Total_Patients}
        ELSE 0
        END;;
    value_format: "$#,##0"
  }

  measure: count {
    type: count
    label: "TOTAL RECORDS"
  }

  dimension: ICD_MAJOR_DISEASE {
    type: string
    label: "DIABETES ?"
    sql: ${TABLE}."ICD_MAJOR_DISEASE" ;;
  }

  dimension: Chronic_vs_Acute {
    type: string
    label: "CHRONIC vs ACUTE"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description]
    sql: CASE WHEN ${2012_chronic} = 'B' THEN 'CHRONIC'
              WHEN ${2012_chronic} = 'C' THEN 'CHRONIC'
              WHEN ${icd_acute} = 'A' THEN 'ACUTE'
        ELSE 'NON-CHRONIC_&_NON-Acute'
        END;;
  }

  dimension: CCW_CHRONIC_CAT_SOURCE {
    type: string
    label: "CCW CHRONIC CAT SOURCE"
    sql: ${TABLE}."CCW_CHRONIC_CAT_SOURCE" ;;
  }

  dimension: LSModify_or_Preventive_disease {
    type: string
    label: "LIFESTYLE MODIFIABLE OR PREVENTIVE DISEASE"
    sql: CASE WHEN ${icd_ls_modify} = 'TRUE' THEN 'LIFESTYLE MODIFIABLE DISEASE'
        WHEN ${icd_preventative} = 'TRUE' THEN 'PREVENTIVE DISEASE'
        ELSE 'NON_LIFESTYLE MODIFIABLE DISEASE & NON-PREVENTIVE DISEASE'
        END;;
  }

  measure: PATIENT_AVERAGE_AGE {
    type: average
    label: "PATIENT AVERAGE AGE"
    value_format: "#,##0.0"
    sql: ${patient_age} ;;
  }

  dimension: Diabetes_specific_Complications {
    type: string
    label: "DIABETES SPECIFIC COMPLICATIONS"
    sql: CASE WHEN LEFT(${reconciled_diagnosis_code_icd10},4) = '2505' OR
                        ${reconciled_diagnosis_code_icd10} IN ('36201', '3621', '36283', '36253', '36281', '36282', '36202', '37923','E08319', 'H3581','H35353', 'H3560', 'H3589', 'E08359', 'H4313') OR
                   LEFT(${reconciled_diagnosis_code_icd10},3) = '361' OR
                   LEFT(${reconciled_diagnosis_code_icd10},3) = '369' THEN 'Retinopathy'
              WHEN ${reconciled_diagnosis_code_icd10} IN ('3569', '2506', '3581', '9510', '9511', '9513', '3540', '3559', '7135', '3572', '59654', '3370', '3371', '5645', '5363', '458') OR
                   ${reconciled_diagnosis_code_icd10} IN ('G609', 'G733','S0410XA', 'S0422XA', 'S0440XA', 'G5602', 'G589', 'A5216', 'E1140', 'N319', 'G990', 'K591', 'K3184', 'E0840', 'E0841', 'E0842',
                  'E0843', 'E0940', 'E0943', 'E1040', 'E1043', 'E1140', 'E1143', 'E1340', 'E1343', 'G603', 'G609', 'G9009', 'H47011', 'H47012', 'H47013', 'H47019' )
                   THEN 'Neuropathy'
              WHEN ${reconciled_diagnosis_code_icd10} IN ('435', '431', '433', '434', '436') OR
                   ${reconciled_diagnosis_code_icd10} IN ('I619', 'I6789')
                   THEN 'Cerebrevascular'
              WHEN ${reconciled_diagnosis_code_icd10} IN ('2504', '580', '581', '58181', '582', '583', '585', '586', '5939') OR
                   ${reconciled_diagnosis_code_icd10} IN ('I6789', 'B520', 'N19', 'N29')
                   THEN 'Nephropathy'
              WHEN LEFT(${reconciled_diagnosis_code_icd10},3) = '440' OR
                   ${reconciled_diagnosis_code_icd10} IN ('411', '413', '414', '410', '4271', '4273', '4274', '4275', '4292', '412', '428', '44023', '44024', '441') OR
                   ${reconciled_diagnosis_code_icd10} IN ('I470', 'I462', 'I2510', 'I252', 'I70234', 'I70261')
                   THEN 'Cardiovascular'
              WHEN ${reconciled_diagnosis_code_icd10} IN ('2507', '4423', '44381', '4439', '8921', '44422', '7854', '04', '7071', '2501', '2502', '2503') OR
                   ${reconciled_diagnosis_code_icd10} IN ('I724', 'E1052', 'I739',  'S91341A', 'I743', 'I70469')
                   THEN 'Peripheral Vascular'
          ELSE 'Other Non-Diabetic Complications'
          END ;;
  }

  dimension: Primarycare_Physician_and_Speciality {
    type: string
    label: "PCP & SPECIALTY SERVICES"
    description: "Primary care physician & Specialty services"
    sql: CASE WHEN ${place_of_service} IN ('5', '6', '7', '8', '11', '17', '18', '49', '71', '72') THEN 'PRIMARY CARE PHYSICIAN SERVICES'
          WHEN ${place_of_service} NOT IN ('5', '6', '7', '8', '11', '17', '18', '49', '71', '72') THEN 'SPECIALTY SERVICES'
          ELSE 'OTHER Services'
          END  ;;
  }

# Cancer Screening Eligible Population (Breast, Colon & Cervical Cancer)
  dimension: Cancer_Screening_Eligible_Population {
    type: string
    description: "Total population eligible for Breast, Cervical & Colon cancer screening."
    sql: CASE WHEN ${patient_gender} = 'F' AND (${patient_age} >= 50 AND ${patient_age} <= 74) AND
          (${reconciled_diagnosis_code_icd10} NOT IN ('Z9011', 'Z9012', 'Z9013', '8542', '8544', '8546', '8548') OR
          ${primary_procedure_code} NOT IN ('0HTU0ZZ', '0HTV0ZZ', '0HTT0ZZ', '19303', '19304', '19305', '19306', '19307', '19200', '19220', '19180', '19240'))
          THEN 'ELIGIBLE - BREAST CANCER SCREENING'
        WHEN ((${patient_gender} = 'F') AND (${patient_age} >= 21 AND ${patient_age} <= 64)) AND
          (${reconciled_diagnosis_code_icd10} NOT IN ('Z90712', 'Z90710', 'Q515', '6185', 'V6701', 'V7647', 'V8801', 'V8803') OR
          ${primary_procedure_code} NOT IN ('684', '685', '686', '687', '688', '56308', '51925', '57540', '57545', '57550', '57555', '57556',
            '58150', '58152', '58200', '58210', '58240', '58260', '58262', '58263', '58267', '58270', '58275', '58280', '58285', '58290', '58291',
            '58292', '58293', '58294', '58548', '58550', '58551', '58552', '58553', '58554', '58570', '58571', '58572', '58573', '58951', '58953',
            '58954', '58956', '59135'))
          THEN 'ELIGIBLE - CERVICAL CANCER SCREENING'
        WHEN (${patient_age} >= 50 AND ${patient_age} <= 75) AND
          (${reconciled_diagnosis_code_icd10} NOT IN ('C180', 'C190', 'C20', 'C212', 'C218', 'C785', 'Z8503', 'Z8504', 'Z85040', 'Z85048', 'C180',
            'C190', 'C20', 'C212', 'C218', 'C785', 'Z85040', 'Z8504', 'Z8503', 'Z85048', '153', '1540', '1541', '1975', 'V1005') OR
          ${primary_procedure_code} NOT IN ('44140', '44141', '44143', '44144', '44145', '44146', '44147', '44150', '44151', '44155', '44156',
            '44157', '44158', '44160', '44204', '44205', '44206', '44207', '44208', '44210', '44211', '44212', '44213', 'G0213', 'G0214', 'G0215', 'G0231'))
          THEN 'ELIGIBLE - COLON CANCER SCREENING'
        ELSE 'ELIGIBLE - Other Screenings'
        END ;;
  }

  measure: Eligible_Breast_Cancer_Screening {
    type: count_distinct
    label: "Eligible: Breast Cancer Screening - N"
    filters: [Cancer_Screening_Eligible_Population: "ELIGIBLE - BREAST CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

  measure: Eligible_Cervical_Cancer_Screening {
    type: count_distinct
    label: "Eligible: Cervical Cancer Screening - N"
    filters: [Cancer_Screening_Eligible_Population: "ELIGIBLE - CERVICAL CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

  measure: Eligible_Colon_Cancer_Screening {
    type: count_distinct
    label: "Eligible: Colon Cancer Screening - N"
    filters: [Cancer_Screening_Eligible_Population: "ELIGIBLE - COLON CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

# Cancer Screening: Revenue Code-0401, 0403, 0923 & loinc_code-10524-7, 10525, 10526, 10527, 18500-9, 18501, 19762-4, 19764-0, 19765-7, 19766-5, 19774-9, 33717-0, 47527-7, 47528-5,  is missing from logic/condition.
  dimension: Cancer_Screening {
    type: string
    description: "Cancer Screening to identfy Patients who had screening for Breast/Cervical/Colon Cancer."
    sql: CASE WHEN ${patient_gender} = 'F' AND (${patient_age} >= 50 AND ${patient_age} <= 74) AND
          (${reconciled_diagnosis_code_icd10} IN ('V7611', 'V7612', 'Z1231', 'V7611', 'V7612', 'Z1231') OR
          ${primary_procedure_code} IN ('77055', '77056', '77057', '77061', '77062', '77063', '77065', '77066', '77067', 'G0202', 'G0204', 'G0206'))
          THEN 'BREAST CANCER SCREENING'
        WHEN ${patient_gender} = 'F' AND (${patient_age} >= 21 AND ${patient_age} <= 64) AND
          (${reconciled_diagnosis_code_icd10} IN ('V7232', 'Z124') OR
          ${primary_procedure_code} IN ('88141', '88142', '88143', '88147', '88148', '88150', '88152', '88153', '88154', '88164', '88165',
            '88166', '88167', '88174', '88175', 'G0123', 'G0124', 'G0141', 'G0143', 'G0144', 'G0145', 'G0147', 'G0148', 'P3000'))
          THEN 'CERVICAL CANCER SCREENING'
        WHEN (${patient_age} >= 50 AND ${patient_age} <= 75) AND
          (${primary_procedure_code} IN ('4522',  '4523',  '4525',   '4542',  '4543', '82270',  '82274',  '44388',  '44389',  '44390', '44391',
            '44392',  '44393',  '44394',  '44397',  '44401',  '44402',  '44403',  '44404', '44405', '44406',  '44407',  '44408',  '45355',  '45378',
            'G0328',  '45398',  '45330',  '45331', '45332', '45333',  '45334',  '45335',  '45337',  '45338', '45339',  '45340',  '45341',  '45342',
            '45345', '45346',  '45347',  '45349',  '45350',  'G0104', '81528',  'G0464',  '74261',  '74262',  '74263', 'G0105',  'G0121',   'G0464'))
          THEN 'COLON CANCER SCREENING'
        ELSE 'Other Screenings'
        END ;;
  }

  measure: Breast_Cancer_Screening {
    type: count_distinct
    label: "Breast Cancer Screening - N"
    filters: [Cancer_Screening: "BREAST CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

  measure: Breast_Cancer_Screening_Rate {
    type: number
    value_format: "0.0\%"
    sql: CASE WHEN ${Eligible_Breast_Cancer_Screening} = 0 THEN 0
        ELSE ${Breast_Cancer_Screening}*100/${Eligible_Breast_Cancer_Screening}
        END ;;
  }

  measure: Cervical_Cancer_Screening {
    type: count_distinct
    label: "Cervical Cancer Screening - N"
    filters: [Cancer_Screening: "CERVICAL CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

  measure: Cervical_Cancer_Screening_Rate {
    type: number
    value_format: "0.0\%"
    sql: CASE WHEN ${Eligible_Cervical_Cancer_Screening} = 0 THEN 0
        ELSE ${Cervical_Cancer_Screening}*100/${Eligible_Cervical_Cancer_Screening}
        END ;;
  }

  measure: Colon_Cancer_Screening {
    type: count_distinct
    label: "Colon Cancer Screening - N"
    filters: [Cancer_Screening: "COLON CANCER SCREENING"]
    sql: ${unique_id} ;;
  }

  measure: Colon_Cancer_Screening_Rate {
    type: number
    value_format: "0.0\%"
    sql: CASE WHEN ${Eligible_Colon_Cancer_Screening} = 0 THEN 0
        ELSE ${Colon_Cancer_Screening}*100/${Eligible_Colon_Cancer_Screening}
        END ;;
  }

  #Value of Preventive Screenings.
  dimension: Cancer_Diagnosis_and_Biopsy {
    type: string
    description: "Cancer Diagnosis (Breast/Cervical/Colon) & Biopsy or removal of suspicious polyps or tumors"
    sql: CASE WHEN ${primary_procedure_code} IN ('10021', '10022', '19100', '19101', '19102', '19120', '19125', '19291', '19295', 'G8875')
            THEN 'Breast Cancer & Biopsy/Removal of Tumors'
          WHEN ${primary_procedure_code} IN ('56820', '56821', '57420', '57421', '57452', '57454', '57455', '57456', '57460', '57461')
            THEN 'Cervical Cancer & Biopsy/Removal of Tumors'
          WHEN ${primary_procedure_code} IN ('45380', '45383', '45384', '45385')
            THEN 'Colon Cancer & Biopsy/Removal of Tumors'
          ELSE 'Other Cancer  Diagnosis'
          END
          ;;
  }

  measure: Breast_Cancer_Diagnosis_with_Biopsy {
    type: count_distinct
    label: "Breast Cancer Biopsy - N"
    filters: [Cancer_Diagnosis_and_Biopsy: "Breast Cancer & Biopsy/Removal of Tumors"]
    sql: ${unique_id} ;;
  }

  measure: Cervical_Cancer_Diagnosis_with_Biopsy {
    type: count_distinct
    label: "Cervical Cancer Biopsy - N"
    filters: [Cancer_Diagnosis_and_Biopsy: "Cervical Cancer & Biopsy/Removal of Tumors"]
    sql: ${unique_id} ;;
  }

  measure: Colon_Cancer_Diagnosis_with_Biopsy {
    type: count_distinct
    label: "Colon Cancer Biopsy - N"
    filters: [Cancer_Diagnosis_and_Biopsy: "Colon Cancer & Biopsy/Removal of Tumors"]
    sql: ${unique_id} ;;
  }

  dimension: Admit_Date {
    type: string
    sql: ${TABLE}."ADMIT_DATE" ;;
  }

  dimension: Discharge_Date {
    type: string
    sql: ${TABLE}."DISCHARGE_DATE" ;;
  }

  dimension: Inpatient_Outpatient_ER_Visits {
    type: string
    label: "InPatient/ OutPatient/ ER_Visits"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description]
    sql: CASE WHEN ${place_of_service} = '21' AND ${Admit_Date} IS NOT NULL THEN 'InPatient'
        WHEN ${place_of_service} IN ('19', '22', '49', '71', '72') THEN 'OutPatient'
        WHEN ${place_of_service} = '23' OR ${primary_procedure_code} IN ('99281', '99282', '99283', '99284', '99285') THEN 'ER Visits'
        ELSE 'Other Visits'
        END ;;
  }

  dimension: DIAGNOSIS_SUB_CATEGORY {
    type: string
    label: "DIAGNOSTIC SUBCATEGORY"
    drill_fields: [icd_description]
    sql: ${TABLE}."DISEASE_SUB_CATEGORY" ;;
  }

  dimension: MSK_BODY_PARTS {
    type: string
    label: "MSK-BODY PARTS"
    drill_fields: [icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description, PROCEDURE_CATEGORY, PROCEDURE_SUBCATEGORY, procedure_description]
    sql: ${TABLE}."MSK_BODY_PARTS" ;;
  }

  dimension: MSK_MRS_CODE_CLASSIFICATION {
    type: string
    label: "MSK-MRS Code Classification"
    sql: ${TABLE}."MSK_MRS_CODE_CLASSIFICATION" ;;
  }

  dimension: PROCEDURE_SUBCATEGORY {
    type: string
    label: "PROCEDURE SUBCATEGORY"
    drill_fields: [procedure_description]
    sql: ${TABLE}."PROCEDURE_SUBCATEGORY" ;;
  }

  dimension: PROCEDURE_CATEGORY {
    type: string
    label: "PROCEDURE CATEGORY"
    drill_fields: [PROCEDURE_SUBCATEGORY, procedure_description, icd_disease_category, DIAGNOSIS_SUB_CATEGORY, icd_description]
    sql: ${TABLE}."PROCEDURE_CATEGORY" ;;
  }

  dimension: RISK_GROUP {
    type: string
    label: "RISK GROUPS"
    sql: ${TABLE}."RISK_GROUP" ;;
  }

  dimension: TRUE_MSK_FLAG {
    type: string
    label: "TRUE MSK FLAG"
    sql: ${TABLE}."TRUE_MSK_FLAG" ;;
  }

  dimension: TRUE_MSK_PROCEDURE_HEADER {
    type: string
    label: "TRUE MSK PROCEDURE"
    sql: ${TABLE}."TRUE_MSK_PROCEDURE_HEADER" ;;
  }

  dimension: Foot_Exam_Flag {
    type: string
    hidden: yes
    sql: CASE WHEN ${primary_procedure_code} IN ('2028F', 'G0247', '2028F') THEN 'TRUE'
      ELSE 'FALSE'
      END ;;
  }

  dimension: Eye_Exam_Flag {
    type: string
    hidden: yes
    sql: CASE WHEN ${primary_procedure_code} IN ('67028', '67030', '67031', '67036', '67039',
        '67040', '67041', '67042', '67043', '67101', '67105', '67107', '67108', '67110', '67112', '67113', '67121', '67141', '67145', '67208', '67210', '67218', '67220', '67221', '67227', '67228', '92002', '92004', '92012', '92014', '92018', '92019', '92225', '92226', '92230', '92235', '92240', '92250', '92260', '92203', '99204', '99205', '99213', '99214', '99215', '2022F', '2024F', '2026F', '3072F', 'S0620', 'S0621', 'S3000') THEN 'TRUE'
      ELSE 'FALSE'
      END ;;
  }

  dimension: HbA1c_Flag {
    type: string
    hidden: yes
    sql: CASE WHEN ${primary_procedure_code} IN ('83036', '83037') THEN 'TRUE'
      ELSE 'FALSE'
      END ;;
  }

  measure: Diabetes_and_No_Foot_exam {
    type: count_distinct
    label: "Diabetes, No Foot Exam"
    filters: [icd_chronic_cat: "DIABETES", Foot_Exam_Flag: "FALSE"]
    sql: ${unique_id} ;;
  }

  measure: Diabetes_and_No_Eye_exam {
    type: count_distinct
    label: "Diabetes, No Eye Exam"
    filters: [icd_chronic_cat: "DIABETES", Eye_Exam_Flag: "FALSE"]
    sql: ${unique_id} ;;
  }

  measure: Diabetes_and_No_HbA1c_exam {
    type: count_distinct
    label: "Diabetes, No HbA1c"
    filters: [icd_chronic_cat: "DIABETES", HbA1c_Flag: "FALSE"]
    sql: ${unique_id} ;;
  }

  measure: Paid_date_Min {
    type: date
    label: "MEDICAL Claim - START"
    sql: MIN(${Paid_raw}) ;;
    html: {{ rendered_value | date: "%m / %d / %Y" }} ;;
  }

  measure: Paid_date_Max {
    type: date
    label: "MEDICAL Claim - END"
    sql: MAX(${Paid_raw}) ;;
    html: {{ rendered_value | date: "%m / %d / %Y" }} ;;
  }



  dimension: year_and_patient_id {
    type: string
    hidden: yes
    sql: CONCAT(${Paid_year}, ${unique_id}) ;;
  }

  measure: total_yearwise_patient_spend {
    type: sum
    sql_distinct_key: ${year_and_patient_id} ;;
    sql: ${total_employer_paid_amt}  ;;
  }
  dimension: patient_gender1 {
    type: string
    sql: case when ${TABLE}."PATIENT_GENDER"= 'M' then 'Male'
              when ${TABLE}."PATIENT_GENDER"= 'F' then 'Female'
              else '0'
          end;;
  }
  dimension: relationship_to_employee1 {
    type: string
    label: "RELATIONSHIP TO EMPLOYEE1"
    sql: case when ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" = 'EMPLOYEE' then 'Employee'
              when ${TABLE}."RELATIONSHIP_TO_EMPLOYEE" = 'SPOUSE' then 'Spouse'
              else 'Dependent'
        end;;
  }


  dimension: PARTICIPANT_NONPARTICIPANT_Flag {
    type: string
    hidden:  yes
    sql: ${TABLE}."PARTICIPANT_FLAG" ;;
  }

  dimension: participant_paid_year {
    type: string
    hidden: yes
    sql: ${Paid_year} ;;
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


  dimension: PARTICIPANT_PROGRAM_NAME{
    type: string
    label: "PARTICIPANT PROGRAM NAME"
    sql: ${TABLE}."PARTICIPANT_PROGRAM_NAME";;
  }

}
