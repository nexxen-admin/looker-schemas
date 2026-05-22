view: drr_daily_revenue_report_base {
  sql_table_name: bi.DRR_Daily_Revenue_Report ;;

#--------------------------------------------------DIMENSIONS-------------------------------------------------------

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }
  dimension: create_timestamp {
    type: number
    hidden: yes
    sql: EXTRACT(EPOCH FROM  ${TABLE}.Create_Timestamp);;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, date, day_of_week, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Event_Date ;;
  }
  dimension: file_record {
    type: string
    sql: ${TABLE}.File_Record ;;
  }
  dimension: impression_type {
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }
  dimension: media_type {
    type: string
    sql: ${TABLE}.Media_Type ;;
  }
  dimension: record_type {
    type: string
    sql: ${TABLE}.Record_Type ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  dimension: subcategory {
    type: string
    sql: ${TABLE}.Subcategory ;;
  }

#--------------------------------------------------MEASURES-------------------------------------------------------

  measure: revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue ;;
  }
  measure: cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Cost ;;
  }
  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
  }
  measure: margin {
    type: number
    label: "Margin (Take rate)"
    value_format: "0.00%"
    sql: ${net_revenue}/${revenue} ;;
  }
  measure: last_updated {
    type: string
    sql: TO_CHAR(TO_TIMESTAMP(MAX(${create_timestamp})), 'YYYY-MM-DD HH24:MI:SS') ;;
    label: "Last Updated"
    html:
    <div style="font-family: Arial, sans-serif; font-size: 13px; line-height: 1.5; text-align: center; color: #000000;">
      <span style="font-weight: normal; word-spacing: 4px;">Last Updated (UTC)</span><br>
      <span style="word-spacing: 15px;">{{ rendered_value }}</span>
    </div> ;;}

#--------------------------------------------------POP-------------------------------------------------------
  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "PoP"
    description: "Start date for previous month"
    type: date
    sql:  TIMESTAMPADD(Month, -1, CAST({% date_start current_date_range %} AS TIMESTAMP));;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql: TIMESTAMPADD(Month, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)));;
  }

  dimension: period_3_start {
    hidden:  yes
    view_label: "PoP"
    description: "Start date for previous year"
    type: date
    sql: TIMESTAMPADD(Year, -1, CAST({% date_start current_date_range %} AS TIMESTAMP));;
  }

  dimension: period_3_end {
    hidden:  yes
    view_label: "PoP"
    description: "End date for previous year"
    type: date
    sql: TIMESTAMPADD(Year, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)));;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:CASE
            WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${event_raw}) + 1
            WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${event_raw}) + 1
            WHEN ${event_raw} between ${period_3_start} and ${period_3_end}
            THEN TIMESTAMPDIFF(DAY, ${period_3_start}, ${event_raw}) + 1
            END
        ;;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    view_label: "PoP"
    type: yesno
    sql:  EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE());;
    description: "Filters the data to be only month to date"
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:  CASE
                WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
                THEN 1
                WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
                THEN 2
                WHEN ${event_raw} between ${period_3_start} and ${period_3_end}
                THEN 3
                END;;
  }

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
    sql:CASE WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
            OR ${event_raw} between ${period_2_start} and ${period_2_end}
            OR ${event_raw} between ${period_3_start} and ${period_3_end}
                THEN 'YES' END;;
  }

  dimension: period_filtered_measures {
    hidden: yes
    description: "We are just using this for the filtered measures"
    type: string
    sql:CASE
          WHEN {% condition current_date_range %} ${event_raw} {% endcondition %} THEN 'this'
          WHEN ${event_raw} between ${period_2_start} and ${period_2_end} THEN 'previous_month'
          WHEN ${event_raw} between ${period_3_start} and ${period_3_end} THEN 'previous_year' END;;
  }

