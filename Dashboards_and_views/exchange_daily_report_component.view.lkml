view: exchange_daily_report_component {
  derived_table: {
    sql: Select event_date::date as event_date,
      to_char(event_date, 'yy') as year,
      to_char(event_date, 'mm') as month,
      region,
      category,
      subcategory,
      record_type,
      file_record,
      Media_Type,
      Device_Type,
      Impression_Type,
      sum(revenue) as Revenue,
      sum(cost) as Cost
    From BI.SVC_DRR_Daily_Revenue_Report
    where event_date>= '2022-01-01' and event_date< current_date()-1
    --event_date >= date_trunc('quarter',timestampadd('month',-2,date_trunc('month',current_date())))
     -- and event_date < date_trunc('month',current_date())
    --and category = 'Exchange'
    Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    Order by 1, 2, 3, 4, 5

      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: Media_Type {
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: Device_Type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: Impression_Type {
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: file_record {
    type: string
    sql: ${TABLE}.file_record ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  measure: Revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue ;;
  }

  measure: Cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Cost ;;
  }

  measure: Net_Revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue-${TABLE}.Cost ;;
  }


  dimension_group: event {
    type: time
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      day_of_week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  measure: max_day {
    type: max
    sql: max(day(${event_month}) ;;
  }

  set: detail {
    fields: [file_record, Revenue]
  }


  #---------------------------------------------------------------POP------------------------------------------------------------------------
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

  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period_filtered_measures} IS NOT NULL ;;
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

  dimension: period_filtered_measures {
    hidden: yes
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${event_raw} {% endcondition %} THEN 'this'
                WHEN ${event_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${event_raw}) + 1
            WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${event_raw}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
    view_label: "PoP"
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      day_of_week,
      month,
      month_name,
      quarter,
      year]

  }

  dimension_group: previous_date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Previous Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, ${period_2_start}) ;;
    view_label: "PoP"
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      day_of_week,
      month,
      month_name,
      quarter,
      year]

  }


  measure: current_period_net_revenue {
    view_label: "PoP"
    type: sum
    description: "Current period Net Revenue"
    sql:  ${TABLE}.Revenue-${TABLE}.Cost;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_net_revenue{
    view_label: "PoP"
    type: sum
    description: "Previous period Net Revenue"
    sql: ${TABLE}.Revenue-${TABLE}.Cost ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

}
