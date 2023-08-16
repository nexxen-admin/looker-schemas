view: flight_demand_units_budget {
  sql_table_name: DIM.DEMAND_UNITS_BUDGET_VIEW ;;

  dimension: budget {
    type: number
    label: "Flight Planned Budget"
    view_label: "Flight"
    hidden: yes
    description: "The flight budget as it is setup in the system."
    sql: ${TABLE}.BUDGET ;;
  }

  measure: max_budget {
    type: max
    hidden: yes
    value_format_name: decimal_2
    sql: ${budget} * (1+ ${flight_media_details_base.agency_fee}) ;;
  }

  measure: sum_budget {
    type: sum
    label: "Flight Target Spend"
    view_label: "Flight"
    description: "The flight target spend."
    value_format_name: decimal_2
    sql: ${budget} * (1+ ${flight_media_details_base.agency_fee}) ;;
  }

  measure: sum_budget_b {
    type: sum
    label: "Flight Target Spend Base"
    view_label: "Flight"
    description: "The flight target spend."
    hidden: yes
    value_format_name: decimal_2
    sql: ${budget} ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_ID ;;
  }

  dimension: delivery_units {
    type: number
    label: "Flight Planned Delivery Units"
    description: "The number of units planned to be delivered for the flight."
    view_label: "Flight"
    hidden: yes
    sql: ${TABLE}.DELIVERY_UNITS ;;
  }

  measure: max_delivery_units {
    type: max
    label: "Flight Planned Delivery Units"
    description: "The number of units planned to be delivered for the flight."
    view_label: "Flight"
    value_format_name: decimal_0
    sql: ${delivery_units} ;;
  }

  dimension: flight_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: insertion_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
  }

  dimension: keyid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.KEYID ;;
  }

  dimension: pl_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PL_PLAN_ID ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.UNITS ;;
  }

  measure: sum_units {
    type: sum
    label: "Flight Target Units"
    view_label: "Flight"
    description: "The flight target units."
    value_format_name: decimal_2
    sql: ${units} ;;
  }

  measure: target_cpu {
    type: number
    label: "Flight Target CPU"
    view_label: "Flight"
    description: "The flight target CPU."
    value_format_name: decimal_2
    sql: ${sum_budget} / NULLIF(${sum_units}, 0) ;;
  }

  measure: max_units {
    type: max
    hidden: yes
    sql: ${units} ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
