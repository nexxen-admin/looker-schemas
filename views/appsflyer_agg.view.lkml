# The name of this view in Looker is "Appsflyer Agg"
view: appsflyer_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.appsflyer_agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "App ID" in Explore.

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: blocked_conversions {
    type: number
    sql: ${TABLE}.Blocked_Conversions ;;
  }

  dimension: blocked_events {
    type: number
    sql: ${TABLE}.Blocked_Events ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_blocked_events {
    type: sum
    sql: ${blocked_events} ;;
  }

  measure: average_blocked_events {
    type: average
    sql: ${blocked_events} ;;
  }

  dimension: blockes {
    type: number
    sql: ${TABLE}.Blockes ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.Conversions ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
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
    sql: ${TABLE}.event_time ;;
  }

  dimension: events {
    type: number
    sql: ${TABLE}."Events" ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: post_attribution {
    type: number
    sql: ${TABLE}.Post_attribution ;;
  }

  dimension: post_attribution_conversions {
    type: number
    sql: ${TABLE}.Post_attribution_Conversions ;;
  }

  dimension: post_attribution_events {
    type: number
    sql: ${TABLE}.Post_attribution_Events ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.publisher ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
