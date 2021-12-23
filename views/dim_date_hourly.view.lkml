# The name of this view in Looker is "V Dim Date Hourly"
view: dim_date_hourly {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Date_Hourly ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    label: " "
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
    sql: ${TABLE}.Date_Key ;;
  }

  dimension_group: date_time_key {
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
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateTime_Key ;;
    hidden: yes
  }

  dimension: is_before_mtd {

    type: yesno
    sql:
           DATE_PART('DAY', ${date_time_key_raw}::TIMESTAMP) = DATEPART('DAY', CURRENT_TIMESTAMP) AND

        DATEPART('HOUR', ${date_time_key_raw}) < DATEPART('HOUR', CURRENT_TIMESTAMP);;

  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Hour Interval" in Explore.

  dimension: hour_interval {
    type: string
    label: "Hour Interval"
    sql: ${TABLE}.Hour_Interval ;;
  }

  dimension: hour {
    type: string
    sql: ${TABLE}.Hour_Key ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
