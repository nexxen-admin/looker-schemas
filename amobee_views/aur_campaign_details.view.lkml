view: aur_campaign_details {
  sql_table_name: dim.campaign_details ;;

  dimension: advertiser_brand_id {
    type: string
    label: "Brand ID"
    view_label: "Brand"
    description: "The system ID of the Brand."
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
  }

  dimension: advertiser_id {
    type: number
    label: "Advertiser ID"
    view_label: "Advertiser"
    description: "The system ID of the Advertiser."
    sql: ${TABLE}.ADVERTISER_ID ;;
    value_format_name: id
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser"
    view_label: "Advertiser"
    description: "The name of the Advertiser"
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: brand_name {
    type: string
    label: "Brand"
    view_label: "Brand"
    description: "The name of the Brand."
    sql: ${TABLE}.brand_name ;;
  }

  dimension: campaign_type_description {
    type: string
    label: "Campaign Type"
    view_label: "Campaign"
    sql: ${TABLE}.CAMPAIGN_TYPE_DESCRIPTION ;;
  }

  dimension: campaign_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_TYPE_ID ;;
  }

  dimension: campaign_active {
    type: yesno
    label: "Campaign is Active"
    view_label: "Campaign"
    description: "A yes/no indicator if the campaign is active."
    sql: ${TABLE}.campaign_active ;;
  }

  dimension: campaign_begin_datetm {
    type: date_time
    label: "Campaign Start Date"
    view_label: "Campaign"
    description: "The start date of the Campaign in GMT."
    sql: ${TABLE}.campaign_begin_datetm ;;
  }

  dimension: campaign_begin_datetm_local {
      type: date_time
      label: "Campaign Start Date - Local"
    view_label: "Campaign"
      description: "The start date of the Campaign in the campaign's timezone."
    sql: ${TABLE}.campaign_begin_datetm_local ;;
  }

  dimension: campaign_budget {
    type: number
    label: "Campaign Budget"
    view_label: "Campaign"
    description: "The amount of budget to deliver."
    value_format_name: decimal_2
    sql: ${TABLE}.campaign_budget ;;
  }

  dimension: campaign_contracted_units {
    type: number
    label: "Campaign Contracted Units"
    view_label: "Campaign"
    description: "The number of units to deliver as defined in the contract."
    value_format_name: decimal_0
    sql: ${TABLE}.campaign_contracted_units ;;
  }

  dimension: campaign_delivery_units {
    type: number
    label: "Campaign Delivery Units"
    view_label: "Campaign"
    description: "The number of units to deliver as setup in the system."
    value_format_name: decimal_0
    sql: ${TABLE}.campaign_delivery_units ;;
  }

  dimension: campaign_end_datetm {
    type: date_time
    label: "Campaign End Date"
    view_label: "Campaign"
    description: "The end date of the Campaign in GMT."
    sql: ${TABLE}.campaign_end_datetm ;;
  }

  dimension: campaign_begin_end_local {
    type: date_time
    label: "Campaign End Date - Local"
    view_label: "Campaign"
    description: "The end date of the Campaign in the campaign's timezone."
    sql: ${TABLE}.campaign_end_datetm_local ;;
  }


  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    view_label: "Campaign"
    description: "The system id of the Campaign."
    link: {    label: "Inspect"
      url: "/dashboards/36?Campaign ID={{value}}"}
    link: {    label: "Manage"
      url: "https://{% if _user_attributes['is_itv_user'] == 'yes' %}theaddressableplatform.amobee{% else %}platform.videologygroup{% endif %}.com/Customer/Campaign/Workspace/{{value}}"}
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    view_label: "Campaign"
    description: "The name of the campaign."
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_started_datetm {
    type: date_time
    label: "Campaign Started Date"
    view_label: "Campaign"
    description: "The date the campaign actually started delivering independent from the planned start date."
    sql: ${TABLE}.campaign_started_datetm ;;
  }

  dimension: campaign_status {
    type: string
    label: "Campaign Status"
    view_label: "Campaign"
    description: "The current status of the campaign (i.e. running, paused, ended, etc.)"
    sql: ${TABLE}.campaign_status ;;
  }


  dimension: campaign_units {
    type: number
    label: "Campaign Units"
    view_label: "Campaign"
    description: "The number of units setup in the system."
    sql: ${TABLE}.campaign_units ;;
  }

  dimension: cpu {
    type: number
    label: "CPU"
    view_label: "Campaign"
    description: "The actual CPU of the campaign."
    value_format_name: decimal_2
    sql: ${TABLE}.cpu ;;
  }

  dimension: cpu_type {
    type: string
    label: "CPU Type"
    view_label: "Campaign"
    description: "The CPU type of the campagin.  Examples include, CPM, CPCV, dCPM, etc."
    sql: ${TABLE}.cpu_type ;;
  }



  dimension: descriptive_campaign_type {
    type: string
    hidden: yes
    sql: ${TABLE}.descriptive_campaign_type ;;
  }


  dimension: insertion_order_id {
    type: number
    label: "Insertion Order ID"
    view_label: "IO"
    description: "The internal identifier of the Insertion Order."
    sql: ${TABLE}.insertion_order_id ;;
    value_format_name: id
  }

  dimension: insertion_order_name {
    type: string
    label: "Insertion Order"
    view_label: "IO"
    description: "The name of the Insertion Order."
    sql: ${TABLE}.insertion_order_name ;;
  }

  dimension: is_filler {
    type: yesno
    label: "House"
    view_label: "Campaign"
    description: "A yes/no indicator if the campaign is a house/filler campaign."
    sql: ${TABLE}.is_filler ;;
  }

  dimension: native_currency {
    type: string
    label: "Currency"
    view_label: "Campaign"
    description: "The demand currency for the campaign."
    sql: ${TABLE}.native_currency ;;
  }

  dimension: platform_client {
    type: string
    label: "Platform Client"
    view_label: "Platform Client"
    description: "The name of the Platform Client"
    sql: ${TABLE}.platform_client ;;
  }

  dimension: platform_client_group {
    type: string
    label: "Platform Client Group"
    view_label: "Platform Client"
    description: "The name of the Platform Client Group"
    sql: ${TABLE}.platform_client_group ;;
  }

  dimension: pl_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pl_plan_id ;;
  }



  measure: count {
    type: count
  }

  # ----- Sets of fields for drilling ------


}
