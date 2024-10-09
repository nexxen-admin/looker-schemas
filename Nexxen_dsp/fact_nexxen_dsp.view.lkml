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
    label: "Date in Timezone"
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
    type: average
    value_format: "0.00\%"
    sql: ${TABLE}.pacing ;;
  }

  measure: yesterday_pacing {
    type: average
    value_format: "0.00\%"
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

  measure: prev_month_uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "$#,##0.00"
    filters: [date_key_in_timezone_date: "last month"]
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
    sql: IFNULL(${clicks}/nullif(${impressions},0),0) ;;
  }

  measure: CTR_3P {
    type: number
    value_format: "0.00%"
    sql: ${third_party_clicks}/nullif(${third_party_impressions},0) ;;
  }

  measure: VCR_1P {
    type: number
    sql: IFNULL(${complete_events}/nullif(${impressions},0),0) ;;
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

  measure: media_margin {
    type: number
    sql: (${capped_revenue}-${cost})/nullif(${capped_revenue},0) ;;
  }

  measure: monthly_budget_breakout {
    type: sum
    sql: case when ${dim_sfdb_opportunitylineitem.gross_billable__c}-${TABLE}.uncapped_revenue<0
      then 0 else ${dim_sfdb_opportunitylineitem.gross_billable__c}-${TABLE}.uncapped_revenue end;;
    filters: [date_key_in_timezone_date: "last month"]
    hidden: yes
    #incorrect - might need to be calculated in the back
    }

  measure: Delivered_Spend {
    type: sum
    sql: ${TABLE}.impressions/1000*${dim_sfdb_opportunitylineitem.rate__c};;
    value_format: "$#,##0.00"
  }


  measure: daily_units_needed {
    type: sum
    sql: case when ${dim_sfdb_opportunitylineitem.price_type_name__c} in ('dCPM', 'CPR') then
    (${dim_sfdb_opportunitylineitem.gross_billable__c} - ${TABLE}.delivery_units)/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) else
    (${dim_sfdb_opportunitylineitem.units__c}-${TABLE}.delivery_units)/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) end;;
    hidden: yes
    #incorrect - might need to be calculated in the back
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
    sql: ${TABLE}.actions ;;
    value_format: "#,##0"
  }

  measure: eCPA {
    type: number
    sql: ${capped_revenue}/nullif(${3p_total_conversions},0) ;;
    value_format: "#,##0.00"
  }

  measure: 1P_CVR {
    type: number
    sql: ${actions}/nullif(${impressions},0) ;;
    value_format: "#,##0.0000"
  }

  measure: 3P_CVR {
    type: number
    sql: ${actions}/nullif(${third_party_impressions},0) ;;
    value_format: "#,##0.0000"
  }

  dimension: cap_msd {
    type: number
    sql: ${dim_sfdb_opportunitylineitem.units__c}/
    (datediff('day',${dim_dsp_package_budget_schedule.start_date_in_timezone},${dim_dsp_package_budget_schedule.end_date_in_timezone})+1) ;;
    #hidden: yes
  }

  measure: pacing_msd {
    type: sum
    value_format: "0.00\%"
    sql: -- case when ${dim_sfdb_opportunitylineitem.price_type_name__c} = 'CPM' then
        ${dim_sfdb_opportunitylineitem.msd_pacing}*100;;
              #when ${dim_sfdb_opportunitylineitem.price_type_name__c} = 'CPC' then ${TABLE}.clicks/sum(${cap_msd}*100
              #when ${dim_sfdb_opportunitylineitem.price_type_name__c} = 'dCPM' then ${TABLE}.cost/${cap_msd}*100 end;;
  }

  measure: count {
    type: count
    hidden: yes
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

  measure: previous_period_impressions{
    view_label: "PoP"
    type: sum
    description: "Previous period impressions"
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: daily_pacing_msd_fact {
    type: average
    label: "MSD Daily Pacing"
    value_format: "0.00%"
    sql:  NULLIF(${dim_sfdb_opportunitylineitem_pacing.daily_pacing_dim},0) ;;
  }

  measure: html_kpi_board_line1 {
    type: count
    hidden: yes
    html:
    <div style = "background:#1982c4; color:#fff; width: 100%; ">

        <div style="display: inline-block; font-size: 20px; letter-spacing: 0.01em; margin: 0px 50px">
          Pacing
          <div style=" line-height: 15px; font-size: 30px;">
            {{ dim_sfdb_opportunitylineitem_pacing.total_pacing._rendered_value }}
          </div>
        </div>

        <div style="display: inline-block;  font-size: 20px; letter-spacing: 0.01em; margin: 0px 50px">
        Total impressions
          <div style="line-height: 15px; font-size: 30px;">
            {{ impressions._rendered_value }}
          </div>
        </div>

        <div style="display: inline-block;  font-size: 20px; letter-spacing: 0.01em; margin: 0px 50px">
        Delivered Spend
          <div style="line-height: 15px; font-size: 30px;">
            {{ Delivered_Spend._rendered_value }}
          </div>
        </div>

    </div>;;

  }

  measure: html_kpi_board_line2 {
    type: count
    # hidden: yes
    html:
    <div style = "color:#1982c4; width: 100%;">

        <div style="display: inline-block;  font-size: 20px; letter-spacing: 0.01em; margin: 0px 75px">
        Clicks
          <div style="line-height: 15px; font-size: 30px;">
            {{ clicks._rendered_value }}
          </div>
        </div>

        <div style="display: inline-block;  font-size: 20px; letter-spacing: 0.01em; margin: 0px 75px">
        CTR
          <div style="line-height: 15px; font-size: 30px;">
            {{ CTR_1P._rendered_value }}
          </div>
        </div>

        <div style="display: inline-block;  font-size: 20px; letter-spacing: 0.01em; margin: 0px 75px">
          VCR
          <div style="line-height: 15px; font-size: 30px;">
            {{ VCR_1P._rendered_value }}
          </div>
        </div>

    </div>;;
  }

}
