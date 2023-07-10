# The name of this view in Looker is "V Dim Sf User"
view: v_dim_sf_user {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_SF_User ;;
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

  dimension: sf_user_division {
    type: string
    sql: ${TABLE}.SF_User_Division ;;
  }

  dimension: sf_user_full_name {
    type: string
    sql: ${TABLE}.SF_User_Full_Name ;;
  }

  dimension: sf_user_id {
    type: string
    sql: ${TABLE}.SF_User_ID ;;
  }

  dimension: sf_user_key {
    type: number
    sql: ${TABLE}.SF_User_Key ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sf_user_key {
    type: sum
    sql: ${sf_user_key} ;;
  }

  measure: average_sf_user_key {
    type: average
    sql: ${sf_user_key} ;;
  }

  dimension: sf_user_seller_region {
    type: string
    sql: ${TABLE}.SF_User_Seller_Region ;;
  }

  measure: count {
    type: count
    drill_fields: [sf_user_full_name]
  }
}
