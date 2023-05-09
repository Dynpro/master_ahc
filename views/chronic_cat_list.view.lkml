#This view created for claims analysis summery - NEW dashboard for showing Chronic Category list

view: chronic_cat_list {
  derived_table: {
    sql: Select
         "UNIQUE_ID" as PATIENT_ID_M,
         LISTAGG(DISTINCT "CCW_CHRONIC_CAT", ' || ') within group (order by "CCW_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_LIST
         FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL"
         GROUP BY PATIENT_ID_M;;
  }

  dimension: PATIENT_ID {
    type: string
    label: "Member Id"
    sql: ${TABLE}.PATIENT_ID_M ;;
  }

  dimension: Chronic_Category_List {
    type: string
    label: "Chronic Category list"
    sql: ${TABLE}.CHRONIC_CATEGORY_LIST ;;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

}
