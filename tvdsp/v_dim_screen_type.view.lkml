# The name of this view in Looker is "V Dim Screen Type"
view: v_dim_screen_type {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Screen_Type ;;
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

  dimension: screen_type_code {
    type: number
    sql: ${TABLE}.Screen_Type_Code ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_screen_type_code {
    type: sum
    sql: ${screen_type_code} ;;
  }

  measure: average_screen_type_code {
    type: average
    sql: ${screen_type_code} ;;
  }

  dimension: screen_type_key {
    type: number
    sql: ${TABLE}.Screen_Type_Key ;;
  }

  dimension: screen_type_name {
    type: string
    sql: ${TABLE}.Screen_Type_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [screen_type_name]
  }
}
