# The name of this view in Looker is "New Revenue"
view: new_revenue {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.New_Revenue ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cogs" in Explore.

  measure: cogs {
    type: sum
    value_format: "$#,###.00"
    sql: ${TABLE}.cogs ;;
  }



  dimension_group: event_time {
    type: time
    timeframes:
    [ date,
      month,
      week,
      year,
      quarter,
      raw
    ]
    label: "Date"
    group_label: "Event Time"
    sql: ${TABLE}.Event_Time ;;
    #hidden: yes
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  #dimension: publisher_name {
   # type: string
   # sql: ${TABLE}.publisher_name ;;
  #}

  measure: revenue {
    type: sum
    value_format: "$#,###.00"
    sql: ${TABLE}.revenue;;
  }

  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
  }

  #  Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_Date ;;
  }

  measure: count {
    type: count
    #drill_fields: [publisher_name]
  }
  #--------------------------------------------------------
  filter: current_date_range {
    type: date
    view_label: "pop"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;

  }
  parameter: compare_to {
    view_label: "pop"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

  parameter: choose_breakdown {
    label: "Choose Grouping (Rows)"
    view_label: "pop"
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
    view_label: "pop"
    type: unquoted
    default_value: "month"
    allowed_value: {value: "year" }
    allowed_value: {value: "month"}

  }
  dimension: pop_pivot {
    view_label: "pop"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2 # Important
    sql:
        {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
        {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month}
        {% else %}NULL{% endif %} ;;
  }

  dimension: pop_row  {
    view_label: "pop"
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
    view_label: "pop"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), CAST({% date_end current_date_range %} AS TIMESTAMP)) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "pop"
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
    view_label: "pop"
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
            WHEN {% condition current_date_range %} ${event_time_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${event_time_raw}) + 1
            WHEN ${event_time_raw} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${event_time_raw}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    view_label: "pop"
    type: yesno
    sql:  (EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE())
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
                EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  }
  dimension: ytd_only {
    group_label: "To-Date Filters"
    label: "YTD"
    view_label: "pop"
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
                WHEN {% condition current_date_range %} ${event_time_raw} {% endcondition %}
                THEN 1
                WHEN ${event_time_raw} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }
## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
    view_label: "pop"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      quarter,
      month_name,
      month_num,
      year]

  }


  dimension: period {
    view_label: "pop"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    hidden: yes
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${event_time_raw} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${event_time_raw} between ${period_2_start} and ${period_2_end}
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
    description: "We just use this for the filtered measures"
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${event_time_raw} {% endcondition %} THEN 'this'
                WHEN ${event_time_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  # Filtered measures

  measure: current_period_revenue {
    view_label: "pop"
    label: "Revenue  {{_filters['current_date_range']}} "
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: current_period_margin {
    view_label: "pop"
    label: "Margin  {{_filters['current_date_range']}} "
    type: number
    sql: (${current_period_revenue}-${current_period_cost})/${current_period_revenue} ;;
    value_format: "0.00%"

  }
  measure: previous_period_margin {
    view_label: "pop"
    #label: " {{_filters['current_date_range']}} "
    type: number
    sql: case when ${previous_period_revenue}=0 then null else
    (${previous_period_revenue}-${previous_period_cost})/${previous_period_revenue} end ;;
    value_format: "0.00%"

  }


  measure: margin_pop_change {
    view_label: "pop"
    label: " Margin Previous{{_filters['compare_to']}} Change"
    type: number
    sql: CASE WHEN ${current_period_margin} = 0
                THEN NULL
                ELSE  (${current_period_margin} - ${previous_period_margin}) END ;;
    value_format_name: percent_2
    html:   {% if value > 0 %}
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
    {{rendered_value}} ;;
  }

  measure: previous_period_revenue{
    view_label: "pop"

    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: revenue_pop_change {
    view_label: "pop"
    label: " Revenue Previous{{_filters['compare_to']}} Change"
    type: number
    sql: CASE WHEN ${current_period_revenue} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_revenue} / NULLIF(${previous_period_revenue} ,0)) - 1 END ;;
    value_format_name: percent_2
    html:   {% if value > 0 %}
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
    {{rendered_value}} ;;
  }

  measure: current_period_cost {
    view_label: "pop"
    type: sum
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_cost{
    view_label: "pop"
    type: sum
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: cost_pop_change {
    view_label: "pop"
    label: "Total cost period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_revenue} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_revenue} / NULLIF(${previous_period_revenue} ,0)) - 1 END ;;
    value_format_name: percent_2
  }
  measure: current_period_profit {
    view_label: "pop"
    type: sum
    sql: (${TABLE}.revenue-${TABLE}.cogs) ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }
  measure: previous_period_profit{
    view_label: "pop"
    type: sum
    sql: (${TABLE}.revenue-${TABLE}.cogs) ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: profit_pop_change {
    view_label: "pop"
    label: "Total profit period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_profit} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_profit} / NULLIF(${previous_period_profit} ,0)) - 1 END ;;
    value_format_name: percent_2
  }
}
