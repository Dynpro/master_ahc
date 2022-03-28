connection: "snowflake_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: vw_medical {
  label: "Medical records"
  sql_always_where: ${Paid_year} IN ('2020', '2021') ;;
}

explore: vw_pharmacy {
  label: "Pharmacy records"
  sql_always_where: ${date_filled_year} IN ('2020', '2021') ;;
}

explore: vw_med_and_pharma_summary_1 {
  label: "Ad Hoc Query Tool"
  sql_always_where: ${PAID_YEAR} IN ('2020', '2021') ;;
}

explore: ad_hoc_query_tool_medical {
  label: "Ad Hoc Query Tool_MEDICAL"
  sql_always_where: ${PAID_DATE_year} IN ('2020', '2021') ;;
}

explore: ad_hoc_query_tool_pharmacy {
  label: "Ad Hoc Query Tool_PHARMACY"
  sql_always_where: ${SERVICE_DATE_year} IN ('2020', '2021') ;;
}

explore: vw_cohort_analysis_summary_1 {
  label: "Cohort Analysis"
  sql_always_where: ${PAID_YEAR} IN ('2020', '2021') ;;
}

explore: vw_risk_group_migration {
  label: "Risk Group Migration"
  sql_always_where: ${File_year} IN ('2020', '2021') ;;
}

explore: vw_risk_group_med_pharma_summary {
  label: "Risk Group - Med & Pharma summary"
  sql_always_where: ${File_year} IN ('2020', '2021') ;;
}

explore: vw_medication_possession_ratio {
  label: "Medication Possession Ratio"
  sql_always_where: ${year} IN ('2020', '2021') ;;
}

explore: vw_preventive_screening {
  label: "Preventive Screening"
  sql_always_having: ${year} IN ('2020', '2021') ;;
}
