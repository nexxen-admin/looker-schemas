# The name of this view in Looker is "V Dim App Name"
view: v_dim_app_name {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_App_Name ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "App Name" in Explore.

  dimension: app_name {
    type: string
    sql: ${TABLE}.App_Name ;;
  }

  dimension: app_name_key {
    type: number
    sql: ${TABLE}.App_Name_Key ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_app_name_key {
    type: sum
    sql: ${app_name_key} ;;
  }

  measure: average_app_name_key {
    type: average
    sql: ${app_name_key} ;;
  }

  dimension: bid_stream_name {
    type: string
    sql: ${TABLE}.BidStream_Name ;;
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

  dimension: manual_name {
    type: string
    sql: ${TABLE}.Manual_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: tp_source_name {
    type: string
    sql: ${TABLE}.TP_Source_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [app_name, tp_source_name, manual_name, bid_stream_name]
  }
}
