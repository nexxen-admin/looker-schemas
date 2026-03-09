view: ncd_fact_nexxen_dsp_state {
    # sql_table_name: BI_DSP.ncd_fact_nexxen_dsp_state ;;
    derived_table: {
      sql: SELECT *,
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY opportunitylineitem_key ORDER BY opportunitylineitem_key)=1 THEN units__c ELSE 0 END AS units,
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY opportunitylineitem_key ORDER BY opportunitylineitem_key)=1 THEN spend__c ELSE 0 END AS spend
FROM
    "BI_DSP"."ncd_fact_nexxen_dsp_state" AS "ncd_fact_nexxen_dsp_state"
  WHERE
        {% condition date_filter %} ncd_fact_nexxen_dsp_state.date_key_in_timezone {% endcondition %}
        AND
        {% condition account_name_filter %} ncd_fact_nexxen_dsp_state.account_name {% endcondition %}
        AND
        {% condition advertiser_name_filter %} ncd_fact_nexxen_dsp_state.advertiser_name {% endcondition %}
    ;;
    }

filter: date_filter {
  type: date
}

filter: account_name_filter {
  type:  string
}

filter: advertiser_name_filter {
  type: string
}
#---------------------------------------------Dimensions---------------------------------------------------
dimension: id {
  primary_key: yes
  type: string
  sql: ${TABLE}.id ;;
  hidden: yes
}
dimension: account_id {
  type: string
  sql:  ${TABLE}.account_id ;;
  hidden: yes
}
dimension: account_name {
  type: string
  sql: ${TABLE}.account_name ;;
}
dimension: advertiser_id {
  type: string
  sql:  ${TABLE}.advertiser_id ;;
  hidden: yes
}
dimension: advertiser_name {
  type: string
  sql: ${TABLE}.advertiser_name ;;
}
dimension: beacon_id {
  type: string
  label: "Beacon ID"
  sql: ${TABLE}.beacon_id ;;
}
  dimension: beacon_name {
    type: string
    label: "Beacon Name"
    sql: ${TABLE}.beacon_name ;;
  }
