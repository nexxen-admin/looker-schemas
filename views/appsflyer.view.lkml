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
    label: "Blocked Installs"
    sql: ${TABLE}.Blocked_Conversions ;;
  }

  measure: CPE_Post_Revenue {
    type: sum
    label: "CPE Post Revenue"
    sql: ${TABLE}.CPE_Post_Revenue ;;
  }
  measure: CPI_Post_Revenue {
    type: sum
    label: "CPI Post Revenue"
    sql: ${TABLE}.CPI_Post_Revenue ;;
  }
  measure: CPE_Post_att {
    type: sum
    label: "CPE Post att"
    sql: ${TABLE}.CPE_Post_att ;;
  }

  measure: blocked_events {
    type: sum
    sql: ${TABLE}.Blocked_Events ;;
  }

  measure: Revenue {
    type: number
    value_format: "$#,##0.00"
    sql: ${cpi_revenue}+${cpe_revenue} ;;
  }

  measure: Net_Revenue {
    type: number
    value_format: "$#,##0.00"
    sql: ${cpi_net_revenue}+${cpe_Net_revenue} ;;
  }
  measure: Payout {
    type: number
    label: "Cost"
    value_format: "$#,##0.00"
    sql: ${cpi_payout}+${cpe_payout} ;;
  }


  measure: Net_Payout {
    type: number
    label: "Net_Cost"
    value_format: "$#,##0.00"
    sql: ${cpi_net_payout}+${cpe_Net_payout} ;;
  }

  measure: Profit {
    type: number
    value_format: "$#,##0.00"
    sql: (${cpi_revenue}+${cpe_revenue})-(${cpi_payout}+${cpe_payout}) ;;
  }

  measure: Net_Profit {
    type: number
    value_format: "$#,##0.00"
    sql: (${cpi_net_revenue}+${cpe_Net_revenue})-(${cpi_net_payout}+${cpe_Net_payout}) ;;
  }


  measure: Margin {
    type: number
    label: "Margin%"
    value_format: "0.00%"
    sql: ((${cpi_revenue}+${cpe_revenue})-(${cpi_payout}+${cpe_payout}))/NULLIF((${cpi_revenue}+${cpe_revenue}),0);;
  }

  measure: Post_Attribution{
    type: number
    label: "Post_Attribution%"
    value_format: "0.00%"
    sql: ${post_attribution_conversions}/NULLIF(${conversions},0);;
  }
  measure: Blocked_Attribution{
    type: number
    label: "Blocked_Attribution%"
    value_format: "0.00%"
    sql: ${blocked_conversions}/NULLIF((${conversions}+${blocked_conversions}),0);;
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
    label: "Publisher Name"
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
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPE_Revenue ;;
  }
  measure: cpe_Net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPE_Net_Revenue ;;
  }

  measure: cpe_payout {
    type: sum
    label: "CPE Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPE_Payout ;;
  }
  measure: cpe_Net_payout {
    type: sum
    label: "CPE Net Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPE_Net_Payout ;;
  }

  measure: cpe_events {
    type: sum
    sql: ${TABLE}.CPE_Events ;;
  }
  measure: cpi_payout {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPI_Payout ;;
  }

  measure: Net_Revenue_NewCalc {
    type: number
    value_format: "$#,##0.00"
    sql: (${cpi_revenue}+${cpe_revenue})-(${CPI_Post_Revenue}+${CPE_Post_Revenue}) ;;
  }

  measure: cpi_net_payout {
    type: sum
    value_format: "$#,##0.00"
    label: "CPE Net Cost"
    sql: ${TABLE}.CPI_Net_Payout ;;
  }

  measure: cpi_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPI_Revenue ;;
  }

  measure: cpi_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.CPI_Net_Revenue ;;
  }

  dimension: campaign {
    type: string
    label: "Campaign Name"
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
    label: "Event Date"
    type: date
    sql: ${TABLE}.event_time ;;
  }



  dimension: app_event_time {
    label: "New Time Date"
    type: date
    sql: ${TABLE}.app_event_time ;;
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
    label: "Install Time"
    type: date
    sql: ${TABLE}.install_time ;;
  }

  dimension: publisher {
    type: string
    label: "Publisher Name"
    sql: ${TABLE}.publisher ;;
  }

  measure: post_attribution {
    type: sum
    sql: ${TABLE}.Post_attribution ;;
  }

  measure: post_attribution_conversions {
    type: sum
    label: "Post Attribution Installs"
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