# Filtered measures


  measure: mtd_revenue {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Current Month"
    type: sum
    sql:  ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "this", mtd_only: "Yes"]
    html:
    <a style="color: black; text-decoration:none;" href="https://tremor.cloud.looker.com/dashboards/4385">{{rendered_value}} </a>;;
  }

  measure: mtd_revenue_last_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Month"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_month", mtd_only: "Yes"]
  }

  measure: mtd_revenue_last_year{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Year"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_year", mtd_only: "Yes"]
  }

  measure: mtd_revenue_complete_month {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Current Month"
    type: sum
    sql:  ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "this"]
    html:
    <a style="color: black; text-decoration:none;" href="https://tremor.cloud.looker.com/dashboards/4385">{{rendered_value}} </a>;;
  }

  measure: mtd_revenue_last_month_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Month"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_month"]
  }

  measure: mtd_revenue_last_year_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Year"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_year"]
  }

  measure: mtd_revenue_final {
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Current Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_revenue_complete_month} ELSE ${mtd_revenue} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_revenue_last_month_final {
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_revenue_last_month_complete_month} ELSE ${mtd_revenue_last_month} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_revenue_last_year_final {
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Previous Year"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_revenue_last_year_complete_month} ELSE ${mtd_revenue_last_year} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_net_revenue {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Current Month"
    type: sum
    sql:  ${TABLE}.Revenue -  ${TABLE}.Cost ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "this", mtd_only: "Yes"]
  }

  measure: mtd_net_revenue_last_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Month"
    type: sum
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_month", mtd_only: "Yes"]
  }

  measure: mtd_net_revenue_last_year{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Year"
    type: sum
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_year", mtd_only: "Yes"]
  }

  measure: mtd_net_revenue_complete_month {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Current Month"
    type: sum
    sql:  ${TABLE}.Revenue -  ${TABLE}.Cost;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "this"]
    html:
    <a style="color: black; text-decoration:none;" href="https://tremor.cloud.looker.com/dashboards/4385">{{rendered_value}} </a>;;
  }

  measure: mtd_net_revenue_last_month_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Month"
    type: sum
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_month"]
  }

  measure: mtd_net_revenue_last_year_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Year"
    type: sum
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
    value_format: "$#,##0.00"
    filters: [period_filtered_measures: "previous_year"]
  }

  measure: mtd_net_revenue_final {
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Current Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_net_revenue_complete_month} ELSE ${mtd_net_revenue} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_net_revenue_last_month_final {
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_net_revenue_last_month_complete_month} ELSE ${mtd_net_revenue_last_month} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_net_revenue_last_year_final {
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Previous Year"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_net_revenue_last_year_complete_month} ELSE ${mtd_net_revenue_last_year} END ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_margin {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Current Month"
    type: number
    sql:  ${mtd_net_revenue}/${mtd_revenue} ;;
    value_format: "0.00%"
  }

  measure: mtd_margin_last_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Month"
    type: number
    sql:  ${mtd_net_revenue_last_month}/${mtd_revenue_last_month} ;;
    value_format: "0.00%"
  }

  measure: mtd_margin_last_year{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Year"
    type: number
    sql:  ${mtd_net_revenue_last_year}/${mtd_revenue_last_year} ;;
    value_format: "0.00%"
  }

  measure: mtd_margin_complete_month {
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Current Month"
    type: number
    sql:  ${mtd_net_revenue_final}/${mtd_revenue_final};;
    value_format: "0.00%"
    html:
    <a style="color: black; text-decoration:none;" href="https://tremor.cloud.looker.com/dashboards/4385">{{rendered_value}} </a>;;
  }

  measure: mtd_margin_last_month_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Month"
    type: number
    sql:  ${mtd_net_revenue_last_month_final}/${mtd_revenue_last_month_final};;
    value_format: "0.00%"
  }

  measure: mtd_margin_last_year_complete_month{
    hidden: yes
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Year"
    type: number
    sql:  ${mtd_net_revenue_last_year_final}/${mtd_revenue_last_year_final};;
    value_format: "0.00%"
  }

  measure: mtd_margin_final {
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Current Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_margin_complete_month} ELSE ${mtd_margin} END ;;
    value_format: "0.00%"
  }

  measure: mtd_margin_last_month_final {
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Month"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_margin_last_month_complete_month} ELSE ${mtd_margin_last_month} END ;;
    value_format: "0.00%"
  }

  measure: mtd_margin_last_year_final {
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Previous Year"
    type: number
    sql: CASE WHEN {% date_end current_date_range %}<CURRENT_DATE() THEN ${mtd_margin_last_year_complete_month} ELSE ${mtd_margin_last_year} END ;;
    value_format: "0.00%"
  }

  measure: mtd_revenue_comparison_previous_month {
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Comparison to Previous Month"
    type: number
    sql: (${mtd_revenue_final}/${mtd_revenue_last_month_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
      {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
      {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs previous month ;;
  }

  measure: mtd_revenue_comparison_previous_year {
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "MTD Revenue - Comparison to Previous Year"
    type: number
    sql: (${mtd_revenue_final}/${mtd_revenue_last_year_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
    {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
    {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs same period LY ;;
  }

  measure: mtd_net_revenue_comparison_previous_month {
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Comparison to Previous Month"
    type: number
    sql: (${mtd_net_revenue_final}/${mtd_net_revenue_last_month_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
    {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
    {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs previous month ;;
  }

  measure: mtd_net_revenue_comparison_previous_year {
    view_label: "PoP"
    group_label: "MTD Net Revenue"
    label: "MTD Net Revenue - Comparison to Previous Year"
    type: number
    sql: (${mtd_net_revenue_final}/${mtd_net_revenue_last_year_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
    {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
    {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs same period LY ;;
  }

  measure: mtd_margin_comparison_previous_month {
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Comparison to Previous Month"
    type: number
    sql: (${mtd_margin_final}/${mtd_margin_last_month_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
    {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
    {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs previous month ;;
  }

  measure: mtd_margin_comparison_previous_year {
    view_label: "PoP"
    group_label: "MTD Margin"
    label: "MTD Margin - Comparison to Previous Year"
    type: number
    sql: (${mtd_margin_final}/${mtd_margin_last_year_final}) - 1 ;;
    value_format: "0.00%"
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}
    {% assign indicator = "red,▼" | split: ',' %}
    {% else %}
    {% assign indicator = "grey,▬" | split: ',' %}
    {% endif %}
    <font color="{{indicator[0]}}">
    {% if value == 99999.12345 %} &infin
    {% else %}{{indicator[1]}}
    {% endif %}
    </font>
    {{rendered_value}} vs same period LY ;;
  }

  measure: mtd_revenue_comparison_all {
    type: count
    view_label: "PoP"
    group_label: "MTD Revenue"
    label: "All in one"
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
                <a style="color: black; text-decoration:none;" href="https://tremor.cloud.looker.com/dashboards/4385">Revenue </a>
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500; margin-top: 20px;">
                {{ mtd_revenue_final._rendered_value }}
              </div>
              <div style=" line-height: 15px; font-size: 15px; color:  #BFBFBF; margin-top: 15px;">
                {{ mtd_revenue_comparison_previous_month._rendered_value }} vs previous month
              </div>
               <div style=" line-height: 15px; font-size: 15px; color:  #BFBFBF; margin-top: 15px;">
                {{ mtd_revenue_comparison_previous_year._rendered_value }}  vs same period LY
              </div>

            </div>;;
  }


}
