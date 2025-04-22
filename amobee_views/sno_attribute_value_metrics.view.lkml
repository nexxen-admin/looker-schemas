view: sno_attribute_value_metrics {
  view_label: "Retargeting Attribute Country-Level Facets"
  sql_table_name: DIM.ATTRIBUTE_VALUE_METRICS ;;

  dimension: attribute_value_metrics_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_value_metrics_id ;;
  }

  dimension: attribute_value_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_value_id ;;
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_id ;;
  }

  dimension: network_imp_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.network_imp_pct ;;
  }

  dimension: household_reach {
    type: number
    sql: ${TABLE}.household_reach ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: user_reach {
    type: number
    sql: ${TABLE}.user_reach ;;
  }

  dimension: profile_reach {
    type: number
    sql: ${TABLE}.profile_reach ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active ;;
  }
}
