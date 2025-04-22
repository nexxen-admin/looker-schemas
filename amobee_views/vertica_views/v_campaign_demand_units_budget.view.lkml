view: v_campaign_demand_units_budget {
  sql_table_name: DIM.DEMAND_UNITS_BUDGET_VIEW ;;

  dimension: budget {
    type: number
    label: "Campaign Planned Budget"
    view_label: "Campaign"
    hidden: yes
    description: "The campaign budget as it is setup in the system."
    sql: ${TABLE}.BUDGET ;;
  }

  measure: campaign_target_net_spend {
    type: sum
    label: "Campaign Target Net Spend"
    view_label: "Campaign"
    description: "The campaign target net spend."
    value_format_name: decimal_2
    hidden: yes
    sql: ${budget} ;;
  }

  measure: campaign_target_gross_spend {
    type:  number
    label: "Campaign Target Spend"
    view_label: "Campaign"
    description: "The campaign target gross spend."
    value_format_name: decimal_2
    sql: ${campaign_target_net_spend} * (1 + ${v_campaign_details_base.agency_fee}) ;;
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

  dimension: campaign_delivery_units {
    type: number
    label: "Campaign Planned Delivery Units"
    description: "The number of units planned to be delivered for the campaign."
    view_label: "Campaign"
    hidden: yes
    sql: ${TABLE}.DELIVERY_UNITS ;;
  }

  measure: sum_campaign_delivery_units {
    type: sum
    label: "Campaign Planned Delivery Units"
    description: "The number of units planned to be delivered for the campaign."
    view_label: "Campaign"
    value_format_name: decimal_0
    sql: ${campaign_delivery_units} ;;
  }

  dimension: flight_id {
    type: number
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
    primary_key: yes
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
    label: "Campaign Target Units"
    view_label: "Campaign"
    description: "The campaign target units."
    value_format_name: decimal_2
    sql: ${units} ;;
  }

  measure: target_cpu {
    type: number
    label: "Campaign Target CPU"
    view_label: "Campaign"
    description: "The campaign target CPU."
    value_format_name: decimal_2
    sql: ${campaign_target_gross_spend} / NULLIF(${sum_units}, 0) ;;
  }

  measure: max_campaign_units {
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
