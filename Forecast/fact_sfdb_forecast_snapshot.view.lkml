view: fact_sfdb_forecast_snapshot {
  sql_table_name: BI_DSP.fact_sfdb_forecast_snapshot ;;

  # dimension: io_super_region {
  #   type: string
  #   sql: ${TABLE}.IO_Super_Region ;;
  # }

  # sql_always_where: ${io_super_region} = 'NAM' ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}.Account_Manager ;;
  }
  dimension: account_manager_2 {
    type: string
    sql: ${TABLE}.Account_Manager_2 ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}.Deal_Type ;;
  }
  dimension: forecast_bet {
    type: number
    sql: ${TABLE}.Forecast_Bet ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: CASE
           WHEN ${TABLE}.GR_Forecast_Full_Credit IS NULL THEN 0
           ELSE ${TABLE}.GR_Forecast_Full_Credit
         END ;;
    label: "GR Forecast Full Credit"
  }
  dimension: holding_company {
    type: string
    sql: ${TABLE}.Holding_company ;;
  }
  dimension: io_booked_units {
    type: number
    sql: ${TABLE}.IO_Booked_Units ;;
  }
  dimension: io_group_name {
    type: string
    sql: ${TABLE}.IO_Group_Name ;;
  }
  dimension: io_region {
    type: string
    sql: ${TABLE}.IO_Region ;;
  }
  dimension: io_sales_team {
    type: string
    sql: ${TABLE}.IO_Sales_Team ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}.IO_Super_Region ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}.IO_Type ;;
  }
  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.Opportunity_Owner ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.Related_Brand_ID ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension_group: schedule_revenue_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_end_date ;;
  }
  dimension_group: schedule_revenue_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_start_date ;;
  }

  dimension: snapshot_booked_full_credit {
    type: number
    sql: ${TABLE}.snapshot_booked_full_credit ;;
    label:"GR Booked Full Credit"
  }
  dimension_group: snapshot {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.snapshot_date ;;
  }
  dimension: snapshot_net_revenue_booked {
    type: number
    sql: ${TABLE}.snapshot_net_revenue_booked ;;
    label: "NR Booked Full Credit"
  }


  dimension: snapshot_nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
    label: "NR Forecast Full Credit"
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}.Social_Specialist ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}.TV_Specialist ;;
  }

  dimension: Strat_Sales_Team {
    type: string
    sql: ${TABLE}.Strat_Sales_Team ;;
  }

  dimension: Strat_Sales_RVP {
    type: string
    sql: ${TABLE}.Strat_Sales_RVP ;;
    drill_fields: [opportunity_owner]
  }

  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
  }

  dimension: Snapshot_Forecast_Checkbox  {
    type: number
    sql: ${TABLE}.Snapshot_Forecast_Checkbox  ;;
  }

  dimension: date_key_in_timezone_raw {
    hidden: yes
    type: date
    sql: ${snapshot_date} ;;
  }



  #--------------------------------------------------pop-------------------------------------------------------
  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
 }

