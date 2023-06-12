# The name of this view in Looker is "Exchange Rev Ops Targets"
view: exchange_rev_ops_targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Exchange_RevOps_Targets ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
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
    sql: ${TABLE}.date_key ;;
  }
  dimension: date_pk  {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${date_key_date} ;;
  }
  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Target 1party" in Explore.

  measure: target_1party {
    type: sum
    sql: ${TABLE}.target_1party;;
    value_format: "#,##0"
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: target_3party {
    type: sum
    sql: ${TABLE}.target_3party ;;
    value_format: "#,##0"
    hidden: yes
  }

  dimension_group: current_date {
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
    sql: current_date ;;
  }

  #dimension: is_current_month {
  # type: string
  #sql: case when month(${activity_month}) = month(current_date)
  #and year(${activity_year}) = year(current_date) then 'Yes' else 'No' end;;
  #}

  dimension: is_current_month {
    type: string
    sql: case when ${date_key_month} = ${current_date_month}
      then 'Yes' else 'No' end;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
