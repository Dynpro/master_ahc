view: hedis_compliance {
  label: "HEDIS Compliance"
  sql_table_name:  "DB_KAIROS_PROD"."SCH_AHC_CRISP_REGIONAL"."LKR_TAB_HEDIS_COMPLIANCE_PERCENT"
    ;;

  dimension: measure_name {
    type: string
    label: "MEASURE NAME"
    sql: ${TABLE}."MEASURE_NAME" ;;
  }
  dimension: measure_description {
    type: string
    label: "MEASURE DESCRIPTION"
    sql: ${TABLE}."MEASURE_DESCRIPTION" ;;
  }

  dimension: age_criteria {
    type: string
    label: "AGE CRITERIA"
    sql: ${TABLE}."AGE_CRITERIA" ;;
  }

  dimension: measure {
    type: string
    label: "MEASURE"
    sql: ${TABLE}."MEASURE" ;;
  }

  dimension: year {
    type: number
    label: "Year"
    sql: ${TABLE}."YEAR" ;;
    value_format: "0"
  }

  measure: compliant {
    type: sum
    label: "COMPLIANT"
    sql: ${TABLE}."COMPLIANT" ;;
  }

  measure: eligible {
    type: sum
    label: "ELIGIBLE"
    sql: ${TABLE}."ELIGIBLE" ;;
  }

  measure: percent {
    type: sum
    label: "PERCENT"
    sql: ${TABLE}."PERCENT" ;;
    value_format: "0.00\%"
  }
#Benchmark labelling, HEDIS list of defined measures, Rendering & $ based on previous months
  dimension: benchmark_year_filter_suggestion {
    type: string
    hidden: yes
    sql: ${year} - 1 ;;
  }

  parameter: benchmark_year_filter {
    type: string
    suggest_dimension: hedis_compliance.benchmark_year_filter_suggestion
  }

  dimension: reporting_benchmark_year {
    type: string
    label: "SERVICE Year"
    sql: CASE WHEN ${year} = CAST({% parameter benchmark_year_filter %} as int) THEN CAST(concat(${year}, ' ', '(Benchmark)') as string)
      ELSE CAST(${year} as string)
      END;;
  }

}
