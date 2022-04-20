view: vw_predictive_healthscore_index {
  sql_table_name: "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."ML_FINAL_TRAIN_TEST"
  ;;

  measure: 24_com_acute_cat_count {
    type: sum
    label: "Acute Count"
    sql: ${TABLE}."24COM_ACUTE_CAT_COUNT" ;;
  }

  dimension: 24_com_acute_cat_count_group {
    type: string
    sql: ${TABLE}."24COM_ACUTE_CAT_COUNT_Group" ;;
  }

  dimension: 24_com_acute_cat_count_woe {
    type: string
    sql: ${TABLE}."24COM_ACUTE_CAT_COUNT_WOE" ;;
  }

  measure: 24_com_avg_paid_amount {
    type: sum
    label: "24Com Avg Paid Amount"
    sql: ${TABLE}."24COM_AVG_PAID_AMOUNT" ;;
    value_format: "$0.00,\" K\""
  }

  measure: avg_24com_paid_amount {
    type: number
    label: "Avg Paid Amount"
    sql: ${24_com_avg_paid_amount}/${total_uid};;
    value_format: "$0.00,\" K\""
  }

  measure: 24_com_avg_sub_amount {
    type: sum
    label: "Avg Submitted Amount"
    sql: ${TABLE}."24COM_AVG_SUB_Amount" ;;
    value_format: "$0.00,\" K\""
  }

  measure: 24_com_chronic_cat_count {
    type: sum
    label: "24M Chronic Count"
    sql: ${TABLE}."24COM_CHRONIC_CAT_COUNT" ;;
  }

  dimension: 24_com_chronic_cat_count_group {
    type: string
    value_format: "0"
    sql: ${TABLE}."24COM_CHRONIC_CAT_COUNT_GROUP" ;;
  }

  measure: avg_comorbid_count{
    type: number
    label: "Avg Comorbid Count"
    sql: ${24_com_chronic_cat_count}/${total_uid};;
    value_format: "0.##"
  }

  measure: 24_com_chronic_icd_count {
    type: sum
    label: "24M Chronic Count"
    sql: ${TABLE}."24COM_CHRONIC_ICD_COUNT" ;;
  }

  dimension: 24_com_chronic_icd_count_group {
    type: string
    value_format: "0"
    sql: ${TABLE}."24COM_CHRONIC_ICD_COUNT_GROUP" ;;
  }

  measure: avg_chronic_count{
    type: number
    label: "Avg Chronic Count"
    sql: ${24_com_chronic_icd_count}/${total_uid};;
    value_format: "0.##"
  }

  measure: 24_com_claim_number_counts {
    type: sum
    sql: ${TABLE}."24COM_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: 24_com_claim_number_counts_group {
    type: string
    sql: ${TABLE}."24COM_CLAIM_NUMBER_COUNTS_Group" ;;
  }

  dimension: 24_com_claim_number_counts_woe {
    type: string
    sql: ${TABLE}."24COM_CLAIM_NUMBER_COUNTS_WOE" ;;
  }

  measure: 24_com_dist_year_count {
    type: sum
    sql: ${TABLE}."24COM_DIST_YEAR_COUNT" ;;
  }

  measure: 24_com_icd_counts {
    type: sum
    label: "Distinct Diagnosis Counts"
    sql: ${TABLE}."24COM_ICD_COUNTS" ;;
  }

  dimension: 24_com_icd_counts_group {
    type: string
    sql: ${TABLE}."24COM_ICD_COUNTS_GROUP" ;;
  }

  dimension: 24_com_icd_counts_group_label {
    type: string
    description: "ICD count group label"
    sql: CASE WHEN ${24_com_icd_counts_group} = '0' THEN  '0-3'
              WHEN ${24_com_icd_counts_group} = '1' THEN  '4-5'
              WHEN ${24_com_icd_counts_group} = '2' THEN  '6-8'
              WHEN ${24_com_icd_counts_group} = '3' THEN  '9-10'
              WHEN ${24_com_icd_counts_group} = '4' THEN  '11-12'
              WHEN ${24_com_icd_counts_group} = '5' THEN  '13-14'
              WHEN ${24_com_icd_counts_group} = '6' THEN  '15-17'
              WHEN ${24_com_icd_counts_group} = '7' THEN  '18-20'
              WHEN ${24_com_icd_counts_group} = '8' THEN  '21-25'
              WHEN ${24_com_icd_counts_group} = '9' THEN  '26-33'
              WHEN ${24_com_icd_counts_group} = '10' THEN  '>=34'
      END;;
  }

  dimension: perf_flag {
    type: string
    sql: ${TABLE}."PERF_FLAG" ;;
  }


  dimension: performance_flag {
    type: string
    label: "Performance Flag"
    sql: CASE WHEN ${perf_flag} = '1' THEN  'True'
              WHEN ${perf_flag} = '0' THEN  'False'
      END;;
  }

  dimension: 24_com_icd_counts_group_description {
    type: string
    sql: ${TABLE}."24COM_ICD_COUNTS_GROUP_DESCRIPTION" ;;
  }

  dimension: 24_com_icd_counts_woe {
    type: string
    sql: ${TABLE}."24COM_ICD_COUNTS_WOE" ;;
  }

  measure: 24_com_paid_amount {
    type: sum
    sql: ${TABLE}."24COM_PAID_AMOUNT" ;;
  }

  measure: 24_com_proc_counts {
    type: sum
    sql: ${TABLE}."24COM_PROC_COUNTS" ;;
  }

  dimension: 24_com_proc_counts_group {
    type: string
    sql: ${TABLE}."24COM_PROC_COUNTS_Group" ;;
  }

  dimension: 24_com_proc_counts_woe {
    type: string
    sql: ${TABLE}."24COM_PROC_COUNTS_WOE" ;;
  }

  measure: 24_com_sub_amount {
    type: sum
    description: "Submitted Paid Amount"
    sql: ${TABLE}."24COM_SUB_AMOUNT" ;;
    value_format: "$0.00,\" K\""
  }

  measure: age {
    type: average
    sql: ${TABLE}."AGE" ;;
    value_format: "0"
  }

  dimension: age_group {
    type: number
    sql: ${TABLE}."AGE_GROUP" ;;
  }

  dimension: age_grouping {
    type: string
    sql: ${TABLE}."AGE_GROUPING" ;;
  }

  dimension: age_group_label {
    type: string
    description: "Age Group label"
    sql: CASE WHEN ${age_group} = '0' THEN  '0-17'
              WHEN ${age_group} = '1' THEN  '18-24'
              WHEN ${age_group} = '2' THEN  '25-31'
              WHEN ${age_group} = '3' THEN  '32-36'
              WHEN ${age_group} = '4' THEN  '37-42'
              WHEN ${age_group} = '5' THEN  '43-47'
              WHEN ${age_group} = '6' THEN  '48-51'
              WHEN ${age_group} = '7' THEN  '52-56'
              WHEN ${age_group} = '8' THEN  '57-60'
              WHEN ${age_group} = '9' THEN  '>=61'
      END;;
  }

  dimension: age_group_description {
    type: string
    label: "Age Group Description"
    sql: ${TABLE}."AGE_GROUP_DESCRIPTION"
      ;;
  }
  dimension: age_woe {
    type: string
    sql: ${TABLE}."AGE_WOE" ;;
  }

  dimension: ans {
    type: string
    sql: ${TABLE}."ANS" ;;
  }

  dimension: ans_group {
    type: string
    sql: ${TABLE}."ANS_GROUP" ;;
  }

  dimension: ans_woe {
    type: string
    sql: ${TABLE}."ANS_WOE" ;;
  }

  dimension: arthritis_flag {
    type: string
    sql: ${TABLE}."ARTHRITIS_FLAG" ;;
  }

  dimension: bbo_acute_cat_count {
    type: string
    sql: ${TABLE}."BBO_ACUTE_CAT_COUNT" ;;
  }

  dimension: bbo_chronic_cat_count {
    type: string
    sql: ${TABLE}."BBO_CHRONIC_CAT_COUNT" ;;
  }

  dimension: bbo_chronic_icd_count {
    type: string
    sql: ${TABLE}."BBO_CHRONIC_ICD_COUNT" ;;
  }

  dimension: bbo_claim_number_counts {
    type: string
    sql: ${TABLE}."BBO_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: bbo_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."BBO_CPT_MAX_SUB_PAID" ;;
  }

  dimension: bbo_dist_year_count {
    type: string
    sql: ${TABLE}."BBO_DIST_YEAR_COUNT" ;;
  }

  dimension: bbo_flag {
    type: string
    sql: ${TABLE}."BBO_FLAG" ;;
  }

  dimension: bbo_icd_count {
    type: string
    sql: ${TABLE}."BBO_ICD_COUNT" ;;
  }

  dimension: bbo_icd_max_paid {
    type: string
    sql: ${TABLE}."BBO_ICD_MAX_PAID" ;;
  }

  dimension: bbo_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."BBO_ICD_MAX_SUB_PAID" ;;
  }

  dimension: bbo_paid_amount {
    type: string
    sql: ${TABLE}."BBO_PAID_AMOUNT" ;;
  }

  dimension: bbo_pos_max_paid {
    type: string
    sql: ${TABLE}."BBO_POS_MAX_PAID" ;;
  }

  dimension: bbo_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."BBO_POS_MAX_SUB_PAID" ;;
  }

  dimension: bbo_proc_counts {
    type: string
    sql: ${TABLE}."BBO_PROC_COUNTS" ;;
  }

  dimension: bbo_sub_amount {
    type: string
    sql: ${TABLE}."BBO_SUB_AMOUNT" ;;
  }

  dimension: ca_acute_cat_count {
    type: string
    sql: ${TABLE}."CA_ACUTE_CAT_COUNT" ;;
  }

  dimension: ca_chronic_cat_count {
    type: string
    sql: ${TABLE}."CA_CHRONIC_CAT_COUNT" ;;
  }

  dimension: ca_chronic_icd_count {
    type: string
    sql: ${TABLE}."CA_CHRONIC_ICD_COUNT" ;;
  }

  dimension: ca_claim_number_counts {
    type: string
    sql: ${TABLE}."CA_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: ca_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."CA_CPT_MAX_SUB_PAID" ;;
  }

  dimension: ca_dist_year_count {
    type: string
    sql: ${TABLE}."CA_DIST_YEAR_COUNT" ;;
  }

  dimension: ca_flag {
    type: string
    sql: ${TABLE}."CA_FLAG" ;;
  }

  dimension: ca_icd_count {
    type: string
    sql: ${TABLE}."CA_ICD_COUNT" ;;
  }

  dimension: ca_icd_max_paid {
    type: string
    sql: ${TABLE}."CA_ICD_MAX_PAID" ;;
  }

  dimension: ca_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."CA_ICD_MAX_SUB_PAID" ;;
  }

  dimension: ca_paid_amount {
    type: string
    sql: ${TABLE}."CA_PAID_AMOUNT" ;;
  }

  dimension: ca_pos_max_paid {
    type: string
    sql: ${TABLE}."CA_POS_MAX_PAID" ;;
  }

  dimension: ca_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."CA_POS_MAX_SUB_PAID" ;;
  }

  dimension: ca_proc_counts {
    type: string
    sql: ${TABLE}."CA_PROC_COUNTS" ;;
  }

  dimension: ca_sub_amount {
    type: string
    sql: ${TABLE}."CA_SUB_AMOUNT" ;;
  }

  dimension: cpt_max_paid_24_com {
    type: string
    sql: ${TABLE}."CPT_MAX_PAID_24COM" ;;
  }

  dimension: cpt_max_sub_24_com {
    type: string
    sql: ${TABLE}."CPT_MAX_SUB_24COM" ;;
  }

  measure: dcci_24_com {
    type: average
    label: "Charlson Deyo Comorbidity Index"
    sql: ${TABLE}."DCCI_24COM" ;;
  }

  dimension: dcci_24_com_group {
    type: string
    value_format: "0"
    sql: ${TABLE}."DCCI_24COM_GROUP" ;;
  }

  dimension: dcci_24_com_group_label {
    type: string
    description: "charlson comorbidity index label group"
    sql: CASE WHEN ${dcci_24_com_group} = '0' THEN  '0'
              WHEN ${dcci_24_com_group} = '1' THEN  '1'
              WHEN ${dcci_24_com_group} = '2' THEN  '>=2'
      END;;
  }

  dimension: dcci_24com_group_description {
    type: string
    sql: ${TABLE}."DCCI_24COM_GROUP_DESCRIPTION" ;;
  }

  dimension: dcci_24_com_woe {
    type: string
    sql: ${TABLE}."DCCI_24COM_WOE" ;;
  }

  dimension: dcs_acute_cat_count {
    type: string
    sql: ${TABLE}."DCS_ACUTE_CAT_COUNT" ;;
  }

  dimension: dcs_chronic_cat_count {
    type: string
    sql: ${TABLE}."DCS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: dcs_chronic_icd_count {
    type: string
    sql: ${TABLE}."DCS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: dcs_claim_number_counts {
    type: string
    sql: ${TABLE}."DCS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: dcs_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."DCS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: dcs_dist_year_count {
    type: string
    sql: ${TABLE}."DCS_DIST_YEAR_COUNT" ;;
  }

  dimension: dcs_flag {
    label: "Disease of Circulatory System"
    type: string
    sql: ${TABLE}."DCS_FLAG" ;;
  }

  dimension: dcs_icd_count {
    type: string
    sql: ${TABLE}."DCS_ICD_COUNT" ;;
  }

  dimension: dcs_icd_max_paid {
    type: string
    sql: ${TABLE}."DCS_ICD_MAX_PAID" ;;
  }

  dimension: dcs_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."DCS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: dcs_paid_amount {
    type: string
    sql: ${TABLE}."DCS_PAID_AMOUNT" ;;
  }

  dimension: dcs_pos_max_paid {
    type: string
    sql: ${TABLE}."DCS_POS_MAX_PAID" ;;
  }

  dimension: dcs_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."DCS_POS_MAX_SUB_PAID" ;;
  }

  dimension: dcs_proc_counts {
    type: string
    sql: ${TABLE}."DCS_PROC_COUNTS" ;;
  }

  dimension: dcs_sub_amount {
    type: string
    sql: ${TABLE}."DCS_SUB_AMOUNT" ;;
  }

  dimension: dds_acute_cat_count {
    type: string
    sql: ${TABLE}."DDS_ACUTE_CAT_COUNT" ;;
  }

  dimension: dds_chronic_cat_count {
    type: string
    sql: ${TABLE}."DDS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: dds_chronic_icd_count {
    type: string
    sql: ${TABLE}."DDS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: dds_claim_number_counts {
    type: string
    sql: ${TABLE}."DDS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: dds_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."DDS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: dds_dist_year_count {
    type: string
    sql: ${TABLE}."DDS_DIST_YEAR_COUNT" ;;
  }

  dimension: dds_flag {
    type: string
    sql: ${TABLE}."DDS_FLAG" ;;
  }

  dimension: dds_icd_count {
    type: string
    sql: ${TABLE}."DDS_ICD_COUNT" ;;
  }

  dimension: dds_icd_max_paid {
    type: string
    sql: ${TABLE}."DDS_ICD_MAX_PAID" ;;
  }

  dimension: dds_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."DDS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: dds_paid_amount {
    type: string
    sql: ${TABLE}."DDS_PAID_AMOUNT" ;;
  }

  dimension: dds_pos_max_paid {
    type: string
    sql: ${TABLE}."DDS_POS_MAX_PAID" ;;
  }

  dimension: dds_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."DDS_POS_MAX_SUB_PAID" ;;
  }

  dimension: dds_proc_counts {
    type: string
    sql: ${TABLE}."DDS_PROC_COUNTS" ;;
  }

  dimension: dds_sub_amount {
    type: string
    sql: ${TABLE}."DDS_SUB_AMOUNT" ;;
  }

  dimension: dgs_acute_cat_count {
    type: string
    sql: ${TABLE}."DGS_ACUTE_CAT_COUNT" ;;
  }

  dimension: dgs_chronic_cat_count {
    type: string
    sql: ${TABLE}."DGS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: dgs_chronic_icd_count {
    type: string
    sql: ${TABLE}."DGS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: dgs_claim_number_counts {
    type: string
    sql: ${TABLE}."DGS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: dgs_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."DGS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: dgs_dist_year_count {
    type: string
    sql: ${TABLE}."DGS_DIST_YEAR_COUNT" ;;
  }

  dimension: dgs_flag {
    type: string
    sql: ${TABLE}."DGS_FLAG" ;;
  }

  dimension: dgs_icd_count {
    type: string
    sql: ${TABLE}."DGS_ICD_COUNT" ;;
  }

  dimension: dgs_icd_max_paid {
    type: string
    sql: ${TABLE}."DGS_ICD_MAX_PAID" ;;
  }

  dimension: dgs_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."DGS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: dgs_paid_amount {
    type: string
    sql: ${TABLE}."DGS_PAID_AMOUNT" ;;
  }

  dimension: dgs_pos_max_paid {
    type: string
    sql: ${TABLE}."DGS_POS_MAX_PAID" ;;
  }

  dimension: dgs_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."DGS_POS_MAX_SUB_PAID" ;;
  }

  dimension: dgs_proc_counts {
    type: string
    sql: ${TABLE}."DGS_PROC_COUNTS" ;;
  }

  dimension: dgs_sub_amount {
    type: string
    sql: ${TABLE}."DGS_SUB_AMOUNT" ;;
  }

  dimension: diabetes_flag {
    type: number
    sql: ${TABLE}."DIABETES_FLAG" ;;
  }

  dimension: drs_acute_cat_count {
    type: string
    sql: ${TABLE}."DRS_ACUTE_CAT_COUNT" ;;
  }

  dimension: drs_chronic_cat_count {
    type: string
    sql: ${TABLE}."DRS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: drs_chronic_icd_count {
    type: string
    sql: ${TABLE}."DRS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: drs_claim_number_counts {
    type: string
    sql: ${TABLE}."DRS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: drs_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."DRS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: drs_dist_year_count {
    type: string
    sql: ${TABLE}."DRS_DIST_YEAR_COUNT" ;;
  }

  dimension: drs_flag {
    type: string
    sql: ${TABLE}."DRS_FLAG" ;;
  }

  dimension: drs_icd_count {
    type: string
    sql: ${TABLE}."DRS_ICD_COUNT" ;;
  }

  dimension: drs_icd_max_paid {
    type: string
    sql: ${TABLE}."DRS_ICD_MAX_PAID" ;;
  }

  dimension: drs_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."DRS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: drs_paid_amount {
    type: string
    sql: ${TABLE}."DRS_PAID_AMOUNT" ;;
  }

  dimension: drs_pos_max_paid {
    type: string
    sql: ${TABLE}."DRS_POS_MAX_PAID" ;;
  }

  dimension: drs_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."DRS_POS_MAX_SUB_PAID" ;;
  }

  dimension: drs_proc_counts {
    type: string
    sql: ${TABLE}."DRS_PROC_COUNTS" ;;
  }

  dimension: drs_sub_amount {
    type: string
    sql: ${TABLE}."DRS_SUB_AMOUNT" ;;
  }

  dimension: ecm_acute_cat_count {
    type: string
    sql: ${TABLE}."ECM_ACUTE_CAT_COUNT" ;;
  }

  dimension: ecm_chronic_cat_count {
    type: string
    sql: ${TABLE}."ECM_CHRONIC_CAT_COUNT" ;;
  }

  dimension: ecm_chronic_icd_count {
    type: string
    sql: ${TABLE}."ECM_CHRONIC_ICD_COUNT" ;;
  }

  dimension: ecm_claim_number_counts {
    type: string
    sql: ${TABLE}."ECM_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: ecm_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."ECM_CPT_MAX_SUB_PAID" ;;
  }

  dimension: ecm_dist_year_count {
    type: string
    sql: ${TABLE}."ECM_DIST_YEAR_COUNT" ;;
  }

  dimension: ecm_flag {
    type: string
    sql: ${TABLE}."ECM_FLAG" ;;
  }

  dimension: ecm_icd_count {
    type: string
    sql: ${TABLE}."ECM_ICD_COUNT" ;;
  }

  dimension: ecm_icd_max_paid {
    type: string
    sql: ${TABLE}."ECM_ICD_MAX_PAID" ;;
  }

  dimension: ecm_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."ECM_ICD_MAX_SUB_PAID" ;;
  }

  dimension: ecm_paid_amount {
    type: string
    sql: ${TABLE}."ECM_PAID_AMOUNT" ;;
  }

  dimension: ecm_pos_max_paid {
    type: string
    sql: ${TABLE}."ECM_POS_MAX_PAID" ;;
  }

  dimension: ecm_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."ECM_POS_MAX_SUB_PAID" ;;
  }

  dimension: ecm_proc_counts {
    type: string
    sql: ${TABLE}."ECM_PROC_COUNTS" ;;
  }

  dimension: ecm_sub_amount {
    type: string
    sql: ${TABLE}."ECM_SUB_AMOUNT" ;;
  }

  dimension: ems {
    type: string
    sql: ${TABLE}."EMS" ;;
  }

  dimension: evci_24_com {
    type: string
    sql: ${TABLE}."EVCI_24COM" ;;
  }

  measure: final_chronic_count {
    type: sum
    label: "Chronic Count"
    sql: ${TABLE}."FINAL_CHRONIC_COUNT" ;;
  }

  measure: final_comorbid_count {
    type: sum
    label: "Comorbid Count"
    sql: ${TABLE}."FINAL_COMORBID_COUNT" ;;
  }

  measure: final_score {
    type: sum
    sql: ${TABLE}."FINAL_SCORE" ;;
  }

  measure: avg_final_score {
    type: number
    label: "Avg Health Score"
    sql: ${final_score}/${total_uid};;
    value_format: "0"
  }

  dimension: fis_acute_cat_count {
    type: string
    sql: ${TABLE}."FIS_ACUTE_CAT_COUNT" ;;
  }

  dimension: fis_acute_cat_count_group {
    type: string
    sql: ${TABLE}."FIS_ACUTE_CAT_COUNT_GROUP" ;;
  }

  dimension: fis_acute_cat_count_woe {
    type: string
    sql: ${TABLE}."FIS_ACUTE_CAT_COUNT_WOE" ;;
  }

  dimension: fis_chronic_cat_count {
    type: string
    sql: ${TABLE}."FIS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: fis_chronic_icd_count {
    type: string
    sql: ${TABLE}."FIS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: fis_claim_number_counts {
    type: string
    sql: ${TABLE}."FIS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: fis_claim_number_counts_group {
    type: string
    sql: ${TABLE}."FIS_CLAIM_NUMBER_COUNTS_GROUP" ;;
  }

  dimension: fis_claim_number_counts_woe {
    type: string
    sql: ${TABLE}."FIS_CLAIM_NUMBER_COUNTS_WOE" ;;
  }

  dimension: fis_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."FIS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: fis_dist_year_count {
    type: string
    sql: ${TABLE}."FIS_DIST_YEAR_COUNT" ;;
  }

  dimension: fis_flag {
    type: string
    sql: ${TABLE}."FIS_FLAG" ;;
  }

  dimension: fis_icd_count {
    type: string
    sql: ${TABLE}."FIS_ICD_COUNT" ;;
  }

  dimension: fis_icd_count_group {
    type: string
    sql: ${TABLE}."FIS_ICD_COUNT_GROUP" ;;
  }

  dimension: fis_icd_count_woe {
    type: string
    sql: ${TABLE}."FIS_ICD_COUNT_WOE" ;;
  }

  dimension: fis_icd_max_paid {
    type: string
    sql: ${TABLE}."FIS_ICD_MAX_PAID" ;;
  }

  dimension: fis_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."FIS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: fis_paid_amount {
    type: string
    sql: ${TABLE}."FIS_PAID_AMOUNT" ;;
  }

  dimension: fis_pos_max_paid {
    type: string
    sql: ${TABLE}."FIS_POS_MAX_PAID" ;;
  }

  dimension: fis_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."FIS_POS_MAX_SUB_PAID" ;;
  }

  dimension: fis_proc_counts {
    type: string
    sql: ${TABLE}."FIS_PROC_COUNTS" ;;
  }

  dimension: fis_sub_amount {
    type: string
    sql: ${TABLE}."FIS_SUB_AMOUNT" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."GROUP" ;;
  }

  dimension: definition {
    type: string
    description: "Group Definition for risk profiling of people"
    sql: CASE WHEN  ${group}='Group1' THEN 'Spend < $1500 and no chronic disease'
              WHEN  ${group}='Group2' THEN 'Spend > $1500 and no chronic disease'
              WHEN  ${group}='Group3' THEN 'Chronic disease and no comorbidities'
              WHEN  ${group}='Group4' THEN 'Chronic disease + 1 comorbidity'
              WHEN  ${group}='Group5' THEN 'Chronic disease + 2 comorbidities'
              WHEN  ${group}='Group6' THEN 'Chronic disease + 3 comorbidities'
              WHEN  ${group}='Group7' THEN 'Chronic disease + 4 or > comorbidities'
        END;;
  }

  dimension: heart_disease_flag {
    type: number
    sql: ${TABLE}."HEART_DISEASE_FLAG" ;;
  }

  dimension: hypertension_flag {
    type: number
    sql: ${TABLE}."HYPERTENSION_FLAG" ;;
  }

  dimension: icd_max_paid_24_com {
    type: string
    sql: ${TABLE}."ICD_MAX_PAID_24COM" ;;
  }

  dimension: icd_max_sub_24_com {
    type: string
    sql: ${TABLE}."ICD_MAX_SUB_24COM" ;;
  }

  dimension: ilb {
    type: string
    sql: ${TABLE}."ILB" ;;
  }

  dimension: ip_acute_cat_count {
    type: string
    sql: ${TABLE}."IP_ACUTE_CAT_COUNT" ;;
  }

  dimension: ip_chronic_cat_count {
    type: string
    sql: ${TABLE}."IP_CHRONIC_CAT_COUNT" ;;
  }

  dimension: ip_chronic_icd_count {
    type: string
    sql: ${TABLE}."IP_CHRONIC_ICD_COUNT" ;;
  }

  dimension: ip_claim_number_counts {
    type: string
    sql: ${TABLE}."IP_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: ip_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."IP_CPT_MAX_SUB_PAID" ;;
  }

  dimension: ip_dist_year_count {
    type: string
    sql: ${TABLE}."IP_DIST_YEAR_COUNT" ;;
  }

  dimension: ip_flag {
    type: string
    sql: ${TABLE}."IP_FLAG" ;;
  }

  dimension: ip_icd_count {
    type: string
    sql: ${TABLE}."IP_ICD_COUNT" ;;
  }

  dimension: ip_icd_max_paid {
    type: string
    sql: ${TABLE}."IP_ICD_MAX_PAID" ;;
  }

  dimension: ip_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."IP_ICD_MAX_SUB_PAID" ;;
  }

  dimension: ip_paid_amount {
    type: string
    sql: ${TABLE}."IP_PAID_AMOUNT" ;;
  }

  dimension: ip_pos_max_paid {
    type: string
    sql: ${TABLE}."IP_POS_MAX_PAID" ;;
  }

  dimension: ip_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."IP_POS_MAX_SUB_PAID" ;;
  }

  dimension: ip_proc_counts {
    type: string
    sql: ${TABLE}."IP_PROC_COUNTS" ;;
  }

  dimension: ip_sub_amount {
    type: string
    sql: ${TABLE}."IP_SUB_AMOUNT" ;;
  }

  dimension: ipd_acute_cat_count {
    type: string
    sql: ${TABLE}."IPD_ACUTE_CAT_COUNT" ;;
  }

  dimension: ipd_chronic_cat_count {
    type: string
    sql: ${TABLE}."IPD_CHRONIC_CAT_COUNT" ;;
  }

  dimension: ipd_chronic_icd_count {
    type: string
    sql: ${TABLE}."IPD_CHRONIC_ICD_COUNT" ;;
  }

  dimension: ipd_claim_number_counts {
    type: string
    sql: ${TABLE}."IPD_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: ipd_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."IPD_CPT_MAX_SUB_PAID" ;;
  }

  dimension: ipd_dist_year_count {
    type: string
    sql: ${TABLE}."IPD_DIST_YEAR_COUNT" ;;
  }

  dimension: ipd_flag {
    type: string
    sql: ${TABLE}."IPD_FLAG" ;;
  }

  dimension: ipd_icd_count {
    type: string
    sql: ${TABLE}."IPD_ICD_COUNT" ;;
  }

  dimension: ipd_icd_max_paid {
    type: string
    sql: ${TABLE}."IPD_ICD_MAX_PAID" ;;
  }

  dimension: ipd_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."IPD_ICD_MAX_SUB_PAID" ;;
  }

  dimension: ipd_paid_amount {
    type: string
    sql: ${TABLE}."IPD_PAID_AMOUNT" ;;
  }

  dimension: ipd_pos_max_paid {
    type: string
    sql: ${TABLE}."IPD_POS_MAX_PAID" ;;
  }

  dimension: ipd_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."IPD_POS_MAX_SUB_PAID" ;;
  }

  dimension: ipd_proc_counts {
    type: string
    sql: ${TABLE}."IPD_PROC_COUNTS" ;;
  }

  dimension: ipd_sub_amount {
    type: string
    sql: ${TABLE}."IPD_SUB_AMOUNT" ;;
  }

  dimension: md_acute_cat_count {
    type: string
    sql: ${TABLE}."MD_ACUTE_CAT_COUNT" ;;
  }

  dimension: md_chronic_cat_count {
    type: string
    sql: ${TABLE}."MD_CHRONIC_CAT_COUNT" ;;
  }

  dimension: md_chronic_icd_count {
    type: string
    sql: ${TABLE}."MD_CHRONIC_ICD_COUNT" ;;
  }

  dimension: md_claim_number_counts {
    type: string
    sql: ${TABLE}."MD_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: md_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."MD_CPT_MAX_SUB_PAID" ;;
  }

  dimension: md_dist_year_count {
    type: string
    sql: ${TABLE}."MD_DIST_YEAR_COUNT" ;;
  }

  dimension: md_flag {
    type: string
    sql: ${TABLE}."MD_FLAG" ;;
  }

  dimension: md_icd_count {
    type: string
    sql: ${TABLE}."MD_ICD_COUNT" ;;
  }

  dimension: md_icd_max_paid {
    type: string
    sql: ${TABLE}."MD_ICD_MAX_PAID" ;;
  }

  dimension: md_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."MD_ICD_MAX_SUB_PAID" ;;
  }

  dimension: md_paid_amount {
    type: string
    sql: ${TABLE}."MD_PAID_AMOUNT" ;;
  }

  dimension: md_pos_max_paid {
    type: string
    sql: ${TABLE}."MD_POS_MAX_PAID" ;;
  }

  dimension: md_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."MD_POS_MAX_SUB_PAID" ;;
  }

  dimension: md_proc_counts {
    type: string
    sql: ${TABLE}."MD_PROC_COUNTS" ;;
  }

  dimension: md_sub_amount {
    type: string
    sql: ${TABLE}."MD_SUB_AMOUNT" ;;
  }

  dimension: month_year_file_date_l {
    type: number
    sql: ${TABLE}."MONTH_YEAR_FILE_DATE_L" ;;
  }

  dimension: msk_acute_cat_count {
    type: number
    value_format: "0"
    label: "MSK Acute Count"
    sql: ${TABLE}."MSK_ACUTE_CAT_COUNT" ;;
  }

  dimension: msk_chronic_cat_count {
    type: string
    sql: ${TABLE}."MSK_CHRONIC_CAT_COUNT" ;;
  }

  dimension: msk_chronic_icd_count {
    type: string
    sql: ${TABLE}."MSK_CHRONIC_ICD_COUNT" ;;
  }

  dimension: msk_claim_number_counts {
    type: string
    sql: ${TABLE}."MSK_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: msk_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."MSK_CPT_MAX_SUB_PAID" ;;
  }

  dimension: msk_dist_year_count {
    type: string
    sql: ${TABLE}."MSK_DIST_YEAR_COUNT" ;;
  }

  dimension: msk_flag {
    type: string
    sql: ${TABLE}."MSK_FLAG" ;;
  }

  dimension: musculoskeletal_flag {
    type: string
    label: "Musculoskeletal Flag"
    sql: CASE WHEN ${msk_flag} = '1' THEN  'True'
              WHEN ${msk_flag} = '0' THEN  'False'
      END;;
  }

  dimension: msk_icd_count {
    type: string
    sql: ${TABLE}."MSK_ICD_COUNT" ;;
  }

  dimension: msk_icd_max_paid {
    type: string
    sql: ${TABLE}."MSK_ICD_MAX_PAID" ;;
  }

  dimension: msk_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."MSK_ICD_MAX_SUB_PAID" ;;
  }

  dimension: msk_paid_amount {
    type: string
    sql: ${TABLE}."MSK_PAID_AMOUNT" ;;
  }

  dimension: msk_pos_max_paid {
    type: string
    sql: ${TABLE}."MSK_POS_MAX_PAID" ;;
  }

  dimension: msk_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."MSK_POS_MAX_SUB_PAID" ;;
  }

  dimension: msk_proc_counts {
    type: string
    sql: ${TABLE}."MSK_PROC_COUNTS" ;;
  }

  dimension: msk_sub_amount {
    type: string
    sql: ${TABLE}."MSK_SUB_AMOUNT" ;;
  }

  dimension: msp {
    type: string
    sql: ${TABLE}."MSP" ;;
  }

  dimension: msp_group {
    type: string
    sql: ${TABLE}."MSP_GROUP" ;;
  }

  dimension: msp_woe {
    type: string
    sql: ${TABLE}."MSP_WOE" ;;
  }

  dimension: neo_acute_cat_count {
    type: string
    sql: ${TABLE}."NEO_ACUTE_CAT_COUNT" ;;
  }

  dimension: neo_chronic_cat_count {
    type: string
    sql: ${TABLE}."NEO_CHRONIC_CAT_COUNT" ;;
  }

  dimension: neo_chronic_icd_count {
    type: string
    sql: ${TABLE}."NEO_CHRONIC_ICD_COUNT" ;;
  }

  dimension: neo_claim_number_counts {
    type: string
    sql: ${TABLE}."NEO_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: neo_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."NEO_CPT_MAX_SUB_PAID" ;;
  }

  dimension: neo_dist_year_count {
    type: string
    sql: ${TABLE}."NEO_DIST_YEAR_COUNT" ;;
  }

  dimension: neo_flag {
    label: "Neoplasms"
    type: string
    sql: ${TABLE}."NEO_FLAG" ;;
  }

  dimension: mbn_flag {
    label: "Mental, Behavioral & Neurodevelopment Disorders"
    type: string
    sql: ${TABLE}."MBN_FLAG" ;;
  }
  dimension: neo_icd_count {
    type: string
    sql: ${TABLE}."NEO_ICD_COUNT" ;;
  }

  dimension: neo_icd_max_paid {
    type: string
    sql: ${TABLE}."NEO_ICD_MAX_PAID" ;;
  }

  dimension: neo_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."NEO_ICD_MAX_SUB_PAID" ;;
  }

  dimension: neo_paid_amount {
    type: string
    sql: ${TABLE}."NEO_PAID_AMOUNT" ;;
  }

  dimension: neo_pos_max_paid {
    type: string
    sql: ${TABLE}."NEO_POS_MAX_PAID" ;;
  }

  dimension: neo_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."NEO_POS_MAX_SUB_PAID" ;;
  }

  dimension: neo_proc_counts {
    type: string
    sql: ${TABLE}."NEO_PROC_COUNTS" ;;
  }

  dimension: neo_sub_amount {
    type: string
    sql: ${TABLE}."NEO_SUB_AMOUNT" ;;
  }

  dimension: nmi_acute_cat_count {
    type: string
    sql: ${TABLE}."NMI_ACUTE_CAT_COUNT" ;;
  }

  dimension: nmi_chronic_cat_count {
    type: string
    sql: ${TABLE}."NMI_CHRONIC_CAT_COUNT" ;;
  }

  dimension: nmi_chronic_icd_count {
    type: string
    sql: ${TABLE}."NMI_CHRONIC_ICD_COUNT" ;;
  }

  dimension: nmi_claim_number_counts {
    type: string
    sql: ${TABLE}."NMI_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: nmi_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."NMI_CPT_MAX_SUB_PAID" ;;
  }

  dimension: nmi_dist_year_count {
    type: string
    sql: ${TABLE}."NMI_DIST_YEAR_COUNT" ;;
  }

  dimension: nmi_flag {
    type: string
    sql: ${TABLE}."NMI_FLAG" ;;
  }

  dimension: nmi_icd_count {
    type: string
    sql: ${TABLE}."NMI_ICD_COUNT" ;;
  }

  dimension: nmi_icd_max_paid {
    type: string
    sql: ${TABLE}."NMI_ICD_MAX_PAID" ;;
  }

  dimension: nmi_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."NMI_ICD_MAX_SUB_PAID" ;;
  }

  dimension: nmi_paid_amount {
    type: string
    sql: ${TABLE}."NMI_PAID_AMOUNT" ;;
  }

  dimension: nmi_pos_max_paid {
    type: string
    sql: ${TABLE}."NMI_POS_MAX_PAID" ;;
  }

  dimension: nmi_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."NMI_POS_MAX_SUB_PAID" ;;
  }

  dimension: nmi_proc_counts {
    type: string
    sql: ${TABLE}."NMI_PROC_COUNTS" ;;
  }

  dimension: nmi_sub_amount {
    type: string
    sql: ${TABLE}."NMI_SUB_AMOUNT" ;;
  }

  dimension: norm {
    type: string
    sql: ${TABLE}."NORM" ;;
  }

  dimension: decile_grouping {
    type: string
    label: "Health Score Decile"
    sql: ${TABLE}."DECILE_SCORE_GROUPING" ;;
  }

  dimension: nss_acute_cat_count {
    type: string
    sql: ${TABLE}."NSS_ACUTE_CAT_COUNT" ;;
  }

  dimension: nss_chronic_cat_count {
    type: string
    sql: ${TABLE}."NSS_CHRONIC_CAT_COUNT" ;;
  }

  dimension: nss_chronic_icd_count {
    type: string
    sql: ${TABLE}."NSS_CHRONIC_ICD_COUNT" ;;
  }

  dimension: nss_claim_number_counts {
    type: string
    sql: ${TABLE}."NSS_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: nss_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."NSS_CPT_MAX_SUB_PAID" ;;
  }

  dimension: nss_dist_year_count {
    type: string
    sql: ${TABLE}."NSS_DIST_YEAR_COUNT" ;;
  }

  dimension: nss_flag {
    type: string
    sql: ${TABLE}."NSS_FLAG" ;;
  }

  dimension: nss_icd_count {
    type: string
    sql: ${TABLE}."NSS_ICD_COUNT" ;;
  }

  dimension: nss_icd_max_paid {
    type: string
    sql: ${TABLE}."NSS_ICD_MAX_PAID" ;;
  }

  dimension: nss_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."NSS_ICD_MAX_SUB_PAID" ;;
  }

  dimension: nss_paid_amount {
    type: string
    sql: ${TABLE}."NSS_PAID_AMOUNT" ;;
  }

  dimension: nss_pos_max_paid {
    type: string
    sql: ${TABLE}."NSS_POS_MAX_PAID" ;;
  }

  dimension: nss_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."NSS_POS_MAX_SUB_PAID" ;;
  }

  dimension: nss_proc_counts {
    type: string
    sql: ${TABLE}."NSS_PROC_COUNTS" ;;
  }

  dimension: nss_sub_amount {
    type: string
    sql: ${TABLE}."NSS_SUB_AMOUNT" ;;
  }

  dimension: opp_acute_cat_count {
    type: string
    sql: ${TABLE}."OPP_ACUTE_CAT_COUNT" ;;
  }

  dimension: opp_chronic_cat_count {
    type: string
    sql: ${TABLE}."OPP_CHRONIC_CAT_COUNT" ;;
  }

  dimension: opp_chronic_icd_count {
    type: string
    sql: ${TABLE}."OPP_CHRONIC_ICD_COUNT" ;;
  }

  dimension: opp_claim_number_counts {
    type: string
    sql: ${TABLE}."OPP_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: opp_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."OPP_CPT_MAX_SUB_PAID" ;;
  }

  dimension: opp_dist_year_count {
    type: string
    sql: ${TABLE}."OPP_DIST_YEAR_COUNT" ;;
  }

  dimension: opp_flag {
    type: string
    sql: ${TABLE}."OPP_FLAG" ;;
  }

  dimension: opp_icd_count {
    type: string
    sql: ${TABLE}."OPP_ICD_COUNT" ;;
  }

  dimension: opp_icd_max_paid {
    type: string
    sql: ${TABLE}."OPP_ICD_MAX_PAID" ;;
  }

  dimension: opp_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."OPP_ICD_MAX_SUB_PAID" ;;
  }

  dimension: opp_paid_amount {
    type: string
    sql: ${TABLE}."OPP_PAID_AMOUNT" ;;
  }

  dimension: opp_pos_max_paid {
    type: string
    sql: ${TABLE}."OPP_POS_MAX_PAID" ;;
  }

  dimension: opp_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."OPP_POS_MAX_SUB_PAID" ;;
  }

  dimension: opp_proc_counts {
    type: string
    sql: ${TABLE}."OPP_PROC_COUNTS" ;;
  }

  dimension: opp_sub_amount {
    type: string
    sql: ${TABLE}."OPP_SUB_AMOUNT" ;;
  }

  dimension: p_24_com_icd_counts {
    type: number
    label: "Distinct Diagnosis Counts."
    value_format: "0"
    sql: ${TABLE}."P_24COM_ICD_COUNT" ;;
  }

  dimension: p_age {
    type: number
    label: "Age."
    value_format: "0"
    sql: ${TABLE}."P_AGE" ;;
  }

  dimension: p_dcs_flag {
    type: number
    label: "Disease of Circulatory System."
    value_format: "0"
    sql: ${TABLE}."P_DCS_FLAG" ;;
  }


  dimension: dcs_flag_group_description {
    type: string
    sql: ${TABLE}."DCS_FLAG_GROUP_DESCRIPTION"
      ;;
  }

  dimension: p_neo_flag {
    type: number
    label: "Neoplasms."
    value_format: "0"
    sql: ${TABLE}."P_NEO_FLAG" ;;
  }

  dimension: neo_flag_group_description {
    type: string
    sql: ${TABLE}."NEO_FLAG_GROUP_DESCRIPTION"
      ;;
  }

  dimension: p_mbn_flag {
    type: number
    label: "Mental, Behavioral & Neurodevelopment Disorders."
    value_format: "0"
    sql: ${TABLE}."P_MBN_FLAG" ;;
  }

  dimension: mbn_flag_group_description {
    type: string
    sql: ${TABLE}."MBN_FLAG_GROUP_DESCRIPTION"
      ;;
  }
  dimension: p_dcci_24_com {
    type: number
    label: "Charlson Deyo Comorbidity Index."
    value_format: "0"
    sql: ${TABLE}."P_DCCI_24COM" ;;
  }

  dimension: p_plp {
    type: number
    label: "Pathology & Lab Count"
    value_format: "0"
    sql: ${TABLE}."P_PLP" ;;
  }

  dimension: p_risk_flag {
    type: number
    label: "Risk Associated with Chronicity."
    value_format: "0"
    sql: ${TABLE}."P_RISK_FLAG" ;;
  }

  dimension: p_sur {
    type: number
    label: "Surgery Count"
    value_format: "0"
    sql: ${TABLE}."P_SUR" ;;
  }

  dimension: patient_birth_year {
    type: string
    sql: ${TABLE}."PATIENT_BIRTH_YEAR" ;;
  }

  dimension: patient_date_of_birth {
    type: string
    sql: ${TABLE}."PATIENT_DATE_OF_BIRTH" ;;
  }

  dimension: patient_id_l {
    type: string
    sql: ${TABLE}."PATIENT_ID_L" ;;
  }

  dimension: pcp_acute_cat_count {
    type: string
    sql: ${TABLE}."PCP_ACUTE_CAT_COUNT" ;;
  }

  dimension: pcp_chronic_cat_count {
    type: string
    sql: ${TABLE}."PCP_CHRONIC_CAT_COUNT" ;;
  }

  dimension: pcp_chronic_icd_count {
    type: string
    sql: ${TABLE}."PCP_CHRONIC_ICD_COUNT" ;;
  }

  dimension: pcp_claim_number_counts {
    type: string
    sql: ${TABLE}."PCP_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: pcp_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."PCP_CPT_MAX_SUB_PAID" ;;
  }

  dimension: pcp_dist_year_count {
    type: string
    sql: ${TABLE}."PCP_DIST_YEAR_COUNT" ;;
  }

  dimension: pcp_flag {
    type: string
    sql: ${TABLE}."PCP_FLAG" ;;
  }

  dimension: pcp_icd_count {
    type: string
    sql: ${TABLE}."PCP_ICD_COUNT" ;;
  }

  dimension: pcp_icd_max_paid {
    type: string
    sql: ${TABLE}."PCP_ICD_MAX_PAID" ;;
  }

  dimension: pcp_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."PCP_ICD_MAX_SUB_PAID" ;;
  }

  dimension: pcp_paid_amount {
    type: string
    sql: ${TABLE}."PCP_PAID_AMOUNT" ;;
  }

  dimension: pcp_pos_max_paid {
    type: string
    sql: ${TABLE}."PCP_POS_MAX_PAID" ;;
  }

  dimension: pcp_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."PCP_POS_MAX_SUB_PAID" ;;
  }

  dimension: pcp_proc_counts {
    type: string
    sql: ${TABLE}."PCP_PROC_COUNTS" ;;
  }

  dimension: pcp_sub_amount {
    type: string
    sql: ${TABLE}."PCP_SUB_AMOUNT" ;;
  }

  measure: perf_acute_cat_count {
    type: number
    sql: ${TABLE}."PERF_ACUTE_CAT_COUNT" ;;
  }

  measure: perf_chronic_cat_count {
    type: number
    sql: ${TABLE}."PERF_CHRONIC_CAT_COUNT" ;;
  }

  measure: perf_chronic_icd_count {
    type: number
    sql: ${TABLE}."PERF_CHRONIC_ICD_COUNT" ;;
  }

  measure: perf_claim_number_counts {
    type: number
    sql: ${TABLE}."PERF_CLAIM_NUMBER_COUNTS" ;;
  }

  measure: perf_dist_year_count {
    type: number
    sql: ${TABLE}."PERF_DIST_YEAR_COUNT" ;;
  }

  measure: perf_icd_counts {
    type: number
    sql: ${TABLE}."PERF_ICD_COUNTS" ;;
  }

  measure: perf_paid_amount {
    type: sum
    label: "Performance Paid Amount"
    sql: ${TABLE}."PERF_PAID_AMOUNT" ;;
    value_format: "$0.00,\" K\""
  }

  measure: perf_proc_counts {
    type: number
    sql: ${TABLE}."PERF_PROC_COUNTS" ;;
  }

  measure: perf_sub_amount {
    type: number
    sql: ${TABLE}."PERF_SUB_AMOUNT" ;;


  }

  measure: total_uid {
    type: count_distinct
    label: "Total Patients"
    # html: <a href="https://dynpro.cloud.looker.com/dashboards-next/633">{{total_uid}}</a>;;
    drill_fields: [patient_id_l, year_file_date_l, avg_24com_paid_amount, avg_predicted_paid_amount, age, gender, sur, 24_com_icd_counts, risk_flag, dcci_24_com,scale_score]
    link: {
      label: "Patient Analysis"

      #url: "/dashboards-next/633?Health Index Decile={{ _filters['vw_predictive_healthscore_index.decile_grouping'] | url_encode }}&Health Index Quartile={{ _filters['vw_predictive_healthscore_index.quartile_grouping'] | url_encode }}&Gender={{ _filters['vw_predictive_healthscore_index.gender'] | url_encode }}&Age Group Description={{ _filters['vw_predictive_healthscore_index.age_group_description'] | url_encode }}&Musculoskeletal Flag={{ _filters['vw_predictive_healthscore_index.musculoskeletal_flag'] | url_encode }}"

      url: "/dashboards-next/633?Health Index Decile={{ _filters['vw_predictive_healthscore_index.decile_grouping'] | url_encode }}&Health Index Quartile={{ _filters['vw_predictive_healthscore_index.quartile_grouping'] | url_encode }}&Gender={{ _filters['vw_predictive_healthscore_index.gender'] | url_encode }}&Age Group Description={{ _filters['vw_predictive_healthscore_index.age_group_description'] | url_encode }}&Musculoskeletal Flag={{ _filters['vw_predictive_healthscore_index.musculoskeletal_flag'] | url_encode }}&Performance Flag={{ _filters['vw_predictive_healthscore_index.performance_flag'] | url_encode }}"

    }
    sql:  CONCAT(${patient_id_l}, ${year_file_date_l}) ;;
  }


  measure: avg_perf_paid_amount {
    type: number
    label: "Avg Performance Paid Amount"
    sql: ${perf_paid_amount}/${total_uid};;
    value_format: "$0.00,\" K\""
  }

  dimension: plp {
    type: string
    label: "Pathology & Lab Count"
    sql: ${TABLE}."PLP" ;;
  }

  dimension: plp_group {
    type: string
    sql: ${TABLE}."PLP_GROUP" ;;
  }

  dimension: plp_group_label {
    type: string
    description: "This is the grouping for Pathology and Laboratory Procedure"
    sql: CASE WHEN ${plp_group} = '0' THEN  '0-2'
              WHEN ${plp_group} = '1' THEN  '3-23'
              WHEN ${plp_group} = '2' THEN  '24-47'
              WHEN ${plp_group} = '3' THEN  '48-72'
              WHEN ${plp_group} = '4' THEN  '73-101'
              WHEN ${plp_group} = '5' THEN  '101-141'
              WHEN ${plp_group} = '6' THEN  '142-186'
              WHEN ${plp_group} = '7' THEN  '187-254'
              WHEN ${plp_group} = '8' THEN  '255-324'
              WHEN ${plp_group} = '9' THEN  '325-427'
              WHEN ${plp_group} = '10' THEN  '428-626'
              WHEN ${plp_group} = '11' THEN  '>=627'
              WHEN ${plp_group} = '12' THEN  'Missing'
      END;;
  }

  dimension: plp_woe {
    type: string
    sql: ${TABLE}."PLP_WOE" ;;
  }

  dimension: pos_max_paid_24_com {
    type: string
    sql: ${TABLE}."POS_MAX_PAID_24COM" ;;
  }

  dimension: pos_max_sub_24_com {
    type: string
    sql: ${TABLE}."POS_MAX_SUB_24COM" ;;
  }

  measure: predicted_paid_amount {
    type: sum
    sql: ${TABLE}."PREDICTED_PAID_AMOUNT" ;;
  }

  measure: avg_predicted_paid_amount {
    type: number
    label: "Avg Predicted Paid Amount"
    sql: ${predicted_paid_amount}/${total_uid};;
    value_format: "$0.00,\" K\""
  }

  dimension: quartile {
    type: string
    sql: CAST(${TABLE}."QUARTILE" as INTEGER) ;;
  }

  dimension: quartile_grouping{
    type: string
    label: "Health Score Quartile"
    sql: ${TABLE}."QUARTILE_SCORE_GROUPING" ;;
  }

  dimension: rap {
    type: string
    sql: ${TABLE}."RAP" ;;
  }

  dimension: rap_group {
    type: string
    sql: ${TABLE}."RAP_GROUP" ;;
  }

  dimension: rap_woe {
    type: string
    sql: ${TABLE}."RAP_WOE" ;;
  }

  dimension: risk_flag {
    label: "Risk Associated with Chronicity"
    type: string
    sql: ${TABLE}."RISK_FLAG" ;;
  }

  dimension: risk_flag_group {
    type: string
    value_format: "0"
    sql: ${TABLE}."RISK_FLAG_GROUP" ;;
  }

  dimension: risk_flag_group_label {
    type: string
    description: "This is Risk Flag label which is derived from Diabetes, Hypertension, Arthritis and Heart Disease"
    sql: CASE WHEN ${risk_flag_group} = '0' THEN  '0'
              WHEN ${risk_flag_group} = '1' THEN  '1'
              WHEN ${risk_flag_group} = '2' THEN  '>=2'
      END;;
  }

  dimension: risk_flag_group_description {
    type: string
    sql: ${TABLE}."RISK_FLAG_GROUP_DESCRIPTION"
      ;;
  }
  dimension: risk_flag_woe {
    type: string
    sql: ${TABLE}."RISK_FLAG_WOE" ;;
  }

  dimension: scale_dist {
    type: string
    sql: ${TABLE}."SCALE_DIST" ;;
  }

  dimension: scale_score {
    type: number
    label: "SCORE"
    value_format: "0"
    sql: ${TABLE}."SCALE_SCORE" ;;
  }

  dimension: score_dist {
    type: string
    sql: ${TABLE}."SCORE_DIST" ;;
  }

  dimension: severity_1 {
    type: number
    value_format: "0"
    sql: ${TABLE}."SEVERITY_1" ;;
  }

  dimension: sno {
    type: string
    sql: ${TABLE}."SNO" ;;
  }

  dimension: ssi_acute_cat_count {
    type: string
    sql: ${TABLE}."SSI_ACUTE_CAT_COUNT" ;;
  }

  dimension: ssi_chronic_cat_count {
    type: string
    sql: ${TABLE}."SSI_CHRONIC_CAT_COUNT" ;;
  }

  dimension: ssi_chronic_icd_count {
    type: string
    sql: ${TABLE}."SSI_CHRONIC_ICD_COUNT" ;;
  }

  dimension: ssi_claim_number_counts {
    type: string
    sql: ${TABLE}."SSI_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: ssi_claim_number_counts_group {
    type: string
    sql: ${TABLE}."SSI_CLAIM_NUMBER_COUNTS_GROUP" ;;
  }

  dimension: ssi_claim_number_counts_woe {
    type: string
    sql: ${TABLE}."SSI_CLAIM_NUMBER_COUNTS_WOE" ;;
  }

  dimension: ssi_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."SSI_CPT_MAX_SUB_PAID" ;;
  }

  dimension: ssi_dist_year_count {
    type: string
    sql: ${TABLE}."SSI_DIST_YEAR_COUNT" ;;
  }

  dimension: ssi_flag {
    type: string
    sql: ${TABLE}."SSI_FLAG" ;;
  }

  dimension: ssi_icd_count {
    type: string
    sql: ${TABLE}."SSI_ICD_COUNT" ;;
  }

  dimension: ssi_icd_count_group {
    type: string
    sql: ${TABLE}."SSI_ICD_COUNT_GROUP" ;;
  }

  dimension: ssi_icd_count_woe {
    type: string
    sql: ${TABLE}."SSI_ICD_COUNT_WOE" ;;
  }

  dimension: ssi_icd_max_paid {
    type: string
    sql: ${TABLE}."SSI_ICD_MAX_PAID" ;;
  }

  dimension: ssi_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."SSI_ICD_MAX_SUB_PAID" ;;
  }

  dimension: ssi_paid_amount {
    type: string
    sql: ${TABLE}."SSI_PAID_AMOUNT" ;;
  }

  dimension: ssi_pos_max_paid {
    type: string
    sql: ${TABLE}."SSI_POS_MAX_PAID" ;;
  }

  dimension: ssi_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."SSI_POS_MAX_SUB_PAID" ;;
  }

  dimension: ssi_proc_counts {
    type: string
    sql: ${TABLE}."SSI_PROC_COUNTS" ;;
  }

  dimension: ssi_proc_counts_group {
    type: string
    sql: ${TABLE}."SSI_PROC_COUNTS_GROUP" ;;
  }

  dimension: ssi_proc_counts_woe {
    type: string
    sql: ${TABLE}."SSI_PROC_COUNTS_WOE" ;;
  }

  dimension: ssi_sub_amount {
    type: string
    sql: ${TABLE}."SSI_SUB_AMOUNT" ;;
  }

  dimension: sst_acute_cat_count {
    type: string
    sql: ${TABLE}."SST_ACUTE_CAT_COUNT" ;;
  }

  dimension: sst_chronic_cat_count {
    type: string
    sql: ${TABLE}."SST_CHRONIC_CAT_COUNT" ;;
  }

  dimension: sst_chronic_icd_count {
    type: string
    sql: ${TABLE}."SST_CHRONIC_ICD_COUNT" ;;
  }

  dimension: sst_claim_number_counts {
    type: string
    sql: ${TABLE}."SST_CLAIM_NUMBER_COUNTS" ;;
  }

  dimension: sst_cpt_max_sub_paid {
    type: string
    sql: ${TABLE}."SST_CPT_MAX_SUB_PAID" ;;
  }

  dimension: sst_dist_year_count {
    type: string
    sql: ${TABLE}."SST_DIST_YEAR_COUNT" ;;
  }

  dimension: sst_flag {
    type: string
    sql: ${TABLE}."SST_FLAG" ;;
  }

  dimension: sst_icd_count {
    type: string
    sql: ${TABLE}."SST_ICD_COUNT" ;;
  }

  dimension: sst_icd_max_paid {
    type: string
    sql: ${TABLE}."SST_ICD_MAX_PAID" ;;
  }

  dimension: sst_icd_max_sub_paid {
    type: string
    sql: ${TABLE}."SST_ICD_MAX_SUB_PAID" ;;
  }

  dimension: sst_paid_amount {
    type: string
    sql: ${TABLE}."SST_PAID_AMOUNT" ;;
  }

  dimension: sst_pos_max_paid {
    type: string
    sql: ${TABLE}."SST_POS_MAX_PAID" ;;
  }

  dimension: sst_pos_max_sub_paid {
    type: string
    sql: ${TABLE}."SST_POS_MAX_SUB_PAID" ;;
  }

  dimension: sst_proc_counts {
    type: string
    sql: ${TABLE}."SST_PROC_COUNTS" ;;
  }

  dimension: sst_sub_amount {
    type: string
    sql: ${TABLE}."SST_SUB_AMOUNT" ;;
  }

  dimension: sur {
    type: string
    label: "Surgery Count"
    sql: ${TABLE}."SUR" ;;
  }

  dimension: sur_group {
    type: string
    sql: ${TABLE}."SUR_GROUP" ;;
  }

  dimension: sur_group_label {
    type: string
    description: "This is Surgery Procedure based labelling"
    sql: CASE WHEN ${sur_group} = '0' THEN  '0-1'
              WHEN ${sur_group} = '1' THEN  '2-27'
              WHEN ${sur_group} = '2' THEN  '28-43'
              WHEN ${sur_group} = '3' THEN  '44-55'
              WHEN ${sur_group} = '4' THEN  '56-70'
              WHEN ${sur_group} = '5' THEN  '71-120'
              WHEN ${sur_group} = '6' THEN  '121-249'
              WHEN ${sur_group} = '7' THEN  '>=250'
              WHEN ${sur_group} = '8' THEN  'Missing'
      END;;
  }

  dimension: sur_woe {
    type: string
    sql: ${TABLE}."SUR_WOE" ;;
  }

  measure: severe_patient{
    type: count
    value_format: "0"
    label: "Severe Patients"
    filters: [severity_1: "1"]
  }

  measure: non_severe_patient{
    type: count
    value_format: "0"
    label: "Non-Severe Patients"
    filters: [severity_1: "0"]
  }

  measure: severity_percentage {
    type: number
    label: "Severity Percentage"
    sql: 100.000 * ${severe_patient} /  ${total_uid};;
    value_format: "0.0\%"
  }

  dimension: train_test_flag {
    type: string
    sql: ${TABLE}."TRAIN_TEST_FLAG" ;;
  }

  dimension: year_file_date_l {
    type: string
    sql: CAST(${TABLE}."YEAR_FILE_DATE_L" as integer) ;;

  }

  dimension: gM25561_claim {
    type: string
    sql: ${TABLE}."GM25561_CLAIM" ;;
  }

  dimension: gm542_claim {
    type: string
    sql: ${TABLE}."GM542_CLAIM" ;;
  }

  dimension: gp99214_claim {
    type: string
    sql: ${TABLE}."GP99214_CLAIM" ;;
  }

  dimension: gp98941_claim {
    type: string
    sql: ${TABLE}."GP98941_CLAIM" ;;
  }

  dimension: Gchronic_icd {
    type: string
    sql: ${TABLE}."Gchronic_icd" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
