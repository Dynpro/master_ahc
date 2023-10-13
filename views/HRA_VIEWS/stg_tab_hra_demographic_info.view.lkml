
view: stg_tab_hra_demographic_info {
  derived_table: {
    sql: select * from SCH_AHC_CRISP_REGIONAL.STG_TAB_HRA_DEMOGRAPHIC_INFO ;;
  }


  dimension: group {
    type: string
    sql: ${TABLE}."GROUP" ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}."UNIQUE_ID" ;;
  }

  dimension: member_id {
    type: string
    sql: ${TABLE}."MEMBER_ID" ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}."ROW_ID" ;;
  }

  dimension: are_you {
    type: string
    sql: ${TABLE}."ARE_YOU:" ;;
  }

  dimension: how_would_you_best_describe_your_racial_or_ethnic_background {
    type: string
    sql: ${TABLE}."HOW_WOULD_YOU_BEST_DESCRIBE_YOUR_RACIAL_OR_ETHNIC_BACKGROUND?" ;;
  }

  dimension: your_bmi_is {
    type: number
    sql: ${TABLE}."YOUR_BMI*_IS:" ;;
  }

  dimension: do_you_have_bluegreen_or_hazel_eyes {
    type: string
    sql: ${TABLE}."DO_YOU_HAVE_BLUE,GREEN_OR_HAZEL_EYES?" ;;
  }

  dimension: how_would_you_best_describe_your_natural_skin_color {
    type: string
    sql: ${TABLE}."HOW_WOULD_YOU_BEST_DESCRIBE_YOUR_NATURAL_SKIN_COLOR?" ;;
  }

  dimension: what_is_your_natural_hair_color {
    type: string
    sql: ${TABLE}."WHAT_IS_YOUR_NATURAL_HAIR_COLOR?" ;;
  }

  dimension: what_is_your_waist_measurement {
    type: string
    sql: ${TABLE}."WHAT_IS_YOUR_WAIST_MEASUREMENT?" ;;
  }

  dimension: would_you_consider_the_place_where_you_have_lived_most_of_your_life_to_be_very_sunny {
    type: string
    sql: ${TABLE}."WOULD_YOU_CONSIDER_THE_PLACE_WHERE_YOU_HAVE_LIVED_MOST_OF_YOUR_LIFE_TO_BE_VERY_SUNNY?" ;;
  }

  dimension: how_much_do_you_weigh {
    type: number
    sql: ${TABLE}."HOW_MUCH_DO_YOU_WEIGH?" ;;
  }

  dimension: height_in_feet {
    type: string
    sql: ${TABLE}."HEIGHT_IN_FEET" ;;
  }

  dimension: height_in_inches {
    type: string
    sql: ${TABLE}."HEIGHT_IN_INCHES" ;;
  }

  dimension: are_you_pregnant {
    type: string
    sql: ${TABLE}."ARE_YOU_PREGNANT?" ;;
  }

  dimension: are_you_interested_in_losing_weight_in_order_to_reduce_your_bmi {
    type: string
    sql: ${TABLE}."ARE_YOU_INTERESTED_IN_LOSING_WEIGHT_IN_ORDER_TO_REDUCE_YOUR_BMI?" ;;
  }

  dimension: do_you_work_in_any_of_the_following_jobs {
    type: string
    sql: ${TABLE}."DO_YOU_WORK_IN_ANY_OF_THE_FOLLOWING_JOBS?" ;;
  }

  dimension: are_you_a_student_who_lives_in_a_dorm {
    type: string
    sql: ${TABLE}."ARE_YOU_A_STUDENT_WHO_LIVES_IN_A_DORM?" ;;
  }

  dimension: please_give_your_prepregnancy_results {
    type: string
    sql: ${TABLE}."PLEASE_GIVE_YOUR_PRE-PREGNANCY_RESULTS" ;;
  }

  dimension: do_you_require_your_employer_to_provide_special_accommodations_in_order_to_read {
    type: string
    sql: ${TABLE}."DO_YOU_REQUIRE_YOUR_EMPLOYER_TO_PROVIDE_SPECIAL_ACCOMMODATIONS_IN_ORDER_TO_READ?" ;;
  }

  dimension: do_you_require_your_employer_to_provide_special_accommodation_in_order_for_you_to_hear {
    type: string
    sql: ${TABLE}."DO_YOU_REQUIRE_YOUR_EMPLOYER_TO_PROVIDE_SPECIAL_ACCOMMODATION_IN_ORDER_FOR_YOU_TO_HEAR?" ;;
  }

  dimension: is_english_your_main_language {
    type: string
    sql: ${TABLE}."IS_ENGLISH_YOUR_MAIN_LANGUAGE?" ;;
  }

  dimension: what_language_do_you_prefer_to_speak {
    type: string
    sql: ${TABLE}."WHAT_LANGUAGE_DO_YOU_PREFER_TO_SPEAK?" ;;
  }

  dimension: have_you_lived_in_the_u_s__most_of_your_life {
    type: string
    sql: ${TABLE}."HAVE_YOU_LIVED_IN_THE_U.S._MOST_OF_YOUR_LIFE?" ;;
  }

  dimension: where_in_the_u_s__have_you_lived_most_of_your_life {
    type: string
    sql: ${TABLE}."WHERE_IN_THE_U.S._HAVE_YOU_LIVED_MOST_OF_YOUR_LIFE?" ;;
  }

  dimension: do_you_plan_to_or_have_you_traveled_to_any_low_or_lowermiddle_income_countries {
    type: string
    sql: ${TABLE}."DO_YOU_PLAN_TO_OR_HAVE_YOU_TRAVELED_TO_ANY_LOW_OR_LOWER-MIDDLE_INCOME_COUNTRIES?" ;;
  }

  dimension: are_you_of_northern_european_descent {
    type: string
    sql: ${TABLE}."ARE_YOU_OF_NORTHERN_EUROPEAN_DESCENT?" ;;
  }

  dimension: system_id {
    type: string
    sql: ${TABLE}."SYSTEM_ID" ;;
  }

  dimension: raw_load_date {
    type: date
    sql: ${TABLE}."RAW_LOAD_DATE" ;;
  }

  dimension: staging_date {
    type: date
    sql: ${TABLE}."STAGING_DATE" ;;
  }

  dimension: last_updated_date {
    type: date
    sql: ${TABLE}."LAST_UPDATED_DATE" ;;
  }

  dimension: last_updated_by {
    type: string
    sql: ${TABLE}."LAST_UPDATED_BY" ;;
  }

  dimension_group: last_update_timestamp {
    type: time
    sql: ${TABLE}."LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: how_would_you_best_describe_your_racial_or_ethnic_background_tf {
    type: string
    sql: case when  ${how_would_you_best_describe_your_racial_or_ethnic_background} = 'Black or African-American' or
                  ${how_would_you_best_describe_your_racial_or_ethnic_background} = 'Hispanic (non-European)' or
                  ${how_would_you_best_describe_your_racial_or_ethnic_background} = 'White' or
                  ${how_would_you_best_describe_your_racial_or_ethnic_background} = 'Asian' or
                  ${how_would_you_best_describe_your_racial_or_ethnic_background} = 'other' or
                  ${how_would_you_best_describe_your_racial_or_ethnic_background}  = 'mixed' and
                   ${your_bmi_is} >= '30' then 'true'
        else 'false'
         end;;
  }

  dimension: HRA_high_risk{
    type: string
    sql:  case when ${how_would_you_best_describe_your_racial_or_ethnic_background_tf} = 'true' then 'Yes'
          else 'No'
          end;;
  }

}
