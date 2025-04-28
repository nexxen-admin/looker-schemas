# The name of this view in Looker is "Dim Revenue Type"
view: dim_revenue_type {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_revenue_type ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_create_date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_update_date ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Revenue Type Key" in Explore.

  dimension: revenue_type_key {
    type: number
    sql: ${TABLE}.revenue_type_key ;;
    hidden: yes
  }

  dimension: revenue_type_name {
    type: string
    sql: ${TABLE}.revenue_type_name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [revenue_type_name]
  }
}
