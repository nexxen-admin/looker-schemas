view: ncd_fact_nexxen_dsp_test_raw_rev2 {
  sql_table_name: BI_DSP.ncd_fact_nexxen_dsp_test_raw_rev2 ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  measure: clicks {
    type: sum
    label: "1P Clicks"
    sql: ${TABLE}.clicks ;;

  }
  measure: complete_events  {
    type: sum
    value_format: "#,##0.00"
    description: "1 for events that were completed"
    sql: ${TABLE}.complete_events  ;;
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }
  dimension: creative_group_a {
    type: string
    sql: ${TABLE}.creative_group_a ;;
  }
  dimension: creative_group_b {
    type: string
    sql: ${TABLE}.creative_group_b ;;
  }
  dimension: creative_group_c {
    type: string
    sql: ${TABLE}.creative_group_c ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_Key ;;
    hidden: yes
  }
  dimension_group: date_key_in_timezone {
    type: time
    label: "Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key_in_timezone ;;
  }
  dimension: day_number_in_week {
    type: number
    sql: ${TABLE}.Day_Number_In_Week ;;
  }

  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    hidden: yes
  }
  dimension: device_type_category {
    type: string
    sql: CASE WHEN ${TABLE}.device_type IN ('TV', 'Set Top Box', 'Media Player', 'Games Console') THEN 'CTV'
      WHEN ${TABLE}.device_type='PC' THEN 'Desktop'
       WHEN ${TABLE}.device_type='E-Reader' THEN 'Tablet'
      WHEN ${TABLE}.device_type IS NULL or  ${TABLE}.device_type IN ('Unknown', 'Any Device') THEN  'Other'
      ELSE ${TABLE}.device_type END;;
  }

  dimension: dma_name_public {
    type: string
    label: "DMA Name"
    sql:  CASE WHEN INSTR(${TABLE}.dma_name, '(')>0 THEN TRIM(SUBSTR(${TABLE}.dma_name, 1, INSTR(${TABLE}.dma_name, '(')-1)) ELSE ${TABLE}.dma_name END;;
  }
  dimension_group: end_date__c {
    type: time
    label: "End Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
  }
  dimension: format {
    type: string
    sql: ${TABLE}."format" ;;
  }
  dimension: free__c {
    type: string
    sql: ${TABLE}.free__c ;;
    hidden: yes
  }
  measure: impressions {
    type: sum
    label: "1P Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }
  dimension: line_item_group_b {
    type: string
    sql: ${TABLE}.line_item_group_b ;;
  }
  dimension: line_item_group_c {
    type: string
    sql: ${TABLE}.line_item_group_c ;;
  }
  dimension: line_item_name__c {
    type: string
    sql: ${TABLE}.line_item_name__c ;;
    hidden: yes
  }
  dimension: line_item_nickname {
    type: string
    label: "Line Item Name"
    sql: ${TABLE}.line_item_nickname ;;
  }
  dimension: mobile_app_name {
    type: string
    sql: ${TABLE}.mobile_app_name ;;
  }
  dimension: month_name {
    type: string
    sql: ${TABLE}.Month_Name ;;
  }
  dimension: month_number {
    type: number
    sql: ${TABLE}.Month_Number ;;
  }
  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }
  dimension: package_group_b {
    type: string
    sql: ${TABLE}.package_group_b ;;
  }
  dimension: package_nickname {
    type: string
    label: "Package Name"
    sql: ${TABLE}.package_nickname ;;
  }
  dimension: price_type_name__c {
    type: string
    label: "Price Type"
    sql: ${TABLE}.price_type_name__c ;;
  }
  dimension: rate__c {
    type: number
    label: "Rate"
    sql: ${TABLE}.rate__c ;;
  }
  dimension: region_name {
    type: string
    sql: ${TABLE}.region_name ;;
  }
  dimension: related_accounts_name {
    type: string
    label: "Related Brand Name"
    sql: ${TABLE}.related_accounts_name ;;
  }
  dimension: spend__c {
    type: number
    sql: ${TABLE}.spend__c ;;
    hidden: yes
  }
  dimension_group: start_date__c {
    type: time
    label: "Start Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
  }
  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }
  dimension: units__c {
    type: number
    sql: ${TABLE}.units__c ;;
    hidden: yes
  }
  measure: delivered_units {
    type: sum
    sql: ${TABLE}.delivery_units ;;
    value_format: "#,##0"
  }


  measure: CTR_1P {
    type: number
    value_format: "0.0%"
    sql: IFNULL(${clicks}/nullif(${impressions},0),0) ;;
  }


  measure: VCR_1P {
    type: number
    sql: IFNULL(${complete_events}/nullif(${impressions},0),0) ;;
    value_format: "0.0%"
  }

  measure: Delivered_Spend {
    type: sum
    sql: ${TABLE}.impressions/1000*${TABLE}.rate__c;;
    value_format: "$#,##0.00"
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


  measure: current_period_impressions {
    view_label: "PoP"
    type: sum
    description: "Current period impressions"
    sql:  ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_impressions{
    view_label: "PoP"
    type: sum
    description: "Previous period impressions"
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    filters: [period_filtered_measures: "last"]
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



#---------------------------------------------NCD Specifics---------------------------------------------------

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
          <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Pacing
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ total_pacing._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_pacing_demo {
    type: count
    hidden: yes
    html:
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Pacing
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                100%
              </div>
            </div>;;
  }

  measure: html_kpi_impressions {
    type: count
    hidden: yes
    html:
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Impressions
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ impressions._rendered_value }}
              </div>
            </div>;;
  }

  measure: impressions_demo {
    type: number
    hidden: yes
    value_format: "#,##0"
    sql:${impressions}  *10.2;;
  }

  measure: html_kpi_impressions_demo {
    type: count
    hidden: yes
    html:
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Impressions
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ impressions_demo._rendered_value }}
              </div>
            </div>;;
  }


  measure: html_kpi_vcr {
    type: count
    hidden: yes
    html:
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              VCR
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ VCR_1P._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_delivered_spend {
    type: count
    hidden: yes
    html:
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Delivered Spend
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
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
           <div style="color:#4D3D69; display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Delivered Spend
              <div style="color:#4D3D69; line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ delivered_spend_demo._rendered_value }}
              </div>
            </div>;;
  }



}
