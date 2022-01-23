# The name of this view in Looker is "V Dim Media Type"
view: dim_media_type {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Media_Type ;;
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
  # This dimension will be called "Media Type" in Explore.

  dimension: media_type {
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_media_type_key {
    type: sum
    sql: ${media_type_key} ;;
    hidden: yes
  }

  measure: average_media_type_key {
    type: average
    sql: ${media_type_key} ;;
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
