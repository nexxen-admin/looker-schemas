view: v_pl_plan {
  sql_table_name: DIM.PL_PLAN_VIEW ;;

  dimension: pl_plan_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.PL_PLAN_ID ;;
  }

  dimension: account_executive {
    type: string
    label: "Account Executive"
    view_label: "Plan"
    description: "Salesperson that sells into accounts."
    sql: ${TABLE}.ACCOUNT_EXECUTIVE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.account_executive
  }

  dimension: account_manager {
    type: string
    label: "Account Manager"
    view_label: "Plan"
    description: "Supports accounts alongside Account Executives and Delivery,
    running point on things like overall Account Coordination, Campaign Trafficking/Reporting, and Billing"
    sql: ${TABLE}.ACCOUNT_MANAGER ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.account_manager
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
  }

  dimension: checksum_value {
    type: number
    hidden: yes
    sql: ${TABLE}.CHECKSUM_VALUE ;;
  }

  dimension: cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.CPU ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDBY ;;
  }

  dimension: createdon {
    type: date
    view_label: "Plan"
    label: "Plan Created Date"
    description: "Date in which the Plan was created."
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: dst_createdon {
    type: date
    view_label: "Plan"
    label: "[DST] Plan Local Created Date"
    description: "Date in which the Plan was created in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then (${TABLE}.CREATEDON) AT TIMEZONE ${v_timezone.timezone_name}
      else ${TABLE}.CREATEDON end ;;
  }

  dimension: custom_field_1 {
    type: string
    view_label: "Plan"
    sql: ${TABLE}.CUSTOM_FIELD_1 ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.custom_field_1
  }

  dimension: custom_field_2 {
    type: string
    view_label: "Plan"
    sql: ${TABLE}.CUSTOM_FIELD_2 ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.custom_field_2
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: customer_io_number {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_IO_NUMBER ;;
  }

  dimension: daily_budget_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.DAILY_BUDGET_CAP ;;
  }

  dimension: demand_medium_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_MEDIUM_TYPE_ID ;;
  }

  dimension: demo_trp {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMO_TRP ;;
  }

  dimension: desired_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.DESIRED_SPEND ;;
  }

  dimension: forecast_comp_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.FORECAST_COMP_PCT ;;
  }

  dimension: forecast_frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.FORECAST_FREQUENCY ;;
  }

  dimension: forecast_index {
    type: number
    hidden: yes
    sql: ${TABLE}.FORECAST_INDEX ;;
  }

  dimension: forecast_max_spend {
    type: number
    hidden: yes
    sql: coalesce(${TABLE}.FORECAST_MAX_SPEND,0) ;;
  }

  dimension: format_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FORMAT_TYPE_ID ;;
  }

  dimension: max_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.MAX_VOLUME ;;
  }

  dimension: min_margin {
    type: number
    hidden: yes
    sql: ${TABLE}.MIN_MARGIN ;;
  }

  dimension: native_currency_id {
    type: number
    hidden: yes
    label: "Plan Currency"
    view_label: "Plan"
    description: "Currency set on the Plan."
    sql: ${TABLE}.NATIVE_CURRENCY_ID ;;
  }

  dimension: opportunity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.OPPORTUNITY_ID ;;
  }

  dimension: pl_plan_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PL_PLAN_STATUS_ID ;;
  }

  dimension: plan_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_NAME ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
  }

  dimension: reach {
    type: number
    hidden: yes
    sql: ${TABLE}.REACH ;;
  }

  dimension: volume {
    type: number
    hidden: yes
    sql: ${TABLE}.VOLUME ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [pl_plan_id, plan_name]
  }

  dimension: sum_forecast_max_spend {
    type: number
    label: "Forecast Max Spend"
    description: "Total of maximum forecasted spend"
    value_format_name: decimal_2
    view_label: "Plan"
    sql: ${forecast_max_spend} ;;
  }
}
