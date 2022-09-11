# The name of this view in Looker is "V Dim Sf Forecasted Spend"
view: v_dim_sf_forecasted_spend {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_SF_Forecasted_Spend ;;
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
  # This dimension will be called "Ri Info" in Explore.

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: sf_flight_number {
    type: string
    sql: ${TABLE}.SF_flight_number ;;
  }

  dimension: sf_flight_schedule_split_name {
    type: string
    sql: ${TABLE}.SF_flight_schedule_split_name ;;
  }

  dimension: sf_forecast_group {
    type: string
    sql: ${TABLE}.SF_forecast_group ;;
  }

  dimension: sf_forecasted_spend_currency {
    type: string
    sql: ${TABLE}.SF_forecasted_spend_currency ;;
  }

  dimension: sf_forecasted_spend_key {
    type: number
    sql: ${TABLE}.SF_Forecasted_Spend_Key ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sf_forecasted_spend_key {
    type: sum
    sql: ${sf_forecasted_spend_key} ;;
  }

  measure: average_sf_forecasted_spend_key {
    type: average
    sql: ${sf_forecasted_spend_key} ;;
  }

  dimension: sf_line_number {
    type: string
    sql: ${TABLE}.SF_line_number ;;
  }

  dimension_group: sf_revenue_month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.SF_revenue_month ;;
  }

  dimension: sf_split_percentage {
    type: number
    sql: ${TABLE}.SF_split_percentage ;;
  }

  dimension: sf_weighted_forecast_spend {
    type: number
    sql: ${TABLE}.SF_weighted_forecast_spend ;;
  }

  measure: count {
    type: count
    drill_fields: [sf_flight_schedule_split_name]
  }
}
