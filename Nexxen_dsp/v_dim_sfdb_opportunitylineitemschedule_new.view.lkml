# The name of this view in Looker is "V Dim Sfdb Opportunitylineitemschedule New"
view: v_dim_sfdb_opportunitylineitemschedule_new {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_dim_sfdb_opportunitylineitemschedule_new ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_month ;;
    hidden: yes
  }

  dimension: opportunitylineitem_key {
    type: string
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }

  dimension: number_of_day_in_month {
    type: number
    sql: ${TABLE}.number_of_day_in_month ;;
    hidden: yes
  }

  dimension: opportunitylineitem_id {
    type: string
    sql: ${TABLE}.opportunitylineitem_id ;;
    hidden: yes
  }

  measure: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    hidden: yes
  }

  dimension: total_days_in_sl {
    type: number
    sql: ${TABLE}.total_days_in_sl ;;
    hidden: yes
  }

  dimension: total_days_left_in_sl {
    type: number
    sql: ${TABLE}.total_days_left_in_sl ;;
    label: "Days Left"
  }

  dimension: total_days_passed_in_sl {
    type: number
    sql: ${TABLE}.total_days_passed_in_sl ;;
    hidden: yes
  }
  measure: count {
    type: count
  }
}
