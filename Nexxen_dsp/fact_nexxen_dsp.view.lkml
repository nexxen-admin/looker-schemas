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

  dimension: environment_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.environment_key ;;
    hidden: yes
  }

  dimension: creative_size_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_size_key ;;
    hidden: yes
  }

  dimension: dma_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.dma_key ;;
    hidden: yes
  }

  dimension: deal_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.deal_key ;;
    hidden: yes
  }

  dimension: city_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.city_id_key ;;
    hidden: yes
  }


  # dimension: environment_key {
  #   type: number
  #   value_format_name: id
  #   sql: ${TABLE}.environment_key ;;
  #   hidden: yes
  # }

  ##dimension: environment_key {
   ## type: number
    ##value_format_name: id
   ## sql: ${TABLE}.environment_key ;;
   ## hidden: yes
  ##}


  dimension: mobile_app_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.mobile_app_key ;;
    hidden: yes
  }

  dimension: country_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.country_key ;;
    hidden: yes
  }

  dimension: region_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.region_key ;;
    hidden:  yes
  }

  dimension: beacon_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.beacon_key ;;
    hidden:  yes
  }

  dimension: device_type_key{
    type: number
    value_format_name: id
    sql: ${TABLE}.device_type_key ;;
    hidden: yes
  }

  dimension: creative_file_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_file_key ;;
    hidden: yes
  }

  dimension: device_manufacturer_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.device_manufacturer_key ;;
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
    label: "1P Clicks"
    value_format: "#,##0"
    sql: ${TABLE}.clicks ;;

 }

  measure: cost {
    type: sum
    label: "Adv Invoice"
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost ;;

  }

  measure: yesterday_cost {
    type: sum
    # label: "Adv Invoice"
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost;;
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
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
    label: "Date Key UTC"
    group_label: "Date UTC"
    view_label: "Time Frame"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
    # hidden: yes
  }

  dimension: date_key_year_month_utc {
    type: string
    label: "Year-Month (YYYY-MM) UTC"
    group_label: "Date UTC"
    sql: TO_CHAR(${date_key_raw}, 'YYYY-MM') ;;
  }


  dimension: date_key_year_number_utc {
    type: number
    label: "Year (Number) UTC"
    group_label: "Date UTC"
    sql: EXTRACT(YEAR FROM ${date_key_raw}) ;;
  }


  parameter: date_granularity {

    label: "Date Granularity Filter (D/W/M/Q/Y)"
    description: "For dynamic Delivery period Granularity. Use with dynamic Dimension Date Granularity"
    type: string
    allowed_value: {value:"Day"}
    allowed_value: {value:"Week"}
    allowed_value: {value:"Month"}
    allowed_value: {value:"Quarter"}
    allowed_value: {value:"Year"}
  }

  dimension: date {
    group_label: "Date Timezone"
    label: "Deliverydate Granularity"
    description: "For dynamic Delivery period Granularity. Use with Filter Date Granularity"
    #value_format: "%m/%d"
    sql:  CASE
      WHEN {% parameter date_granularity %} = 'Day'
        THEN ${date_key_in_timezone_date}
      When {% parameter date_granularity %} ='Week'
        THEN ${date_key_in_timezone_week}
      WHEN {% parameter date_granularity %} = 'Month'
        THEN ${date_key_in_timezone_month}
      WHEN {% parameter date_granularity %} = 'Quarter'
        THEN ${date_key_in_timezone_quarter}
      WHEN {% parameter date_granularity %} = 'Year'
        THEN ${date_key_in_timezone_year}
      ELSE NULL
    END ;;

    hidden:  no
  }

  parameter: top_x_rank_limit {
    type: unquoted
    label: "Top X Accounts"
    view_label: "Dashboard Filters"
    description: "Select number of top accounts to display"
    default_value: "5"

    allowed_value: {
      label: "Top 5"
      value: "5"
    }
    allowed_value: {
      label: "Top 10"
      value: "10"
    }
    allowed_value: {
      label: "Top 15"
      value: "15"
    }
    allowed_value: {
      label: "Top 20"
      value: "20"
    }
  }

  # Helper dimension to pass the parameter value to the Explore
  dimension: top_x_limit_value {
    type: number
    label: "Top X Limit Value"
    #hidden: yes
    sql: {% parameter top_x_rank_limit %} ;;
  }


  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date in Timezone"
    group_label: "Date Timezone"
    view_label: "Time Frame"
    sql: ${TABLE}.date_key_in_timezone ;;
  }

  dimension: date_key_year_number {
    type: number
    label: "Year (Number)"
    group_label: "Date Timezone"
    sql: EXTRACT(YEAR FROM ${date_key_in_timezone_raw}) ;;
  }

  dimension: date_key_year_month {
    type: string
    label: "Year-Month (YYYY-MM)"
    group_label: "Date Timezone"
    sql: TO_CHAR(${date_key_in_timezone_raw}, 'YYYY-MM') ;;
  }



