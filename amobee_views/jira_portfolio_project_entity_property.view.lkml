view: portfolio_project_entity_property {
  sql_table_name: public.entity_property ;;

  dimension: entity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_id ;;
  }

  dimension: property_key {
    type: string
    hidden: yes
    sql: ${TABLE}.property_key ;;
  }

  dimension: target_start {
    type: date
    label: "Target Start"
    view_label: "Portfolio Project"
    sql: to_timestamp((${TABLE}.json_value::json->>'baseline_start')::numeric / 1000) ;;
    convert_tz: no
  }

  dimension: target_end {
    type: date
    label: "Target End"
    view_label: "Portfolio Project"
    sql: to_timestamp((${TABLE}.json_value::json->>'baseline_end')::numeric / 1000) ;;
    convert_tz: no
  }
}
