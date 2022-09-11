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
    label: "App Name"
    type: string
    sql: ${TABLE}.App_Name ;;
  }

  dimension: app_name_key {
    type: number
    sql: ${TABLE}.App_Name_Key ;;
    hidden: yes
  }

  dimension: bid_stream_name {
    label: "Bid Stream Name"
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
    hidden: yes
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
    hidden: yes
  }

  dimension: manual_name {
    label: "Manual Name"
    type: string
    sql: ${TABLE}.Manual_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: tp_source_name {
    label: "Tp Source Name"
    type: string
    sql: ${TABLE}.TP_Source_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [app_name, tp_source_name, manual_name, bid_stream_name]
    hidden: yes
  }
}