dimension: campaign {
  type: string
  sql: ${TABLE}.campaign ;;
}
dimension: country_name {
  type: string
  sql: ${TABLE}.country_name ;;
  map_layer_name: countries
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
dimension: day_of_week_name {
  type: string
  sql: substring(TO_CHAR(${TABLE}.Date_Key, 'Day') ,1,3) ;;
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
dimension: package_group_c {
  type: string
  sql: ${TABLE}.package_group_c ;;
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
  value_format: "$#,##0.00"
}
dimension: region_name {
  type: string
  map_layer_name: us_states
  sql: ${TABLE}.region_name ;;
}
dimension: related_accounts_id {
  type: number
  sql: ${TABLE}.related_accounts_id ;;
  hidden: yes
}
dimension: related_accounts_name {
  type: string
  label: "Related Brand Name"
  sql: ${TABLE}.related_accounts_name ;;
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
dimension: tactic {
  type: string
  label: "Tactic"
  sql: CASE WHEN ${line_item_name__c} LIKE '%RET%' THEN 'Retargeting'
          WHEN ${line_item_name__c} LIKE '%BI%' THEN 'Brand Intelligence'
          WHEN ${line_item_name__c} LIKE '%DEMO%' THEN 'Demographic'
          WHEN ${line_item_name__c} LIKE '%BT%' THEN 'Behavioral'
          WHEN ${line_item_name__c} LIKE '%PERF%' THEN 'Performance'
          WHEN ${line_item_name__c} LIKE '%PMP%' THEN 'PMP'END ;;
}

#---------------------------------------------Measures---------------------------------------------------
  measure: impressions {
    type: sum
    label: "1P Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  measure: complete_events  {
    type: sum
    value_format: "#,##0"
    description: "1 for events that were completed"
    sql: ${TABLE}.complete_events  ;;
  }

measure: delivered_units {
  type: sum
  sql: ${TABLE}.delivery_units ;;
  value_format: "#,##0"
}
measure: budgeted_spend{
  type: sum
  label: "Budgeted Spend"
  sql: ${TABLE}.spend ;;
  value_format: "$#,##0.00"
}
  measure: budgeted_spend_cad{
    type: sum
    label: "Budgeted Spend (CAD)"
    sql: ${TABLE}.spend/1.4 ;;
    value_format: "$#,##0.00"
  }
measure: budgeted_units {
  type: sum
  label: "Budgeted Units"
  sql: ${TABLE}.units ;;
}


  measure: video_impressions {
    hidden: yes
    type: sum
    value_format: "#,##0"
    sql: CASE WHEN ${format} IN ('Video', 'Audio') THEN ${TABLE}.impressions ELSE 0 END ;;
  }
  measure: video_complete_events  {
    hidden: yes
    type: sum
    value_format: "#,##0"
    sql: CASE WHEN ${format} IN ('Video', 'Audio') THEN ${TABLE}.complete_events ELSE 0 END   ;;
  }

measure: VCR_1P {
  type: number
  sql: IFNULL(${video_complete_events}/nullif(${video_impressions},0),0) ;;
  value_format: "0.0%"
}

measure: Delivered_Spend {
  type: sum
  sql: ${TABLE}.uncapped_revenue;;
  value_format: "$#,##0.00"
}
  measure: Delivered_Spend_cad {
    type: sum
    label: "Delivered Spend (CAD)"
    sql: ${TABLE}.uncapped_revenue/1.4;;
    value_format: "$#,##0.00"
  }

dimension: ncd_clicks_dim {
  type: number
  hidden: yes
  sql: CASE WHEN ${device_type_category}='CTV' THEN 0 ELSE ${TABLE}.clicks END;;
}

measure: ncd_clicks {
  type: sum
  value_format: "#,##0"
  label: "Clicks"
  sql: CASE WHEN ${device_type_category}='CTV' THEN 0 ELSE ${TABLE}.clicks END;;
}
  measure: non_ctv_impressions {
    hidden: yes
    type: sum
    value_format: "#,##0"
    sql: CASE WHEN ${device_type_category}='CTV' THEN 0 ELSE ${TABLE}.impressions END ;;
  }
measure: ncd_ctr {
  type: number
  label: "CTR 1P"
  value_format: "0.00%"
  sql: IFNULL(${ncd_clicks}/NULLIF(${non_ctv_impressions},0),0) ;;
}
#---------------------------------------------Conversion Metrics---------------------------------------------------

  measure: actions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.actions ;;
  }
  measure: rate{
    type: number
    label: "RFI Rate"
    description: "Actions divided by impressions"
    value_format: "0.00%"
    sql: CASE WHEN ${impressions}=0 THEN 0 ELSE ${actions}*100/${impressions} END;;
  }
  measure: cta {
    type: sum
    label: "CTA"
    description: "Click based actions"
    value_format: "#,##0"
    sql: ${TABLE}.CTV ;;
  }
  measure: vta {
    type: sum
    label: "VTA"
    description: "View based actions"
    value_format: "#,##0"
    sql: ${TABLE}.VTA ;;
  }
  measure: shopping_cart {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.shopping_cart_value ;;
  }
  measure: shopping_cart_cta {
    type: sum
    label: "Shopping Cart CTA"
    value_format: "#,##0"
    sql: ${TABLE}.shopping_cart_value_CTA ;;
  }
  measure: shopping_cart_vta {
    type: sum
    label: "Shopping Cart VTA"
    value_format: "#,##0"
    sql: ${TABLE}.shopping_cart_VTA ;;
  }
  measure: cross_device_actions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_actions ;;
  }
  measure: cross_device_cta {
    type: sum
    label: "Cross Device CTA"
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_CTA ;;
  }
  measure: cross_device_vta {
    type: sum
    label: "Cross Device VTA"
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_VTA ;;
  }
  measure: cross_device_shopping_cart_total {
    type: sum
    label: "Cross Device Shopping Cart Total"
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_shopping_cart_value_total ;;
  }
  measure: cross_device_shopping_cart_cta {
    type: sum
    label: "Cross Device Shopping Cart CTA"
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_shopping_cart_value_CTA ;;
  }
  measure: cross_device_shopping_cart_vta {
    type: sum
    label: "Cross Device Shopping Cart VTA"
    value_format: "#,##0"
    sql: ${TABLE}.cross_device_shopping_cart_value_VTA ;;
  }
  measure: household_actions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.household_actions ;;
  }
  measure: household_cta {
    type: sum
    label: "Household CTA"
    value_format: "#,##0"
    sql: ${TABLE}.household_CTA ;;
  }
  measure: household_vta {
    type: sum
    label: "Household VTA"
    value_format: "#,##0"
    sql: ${TABLE}.household_VTA ;;
  }
  measure: household_shopping_cart_cta {
    type: sum
    label: "Household Shopping Cart CTA"
    value_format: "#,##0"
    sql: ${TABLE}.household_shopping_cart_value_CTA ;;
  }
  measure: household_shopping_cart_vta {
    type: sum
    label: "Household Shopping Cart VTA"
    value_format: "#,##0"
    sql: ${TABLE}.household_shopping_cart_value_VTA ;;
  }

  measure: cpa {
    type: number
    label: "CPA"
    description: "Cost per action - delivered spend (advertiser invoice) divided by actions."
    value_format: "$0.00"
    sql: CASE WHEN ${actions}=0 THEN 0 ELSE ${Delivered_Spend}/${actions} END;;
  }

  measure: roas {
    type: number
    label: "ROAS"
    description: "Cross device shopping cart value divided by delivered spend (advertiser invoice)."
    value_format: "0.00%"
    sql: CASE WHEN ${Delivered_Spend}=0 THEN 0 ELSE ${cross_device_shopping_cart_total}/${Delivered_Spend} END ;;
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
  sql: ${ncd_clicks_dim}  ;;
  value_format: "#,##0"
  filters: [period_filtered_measures: "this"]
}