dimension: inventory_source_key {
  type: number
  sql: ${TABLE}.inventory_source_key ;;
  hidden: yes
}

  # dimension: inventory_source_id {
  #   type: number
  #   sql: ${TABLE}.inventory_source_id ;;
  #   hidden: yes
  # }

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

  dimension: line_item_key {
    type: number
    sql: ${TABLE}.line_item_key ;;
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

  dimension: format_id {
    type: number
    sql: ${TABLE}.format_key ;;
    hidden: yes
  }



  measure: impressions {
    type: sum
    label: "1P Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  measure: last_3_days_impressions_raw {
    type: sum
    label: "Last 3 Days 1P Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;; # Reference the underlying column
    filters: [date_key_in_timezone_date: "3 days ago for 3 days"]
  }


  # measure: netsuite_invoice_amount {
  #   type: sum
  #   sql: ${dim_dsp_netsuite_invoice.Amount_Functional_Currency} ;;
  #   hidden: no
  # }


  measure: third_party_impressions {
    type: sum
    label: "3P Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.third_party_impressions ;;
  }

  measure: third_party_clicks {
    type: sum
    label: "3P Clicks"
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
   # primary_key: yes
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

  dimension: package_id_key {
    type: number
    sql: ${TABLE}.package_id_key ;;
    hidden: yes
  }

  dimension: zip_code {
    type: zipcode
    view_label: "Geo"
    sql: ${TABLE}.zip_code ;;
  }

  measure: inventory_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.inventory_cost ;;
    hidden: yes
  }

  # measure: inv_cost {
  #   type: sum
  #   value_format: "$#,##0"
  #   sql: ${TABLE}.inv_cost ;;
  # }

  measure: inv_cost {
    type: sum
    description: "Using inventory_cost"
    value_format: "$#,##0"
    sql: ${TABLE}.inventory_cost  ;;
  }


  measure: Nexxen_Inv_Cost {
    type: sum
    value_format: "$#,##0"
    sql: case when ${dim_dsp_inventory_source.inventory_source_id}=158 then ${TABLE}."inventory_cost" else null end ;;
  }

  # measure: nexxen_inv_cost_percent {
  #   type: number
  #   label: "Nexxen inv cost %"
  #   sql: ${Nexxen_Inv_Cost}/nullif(${inv_cost},0)  ;;
  #   value_format: "0.00%"
  # }

measure: Nexxen_Inv_Cost_Percent {
  type: number
  label: "Nexxen Inv Cost %"
  value_format:  "0.00%"
  sql: ${Nexxen_Inv_Cost}/nullif(${inventory_cost},0);;
}


#   measure: inv_cost {
#     type: sum
#     value_format: "$#,##0.00"
#     sql: ${TABLE}.inv_cost ;;
#   }

# measure: nexxen_inventory_cost {
#   type: sum
#   label: "nexxen inventory cost"
#   value_format: "$#,##0.00"
#   sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}."inv_cost" ELSE NULL END ;;
# }


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
    value_format: "#,##0"
    description: "1 for events that were completed"
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

  dimension: modified_case_safe {
    type: string
    label: "Modified Case Safe ID"
    sql: CASE
           WHEN ${dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c} = 'Unknown' THEN ${dim_dsp_package_budget_schedule.salesforce_line_item_id}
           ELSE ${dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c}
         END ;;
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
    description: "Inventory cost plus third party cost"
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
    label: "3P Conversions"
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
    description: "Current pacing based on expected delivery vs. actual delivery and total days vs. remaining days. Calculation is: ((delivered units/total flight days) - Days Remaining + .0000001) * (Total Flight Days/Booked Units)"
    type: average
    value_format: "0.00\%"
    sql: ${TABLE}.pacing ;;
  }

  measure: yesterday_pacing {
    description: "Yesterday’s pacing, comparing the daily expected goal with the actual units delivered yesterday. Calculation is: yesterday's delivered units / daily units needed"
    type: average
    value_format: "0.00\%"
    sql: ${TABLE}.pacing ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: delivered_units {
    description: "The number of units delivered on the campaign."
    type: sum
    sql: ${TABLE}.delivery_units ;;
    value_format: "#,##0"
  }

  measure: impressions_discrepancy {
    type: number
    sql: (${third_party_impressions}-${impressions})/NULLIF(${impressions},0) ;;
    value_format: "0.00%"
  }

  measure: clicks_discrepancy {
    type: number
    sql: (${third_party_clicks}-${clicks})/nullif(${clicks},0) ;;
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
    value_format: "#,##0.00"
  }



  measure: yesterday_uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: prev_month_uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
    filters: [date_key_in_timezone_date: "last month"]
  }

  measure: capped_revenue{
    description: "Capped Revenue n Opp Local Currency"
    type: sum
    sql: ${TABLE}.capped_revenue ;;
    value_format: "#,##0.00"
  }

  # measure: capped_revenue_usd {
  #   label: "Capped Revenue USD"
  #   type: sum
  #   # Use raw SQL alias "opportunity_exchange_rate".
  #   # Do NOT use ${opportunity_exchange_rate.exchange_rate} syntax.
  #   sql: ${TABLE}.capped_revenue * opportunity_exchange_rate.exchange_rate ;;
  #   value_format: "#,##0.00"
  # }

  measure: capped_revenue_usd {
    label: "Capped Revenue USD"
    description: "Capped Revenue in USD ( USD daily FX rate)"
    type: sum
    sql:
      CASE
        WHEN ${dim_sfdb_opportunitylineitem.io_currency__c} = 'USD' THEN ${TABLE}.capped_revenue
        WHEN opportunity_exchange_rate.exchange_rate IS NOT NULL THEN ${TABLE}.capped_revenue * opportunity_exchange_rate.exchange_rate
        ELSE ${TABLE}.capped_revenue
      END ;;
    value_format: "#,##0.00"
  }

  measure: uncapped_revenue_usd {
    label: "Uncapped Revenue USD"
    description: "Uncapped Revenue in USD ( USD daily FX rate)"
    type: sum
    sql:
      CASE
        WHEN ${dim_sfdb_opportunitylineitem.io_currency__c} = 'USD' THEN ${TABLE}.uncapped_revenue
        WHEN opportunity_exchange_rate.exchange_rate IS NOT NULL THEN ${TABLE}.uncapped_revenue * opportunity_exchange_rate.exchange_rate
        ELSE ${TABLE}.uncapped_revenue
      END ;;
    value_format: "#,##0.00"
  }

  measure: yesterday_capped_revenue {
    type: sum
    sql:  ${TABLE}.capped_revenue ;;
    value_format: "$#,##0.00"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  # measure: yesterday_capped_revenue {
  #   type: sum
  #   sql: ${capped_revenue} ;;
  #   value_format: "$#,##0.00"
  #   filters: [date_key_in_timezone_date: "yesterday"]
  # }

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
    sql: IFNULL(${clicks}/nullif(${impressions},0),0) ;;
  }

  measure: yesterday_CTR_1P {
    type: number
    value_format: "0.00%"
    sql: IFNULL(${Last_day_1p_clicks}/nullif(${Last_day_1p_impressions},0),0) ;;
  }


  measure: CTR_3P {
    type: number
    value_format: "0.0%"
    sql: ${third_party_clicks}/nullif(${third_party_impressions},0) ;;
  }

  measure: VCR_1P {
    type: number
    sql: IFNULL(${complete_events}/nullif(${impressions},0),0) ;;
    value_format: "0.0%"
  }

  measure: VCR_3P {
    type: number
    sql: ${third_party_complete_events}/nullif(${third_party_impressions},0) ;;
    value_format: "0.0%"
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
    sql: ${TABLE}.inventory_cost;;
    value_format: "$#,##0.00"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: yesterday_units {
    description: "The number of units delivered on the campaign yesterday."
    type: sum
    sql: ${TABLE}.delivery_units ;;
    filters: [date_key_in_timezone_date: "yesterday"]
    value_format: "#,##0"
  }

  measure:  Last_day_1p_clicks {
    label: "Yesterday 1P Clicks"
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure:  Last_day_3p_clicks {
    label: "Yesterday 3P Clicks"
    type: sum
    sql: ${TABLE}.third_party_clicks ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    #hidden: yes
  }

  measure:  Last_day_1p_impressions {
    label: "Yesterday 1P Impressions"
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
  }

  measure:  Last_day_3p_impressions {
    label: "Yesterday 3P Impressions"
    type: sum
    sql: ${TABLE}.third_party_impressions ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
  }

  measure:  Last_day_1p_complete_events {
    label: "Yesterday 1P Complete Events"
    type: sum
    sql: ${TABLE}.complete_events ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
  }

  measure:  Last_day_3p_complete_events {
    label: "Yesterday 3P Complete Events"
    type: sum
    sql: ${TABLE}.third_party_complete_events ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
  }

  measure:  Last_day_1P_CTR {
    label: "Yesterday 1P CTR"
    type: number
    sql: IFNULL(${Last_day_1p_clicks}/nullif(${Last_day_1p_impressions},0),0) ;;
    value_format: "0.00%"
  }

  measure:  Last_day_3P_CTR {
    label: "Yesterday 3P CTR"
    type: number
    sql: IFNULL(${Last_day_3p_clicks}/nullif(${Last_day_3p_impressions},0),0) ;;
    value_format: "0.00%"
  }

  measure:  Last_day_1P_VCR {
    label: "Yesterday 1P VCR"
    type: number
    sql: IFNULL(${Last_day_1p_complete_events}/nullif(${Last_day_1p_impressions},0),0) ;;
    value_format: "0.00%"
  }

  measure:  Last_day_3P_VCR {
    label: "Yesterday 3P VCR"
    type: number
    sql: IFNULL(${Last_day_3p_complete_events}/nullif(${Last_day_3p_impressions},0),0) ;;
    value_format: "0.00%"
  }



  measure: distinct_package_id {
    type: count_distinct
    sql: ${dim_dsp_package_budget_schedule.package_id} ;;
  }

  measure: internal_ecpm_vertica {
    type: average
    sql: ${TABLE}.internal_ecpm ;;
    value_format: "$#,##0.00"
    hidden: yes
  }

  measure: internal_ecpm {
    type: number
    sql: (${cost}/nullif(${impressions},0))*1000 ;;
    value_format: "$#,##0.00"
  }

  measure: yesterday_internal_ecpm {
    type: number
    sql: (${yesterday_cost}/nullif(${Last_day_1p_impressions},0))*1000 ;;
    value_format: "$#,##0.00"
  }

  measure: is_internal_ecpm_greater_than_booked_rate {
    type: string
    label: "Internal eCPM > Booked Rate"
    description: "Returns 'Yes' if Internal eCPM is greater than Booked Rate, else 'No'. Use for filtering."
    sql: CASE WHEN ${internal_ecpm} > ${dim_sfdb_opportunitylineitem.booked_rate} THEN 'Yes' ELSE 'No' END ;;
  }



  measure: media_margin {
    type: number
    label: "Media Margin (Not USD)"
    description: "not in USD"
    sql: (${capped_revenue}-${cost})/nullif(${capped_revenue},0) ;;
    value_format_name: percent_2
  }

  measure: Total_Data_External_adserver_cost_USD {
    type: number
    label: "Total Data & External adserver cost USD"
    sql: (${fdw_cost}-${inv_cost}) ;;
    value_format: "#,##0.00"
  }

  # measure: Margin_usd {
  #   type: number
  #   label: "Margin USD"
  #   required_joins: [billing_unified_revenue]
  #   sql: ((${billing_unified_revenue.locked_final_billable_revenue_after_adj_usd_measure} – ${inv_cost}– ${Total_Data_External_adserver_cost_USD})) ;;
  #   value_format: "#,##0.00"
  # }

  # measure: Margin_usd {
  #   type: number
  #   label: "Margin USD"
  #   required_joins: [billing_unified_revenue]

  #   sql: ((${billing_unified_revenue.locked_final_billable_revenue_after_adj_usd_measure} – ${inv_cost}– ${Total_Data_External_adserver_cost_USD})) ;;
  #   value_format: "#,##0.00"
  # }

  measure:Media_Margin_Vendor_cost {
    type: number
    label: "Media Margin (w/o Vendor cost)"
    description: "in USD"
    sql: (${capped_revenue_usd} - ${fdw_cost})/${capped_revenue_usd} ;;
    value_format_name: percent_2
  }

  measure: monthly_budget_breakout {
    type: sum
    sql: case when ${dim_sfdb_opportunitylineitem.gross_billable__c}-${TABLE}.uncapped_revenue<0
      then 0 else ${dim_sfdb_opportunitylineitem.gross_billable__c}-${TABLE}.uncapped_revenue end;;
    filters: [date_key_in_timezone_date: "last month"]
    hidden: yes
    }



  measure: hybrid_video_completes {
    type: sum
    label: "Hybrid Video Completes"
    value_format: "#,##0"
    sql:
    CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
        THEN ${TABLE}.third_party_complete_events
      ELSE ${TABLE}.complete_events
    END ;;
  }

  measure: hybrid_impressions_delivered {
    type: sum
    label: "Hybrid Impressions Delivered"
    value_format: "#,##0"
    sql:
    CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
        THEN ${TABLE}.complete_events
      ELSE ${TABLE}.impressions
    END ;;
  }

  measure: hybrid_vcr_overall {
    type: number
    label: "Hybrid VCR Overall"
    value_format_name: "percent_2"
    sql:
    CASE
      WHEN ${complete_events} > 0
        THEN ${hybrid_video_completes} / NULLIF(${complete_events}, 0)
      ELSE ${hybrid_video_completes} / NULLIF(${hybrid_impressions_delivered}, 0)
    END ;;
  }

  measure: hybrid_video_completes_yesterday {
    type: sum
    label: "Hybrid Video Completes (Yesterday)"
    value_format: "#,##0"
    sql:
    CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
        THEN ${TABLE}.third_party_complete_events
      ELSE ${TABLE}.complete_events
    END ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: hybrid_impressions_delivered_yesterday {
    type: sum
    label: "Hybrid Impressions Delivered (Yesterday)"
    value_format: "#,##0"
    sql:
    CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
        THEN ${TABLE}.complete_events
      ELSE ${TABLE}.impressions
    END ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: complete_events_yesterday {
    type: sum
    label: "Complete Events (Yesterday)"
    value_format: "#,##0"
    sql: ${TABLE}.complete_events ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: hybrid_vcr_overall_yesterday {
    type: number
    label: "Hybrid VCR Overall (Yesterday)"
    value_format_name: "percent_2"
    sql:
    CASE
      WHEN ${complete_events_yesterday} > 0
        THEN ${hybrid_video_completes_yesterday} / NULLIF(${complete_events_yesterday}, 0)
      ELSE ${hybrid_video_completes_yesterday} / NULLIF(${hybrid_impressions_delivered_yesterday}, 0)
    END ;;
  }


  measure: hybrid_impressions_remaining {
    type: number
    label: "Hybrid Impressions Remaining"
    sql: ${dim_sfdb_opportunitylineitem.budgeted_units} - ${hybrid_impressions_delivered} ;;
  }


  measure: hybrid_impressions_remaining_yesterday {
    type: number
    label: "Hybrid Impressions Remaining Yesterday"
    sql: ${hybrid_impressions_remaining} + ${hybrid_impressions_delivered_yesterday} ;;
  }

  measure: hybrid_impressions_needed_yesterday {
    type: number
    value_format_name: "decimal_0"
    sql:
    GREATEST(
      ${hybrid_impressions_remaining_yesterday} / NULLIF(MAX(${dim_sfdb_opportunitylineitem.item_days_left}) + 1, 0),
      0
    )
    ;;
  }


  measure: avg_3_day_needed_imp {
    type: number
    label: "Avg 3 Day Needed Imp"
    sql: (${hybrid_impressions_needed_yesterday} * 3) ;;
    value_format: "#,##0.00"
  }

  measure: Last_3_day_impression_pacing {
    type: number
    value_format_name: "decimal_0"
    label: "Last 3 day impression pacing"
    sql: (${last_3_days_impressions_raw} /NULLIF(${avg_3_day_needed_imp},0)) ;;
  }

  measure: min_incremental_spend {
    type: number
    value_format_name: "decimal_0"
    label: "Min Incremental Spend"
    sql:
    (
      (${last_3_days_impressions_raw} / NULLIF(${avg_3_day_needed_imp}, 0)) * ${dim_sfdb_opportunitylineitem.total_booked_budget_meas}
    ) - ${dim_sfdb_opportunitylineitem.total_booked_budget_meas} ;;
  }

  measure: min_incremental_impression_amount {
    type: number
    value_format_name: "decimal_0"
    label: "Min Incremental Impression Amount"
    sql:
    (
      (${last_3_days_impressions_raw} / NULLIF(${avg_3_day_needed_imp}, 0)) * ${dim_sfdb_opportunitylineitem.budgeted_units}
    ) - ${dim_sfdb_opportunitylineitem.budgeted_units} ;;
  }

  measure: hybrid_clicks {
    type: number
    label: "Hybrid Clicks"
    sql:
    CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen')
        THEN ${clicks}
      ELSE ${third_party_clicks}
    END ;;
  }

  # measure: hybrid_clicks_yesterday {
  #   type: sum
  #   label: "Hybrid Clicks Yesterday"
  #   sql:
  #   CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen')
  #       THEN ${clicks}
  #     ELSE ${third_party_clicks}
  #   END ;;
  #   filters: [date_key_in_timezone_date: "yesterday"]
  # }



  measure: hybrid_impressions_pacing_to_date {
    type: number
    label: "Hybrid Impressions Pacing To Date"
    value_format_name: "percent_1"
    sql:
          ${hybrid_impressions_delivered}
          / (
            ( MAX(${dim_sfdb_opportunity.total_units__c}) / NULLIF(MAX(${dim_sfdb_opportunitylineitem.item_days}), 0) )
            *
            CASE
              WHEN MAX(${dim_sfdb_opportunitylineitem.days_remaining}) > 0
              THEN MAX(${dim_sfdb_opportunitylineitem.days_elapsed_today})
              ELSE MAX(${dim_sfdb_opportunitylineitem.item_days})
            END
          )
        ;;
  }


  measure: hybrid_impressions_pacing_yesterday {
    type: number
    label: "Hybrid Impressions Pacing Yesterday"
    sql: ${hybrid_impressions_delivered_yesterday} / NULLIF(${hybrid_impressions_needed_yesterday}, 0) ;;
    value_format: "0.0%"
  }

  measure: hybrid_CTR_overall {
    type: number
    label: "Hybrid CTR Overall"
    sql:
    SUM(
      CASE
        WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen')
          THEN ${TABLE}.clicks
        ELSE ${TABLE}.third_party_clicks
      END
    )
    /
    NULLIF(
      SUM(
        CASE
          WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
            THEN ${TABLE}.complete_events
          ELSE ${TABLE}.impressions
        END
      ), 0
    ) ;;
    value_format: "0.0%"
  }

    measure: hybrid_CTR_yesterday {
      type: number
      label: "Hybrid CTR Yesterday"
      value_format: "0.0%"
      sql:
          SUM(
            CASE
              -- Filter the Clicks to only include yesterday's data
              WHEN ${date_key_in_timezone_date} = DATE_TRUNC('day', CURRENT_DATE() - INTERVAL '1 day')
              THEN
                (CASE
                   WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen')
                     THEN ${TABLE}.clicks
                     ELSE ${TABLE}.third_party_clicks
                 END)
              ELSE NULL
            END
          )
          /
          NULLIF(
            SUM(
              CASE
                -- Filter the Impressions/Events to only include yesterday's data
                WHEN ${date_key_in_timezone_date} = DATE_TRUNC('day', CURRENT_DATE() - INTERVAL '1 day')
                THEN
                  (CASE
                     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
                       THEN ${TABLE}.complete_events
                       ELSE ${TABLE}.impressions
                   END)
                ELSE NULL
              END
            ), 0
          )
        ;;
    }

# measure: hybrid_CTR_yesterday {
#   type: number
#   label: "Hybrid CTR Yesterday"
#   value_format: "0.0%"
#   sql:
#     SUM(
#       CASE
#         WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
#           THEN ${TABLE}.clicks
#         ELSE ${TABLE}.third_party_clicks
#       END
#     )
#     /
#     NULLIF(
#       SUM(
#         CASE
#           WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee','Nexxen')
#             THEN ${TABLE}.complete_events
#           ELSE ${TABLE}.impressions
#         END
#       ),
#       0
#     )
#     ;;
#   filters: [date_key_in_timezone_date: "yesterday"]
# }



  # measure: hybrid_CTR_overall {
  #   type: number
  #   label: "Hybrid CTR Overall"
  #   sql: ${hybrid_clicks} / NULLIF(${hybrid_impressions_delivered}, 0) ;;
  #   value_format: "0.0%"
  # }

  measure: Delivered_Spend {
    type: sum
    sql: ${TABLE}.delivery_units/1000*${dim_sfdb_opportunitylineitem.rate__c};;
    value_format: "$#,##0.00"
  }


  measure: daily_units_needed {
    description: "The number of units required daily to stay on track."
    type: average
    value_format: "#,##0"
    sql: ${TABLE}.daily_units_needed;;
  }

  measure: daily_units_needed_t1 {
    type: sum
    sql: ${dim_sfdb_opportunitylineitem.daily_units_needed_comp_2}-${TABLE}.delivery_units/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) ;;
    hidden: yes
  }


  measure: is_delivered_in_full {
    type: string
    label: "Is Delivered in Full"
    description: "Returns 'Yes' if the campaign met or exceeded booked goals. 'No' indicates under-delivery."
    sql: CASE
           WHEN MAX(${dim_sfdb_opportunitylineitem.price_type_name__c}) = 'CPM'
                AND ${delivered_units} >= MAX(${dim_sfdb_opportunitylineitem.units__c}) THEN 'Yes'
           WHEN MAX(${dim_sfdb_opportunitylineitem.price_type_name__c}) = 'dCPM'
                AND ${Delivered_Spend} >= MAX(${dim_sfdb_opportunitylineitem.gross_billable__c}) THEN 'Yes'
           ELSE 'No'
         END ;;
  }

  measure: GP {
    type: number
    sql: ${capped_revenue}-${cogs} ;;
    value_format: "$#,##0.00"
  }

  measure: out_of_geo_rate {
    type: sum
    sql: ${TABLE}.out_of_geo_rate ;;
    #hidden: yes
  }

  measure: brand_safety_rate {
    type: sum
    sql: ${TABLE}.brand_safety_rate ;;
    #hidden: yes
  }

  measure: third_party_fraud_SIVT_incidents {
    type: sum
    label: "3P fraud/sivt incidents"
    sql: ${TABLE}.third_party_Fraud_SIVTIncidents ;;
    #hidden: yes
  }

  measure: actions {
    type: sum
    label: "1P Conversions"
    sql: ${TABLE}.actions ;;
    value_format: "#,##0"
  }

  measure: yesterday_actions {
    type: sum
    sql: ${TABLE}.actions ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
  }

  measure: eCPA_3P {
    label: "eCPA 3P"
    type: number
    sql: ${capped_revenue}/nullif(${3p_total_conversions},0) ;;
    value_format: "#,##0.00"
  }

  measure: yesterday_eCPA_3P {
    label: "eCPA 3P"
    type: number
    sql: ${yesterday_capped_revenue}/nullif(${yesterday_3p_total_conversions},0) ;;
    value_format: "#,##0.00"
  }

  measure: eCPA_1P {
    label: "eCPA 1P"
    type: number
    sql: ${capped_revenue}/nullif(${actions},0) ;;
    value_format: "#,##0.00"
  }

  measure: yesterday_eCPA_1P {
    type: number
    sql: ${yesterday_capped_revenue}/nullif(${yesterday_actions},0) ;;
    value_format: "#,##0.00"
  }

  measure: 1P_CVR {
    type: number
    sql: ${actions}/nullif(${impressions},0) ;;
    value_format: "0.00%"
  }

  measure: yesterday_1P_CVR {
    type: number
    sql: ${yesterday_actions}/nullif(${Last_day_1p_impressions},0) ;;
    value_format: "0.00%"
  }

  measure: 3P_CVR {
    type: number
    sql: ${3p_total_conversions}/nullif(${third_party_impressions},0) ;;
    value_format: "0.00%"
  }

  measure: yesterday_3P_CVR {
    type: number
    sql: ${yesterday_3p_total_conversions}/nullif(${Last_day_3p_impressions},0) ;;
    value_format: "0.00%"
    hidden: yes
  }

  measure:  yesterday_3p_total_conversions {
    label: "Yesterday 3P Conversions"
    type: sum
    sql:${TABLE}.third_party_total_conversions  ;;
    value_format: "#,##0"
    filters: [date_key_in_timezone_date: "yesterday"]
    hidden: yes
  }

  measure: third_party_media_measured_impressions {
    type: sum
    label: "3P media measured impressions"
    sql: ${TABLE}.third_party_media_measured_impressions ;;
    value_format: "#,##0"
  }

  measure: monthly_budget_breakdown_v1 {
    type: sum
    sql: ${dim_sfdb_opportunitylineitem.monthy_budget_breakout_temp} ;;
    hidden: yes
  }

  measure: remaining_budget {
    type: number
    label: "Remaining Budget"
    sql: ${dim_sfdb_opportunitylineitem.total_booked_budget_meas}-${dim_dsp_netsuite_invoice.passed_bill_amount_measure};;
  }

  measure: revenue_risk {
    type: number
    sql: case when ${yesterday_pacing}>1 then 0 else ${remaining_budget}*(1-${yesterday_pacing}) end;;
  }

  measure: completion_discrepancy {
    type: number
    sql: (${third_party_complete_events}-${complete_events})/nullif(${complete_events},0) ;;
    value_format: "0.00%"
  }

  measure: dsp_padding {
    type: number
    sql: case when ((1/100) + case when round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) <
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),3) then
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) + (1/100) else
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) end) < 0
                  then 0 else
                  (1/100) + case when round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) <
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),3) then
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) + (1/100) else
                   round((${third_party_impressions}-${impressions})/NULLIF(${impressions},0),2) end
                  end;;
  }

  measure: count {
    type: count
    hidden: yes
  }

  measure: shopping_cart_value {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.shopping_cart_value ;;
  }

  measure: shopping_cart_value_cta {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.shopping_cart_value_cta ;;
  }

  measure: shopping_cart_value_vta {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.shopping_cart_value_vta ;;
  }

  measure: fdw_cost {
    type: sum
    description: "FDW US"
    label: "FDW Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.fdw_cost ;;
  }

  measure: yesterday_fdw_cost {
    type: sum
    description: "FDW US"
    label: "Yesterday FDW Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.fdw_cost ;;
    filters: [date_key_in_timezone_date: "yesterday"]
  }


  measure: Yesterday_Media_Margin {
    type: number
    label: "Yesterday's Media Margin"
    sql: (${yesterday_uncapped_revenue} - ${yesterday_fdw_cost})/ ${yesterday_uncapped_revenue} ;;
    value_format: "0.00%"
  }



  measure: fraud_rate {
    type: number
    sql:  CASE WHEN ${3p_impressions_analyzed}!=0 AND ${3p_impressions_analyzed} IS NOT NULL
            THEN ${third_party_fraud_SIVT_incidents}/${3p_impressions_analyzed} END;;
    value_format: "0.00%"
  }

  measure: delivered_spend_100_view_impr {
    hidden: yes
    label: "Delivered Spend (100% viewable impressions)"
    type: number
    sql: (${3p_iv_ia_billable_impressions}*${dim_sfdb_opportunitylineitem.booked_rate})/1000 ;;
  }

  measure: vendor_cost {
    type: sum
    label: "Vendor Cost"
    sql: ${TABLE}.vendor_cost ;;
    value_format: "#,##0.00"
  }

  measure: full_costs_fdw_cost {
    type: number
    label: "Full Costs FDW Cost"
    sql: ${vendor_cost} + ${fdw_cost} ;;
    value_format: "#,##0.00"
  }

  measure:  net_revenue_fdw_cost_w_o_vendor_cost {
    type: number
    label: "Net Revenue (FDW Cost-w/o vendor cost)"
    description: "in USD"
    sql: ${capped_revenue_usd} - ${fdw_cost} ;;
    value_format: "#,##0.00"
  }

  # measure: Net_evenue_FDW_cost {
  #   type: number
  #   label: "Net Revenue (FDW cost)"
  #   sql: ${dim_dsp_netsuite_invoice.Amount_Functional_Currency}-${full_costs_fdw_cost} ;;
  #   value_format: "#,##0.00"
  # }

  measure: net_revenue_capped_rev_fdw_cost {
    type: number
    label: "Net Revenue (Capped Rev-Full Costs)"
    description: "in USD"
    sql: ${capped_revenue_usd} - ${full_costs_fdw_cost} ;;
    value_format: "#,##0.00"
  }

  measure: media_margin_overall {
    type: number
    label: "Media Margin (overall)"
    description: "in USD"
    sql: (${capped_revenue_usd} - (${fdw_cost}+${vendor_cost}))/${capped_revenue};;
    value_format: "0.00%"
  }

  measure: TPCA {
    type: sum
    label: "TPCA"
    description: "Turn Third Party Cost"
    sql: CASE WHEN ${date_key_in_timezone_date} >= '2025-10-01' THEN ${TABLE}.TPCA ELSE 0 END ;;
    value_format: "$#,##0.00"
  }

  measure: FPCA {
    type: sum
    label: "FPCA"
    description: "Turn First Party Cost"
     sql: CASE WHEN ${date_key_in_timezone_date} >= '2025-10-01' THEN ${TABLE}.FPCA ELSE 0 END ;;
    value_format: "$#,##0.00"
  }

  measure: audience_data_cost {
    type: sum
    label: "Audience Data Cost"
    sql: CASE WHEN ${date_key_in_timezone_date} >= '2025-10-01' THEN ${TABLE}.audience_data_cost ELSE 0 END ;;
    value_format: "$#,##0.00"
  }

  measure: content_data_cost {
    type: sum
    label: "Content Data Cost"
    sql: CASE WHEN ${date_key_in_timezone_date} >= '2025-10-01' THEN ${TABLE}.content_data_cost ELSE 0 END ;;
    value_format: "$#,##0.00"
  }

  measure: data_cost_adjustment_calculated {
    type: sum
    label: "Raw Net Data Cost"
    description: "Data Cost after rev/share (DCOM Adjusted Net Revenue)"
    sql: CASE WHEN ${date_key_in_timezone_date} >= '2025-10-01' THEN ${TABLE}.data_cost_adjustment_calculated ELSE 0 END ;;
    value_format: "$#,##0.00"
  }


  # ==========================================
  # Margin Fields - Measures
  # ==========================================

  # measure: net_revenue_final_billable_usd {
  #   type: number
  #   label: "Net Revenue (Final Billable) USD"
  #   description: "Net Revenue in USD calculated based on Final Billable Revenue in USD (including Billing adjustments)"
  #   value_format_name: usd
  #   sql: ${billing_unified_revenue.locked_final_billable_revenue_after_adj_usd_measure} - ${inventory_cost} - ${data_cost_adjustment_calculated} ;;
  # }

  measure: net_revenue_capped_usd {
    type: number
    label: "Net Revenue (Capped) USD"
    description: "Net Revenue in USD calculated based on Capped Revenue in USD"
    value_format_name: usd
    sql: ${capped_revenue_usd} - ${inventory_cost} - ${data_cost_adjustment_calculated} ;;
  }

  measure: margin_percent_capped {
    type: number
    label: "Margin % Capped"
    description: "The profit margin calculated using the capped revenue amount"
    value_format_name: percent_2
    # Using NULLIF to prevent division by zero errors in SQL
    sql: 1.0 * ${net_revenue_capped_usd} / NULLIF(${capped_revenue_usd}, 0) ;;
  }

  # measure: margin_percent_final {
  #   type: number
  #   label: "Margin % Final"
  #   description: "The profit margin calculated using the final billable revenue amount"
  #   value_format_name: percent_2
  #   # Using NULLIF to prevent division by zero errors in SQL
  #   sql: 1.0 * ${net_revenue_final_billable_usd} / NULLIF(${billing_unified_revenue.locked_final_billable_revenue_after_adj_usd_measure}, 0) ;;
  # }

  measure: revshare_data_cost {
    type: number
    label: "RevShare Data Cost"
    description: "Amount of revenue that is shared with a partner/data provider as part of a revenue-sharing agreement."
    value_format_name: usd
    sql: (${TPCA}+${FPCA}+${audience_data_cost}+${content_data_cost})-${data_cost_adjustment_calculated} ;;
  }





  # measure: primary_kpi_result_old {
  #   label: "Primary KPI Result"
  #   type: number
  #   sql: ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN ${CTR_1P}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN ${VCR_1P}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN ${1P_CVR}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${1P_CVR}
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN ${eCPA_1P}
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${pacing}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${uncapped_revenue}/${actions}
  #             ELSE 0 END,2);;
  # }

  # measure: primary_kpi_result {
  #   label: "Primary KPI Result"
  #   type: number
  #   sql: ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN ${CTR_1P}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN ${VCR_3P}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN ${1P_CVR}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${1P_CVR}
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN ${eCPA_1P}
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${pacing}*100
  #             WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${uncapped_revenue}/${actions}
  #             ELSE 0 END,2);;
  # }


  # measure: primary_kpi_result {
  #   label: "Primary KPI Result"
  #   type: number
  #   sql: ROUND(CASE
  #           WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN
  #             CASE
  #               WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${CTR_1P}
  #               ELSE ${CTR_3P}
  #             END * 100
  #     -- Completion Rate (VCR) Logic
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${VCR_1P}
  #     -- Check 3P, fallback to 1P if 3P is NULL
  #     ELSE COALESCE(${VCR_3P}, ${VCR_1P})
  #     END * 100
  #     -- CVR / Site Visit Rate Logic
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${1P_CVR}
  #     ELSE ${3P_CVR}
  #     END * 100
  #     -- eCPA Logic (Note: No *100)
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('e ‘A', 'Cost Per Visit') THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${eCPA_1P}
  #     ELSE ${eCPA_3P}
  #     END
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${1P_CVR}
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${pacing}*100
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${uncapped_revenue}/${actions}

  #     ELSE 0
  #     END,2);;
  # }

  measure: primary_kpi_result {
    label: "Primary KPI Result"
    type: number
    sql: ROUND(CASE
            WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN
              CASE
                WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${CTR_1P}
                ELSE COALESCE(NULLIF(${CTR_3P}, 0), ${CTR_1P})
              END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${VCR_1P}
      ELSE COALESCE(NULLIF(${VCR_3P}, 0), ${VCR_1P})
      END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${1P_CVR}
      ELSE COALESCE(NULLIF(${3P_CVR}, 0), ${1P_CVR})
      END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${eCPA_1P}
      ELSE COALESCE(NULLIF(${eCPA_3P}, 0), ${eCPA_1P})
      END
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${1P_CVR}
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${pacing}*100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${uncapped_revenue}/${actions}
      ELSE 0
      END,2);;
  }


  # measure: yesterday_primary_kpi_result {
  #   label: "Yesterday Primary KPI Result"
  #   type: number
  #   sql: ROUND(CASE
  #           WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN
  #             CASE
  #               WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${Last_day_1P_CTR}
  #               ELSE ${Last_day_3P_CTR}
  #             END * 100
  #     -- Completion Rate (VCR) Logic
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${Last_day_1P_VCR}
  #     -- Check 3P, fallback to 1P if 3P is NULL
  #     ELSE COALESCE(${Last_day_3P_VCR}, ${Last_day_1P_VCR})
  #     END * 100
  #     -- CVR / Site Visit Rate Logic
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${yesterday_1P_CVR}
  #     ELSE ${yesterday_3P_CVR}
  #     END * 100
  #     -- eCPA Logic (Note: No *100)
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('e ‘A', 'Cost Per Visit') THEN
  #     CASE
  #     WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${yesterday_eCPA_1P}
  #     ELSE ${yesterday_eCPA_3P}
  #     END
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${yesterday_1P_CVR}
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${yesterday_pacing}*100
  #     WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${yesterday_uncapped_revenue}/${yesterday_actions}

  #     ELSE 0
  #     END,2);;
  # }

  measure: yesterday_primary_kpi_result {
    label: "Yesterday Primary KPI Result"
    type: number
    sql: ROUND(CASE
            WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN
              CASE
                WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${Last_day_1P_CTR}
                ELSE ${Last_day_3P_CTR}
              END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${Last_day_1P_VCR}
      ELSE COALESCE(${Last_day_3P_VCR}, ${Last_day_1P_VCR})
      END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${yesterday_1P_CVR}
      ELSE ${yesterday_3P_CVR}
      END * 100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN
      CASE
      WHEN ${dim_sfdb_opportunitylineitem.reporting__c} IN ('Amobee', 'Nexxen') THEN ${yesterday_eCPA_1P}
      ELSE ${yesterday_eCPA_3P}
      END
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${yesterday_1P_CVR}
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${yesterday_pacing}*100
      WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${yesterday_uncapped_revenue}/${yesterday_actions}
      ELSE 0
      END,2);;
  }


  # measure: yesterday_primary_kpi_result {
  #   label: "Yesterday Primary KPI Result"
  #   type: number
  #   sql:
  #           ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR'
  #                   THEN ${yesterday_CTR_1P}*100

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate'
  #                   THEN (${Last_day_1p_complete_events} / NULLIF(${Last_day_1p_impressions}, 0)) * 100

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate')
  #                   THEN ${yesterday_1P_CVR} * 100

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%'
  #                   THEN ${yesterday_1P_CVR}

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit')
  #                   THEN ${yesterday_eCPA_1P}

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%'
  #                   THEN ${yesterday_pacing} * 100

  #                   WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%'
  #                   THEN ${yesterday_uncapped_revenue} / NULLIF(${yesterday_actions}, 0)
  #             ELSE 0 END,2)

  #           ;;
  # }




  measure: primary_kpi_check {
    label: "KPI Check"
    type: number
    sql: CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%best%' OR
    (${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CTR', 'Completion Rate', 'CVR', 'Site Visit Rate', 'Engagement  Rate', 'In Audience %', 'in View %', 'ROAS') AND ${primary_kpi_result}>${dim_sfdb_opportunitylineitem.primary_kpi_metric_clean}) OR
    (${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit',  'Cost Per View (IV or Complete)') AND ${primary_kpi_result}<${dim_sfdb_opportunitylineitem.primary_kpi_metric_clean}) OR
    (${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} ILIKE '%pacing%' AND ${primary_kpi_result}>${dim_sfdb_opportunitylineitem.primary_kpi_metric_clean}) OR
    (${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' AND ${primary_kpi_result}>(${dim_sfdb_opportunitylineitem.primary_kpi_metric_clean}/100.0))
    THEN 1
    ELSE 0 END;;
  }

  measure: secondary_kpi_result {
    label: "Secondary KPI Result"
    type: number
    sql: ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c}='CTR' THEN ${CTR_1P}*100
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c}='Completion Rate' THEN ${VCR_1P}*100
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN ${1P_CVR}*100
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.secondary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${1P_CVR}
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN ${eCPA_1P}
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.secondary_kpi_metric__c}) LIKE '%pacing%' THEN ${pacing}*100
              WHEN ${dim_sfdb_opportunitylineitem.secondary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.secondary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${uncapped_revenue}/${actions}
              ELSE 0 END,2);;
  }

  #--------------------------------------------------pop-------------------------------------------------------
  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;


  }
  dimension:  date_for_html {
    type: date
    view_label: "PoP"
    sql: ${current_date_range} ;;
    html:
    <ul>
         <li> value: {{ rendered_value }} </li>
    </ul> ;;

  }



  parameter: compare_to {
    view_label: "PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "Compare To:"
    type: unquoted

    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }

    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }

    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }

    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    default_value: "Period"
  }

  parameter: choose_breakdown {
    label: "Choose Grouping"
    view_label: "PoP"
    type: unquoted
    default_value: "day_of_month"
    allowed_value: {label:"daily" value:"day_of_month"}
    allowed_value: {label:"monthly" value: "month_name"}
  }


## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##
  dimension: sort_by1 {
    hidden: yes
    type: number
    sql:
        {% if choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_num}
        {% elsif choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'year' %} ${date_in_period_year}}
        {% elsif choose_breakdown._parameter_value == 'quarter' %} ${date_in_period_quarter}
        {% else %}NULL{% endif %} ;;
  }
  dimension: sort_by2 {
    hidden: yes
    type: string
    sql:
        {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
        {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month_num}
        {% else %}NULL{% endif %} ;;
  }
  parameter: choose_comparison {
    label: "Choose Comparison (Pivot)"
    view_label: "PoP"
    description: "Defines whether the comparison will be monthly or yearly"
    type: unquoted
    default_value: "month"
    allowed_value: {value: "year" }
    allowed_value: {value: "month"}

  }
  dimension: pop_pivot {
    view_label: "PoP"
    description: "Takes the 'choose comparison' parameter and adds a suitable parameter to it"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2 # Important
    sql:
        {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
        {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month}
        {% else %}NULL{% endif %} ;;
  }

  dimension: pop_row  {
    view_label: "PoP"
    description: "Takes the 'choose breakdown' parameter and adds a suitable parameter to it"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by1 # Important
    sql:
        {% if choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_name}
        {% else %}'2022-01-01'{% endif %} ;;
  }

  dimension: days_in_period {
    hidden:  yes
    view_label: "PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), CAST({% date_end current_date_range %} AS TIMESTAMP)) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
           -- TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            TIMESTAMPADD(DAY, -${days_in_period}, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            TIMESTAMPADD(DAY, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)))
            {% endif %};;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${date_key_in_timezone_raw}) + 1
            WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${date_key_in_timezone_raw}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    view_label: "PoP"
    type: yesno
    sql:  (EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE())
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
                EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
    description: "Filters the data to be only month to date"
  }

  dimension: qtd_only {
    group_label: "To-Date Filters"
    label: "QTD"
    view_label: "PoP"
    description: "Filters the data to be only quarter to date"
    type: yesno
    sql: ${date_in_period_date} > TO_DATE(DATE_TRUNC('quarter', CURRENT_DATE())) AND ${date_in_period_date} <
      (TO_DATE(DATEADD('month', 3, CAST(DATE_TRUNC('quarter', CAST(DATE_TRUNC('quarter', CURRENT_DATE()) AS DATE)) AS DATE)))) ;;
  }

  dimension: ytd_only {
    group_label: "To-Date Filters"
    label: "YTD"
    description: "Filters the data to be only year to date"
    view_label: "PoP"
    type: yesno
    sql:  (EXTRACT(DOY FROM ${date_in_period_date}) < EXTRACT(DOY FROM GETDATE())
                    OR
                (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
                    OR
                (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
                EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %}
                THEN 1
                WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

  ## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##


  dimension: wtd_only {hidden:yes}


  ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
    view_label: "PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      week,
      month,
      quarter,
      month_name,
      month_num,
      year]

  }


  dimension: period {
    view_label: "PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    hidden: yes
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end}
                THEN 'Last {% parameter compare_to %}'
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }


  ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  dimension: period_filtered_measures {
    hidden: yes
    description: "We are just using this for the filtered measures"
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %} THEN 'this'
                WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  # Filtered measures

  measure: current_period_cost {
    view_label: "PoP"
    type: sum
    description: "The current period's cost"
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_cost{
    view_label: "PoP"
    type: sum
    description: "The previous period's cost"
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_pacing {
    view_label: "PoP"
    type: average
    description: "The current period's pacing"
    sql: ${TABLE}.pacing ;;
    value_format: "0.00\%"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_pacing{
    view_label: "PoP"
    type: average
    description: "The previous period's pacing"
    sql: ${TABLE}.pacing ;;
    value_format: "0.00\%"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_capped_revenue {
    view_label: "PoP"
    type: sum
    description: "The current period's capped revenue"
    sql: ${TABLE}.capped_revenue;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_capped_revenue{
    view_label: "PoP"
    type: sum
    description: "The previous period's capped revenue"
    sql:  ${TABLE}.capped_revenue;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_uncapped_revenue {
    view_label: "PoP"
    type: sum
    description: "The current period's uncapped revenue"
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_uncapped_revenue{
    view_label: "PoP"
    type: sum
    description: "The previous period's uncapped revenue"
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "last"]
  }

  measure: cost_pop_change {
    view_label: "PoP"
    label: "Total cost period-over-period % change"
    description: "Cost change from previous period to current"
    type: number
    sql: CASE WHEN ${current_period_cost} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_cost} / NULLIF(${previous_period_cost} ,0)) - 1 END ;;
    value_format_name: percent_2

    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }


  measure: current_period_impressions {
    view_label: "PoP"
    type: sum
    description: "Current period impressions"
    sql:  ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: impressions_pop_change {
    view_label: "PoP"
    label: "Impressions Change"
    type: number
    sql: ${current_period_impressions} - ${previous_period_impressions} ;;
    value_format: "+#,##0;-#,##0" # Adds a + sign for positive numbers
  }

  measure: impressions_pop_change_percent {
    view_label: "PoP"
    label: "Impressions Change %"
    type: number
    sql: 1.0 * (${current_period_impressions} - ${previous_period_impressions}) / NULLIF(${previous_period_impressions},0) ;;
    value_format: "0.00%"
  }

  measure: current_period_clicks {
    view_label: "PoP"
    type: sum
    description: "Current period clicks"
    sql: ${TABLE}.clicks  ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_clicks {
    view_label: "PoP"
    type: sum
    description: "Previous period clicks"
    sql: ${TABLE}.clicks  ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
  }


  measure: current_period_ctr {
    view_label: "PoP"
    type: number
    description: "Current period CTR"
    sql:  ${current_period_clicks}/nullif(${current_period_impressions},0);;
    value_format: "0.00%"
    # filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_ctr {
    view_label: "PoP"
    type: number
    description: "Previous period CTR"
    sql:  ${previous_period_clicks}/nullif(${previous_period_impressions},0);;
    value_format: "0.00%"
    #filters: [period_filtered_measures: "last"]
  }

  measure: current_period_primary_kpi_result {
    view_label: "PoP"
    type: number
    description: "Current period Primary KPI Result"
    sql:  ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN ${current_period_ctr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN ${current_period_vcr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN ${current_period_cvr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${current_period_cvr}
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN ${current_period_eCPA}
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${current_period_pacing}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${current_period_uncapped_revenue}/${current_period_actions}
              ELSE 0 END,2);;
  }

  measure: previous_period_primary_kpi_result {
    view_label: "PoP"
    type: number
    description: "Previous period Primary KPI Result"
    sql:  ROUND(CASE WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='CTR' THEN ${previous_period_ctr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Completion Rate' THEN ${previous_period_vcr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('CVR', 'Site Visit Rate') THEN ${previous_period_cvr}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%Visit Rate: .08%' THEN ${previous_period_cvr}
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c} IN ('eCPA', 'Cost Per Visit') THEN ${previous_period_eCPA}
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND LOWER(${dim_sfdb_opportunitylineitem.primary_kpi_metric__c}) LIKE '%pacing%' THEN ${previous_period_pacing}*100
              WHEN ${dim_sfdb_opportunitylineitem.primary_kpi__c}='Custom' AND ${dim_sfdb_opportunitylineitem.primary_kpi_metric__c} LIKE '%CPBI $8%' THEN ${previous_period_uncapped_revenue}/${previous_period_actions}
              ELSE 0 END,2);;
  }

  measure: previous_period_impressions{
    view_label: "PoP"
    type: sum
    description: "Previous period impressions"
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_complete_events {
    view_label: "PoP"
    type: sum
    description: "Current period completes"
    sql:   ${TABLE}.complete_events ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_complete_events {
    view_label: "PoP"
    type: sum
    description: "Previous period completes"
    sql:   ${TABLE}.complete_events ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_actions {
    view_label: "PoP"
    type: sum
    description: "Current period actions"
    sql:   ${TABLE}.actions;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_actions {
    view_label: "PoP"
    type: sum
    description: "Previous period actions"
    sql:   ${TABLE}.actions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: current_period_vcr {
    view_label: "PoP"
    type: number
    description: "Current period VCR"
    sql:  IFNULL(${current_period_complete_events}/nullif(${current_period_impressions},0),0);;
    value_format: "0.00%"
    # filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_vcr {
    view_label: "PoP"
    type: number
    description: "Previous period VCR"
    sql:  IFNULL(${previous_period_complete_events}/nullif(${previous_period_impressions},0),0);;
    value_format: "0.00%"
    #filters: [period_filtered_measures: "last"]
  }

  measure: current_period_cvr {
    view_label: "PoP"
    type: number
    description: "Current period CVR"
    sql:  IFNULL(${current_period_actions}/nullif(${current_period_impressions},0),0);;
    value_format: "0.00%"
  }

  measure: previous_period_cvr {
    view_label: "PoP"
    type: number
    description: "Previous period CVR"
    sql:  IFNULL(${previous_period_actions}/nullif(${previous_period_impressions},0),0);;
    value_format: "0.00%"
  }

  measure: current_period_eCPA {
    view_label: "PoP"
    type: number
    description: "Current period eCPA"
    sql:  IFNULL(${current_period_capped_revenue}/nullif(${current_period_actions},0),0);;
    value_format: "0.00%"
  }

  measure: previous_period_eCPA {
    view_label: "PoP"
    type: number
    description: "Previous period eCPA"
    sql:  IFNULL(${previous_period_capped_revenue}/nullif(${previous_period_actions},0),0);;
    value_format: "0.00%"
  }



#---------------------------------------------NCD Specifics---------------------------------------------------

  # measure: daily_pacing_msd_fact {
  #   type: average
  #   label: "NCD Daily Pacing"
  #   value_format: "#,##0"
  #   sql:  NULLIF(${dim_sfdb_opportunitylineitem_pacing.daily_pacing_dim},0) ;;
  # }

  measure: ncd_clicks {
    type: sum
    value_format: "#,##0"
    label: "NCD Clicks"
    sql: CASE WHEN ${dim_dsp_device_type.device_type_category}='CTV' THEN 0 ELSE ${TABLE}.clicks END;;
  }

  measure: ncd_ctr {
    type: number
    value_format: "0.00%"
    sql: IFNULL(${ncd_clicks}/NULLIF(${impressions},0),0) ;;
  }

measure: total_pacing {
  type: average
  label: "Total Pacing - NCD"
  sql: ${ncd_pacing.pacing_dim} ;;
  value_format: "0.0%"
}

  measure: html_kpi_pacing {
    type: count
    hidden: yes
    html:
    <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Pacing
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ total_pacing._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_pacing_demo {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Pacing
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          100%
        </div>
      </div>;;
  }

  measure: html_kpi_delivered_units {
    type: count
    # hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Delivered Units
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ delivered_units._rendered_value }}
        </div>
      </div>;;
  }

  measure: delivered_units_demo {
    type: number
    hidden: yes
    value_format: "#,##0"
    sql:${delivered_units}  *10.2;;
  }

  measure: html_kpi_impressions_demo {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Delivered Units
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ delivered_units_demo._rendered_value }}
        </div>
      </div>;;
  }


  measure: html_kpi_vcr {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        VCR
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ VCR_1P._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_delivered_spend {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Delivered Spend
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ Delivered_Spend._rendered_value }}
        </div>
      </div>;;
  }

  measure: delivered_spend_demo {
    type: number
    hidden: yes
    value_format: "$#,##0.00"
    sql:${Delivered_Spend}  *11.7;;
  }

  measure: html_kpi_delivered_spend_demo {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Delivered Spend
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ delivered_spend_demo._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_clicks {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Clicks
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ ncd_clicks._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_complete_events {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Complete Events
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ complete_events._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_ctr {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        CTR
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ ncd_ctr._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_impr_comp_event {
    type: number
    hidden: yes
    #value_format: "#,##0,,,\"B\""
    sql: ${impressions} ;;
    label: "Impressions"
    html: {{ rendered_value }} | VCR: {{VCR_1P._rendered_value }}  ;;
  }

  measure: html_kpi_shopping_cart_value {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Cart Value
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ shopping_cart_value._rendered_value }}
        </div>
      </div>;;
  }

  measure: html_kpi_shopping_cart_value_cta {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Cart Value CT
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ shopping_cart_value_cta._rendered_value }}
        </div>
      </div>;;
  }


  measure: html_kpi_shopping_cart_value_vta {
    type: count
    hidden: yes
    html:
     <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
        Cart Value VT
        <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
          {{ shopping_cart_value_vta._rendered_value }}
        </div>
      </div>;;
  }


}
