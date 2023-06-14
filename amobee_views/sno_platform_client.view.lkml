view: platform_client {
  sql_table_name: DIM.PLATFORM_CLIENT_VIEW ;;
  view_label: "Demand Platform Client"

  dimension: platform_client_id {
    primary_key: yes
    type: number
    label: "Platform Client ID"
    description: "The system ID of the Platform Client"
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  dimension: business_region {
    type: string
    label: "Business Region"
    description: "The business region of the demand customer (Americas, Europe, or Asia)."
    sql: ${TABLE}.BUSINESS_REGION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.business_region_description
  }

  dimension: business_region_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_ID ;;
  }

  dimension: default_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEFAULT_CURRENCY_ID ;;
  }

  dimension: default_timezone_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEFAULT_TIMEZONE_ID ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.OFFICE_ID ;;
  }

  dimension: office_name {
    type: string
    label: "Platform Client Office"
    description: "The office of the platform client"
    sql: ${TABLE}.OFFICE_NAME ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.pc_office_name
  }

  dimension: platform_client_active {
    type: yesno
    label: "Active"
    description: "A yes/no indicatior if the platform client is active."
    sql: ${TABLE}.PLATFORM_CLIENT_ACTIVE ;;
  }

  dimension: platform_client_description {
    type: string
    label: "Platform Client"
    description: "The name of the Platform Client"
    sql: ${TABLE}.PLATFORM_CLIENT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.platform_client_description
  }

  dimension: platform_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLATFORM_TYPE_ID ;;
  }

  dimension: platform_type_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PLATFORM_TYPE_NAME ;;
  }

  dimension: use_daylight_saving {
    type: yesno
    hidden: yes
    sql: COALESCE(${TABLE}.DST, FALSE) ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      platform_client_id,
      platform_type_name,
      office_name,
      action_pixel.count,
      campaign_details.count,
      campaign_details_base.count,
      customer_user_access.count,
      insertion_order_details.count,
      placement_details.count,
      placement_details_base.count,
      placement_platform_client.count,
      pl_plan.count,
      site_category.count
    ]
  }
}
