
view: ifr_data_margin {
  sql_table_name: financial.ifr_data_margin ;;
  # derived_table: {
  #   sql: with rs as
  #         (select rs.period_name,
  #                 rs.impression_date :: date,
  #                 rs.advertiser_home_mkt_id,
  #                 rs.advertiser_home_mkt_name,
  #                 rs.advertiser_name,
  #                 rs.advertiser_id,
  #                 sum(rs.turn_fee) as turn_fee,
  #                 SUM(rs.total_billable) as total_billable
  #         from fact_programmatic_revenue_summary_by_day rs
  #         where rs."source" = 'BILLINGS'
  #             and ifr_period >= '2023-01-01'
  #             and rs.advertiser_home_mkt_id in ('141',
  #                                               '861',
  #                                               '927',
  #                                               '999',
  #                                               '1356',
  #                                               '1379',
  #                                               '1405',
  #                                               '1472',
  #                                               '1602',
  #                                               '2048',
  #                                               '2107',
  #                                               '2139',
  #                                               '2143',
  #                                               '2147',
  #                                               '2145',
  #                                               '2149')
  #         group by 1,
  #                   2,
  #                   3,
  #                   4,
  #                   5,
  #                   6 ), -- data cost
  #     --
  #     d as
  #         ( SELECT d.period_name,
  #                 d.impression_date :: date as impression_date,
  #                 d.market_id,
  #                 d.market_name,
  #                 d.advertiser_id,
  #                 d.advertiser_name,
  #                 d.data_product_description as product,
  #                 sum(d.turn_fee) as data_cost_adj
  #         FROM fact_programmatic_decom d
  #         WHERE d.date_period :: date >= '2023-01-01'
  #         group by 1,
  #                   2,
  #                   3,
  #                   4,
  #                   5,
  #                   6,
  #                   7 )
  #     select period_name,
  #           impression_date,
  #           advertiser_Home_mkt_id,
  #           advertiser_home_mkt_name,
  #           advertiser_id,
  #           advertiser_name,
  #           unnest(array['total_billable', 'turn_fee']) as product,
  #           unnest(array[total_billable, turn_fee]) as turn_fee,
  #           total_billable
  #     FROM rs
  #     UNION ALL
  #     SELECT d.period_name,
  #           d.impression_date,
  #           d.market_id,
  #           d.market_name,
  #           d.advertiser_id,
  #           d.advertiser_name,
  #           d.product,
  #           data_cost_adj,
  #           rs.total_billable
  #     FROM d
  #     LEFT JOIN rs ON rs.period_name = d.period_name
  #     AND rs.advertiser_id = d.advertiser_id
  #     AND rs.impression_date = d.impression_date ;;
  # }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: period_name {
    type: string
    sql: ${TABLE}."period_name" ;;
  }

  # dimension: impression_date {
  #   type: date
  #   sql: ${TABLE}."impression_date" ;;
  # }

  dimension_group: impression_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."impression_date" ;;
  }

  dimension: advertiser_home_mkt_id {
    type: string
    label: "market id"
    sql: ${TABLE}."advertiser_home_mkt_id" ;;
  }

  dimension: advertiser_home_mkt_name {
    type: string
    label: "market name"
    sql: ${TABLE}."advertiser_home_mkt_name" ;;
  }

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}."advertiser_id" ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}."advertiser_name" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."product" ;;
  }

  measure: turn_fee {
    type: sum
    sql: ${TABLE}."turn_fee" ;;
  }

  measure: total_billable {
    type: sum
    sql: ${TABLE}."total_billable" ;;
  }

  #   measure: data_margin_tmp {
  #   type: number
  #   sql: sum(case when ${product} != "total_billable" and ${product} != "turn_fee" then ${TABLE}."turn_fee" end) ;;
  # }

  set: detail {
    fields: [
        period_name,
  advertiser_home_mkt_id,
  advertiser_home_mkt_name,
  advertiser_id,
  advertiser_name,
  product,
  turn_fee,
  total_billable
    ]
  }

  # filter: current_date_range {
  #   type: date
  #   view_label: "PoP"
  #   label: "Current Date Range"
  #   description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
  #   sql: ${period} IS NOT NULL ;;


  # }
  # dimension:  date_for_html {
  #   type: date
  #   view_label: "PoP"
  #   sql: ${current_date_range} ;;
  #   html:
  #   <ul>
  #       <li> value: {{ rendered_value }} </li>
  #   </ul> ;;

  # }

  # parameter: compare_to {
  #   view_label: "PoP"
  #   description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
  #   label: "Compare To:"
  #   type: unquoted

  #   allowed_value: {
  #     label: "Previous Month"
  #     value: "Month"
  #   }

  #   allowed_value: {
  #     label: "Previous Year"
  #     value: "Year"
  #   }

  #   allowed_value: {
  #     label: "Previous Week"
  #     value: "Week"
  #   }
  #   default_value: "Period"
  # }

  # parameter: choose_breakdown {
  #   label: "Choose Grouping"
  #   view_label: "PoP"
  #   type: unquoted
  #   default_value: "day_of_month"
  #   allowed_value: {label:"daily" value:"day_of_month"}
  #   allowed_value: {label:"monthly" value: "month_name"}
  # }

  # dimension: sort_by1 {
  #   hidden: yes
  #   type: number
  #   sql:
  #       {% if choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_num}
  #       {% elsif choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
  #       {% elsif choose_breakdown._parameter_value == 'year' %} ${date_in_period_year}}
  #       {% elsif choose_breakdown._parameter_value == 'quarter' %} ${date_in_period_quarter}
  #       {% else %}NULL{% endif %} ;;
  # }
  # dimension: sort_by2 {
  #   hidden: yes
  #   type: string
  #   sql:
  #       {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
  #       {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month_num}
  #       {% else %}NULL{% endif %} ;;
  # }
  # parameter: choose_comparison {
  #   label: "Choose Comparison (Pivot)"
  #   view_label: "PoP"
  #   description: "Defines whether the comparison will be monthly or yearly"
  #   type: unquoted
  #   default_value: "month"
  #   allowed_value: {value: "year" }
  #   allowed_value: {value: "month"}

  # }
  # dimension: pop_pivot {
  #   view_label: "PoP"
  #   description: "Takes the 'choose comparison' parameter and adds a suitable parameter to it"
  #   label_from_parameter: choose_comparison
  #   type: string
  #   order_by_field: sort_by2 # Important
  #   sql:
  #       {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
  #       {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month}
  #       {% else %}NULL{% endif %} ;;
  # }

  # dimension: pop_row  {
  #   view_label: "PoP"
  #   label_from_parameter: choose_breakdown
  #   type: string
  #   order_by_field: sort_by1 # Important
  #   sql:
  #       {% if choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
  #       {% elsif choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_name}
  #       {% else %}'2022-01-01'{% endif %} ;;
  # }

  # dimension: days_in_period {
  #   hidden:  yes
  #   view_label: "PoP"
  #   description: "Gives the number of days in the current period date range"
  #   type: number
  #   sql: TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), CAST({% date_end current_date_range %} AS TIMESTAMP)) ;;
  # }

  # dimension: period_2_start {
  #   hidden:  yes
  #   view_label: "PoP"
  #   description: "Calculates the start of the previous period"
  #   type: date
  #   sql:
  #           {% if compare_to._parameter_value == "Period" %}
  #         -- TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
  #           TIMESTAMPADD(DAY, -${days_in_period}, CAST({% date_start current_date_range %} AS TIMESTAMP))
  #           {% else %}
  #           TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
  #           {% endif %};;
  # }

  # dimension: period_2_end {
  #   hidden:  yes
  #   view_label: "PoP"
  #   description: "Calculates the end of the previous period"
  #   type: date
  #   sql:
  #           {% if compare_to._parameter_value == "Period" %}
  #           TIMESTAMPADD(DAY, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
  #           {% else %}
  #           TIMESTAMPADD({% parameter compare_to %}, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)))
  #           {% endif %};;
  # }

  # dimension: day_in_period {
  #   hidden: yes
  #   description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
  #   type: number
  #   sql:
  #       {% if current_date_range._is_filtered %}
  #           CASE
  #           WHEN {% condition current_date_range %} ${impression_date_raw} {% endcondition %}
  #           THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${impression_date_raw}) + 1
  #           WHEN ${impression_date_raw} between ${period_2_start} and ${period_2_end}
  #           THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${impression_date_raw}) + 1
  #           END
  #       {% else %} NULL
  #       {% endif %}
  #       ;;
  # }

  # dimension: mtd_only {
  #   group_label: "To-Date Filters"
  #   label: "MTD"
  #   view_label: "PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE())
  #                   OR
  #               (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
  #               EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
  #                   OR
  #               (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
  #               EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #               EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: qtd_only {
  #   group_label: "To-Date Filters"
  #   label: "QTD"
  #   view_label: "PoP"
  #   type: yesno
  #   sql: ${date_in_period_date} > TO_DATE(DATE_TRUNC('quarter', CURRENT_DATE())) AND ${date_in_period_date} <
  #     (TO_DATE(DATEADD('month', 3, CAST(DATE_TRUNC('quarter', CAST(DATE_TRUNC('quarter', CURRENT_DATE()) AS DATE)) AS DATE)))) ;;
  # }

  # dimension: ytd_only {
  #   group_label: "To-Date Filters"
  #   label: "YTD"
  #   view_label: "PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DOY FROM ${date_in_period_date}) < EXTRACT(DOY FROM GETDATE())
  #                   OR
  #               (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
  #               EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
  #                   OR
  #               (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
  #               EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #               EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: order_for_period {
  #   hidden: yes
  #   type: number
  #   sql:
  #           {% if current_date_range._is_filtered %}
  #               CASE
  #               WHEN {% condition current_date_range %} ${impression_date_raw} {% endcondition %}
  #               THEN 1
  #               WHEN ${impression_date_raw} between ${period_2_start} and ${period_2_end}
  #               THEN 2
  #               END
  #           {% else %}
  #               NULL
  #           {% endif %}
  #           ;;
  # }

  # ## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##


  # dimension: wtd_only {hidden:yes}


  # ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  # dimension_group: date_in_period {
  #   description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
  #   label: "Current Period"
  #   type: time
  #   sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
  #   view_label: "PoP"
  #   timeframes: [
  #     date,
  #     hour_of_day,
  #     day_of_week,
  #     day_of_week_index,
  #     day_of_month,
  #     day_of_year,
  #     week_of_year,
  #     week,
  #     month,
  #     quarter,
  #     month_name,
  #     month_num,
  #     year]

  # }


  # dimension: period {
  #   view_label: "PoP"
  #   label: "Period"
  #   description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
  #   type: string
  #   hidden: yes
  #   order_by_field: order_for_period
  #   sql:
  #           {% if current_date_range._is_filtered %}
  #               CASE
  #               WHEN {% condition current_date_range %} ${impression_date_raw} {% endcondition %}
  #               THEN 'This {% parameter compare_to %}'
  #               WHEN ${impression_date_raw} between ${period_2_start} and ${period_2_end}
  #               THEN 'Last {% parameter compare_to %}'
  #               END
  #           {% else %}
  #               NULL
  #           {% endif %}
  #           ;;
  # }


  # ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  # dimension: period_filtered_measures {
  #   hidden: yes
  #   description: "We are just using this for the filtered measures"
  #   type: string
  #   sql:
  #           {% if current_date_range._is_filtered %}
  #               CASE
  #               WHEN {% condition current_date_range %} ${impression_date_raw} {% endcondition %} THEN 'this'
  #               WHEN ${impression_date_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
  #           {% else %} NULL {% endif %} ;;
  # }

  # # Filtered measures

  # measure: current_period_turn_fee {
  #   view_label: "PoP"
  #   label: "Current Period turn fee  {{_filters['current_date_range']}} "
  #   type: sum
  #   description: "Specifies the turn of the current period we are looking at, using the filter 'current date range' which has to be applied"
  #   sql: ${TABLE}."turn_fee" ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "this"]
  # }

  # measure: current_period_total_billable {
  #   view_label: "PoP"
  #   label: "Current Period total billable  {{_filters['current_date_range']}} "
  #   type: sum
  #   description: "Specifies the % of the net revenue out of the revenue of the current period we are looking at, using the filter 'current date range' which has to be applied"
  #   sql: ${TABLE}."total_billable";;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "this"]
  # }

  # measure: previous_period_turn_fee{
  #   view_label: "PoP"
  #   description: "Specifies the turn fee of the previous period"
  #   type: sum
  #   sql: ${TABLE}."turn_fee" ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "last"]
  # }

  # measure: previous_period_total_billable{
  #   view_label: "PoP"
  #   description: "Specifies the total billable of the previous period"
  #   type: sum
  #   sql: ${TABLE}."turn_fee" ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "last"]
  # }

  # measure: current_period_cost {
  #   view_label: "PoP"
  #   type: sum
  #   description: "The current period's cost"
  #   sql: ${TABLE}.sum_of_cogs ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "this"]
  # }

  # measure: previous_period_cost{
  #   view_label: "PoP"
  #   type: sum
  #   description: "The previous period's cost"
  #   sql: ${TABLE}.sum_of_cogs ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "last"]
  # }

  # measure: cost_pop_change {
  #   view_label: "PoP"
  #   label: "Total cost period-over-period % change"
  #   description: "Cost change from previous period to current"
  #   type: number
  #   sql: CASE WHEN ${current_period_revenue} = 0
  #               THEN NULL
  #               ELSE (1.0 * ${current_period_revenue} / NULLIF(${previous_period_revenue} ,0)) - 1 END ;;
  #   value_format_name: percent_2

  #   html:
  #   {% if value > 0 %}
  #   {% assign indicator = "green,▲" | split: ',' %}
  #   {% elsif value < 0 %}

  #     {% assign indicator = "red,▼" | split: ',' %}

  #     {% else %}

  #     {% assign indicator = "black,▬" | split: ',' %}

  #     {% endif %}
  #     <font color="{{indicator[0]}}">

  #     {% if value == 99999.12345 %} &infin

  #     {% else %}{{indicator[1]}}

  #     {% endif %}

  #     </font>
  #     {{rendered_value}}


  #     ;;
  # }


  # measure: current_period_profit {
  #   view_label: "PoP"
  #   type: sum
  #   description: "Current period difference between revenue and cogs"
  #   sql: (${TABLE}.sum_of_revenue-${TABLE}.sum_of_cogs) ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "this"]
  # }
  # measure: previous_period_profit{
  #   view_label: "PoP"
  #   type: sum
  #   description: "Previous period difference between revenue and cogs"
  #   sql: (${TABLE}.sum_of_revenue-${TABLE}.sum_of_cogs) ;;
  #   value_format: "$#,##0"
  #   filters: [period_filtered_measures: "last"]
  # }

  # measure: profit_pop_change {
  #   view_label: ""
  #   label: "Profit Previous {{_filters['compare_to']}} Change"
  #   description: "The change in the difference between revenue and cogs between previous and current periods"
  #   type: number
  #   sql: CASE WHEN ${current_period_profit} = 0
  #               THEN NULL
  #               ELSE (1.0 * ${current_period_profit} / NULLIF(${previous_period_profit} ,0)) - 1 END ;;
  #   value_format_name: percent_0

  #   html:
  #   {% if value > 0 %}
  #   {% assign indicator = "green,▲" | split: ',' %}
  #   {% elsif value < 0 %}

  #     {% assign indicator = "red,▼" | split: ',' %}

  #     {% else %}

  #     {% assign indicator = "black,▬" | split: ',' %}

  #     {% endif %}
  #     <font color="{{indicator[0]}}">

  #     {% if value == 99999.12345 %} &infin

  #     {% else %}{{indicator[1]}}

  #     {% endif %}

  #     </font>
  #     {{rendered_value}}


  #     ;;
  # }



}
