# The name of this view in Looker is "App Temp1"
view: appsflyer {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.appsflyer ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "App ID" in Explore.

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: app_name {
    type: string
    sql: ${TABLE}.app_name ;;
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



  dimension: blocked_reason {
    type: string
    sql: ${TABLE}.blocked_reason ;;
  }


  dimension: offer_name {
    type: string
    sql: ${TABLE}.Offer_Name ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.Pub_ID ;;
  }

  dimension: sub_aff {
    type: string
    sql: ${TABLE}.Sub_Aff ;;
  }

  dimension: media_manager_name {
    type: string
    sql: ${TABLE}.Media_Manager_Name ;;
  }

  dimension: adv_name {
    type: string
    sql: ${TABLE}.adv_name ;;
  }

  dimension: CSM_name {
    type: string
    sql: ${TABLE}.CSM_name ;;
  }
  dimension: Office {
    type: string
    sql: ${TABLE}.Office ;;
  }

  measure: blockes {
    type: sum
    sql: ${TABLE}.Blockes ;;
  }

  measure: cpe_revenue {
    type: sum
    sql: ${TABLE}.CPE_Revenue ;;
  }

  measure: cpe_payout {
    type: sum
    sql: ${TABLE}.CPE_Payout ;;
  }

  measure: cpe_events {
    type: sum
    sql: ${TABLE}.CPE_Events ;;
  }
  measure: cpi_payout {
    type: sum
    value_format: ""
    sql: ${TABLE}.CPI_Payout ;;
  }
  measure: cpi_revenue {
    type: sum
    sql: ${TABLE}.CPI_Revenue ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.Conversions ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  measure: event_count {
    type: sum
    sql: ${TABLE}.Event_Count ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: event {
    type: date
    sql: ${TABLE}.event_time ;;
  }

  dimension: fraud_reason {
    type: string
    sql: ${TABLE}.fraud_reason ;;
  }

  dimension: fraud_sub_reason {
    type: string
    sql: ${TABLE}.fraud_sub_reason ;;
  }

  dimension: install {
    type: date
    sql: ${TABLE}.install_time ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.publisher ;;
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

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }



  dimension: source {
    type: string
    sql: ${TABLE}."source" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: [event_name, app_name]
  }
}
