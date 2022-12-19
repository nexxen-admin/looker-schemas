view: ctrl_supply_entity {
  sql_table_name: dashboard.{% parameter entity %} ;;

  parameter: entity {
    type: unquoted
    description: "Choose entity to analyze the data."
    allowed_value: {
      label: "Deal"
      value: "supply_publisher_deal"
    }
    allowed_value: {
      label: "Placement"
      value: "supply_placement"
    }
    allowed_value: {
      label: "Publisher"
      value: "supply_publisher"
    }
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.{% if entity._parameter_value == 'supply_publisher_deal' %}pub_deal_id{% elsif entity._parameter_value == 'supply_placement' %}placement_id{% else %}publisher_id{% endif %} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.{% if entity._parameter_value == 'supply_publisher_deal' %}description{% elsif entity._parameter_value == 'supply_placement' %}placement_name{% else %}publisher_name{% endif %} ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [raw, time, date, week, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: updated_at {
    type: time
    timeframes: [raw, time, date, week, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }

  dimension_group: deleted_at {
    type: time
    timeframes: [raw, time, date, week, quarter, year]
    sql: ${TABLE}.deleted_at ;;
  }

  measure: count {
    type: count
  }

}
