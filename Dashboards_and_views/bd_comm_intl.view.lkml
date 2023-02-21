# The name of this view in Looker is "Bd Comm Intl"
view: bd_comm_intl {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.BD_COMM_Intl ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bd Country" in Explore.

  dimension: bd_country {
    type: string
    sql: ${TABLE}.BD_Country ;;
  }

  dimension: bd_office {
    type: string
    sql: ${TABLE}.BD_Office ;;
  }

  dimension: bd_user_id {
    type: number
    sql: ${TABLE}.bd_user_id ;;
  }

  dimension: bizdev_owner {
    type: string
    sql: ${TABLE}.bizdev_owner ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
  }

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

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  #measure: total_impressions {
   # type: sum
    #sql: ${impressions} ;;
  #}

  #measure: average_impressions {
   # type: average
    #sql: ${impressions} ;;
  #}

  measure: profit {
    type: sum
    sql: ${TABLE}.profit ;;
  }

  dimension: pub_id {
    type: number
    sql: ${TABLE}.pub_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  measure: revenue {
    type: sum
    sql: coalesce(${TABLE}.revenue,0) ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_date ;;
  }

  measure: count {
    type: count
    drill_fields: [publisher_name]
  }
}