measure: previous_period_clicks {
  view_label: "PoP"
  type: sum
  description: "Previous period clicks"
  sql: ${ncd_clicks_dim}  ;;
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
  # filters: [period_filtered_measures: "last"]
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
          <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em; vertical-align: middle;">
              Pacing
                <div style="width: 15px; height: 15px; border: 2px solid #6c5d8c; border-radius: 50%; color: #6c5d8c; text-align: center; line-height: 12px; display: inline-block; vertical-align: middle;  font-weight: bold; font-size: 10px;" title="Pacing for campaigns active in the selected time frame, calculated from the start of the campaign to the latest date."> i</div>
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ total_pacing._rendered_value }}
              </div>
            </div>;;
}

measure: html_kpi_delivered_units {
  type: count
  hidden: yes
  html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Delivered Units
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ delivered_units._rendered_value }}
              </div>
            </div>;;
}

  measure: html_kpi_impressions {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Delivered Impressions
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ impressions._rendered_value }}
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

  measure: html_kpi_delivered_spend_cad {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Delivered Spend (CAD)
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ Delivered_Spend_cad._rendered_value }}
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

  measure: html_kpi_actions {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              RFI Actions
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ actions._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_rate {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              RFI Rate
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ rate._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_cpa {
    type: count
    # hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              CPA
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ cpa._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_roas {
    type: count
    # hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              ROAS
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ roas._rendered_value }}
              </div>
            </div>;;
  }

#---------------------------------------NCD DEMO---------------------------
  measure: html_kpi_pacing_demo {
    type: count
    hidden: yes
    html:
          <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em; vertical-align: middle;">
              Pacing
                <div style="width: 15px; height: 15px; border: 2px solid #6c5d8c; border-radius: 50%; color: #6c5d8c; text-align: center; line-height: 12px; display: inline-block; vertical-align: middle;  font-weight: bold; font-size: 10px;" title="Pacing for campaigns active in the selected time frame, calculated from the start of the campaign to the latest date."> i</div>
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                100%
              </div>
            </div>;;
  }


  measure: delivered_units_demo {
    type: number
    hidden: yes
    value_format: "#,##0"
    sql:${delivered_units}  *5.1;;
  }

  measure: html_kpi_delivered_units_demo {
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

  measure: delivered_spend_demo {
    type: number
    hidden: yes
    value_format: "$#,##0.00"
    sql:${Delivered_Spend}  *5.8;;
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

  measure: ncd_clicks_demo {
    type: sum
    hidden: yes
    value_format: "#,##0"
    sql: CASE WHEN ${device_type_category}='CTV' THEN 0 ELSE ${TABLE}.clicks*6.9 END;;
  }

  measure: html_kpi_clicks_demo {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Clicks
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ ncd_clicks_demo._rendered_value }}
              </div>
            </div>;;
  }

  measure: complete_events_demo  {
    type: sum
    hidden: yes
    value_format: "#,##0"
    sql: ${TABLE}.complete_events*4.8  ;;
  }

  measure: html_kpi_complete_events_demo {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Complete Events
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ complete_events_demo._rendered_value }}
              </div>
            </div>;;
  }

  measure: ncd_ctr_demo {
    type: number
    hidden: yes
    value_format: "0.00%"
    sql: ${ncd_ctr}*1.25 ;;
  }

  measure: html_kpi_ctr_demo {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              CTR
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ ncd_ctr_demo._rendered_value }}
              </div>
            </div>;;
  }

  measure: impressions_demo {
    type: sum
    hidden: yes
    value_format: "#,##0"
    sql: ${TABLE}.impressions*4.6 ;;
  }
}
