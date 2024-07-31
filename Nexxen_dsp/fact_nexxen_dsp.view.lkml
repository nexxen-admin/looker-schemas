# The name of this view in Looker is "Fact Nexxen Dsp"
view: fact_nexxen_dsp {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.fact_nexxen_dsp ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID Key" in Explore.

  dimension: account_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_key ;;
    hidden: yes
  }

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
    hidden: yes
  }

  dimension: creative_file_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_file_key ;;
    hidden: yes
  }

  dimension: exchange_rate_to_target_currency_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.exchange_rate_to_target_currency_key ;;
    hidden: yes
  }

  dimension: exchange_rate_to_usd_currency_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.exchange_rate_to_usd_currency_key ;;
    hidden: yes
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;

 }

  measure: cost {
    type: sum
    label: "Adv Invoice"
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost ;;

  }


  dimension: creative_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_id_key ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
    hidden: yes
  }

  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date IN Timezone"
    sql: ${TABLE}.date_key_in_timezone ;;
  }


  dimension: manual_adjustment_key {
    type: number
    sql: ${TABLE}.manual_adjustment_key ;;
    hidden: yes
  }

  dimension: netsuite_invoice_key {
    type: number
    sql: ${TABLE}.Netsuite_invoice_key ;;
    hidden: yes
  }

  dimension: third_party_key {
    type: number
    sql: ${TABLE}.third_party_key ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }



  measure: impressions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  measure: third_party_impressions {
    type: sum
    label: "3RD Party Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.third_party_impressions ;;
  }

  measure: third_party_clicks {
    type: sum
    label: "3RD Party Clicks"
    value_format: "#,##0"
    sql: ${TABLE}.third_party_clicks ;;
  }

  measure: third_party_complete_events {
    type: sum
    label: "3RD Party Complete Events"
    value_format: "#,##0"
    sql: ${TABLE}.third_party_complete_events ;;
  }

  dimension: market_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.market_id_key ;;
    hidden: yes
  }

  dimension: opportunity_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.opportunity_id_key ;;
    hidden: yes
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }

  dimension: opportunitylineitemschedule_key {
    type: number
    sql: ${TABLE}.opportunitylineitemschedule_key ;;
    hidden: yes

  }

  dimension: package_budget_schedule_key {
    type: number
    sql: ${TABLE}.package_budget_schedule_key ;;
    hidden: yes
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
    hidden: yes


  }
   measure: inventory_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.inventory_cost ;;
    hidden: yes
  }

  measure: inv_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.inv_cost ;;
  }

  measure: brand_safety_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.brand_safety_data_cost ;;
  }

  measure: first_party_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.first_party_cost ;;
  }

  measure: turn_third_party_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.turn_third_party_cost ;;
  }

  measure: turn_audience_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.turn_audience_data_cost ;;
  }

  measure: concatenated_brand_intelligence_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.  concatenated_brand_intelligence_data_cost ;;
  }

  measure: complete_events  {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.complete_events  ;;
  }

  dimension: time_zone_code {
    type: string
    sql: ${TABLE}.time_zone_code ;;
    hidden: yes
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
    hidden: yes
  }

  measure: tac {
    type: sum
    sql: ${TABLE}.tac ;;
    value_format: "$#,##0.00"
    description: "Traffic acquisition cost"
  }

  measure: percent25_events {
    type: sum
    sql: ${TABLE}.percent25_events ;;
  }

  measure: percent50_events {
    type: sum
    sql: ${TABLE}.percent50_events ;;
  }

  measure: percent75_events {
    type: sum
    sql: ${TABLE}.percent75_events ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0.00"
  }

  measure: 3p_in_view_impressions {
    type: sum
    sql: ${TABLE}.third_party_in_view_impressions ;;
    value_format: "#,##0"
  }

  measure: 3p_in_view_measurable_impressions {
    type: sum
    sql: ${TABLE}.third_party_in_view_measurable_impressions ;;
    value_format: "#,##0"
  }

  measure: 3p_rich_media_impressions {
    type: sum
    sql: ${TABLE}.third_party_rich_media_impressions ;;
    value_format: "#,##0"
  }

  measure: 3p_adj_engagements {
    type: sum
    sql: ${TABLE}.third_party_adj_engagements ;;
    value_format: "#,##0"
  }

  measure: 3p_total_conversions {
    type: sum
    sql: ${TABLE}.third_party_total_conversions ;;
    value_format: "#,##0"
  }

  measure: 3p_iv_ia_billable_impressions{
    type: sum
    sql: ${TABLE}.third_party_IV_IA_Billable_Impressions ;;
    value_format: "#,##0"
  }

  measure: 3p_impressions_analyzed {
    type: sum
    sql: ${TABLE}.third_party_impressions_analyzed ;;
    value_format: "#,##0"
  }

  measure: pacing {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.pacing ;;
  }

  measure: yesterday_pacing {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.pacing ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: delivered_units {
    type: sum
    sql: ${TABLE}.delivery_units ;;
    value_format: "#,##0"
  }

  measure: hybrid_impressions_delivered {
    type: sum
    value_format: "#,##0"
    sql: case when dim_sfdb_opportunitylineitem.reporting__c = 'Amobee' then ${TABLE}.impressions else
    ${TABLE}.third_party_impressions end;;
    hidden: yes
  }

  measure: remaining_budget {
    type: number
    sql: dim_sfdb_opportunitylineitem.gross_billable__c - ${hybrid_impressions_delivered}*dim_sfdb_opportunitylineitem.rate__c
    /1000 ;;
  }

  measure: impressions_discrepancy {
    type: number
    sql: (${impressions}-${third_party_impressions})/NULLIF(${impressions},0) ;;
    value_format: "0.00%"
  }

  measure: clicks_discrepancy {
    type: number
    sql: (${clicks}-${third_party_clicks})/nullif(${clicks},0) ;;
    value_format: "0.00%"
  }

  # measure: days_left {
  #   type: sum
  #   sql: case when DATEDIFF('day',current_date - INTERVAL '1' day ,dim_sfdb_opportunitylineitem.end_date__c)<0
  #   then 0 else DATEDIFF('day',current_date - INTERVAL '1' day ,dim_sfdb_opportunitylineitem.end_date__c) end;;
  # }

  measure: uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "$#,##0.00"
  }

  measure: capped_revenue {
    type: sum
    sql: ${TABLE}.capped_revenue ;;
    value_format: "$#,##0.00"
  }

  measure: final_impressions {
    type: sum
    sql: ${TABLE}.final_impressions ;;
  }

  measure: final_clicks {
    type: sum
    sql: ${TABLE}.final_clicks ;;
  }

  measure: final_complete_events {
    type: sum
    sql: ${TABLE}.final_complete_events ;;
  }

  measure: CTR_1P {
    type: number
    value_format: "0.00%"
    sql: ${clicks}/nullif(${impressions},0) ;;
  }

  measure: CTR_3P {
    type: number
    value_format: "0.00%"
    sql: ${third_party_clicks}/nullif(${third_party_impressions},0) ;;
  }

  measure: VCR_1P {
    type: number
    sql: ${complete_events}/nullif(${impressions},0) ;;
    value_format: "0.00%"
  }

  measure: VCR_3P {
    type: number
    sql: ${third_party_complete_events}/nullif(${third_party_impressions},0) ;;
    value_format: "0.00%"
  }

  measure: IV {
    type: number
    label: "IV %"
    sql: ${3p_in_view_impressions}/nullif(${3p_in_view_measurable_impressions},0) ;;
    value_format: "0.00%"
  }

  measure:  Last_day_inv_cost {
    label: "Yesterday Inv Cost"
    type: sum
    sql: ${TABLE}.inv_cost ;;
    value_format: "$#,##0.00"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: yesterday_units {
    type: sum
    sql: ${TABLE}.delivery_units ;;
    filters: [date_key_in_timezone_date: "yesterday"]
    value_format: "#,##0"
  }

  measure: distinct_package_id {
    type: count_distinct
    sql: ${dim_dsp_package_budget_schedule.package_id} ;;
  }

  measure: internal_ecpm {
    type: sum
    sql: ${TABLE}.internal_ecpm ;;
    value_format: "$#,##0.00"
  }

  measure: daily_units_needed {
    type: sum
    sql: case when ${dim_sfdb_opportunitylineitem.price_type_name__c} in ('dCPM', 'CPR') then
    (${dim_sfdb_opportunitylineitem.gross_billable__c} - ${TABLE}.delivery_units)/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) else
    (${dim_sfdb_opportunitylineitem.units__c}-${TABLE}.delivery_units)/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) end;;
    #hidden: yes
  }

  measure: count {
    type: count
    hidden: yes
  }

}
