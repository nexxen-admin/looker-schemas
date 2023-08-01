# The name of this view in Looker is "Dim Up Employee Targets"
view: dim_up_employee_targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_up_employee_targets ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    sql: ${TABLE}.db_update_date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Employee Key" in Explore.

  dimension: employee_key {
    type: number
    sql: ${TABLE}.employee_key ;;
  }

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
  }

  measure: target_amount {
    type: sum
    sql: ${TABLE}.target_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension_group: target {
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
    sql: ${TABLE}.target_date ;;
  }

  dimension: target_type {
    type: string
    sql: ${TABLE}.target_type ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
