view: flight_media_statistics {
  sql_table_name: vg_main.flight_media_statistics ;;

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${flight_media_id}, "-",${placement_id}) ;;
  }

  dimension: budget_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_spent ;;
  }

  measure: sum_budget_spent {
    type: sum
    label: "Budget Spent"
    description: "Total Budget Spent in Demand Currency."
    view_label: "Metrics"
    value_format_name: decimal_2
    sql: ${budget_spent} ;;
  }

  dimension: budget_spent_today {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_spent_today ;;
  }

  measure: sum_budget_spent_today {
    type: sum
    label: "Budget Spent Today"
    description: "Total Budget Spent today based on GMT date, numbers reset at midnight GMT."
    view_label: "Metrics"
    value_format_name: decimal_2
    sql: ${budget_spent_today} ;;
  }

  dimension: delivery_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units_spent ;;
  }

  measure: sum_delivery_units_spent {
    type: sum
    label: "Delivery Units"
    description: "Total Delivery Units delivered."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${delivery_units_spent} ;;
  }

  dimension: delivery_units_spent_today {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units_spent_today ;;
  }

  measure: sum_delivery_units_spent_today {
    type: sum
    label: "Delivery Units Today"
    description: "Total Delivery Units today based on GMT date, numbers reset at midnight GMT."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${delivery_units_spent_today} ;;
  }

  dimension: effective_units_spent {
    type: number
    hidden: yes
    label: "Billable Units Spent"
    value_format_name: decimal_0
    sql: ${TABLE}.effective_units_spent ;;
  }

  measure: sum_effective_units_spent {
    type: sum
    label: "Billable Units Spent"
    description: "Total Billable Units delivered."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${effective_units_spent} ;;
  }

  dimension: effective_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units_today ;;
  }

  measure: sum_effective_units_today {
    type: sum
    label: "Billable Units Today"
    description: "Total Billable Units today based on GMT date, numbers reset at midnight GMT."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${effective_units_today} ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: hh_units_spent {
    type: number
    hidden: yes
    label: "Effective Units Spent"
    value_format_name: decimal_2
    sql: ${TABLE}.hh_units_spent ;;
  }

  measure: sum_hh_units_spent {
    type: sum
    label: "Effective Units Spent"
    description: "Total Effective Units delivered."
    value_format_name: decimal_2
    view_label: "Metrics"
    sql: ${hh_units_spent} ;;
  }

  dimension: hh_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.hh_units_today ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  measure: sum_hh_units_today {
    type: sum
    label: "Effective Units Today"
    description: "Total Effective Units today based on GMT date, numbers reset at midnight GMT."
    view_label: "Metrics"
    value_format_name: decimal_2
    sql: ${hh_units_today} ;;
  }

  measure: lastimp_datetm {
    type: date_time
    label: "Updated Date"
    view_label: "Metrics"
    description: "The last time the record was updated in GMT."
    sql: MAX(${TABLE}.lastimp_datetm) ;;
  }

  dimension: units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.units_spent ;;
  }

  measure: sum_units_spent {
    type: sum
    label: "Units Spent"
    description: "Total Units delivered."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${units_spent} ;;
  }

  dimension: units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.units_today ;;
  }

  measure: sum_units_today {
    type: sum
    label: "Units Today"
    description: "Total Units today based on GMT date, numbers reset at midnight GMT."
    view_label: "Metrics"
    value_format_name: decimal_0
    sql: ${units_today} ;;
  }


}
