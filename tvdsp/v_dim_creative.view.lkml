# The name of this view in Looker is "V Dim Creative"
view: v_dim_creative {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Creative ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Format" in Explore.

  dimension: ad_format {
    type: string
    sql: ${TABLE}.Ad_Format ;;
  }

  dimension: ad_format_key {
    type: number
    sql: ${TABLE}.Ad_Format_Key ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.Advertiser_ID ;;
  }

  dimension: advertiser_key {
    type: number
    sql: ${TABLE}.Advertiser_Key ;;
  }

  dimension: agency_id {
    type: number
    sql: ${TABLE}.Agency_ID ;;
  }

  dimension: agency_key {
    type: number
    sql: ${TABLE}.Agency_Key ;;
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.Creative_ID ;;
  }

  dimension: creative_key {
    type: number
    sql: ${TABLE}.Creative_Key ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.Creative_Name ;;
  }

  dimension: creative_type {
    type: string
    sql: ${TABLE}.Creative_Type ;;
  }

  dimension: creative_type_key {
    type: number
    sql: ${TABLE}.Creative_Type_Key ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_create {
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
    sql: ${TABLE}.DB_Create_Date ;;
  }

  dimension_group: db_update {
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
    sql: ${TABLE}.DB_Update_Date ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.Duration ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_duration {
    type: sum
    sql: ${duration} ;;
  }

  measure: average_duration {
    type: average
    sql: ${duration} ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.External_ID ;;
  }

  dimension_group: loaded {
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
    sql: ${TABLE}.Loaded ;;
  }

  dimension: network_id {
    type: number
    sql: ${TABLE}.Network_ID ;;
  }

  dimension: network_key {
    type: number
    sql: ${TABLE}.Network_Key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  measure: count {
    type: count
    drill_fields: [creative_name]
  }
}
