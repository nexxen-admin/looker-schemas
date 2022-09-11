# The name of this view in Looker is "V Dim Deal"
view: v_dim_deal {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Deal ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deal ID" in Explore.

  dimension: deal_id {
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_deal_key {
    type: sum
    sql: ${deal_key} ;;
  }

  measure: average_deal_key {
    type: average
    sql: ${deal_key} ;;
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

  dimension: package_name {
    type: string
    sql: ${TABLE}.Package_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  measure: count {
    type: count
    drill_fields: [package_name]
  }
}
