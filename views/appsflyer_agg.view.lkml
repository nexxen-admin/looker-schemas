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

  measure: blocked_conversions {
    type: sum
    sql: ${TABLE}.Blocked_Conversions ;;
  }

  measure: blocked_events {
    type: sum
    sql: ${TABLE}.Blocked_Events ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  measure: blockes {
    type: sum
    sql: ${TABLE}.Blockes ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.Conversions ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    label: "Event Date"
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

  measure: events {
    type: sum
    sql: ${TABLE}."Events" ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: post_attribution {
    type: sum
    sql: ${TABLE}.Post_attribution ;;
  }

  measure: post_attribution_conversions {
    type: sum
    sql: ${TABLE}.Post_attribution_Conversions ;;
  }

  measure: post_attribution_events {
    type: sum
    sql: ${TABLE}.Post_attribution_Events ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.publisher ;;
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
