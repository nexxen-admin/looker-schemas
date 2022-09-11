# The name of this view in Looker is "V Dim Browser Type"
view: v_dim_browser_type {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Browser_Type ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Browser Type Code" in Explore.

  dimension: browser_type_code {
    type: string
    sql: ${TABLE}.Browser_Type_Code ;;
  }

  dimension: browser_type_key {
    type: number
    sql: ${TABLE}.Browser_Type_Key ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_browser_type_key {
    type: sum
    sql: ${browser_type_key} ;;
  }

  measure: average_browser_type_key {
    type: average
    sql: ${browser_type_key} ;;
  }

  dimension: browser_type_name {
    type: string
    sql: ${TABLE}.Browser_Type_Name ;;
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

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  measure: count {
    type: count
    drill_fields: [browser_type_name]
  }
}
