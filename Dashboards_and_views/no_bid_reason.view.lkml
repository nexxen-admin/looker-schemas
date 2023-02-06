# The name of this view in Looker is "No Bid Reason"
view: no_bid_reason {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.No_Bid_Reason ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bid Filterreason" in Explore.

  dimension: bid_filterreason {
    type: string
    sql: ${TABLE}.bid_filterreason ;;
  }

  measure: bids {
    type: sum
    sql: ${TABLE}.Bids ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: dsp {
    type: string
    sql: ${TABLE}.DSP ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension: imptype {
    type: string
    sql: ${TABLE}.imptype ;;
  }

  dimension: nb_reason {
    type: string
    sql: ${TABLE}.NB_Reason ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
  }

  dimension: pubid {
    type: string
    sql: ${TABLE}.pubid ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.Requests ;;
  }

  measure: count {
    type: count
    drill_fields: [publisher_name]
  }
}
