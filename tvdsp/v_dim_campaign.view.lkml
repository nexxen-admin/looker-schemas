# The name of this view in Looker is "V Dim Campaign"
view: v_dim_campaign {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Campaign ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Booked Rate" in Explore.

  dimension: booked_rate {
    type: number
    sql: ${TABLE}.Booked_Rate ;;
  }

  dimension: campaign_budget {
    type: number
    sql: ${TABLE}.Campaign_Budget ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: campaign_end {
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
    sql: ${TABLE}.Campaign_End_Date ;;
  }

  dimension: campaign_gross_budget {
    type: number
    sql: ${TABLE}.Campaign_Gross_Budget ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.Campaign_ID ;;
  }

  dimension: campaign_key {
    type: number
    sql: ${TABLE}.Campaign_Key ;;
  }

  dimension_group: campaign_max_placement_end {
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
    sql: ${TABLE}.Campaign_Max_Placement_End_Date ;;
  }

  dimension_group: campaign_min_placement_start {
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
    sql: ${TABLE}.Campaign_Min_Placement_Start_Date ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.Campaign_Name ;;
  }

  dimension_group: campaign_start {
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
    sql: ${TABLE}.Campaign_Start_Date ;;
  }

  dimension: campaign_sum_flight_booked_amount {
    type: number
    sql: ${TABLE}.Campaign_Sum_Flight_Booked_Amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_campaign_sum_flight_booked_amount {
    type: sum
    sql: ${campaign_sum_flight_booked_amount} ;;
  }

  measure: average_campaign_sum_flight_booked_amount {
    type: average
    sql: ${campaign_sum_flight_booked_amount} ;;
  }

  dimension: campaign_sum_flight_gross_budget {
    type: number
    sql: ${TABLE}.Campaign_Sum_Flight_Gross_Budget ;;
  }

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

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: total_population {
    type: number
    sql: ${TABLE}.Total_Population ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
}
