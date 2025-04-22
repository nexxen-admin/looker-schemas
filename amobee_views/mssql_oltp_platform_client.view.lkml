view: mssql_oltp_platform_client {
  sql_table_name: dbo.platform_client (NOLOCK) ;;
  label: "Platform Client"

  dimension: platform_client_id {
    primary_key: yes
    type: number
    label: "Platform Client ID"
    description: "The platform client id of the publisher."
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    label: "Platform Client Active"
    description: "A yes/no indicator if the platform client is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }

  dimension_group: changedon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Platform Client Changed"
    description: "The date/time when platform client was changed."
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: dst_changedon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "[DST] Platform Client Local Changed"
    description: "The date/time when platform client was changed in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_platform_client_changed.utc_offset}, ${TABLE}.changedon)
      else ${TABLE}.changedon end ;;
  }

  dimension: default_agency_fee {
    type: number
    hidden: yes
    sql: ${TABLE}.default_agency_fee ;;
  }

  dimension: default_campaign_network_id {
    type: number
    hidden: yes
    sql: ${TABLE}.default_campaign_network_id ;;
  }

  dimension: default_reporting_business_unit_id {
    type: number
    hidden: yes
    sql: ${TABLE}.default_reporting_business_unit_id ;;
  }

  dimension: demo_composition_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_composition_vendor_id ;;
  }

  dimension: demo_segment_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_segment_group_id ;;
  }

  dimension: description {
    type: string
    label: "Platform Client"
    description: "The platform client name of the publisher."
    sql: ${TABLE}.description ;;
  }

  dimension: dmp_partner_code {
    type: string
    hidden: yes
    sql: ${TABLE}.dmp_partner_code ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: is_demo {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_demo = 1 ;;
  }

  dimension: is_publisher {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_publisher = 1 ;;
  }

  dimension: liability {
    type: yesno
    hidden: yes
    sql: ${TABLE}.liability = 1 ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: marketplace_fee {
    type: number
    hidden: yes
    sql: ${TABLE}.marketplace_fee ;;
  }

  dimension: net_payback_billing {
    type: yesno
    hidden: yes
    sql: ${TABLE}.net_payback_billing = 1 ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: parent_id {
    type: number
    hidden: yes
    sql: ${TABLE}.parent_id ;;
  }

  dimension: platform_client_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_group_id ;;
  }

  dimension: platform_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_type_id ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Platform Clients"
    description: "The distinct count of Platform Clients."
    sql:  ${platform_client_id} ;;
  }
}
