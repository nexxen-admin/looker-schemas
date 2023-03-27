view: opt_smart_converged_campaign {
  sql_table_name: AN_SMART..converged_campaign (NOLOCK) ;;
  label: "Converged Campaign"

  dimension: avail_chop {
    type: number
    label: "Available CHOP"
    sql: ${TABLE}.avail_chop ;;
  }

  dimension: camp_pool_id {
    type: number
    label: "Campaign Pool ID"
    sql: ${TABLE}.camp_pool_id ;;
    value_format_name: id
  }

  dimension: campaign_id {
    description: "Unique ID for each campaign"
    label: "Campaign ID"
    type: number
    sql:  ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: category {
    type: string
    label: "Category"
    sql: ${TABLE}.category ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [raw, date, month, year]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [raw, date, month, year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: customer_id {
    type: number
    label: "Customer ID"
    sql: ${TABLE}.customer_id ;;
    value_format_name: id
  }

  dimension: demo_composition_vendor_id {
    type: number
    label: "Demo Composition Vendor ID"
    sql: ${TABLE}.demo_composition_vendor_id ;;
    value_format_name: id
  }

  dimension: demo_group_id {
    view_label: "RTA Groups"
    description: "Unique ID for Demo Target"
    type: number
    sql:  ${TABLE}.demo_group_id ;;
    value_format_name: id
  }

  dimension: demo_pool_id {
    type: number
    label: "Demo Pool ID"
    sql: ${TABLE}.demo_pool_id ;;
    value_format_name: id
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: json_param {
    type: string
    label: "Open Parameter"
    sql: ${TABLE}.json_param ;;
  }

  dimension_group: li_data_end {
    type: time
    label: "LI Begin"
    timeframes: [raw, date, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.li_data_end_date ;;
  }

  dimension_group: li_data_start {
    type: time
    label: "LI End"
    timeframes: [raw, date, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.li_data_start_date ;;
  }

  dimension: platform_client_id {
    type: number
    label: "Platform Client ID"
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: price_factor {
    type: number
    label: "Price Factor"
    sql: ${TABLE}.price_factor ;;
  }

  dimension: str_pool_id {
    type: number
    label: "Pool ID"
    sql: ${TABLE}.str_pool_id ;;
    value_format_name: id
  }

  dimension: str_target_group_id {
    view_label: "RTA Groups"
    description: "Unique ID for Strategic Target"
    type: number
    sql:  ${TABLE}.str_target_group_id ;;
    value_format_name: id
  }
  dimension: volume_shortfall_coef {
    type: number
    label: "Volume Shortfall Coef"
    sql: ${TABLE}.volume_shortfall_coef ;;
  }

  dimension: volume_surplus_coef {
    type: number
    label: "Volume Surplus Coef"
    sql: ${TABLE}.volume_surplus_coef ;;
  }

}