#
  filter: previous_date_range {
    type: date
    view_label: "PoP"
    label: "Previous Date Range"
    description: "Manually choose the date range for comparison"
    sql: ${period} IS NOT NULL ;;
  }


  # dimension:  date_for_html {
  #   type: date
  #   view_label: "PoP"
  #   sql: ${current_date_range} ;;
  #   html:
  #   <ul>
  #       <li> value: {{ rendered_value }} </li>
  #   </ul> ;;

  # }



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
  #               WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %}
  #               THEN 'This {% parameter compare_to %}'
  #               WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end}
  #               THEN 'Last {% parameter compare_to %}'
  #               END
  #           {% else %}
  #               NULL
  #           {% endif %}
  #           ;;
  # }


  dimension: period {
    view_label: "PoP"
    label: "Period"
    # hidden: yes
    type: string
    sql:
    CASE
      WHEN {% condition current_date_range %} ${snapshot_date} {% endcondition %}
        THEN 'Current'
      WHEN {% condition previous_date_range %} ${snapshot_date} {% endcondition %}
        THEN 'Previous'
      ELSE NULL
    END ;;
  }

  # dimension: period {
  #   view_label: "PoP"
  #   label: "Period"
  #   # hidden: yes
  #   type: string
  #   sql:
  #   CASE
  #     WHEN {% condition current_date_range %} ${schedule_revenue_start_date} {% endcondition %}
  #       THEN 'Current'
  #     WHEN {% condition previous_date_range %} ${schedule_revenue_start_date} {% endcondition %}
  #       THEN 'Previous'
  #     ELSE NULL
  #   END ;;
  # }


  ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  # dimension: period_filtered_measures {
  #   hidden: yes
  #   description: "We are just using this for the filtered measures"
  #   type: string
  #   sql:
  #           {% if current_date_range._is_filtered %}
  #               CASE
  #               WHEN {% condition current_date_range %} ${date_key_in_timezone_raw} {% endcondition %} THEN 'this'
  #               WHEN ${date_key_in_timezone_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
  #           {% else %} NULL {% endif %} ;;
  # }

  dimension: period_filtered_measures {
    hidden: yes
    description: "Used to split current and previous periods"
    type: string
    sql:
    CASE
      WHEN {% condition current_date_range %} ${snapshot_date} {% endcondition %} THEN 'this'
      WHEN {% condition previous_date_range %} ${snapshot_date} {% endcondition %} THEN 'last'
      ELSE NULL
    END ;;
  }

  # dimension: period_filtered_measures {
  #   hidden: yes
  #   description: "Used to split current and previous periods"
  #   type: string
  #   sql:
  #   CASE
  #     WHEN {% condition current_date_range %} ${schedule_revenue_start_date} {% endcondition %} THEN 'this'
  #     WHEN {% condition previous_date_range %} ${schedule_revenue_start_date} {% endcondition %} THEN 'last'
  #     ELSE NULL
  #   END ;;
  # }

          ###----NR Booked Full Credit POP---###

  measure: current_period_net_revenue_booked {
    view_label: "NR Booked Full Credit POP"
    type: sum
    description: "Current period NR Booked"
    sql: ${TABLE}.snapshot_net_revenue_booked   ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "this"]
    label: "NR Booked Full Credit (Current)"
  }

  measure: previous_period_net_revenue_booked {
    view_label: "NR Booked Full Credit POP"
    type: sum
    description: "Previous period NR Booked"
    sql: ${TABLE}.snapshot_net_revenue_booked  ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "last"]
    label: "NR Booked Full Credit (Previous)"
  }

  measure: delta_nr_booked_Full_Credit {
    view_label: "NR Booked Full Credit POP"
    type: number
    sql: ${current_period_net_revenue_booked} - ${previous_period_net_revenue_booked} ;;
    label: "NR Booked Full Credit Delta"
    value_format: "#,##0.00"
  }

  measure: percent_nr_booked_Full_Credit {
    view_label: "NR Booked Full Credit POP"
    type: number
    sql: (100.0 * (${current_period_net_revenue_booked} - ${previous_period_net_revenue_booked}) / NULLIF(${previous_period_net_revenue_booked}, 0)) ;;
    value_format_name: percent_2
    label: "% Change in NR Booked Full Credit"
  }





      ####- view_label: NR Forecast Full Credit POP"-#####


    measure: current_period_snapshot_nr_forecast_full_credit {
      view_label: "NR Forecast Full Credit POP"
      type: sum
      description: "Current NR Forecast Full Credit"
      sql: ${TABLE}.snapshot_NR_forecast_full_credit  ;;
      value_format: "#,##0.00"
      filters: [period_filtered_measures: "this"]
      label: "NR Forecast Full Credit (Current)"
    }

    measure: previous_period_snapshot_nr_forecast_full_credit {
      view_label: "NR Forecast Full Credit POP"
      type: sum
      description: "Previous NR Forecast Full Credit"
      sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
      value_format: "#,##0.00"
      filters: [period_filtered_measures: "last"]
      label: "NR Forecast Full Credit (Previous)"
    }

    measure: delta_nr_forecast_Full_Credit {
      view_label: "NR Forecast Full Credit POP"
      type: number
      sql: ${current_period_snapshot_nr_forecast_full_credit} - ${previous_period_snapshot_nr_forecast_full_credit} ;;
      label: "NR Forecast Full Credit Delta"
      value_format: "#,##0.00"
    }

  measure: percent_nr_forecast_Full_Credit {
    view_label: "NR Forecast Full Credit POP"
    type: number
    sql: ((${current_period_snapshot_nr_forecast_full_credit} - ${previous_period_snapshot_nr_forecast_full_credit})
      / NULLIF(${previous_period_snapshot_nr_forecast_full_credit}, 0)) ;;
    value_format: "0.00%"
    label: "% Change in NR Forecast Full Credit"
  }


  # sql: (
  # ( ${current_period_GR_Forecast_Full_Credit} - ${previous_period_GR_Forecast_Full_Credit} )
  # / NULLIF(${previous_period_GR_Forecast_Full_Credit}, 0)
  # )


  ####-"GR Forecast Full Credit POP"-####

  measure: current_period_GR_Forecast_Full_Credit {
    view_label:"GR Forecast Full Credit POP"
    type: sum
    description: "Current GR Forecast Full Credit"
    sql: ${TABLE}.GR_Forecast_Full_Credit  ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "this"]
    label: "GR Forecast Full Credit (Current)"
  }

  measure: previous_period_GR_Forecast_Full_Credit {
    view_label: "GR Forecast Full Credit POP"
    type: sum
    description: "Previous GR Forecast Full Credit"
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "last"]
    label: "GR Forecast Full Credit (Previous)"
  }

  measure: delta_gr_forecast_Full_Credit {
    view_label: "GR Forecast Full Credit POP"
    type: number
    sql: ${current_period_GR_Forecast_Full_Credit} - ${previous_period_GR_Forecast_Full_Credit} ;;
    label: "GR Forecast Full Credit Delta"
    value_format: "#,##0.00"
  }

  # measure: percent_gr_forecast_full_credit {
  #   type: number
  #   sql: CASE
  #         WHEN ${previous_period_GR_Forecast_Full_Credit} = 0 THEN NULL
  #         ELSE (
  #           (${current_period_GR_Forecast_Full_Credit} - ${previous_period_GR_Forecast_Full_Credit})
  #           / NULLIF(${previous_period_GR_Forecast_Full_Credit}, 0)
  #         )
  #     END ;;
  #   value_format_name: percent_2
  #   label: "% Change in GR Forecast Full Credit"
  #   view_label: "GR Forecast Full Credit POP"
  # }

  #   measure: percent_gr_forecast_Full_Credit {
  #   view_label: "GR Forecast Full Credit POP"
  #   type: sum
  #   sql:  ${delta_gr_forecast_Full_Credit } ;;
  #   value_format_name: percent_2
  #   label: "% Change in GR Forecast Full Credit"
  # }

  measure: percent_change_gr_forecast_full_credit {
    view_label: "GR Forecast Full Credit POP"
    type: number
    sql: (
          ( ${current_period_GR_Forecast_Full_Credit} - ${previous_period_GR_Forecast_Full_Credit} )
          / NULLIF(${previous_period_GR_Forecast_Full_Credit}, 0)
        ) ;;
    value_format: "0.00%"
    label: "% Change in GR Forecast Full Credit"
  }



  # view_label: "GR Booked Full Credit POP"

  measure: current_period_snapshot_booked_full_credit {
    view_label: "GR Booked Full Credit POP"
    type: sum
    description: "Current GR Booked Full Credit"
    sql: ${TABLE}.snapshot_booked_full_credit  ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "this"]
    label: "GR Booked Full Credit (Current)"
  }

  measure: previous_period_snapshot_booked_full_credit {
    view_label: "GR Booked Full Credit POP"
    type: sum
    description: "Previous GR Booked Full Credit"
    sql: ${TABLE}.snapshot_booked_full_credit ;;
    value_format: "#,##0.00"
    filters: [period_filtered_measures: "last"]
    label: "GR Booked Full Credit (Previous)"
  }

  measure: delta_gr_Booked_Full_Credit {
    view_label: "GR Booked Full Credit POP"
    type: number
    sql: ${current_period_snapshot_booked_full_credit} - ${previous_period_snapshot_booked_full_credit} ;;
    label: "GR Booked Full Credit Delta"
    value_format: "#,##0.00"
  }

  measure: percent_gr_Booked_Full_Credit {
    view_label: "GR Booked Full Credit POP"
    type: number
    sql: (100.0 * (${current_period_snapshot_booked_full_credit} - ${previous_period_snapshot_booked_full_credit}) / NULLIF(${previous_period_snapshot_booked_full_credit}, 0)) ;;
    value_format_name: percent_2
    label: "% Change in GR Booked Full Credit"
  }




  # view_label: "Revenue POP"

  measure: sum_revenue_current {
    view_label: "Revenue POP"
    type: sum
    sql: ${revenue} ;;
    filters: [period: "Current"]
    label: "Revenue (Current)"
    value_format: "#,##0.00"
  }

  measure: sum_revenue_previous {
    view_label: "Revenue POP"
    type: sum
    sql: ${revenue} ;;
    filters: [period: "Previous"]
    label: "Revenue (Previous)"
    value_format: "#,##0.00"
  }


  measure: delta_revenue {
    view_label: "Revenue POP"
    type: number
    sql: ${sum_revenue_current} - ${sum_revenue_previous} ;;
    label: "Revenue Delta"
    value_format: "#,##0.00"
  }

  measure: percent_change_revenue {
    view_label: "Revenue POP"
    type: number
    sql: (100.0 * (${sum_revenue_current} - ${sum_revenue_previous}) / NULLIF(${sum_revenue_previous}, 0)) ;;
    value_format_name: percent_2
    label: "% Change in Revenue"
  }


  ### ---  Measures  ---###
  measure:sum_snapshot_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.snapshot_nr_forecast_full_credit ;;
    label: "NR Forecast Full Credit"
    value_format: "#,##0.00"
  }

  measure:sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.gr_forecast_full_credit ;;
    label:"GR Forecast Full Credit"
    value_format: "#,##0.00"
  }

  measure:sum_revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "#,##0.00"
  }

  measure:sum_snapshot_net_revenue_booked {
    type: sum
    sql: ${TABLE}.snapshot_net_revenue_booked ;;
    label: "NR Booked Full Credit"
    value_format: "#,##0.00"
  }

  # measure:sum_snapshot_booked_full_credit {
  #   type: sum
  #   sql: ${TABLE}.gr_snapshot_booked_full_credit ;;
  #   value_format: "#,##0.00"
  # }

  measure: sum_snapshot_booked_full_credit {
    type: sum
    sql: ${TABLE}.snapshot_booked_full_credit ;;
    label:"GR Booked Full Credit"
  }


  ###---QTD Comparison NR_forecast---###

  dimension: period_filtered_measures_qtd {
    # hidden: yes
    description: "Used only for comparing TODAY vs 1st day of current quarter"
    type: string
    sql:
    CASE
      WHEN ${snapshot_date} = CURRENT_DATE THEN 'this'
      WHEN ${snapshot_date} = DATE_TRUNC('quarter', CURRENT_DATE) THEN 'last'
      ELSE NULL
    END ;;
    view_label: "NR QTD Comparison"
  }

  measure: qtd_today_snapshot_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
    filters: [period_filtered_measures_qtd: "this"]
    label: "NR Forecast Full Credit (Today)"
    view_label: "NR QTD Comparison"
    value_format: "#,##0.00"
  }

  measure: qtd_start_snapshot_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
    filters: [period_filtered_measures_qtd: "last"]
    label: "NR Forecast Full Credit (QTD Start)"
    view_label: "NR QTD Comparison"
    value_format: "#,##0.00"
  }

  measure: qtd_delta_snapshot_nr_forecast_full_credit {
    type: number
    sql: ${qtd_today_snapshot_nr_forecast_full_credit} - ${qtd_start_snapshot_nr_forecast_full_credit} ;;
    label: "NR Forecast Delta (Today vs QTD Start)"
    value_format: "#,##0.00"
    view_label: "NR QTD Comparison"
  }

   ###---QTD Comparison GR_forecast---###

  measure: qtd_today_snapshot_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    filters: [period_filtered_measures_qtd: "this"]
    label: "GR Forecast Full Credit (Today)"
    view_label: "GR QTD Comparison"
    value_format: "#,##0.00"
  }

  measure: qtd_start_snapshot_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    filters: [period_filtered_measures_qtd: "last"]
    label: "GR Forecast Full Credit (QTD Start)"
    view_label: "GR QTD Comparison"
    value_format: "#,##0.00"
  }

  measure: qtd_delta_snapshot_gr_forecast_full_credit {
    type: number
    sql: ${qtd_today_snapshot_gr_forecast_full_credit} - ${qtd_start_snapshot_gr_forecast_full_credit} ;;
    label: "GR Forecast Delta (Today vs QTD Start)"
    value_format: "#,##0.00"
    view_label: "GR QTD Comparison"
  }


  measure: count {
    type: count
    drill_fields: [related_brand_name, account_name, opportunity_name, io_group_name]
  }
}
