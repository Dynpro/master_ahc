#This view created for claims analysis summery - NEW dashboard for showing Chronic Category list

view: chronic_cat_list {
  derived_table: {
    sql: SELECT DISTINCT A.UNIQUE_ID AS PATIENT_ID_M,LISTAGG(DISTINCT A."CCW_CHRONIC_CAT", ' || ') within group (order by A."CCW_CHRONIC_CAT" ASC) as CHRONIC_CATEGORY_LIST,
          LISTAGG(DISTINCT B."PROPRIETARY_NAME", ' || ') within group (order by B."PROPRIETARY_NAME" ASC) as DRUG_BRAND_NAME,
          LISTAGG(DISTINCT B."NON_PROPRIETARY_NAME", ' || ') within group (order by B."NON_PROPRIETARY_NAME" ASC) as DRUG_GENERIC_NAME
          FROM "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_MEDICAL" AS A
          FULL JOIN "SCH_AHC_CRISP_REGIONAL"."LKR_TAB_PHARMACY" AS B
          ON A.UNIQUE_ID=B.UNIQUE_ID
          GROUP BY A.UNIQUE_ID;;
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

  dimension: Drug_Brand_Name_List {
    type: string
    label: "Drug Brand Name List"
    sql: ${TABLE}.DRUG_BRAND_NAME ;;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

  dimension: Drug_Generic_Name_List {
    type: string
    label: "Drug Generic Name List"
    sql: ${TABLE}.DRUG_GENERIC_NAME ;;
    html: {% assign words = value | split: ' || ' %}
        <ul>
        {% for word in words %}
        <li>{{ word }}</li>
        {% endfor %} ;;
  }

}
