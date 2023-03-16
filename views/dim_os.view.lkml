# The name of this view in Looker is "V Dim OS"
view: dim_os {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_OS ;;
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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "OS" in Explore.

  dimension: os {
    type: string
    description: "Device operating system"
    sql: ${TABLE}.OS ;;
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_os_key {
    type: sum
    sql: ${os_key} ;;
    hidden: yes
  }

  measure: average_os_key {
    type: average
    sql: ${os_key} ;;
    hidden: yes
  }

  dimension: os_sub_type {
    type: string
    sql: ${TABLE}.OS_SubType ;;
    hidden: yes
  }

  dimension: os_type {
    type: string
    sql: ${TABLE}.OS_Type ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
