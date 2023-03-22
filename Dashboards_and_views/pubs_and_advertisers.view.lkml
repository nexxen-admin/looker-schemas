# The name of this view in Looker is "Pubs and Advertisers"
view: pubs_and_advertisers {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Pubs_And_Advertisers ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
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
    sql: ${TABLE}.Event_Month ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Profile" in Explore.

  dimension: profile {
    type: string
    sql: ${TABLE}."profile" ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: profile_name {
    type: string
    sql: ${TABLE}.Profile_Name ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_revenue {
  #   type: sum
  #   sql: ${revenue} ;;
  # }

  # measure: average_revenue {
  #   type: average
  #   sql: ${revenue} ;;
  # }

  measure: count {
    type: count
    drill_fields: [profile_name]
  }
}
