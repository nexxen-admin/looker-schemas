view: supply_qps_and_bids {
  label: "Supply QPS and Bids"
  sql_table_name: rawdb.supply_qps_analytics ;;

  dimension_group: gmt{
    type: time
    label: "GMT"
    timeframes: [raw, time, date, week, month, quarter]
    sql: ${TABLE}.gmt_date ;;
  }

  dimension: country {
    type: string
    label: "Country"
    description: "Country ID for the audience segment"
    sql: ${TABLE}.country ;;
  }

  dimension: inventory_source_id {
    type: number
    label: "Inventory Source ID"
    sql: ${TABLE}.inventory_source_id ;;
    value_format_name: id
  }

  dimension: inventory_source_name {
    type: string
    label: "Inventory Source Name"
    sql: ${TABLE}.inventory_source_name ;;
  }

  dimension: media_channel_name {
    type: string
    label: "Media Channel Name"
    sql: ${TABLE}.media_channel_name ;;
  }

  dimension: ext_app {
    type: string
    label: "Ext App"
    description: "Implies Web or App environment"
    sql: ${TABLE}.ext_app ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.device_type ;;
  }

  dimension: format {
    type: string
    label: "Format"
    description: "Creative format on the campaign e.g. display or video"
    sql: ${TABLE}.format ;;
  }

  dimension: environment {
    type: string
    label: "Environment"
    description: "Media environment where ad is delivered - desktop web/ mobile web/ mobile app/ CTV app"
    sql: ${TABLE}.environment ;;
  }

  dimension: deal_or_open {
    type: string
    label: "Deal or Open"
    sql: ${TABLE}.deal_or_open ;;
  }

  dimension: deal_type {
    type: string
    label: "Deal Type"
    description: "The type of a deal"
    sql: ${TABLE}.deal_type ;;
  }

  dimension: pacing_type {
    type: string
    label: "Pacing Type"
    sql: ${TABLE}.pacing_type ;;
  }

  measure: bid_requests {
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: case when ${inventory_source_name} in ('Place Exchange', 'Vistar', 'VIOOH', 'Vizio') then ${TABLE}.est_bid_requests/50 else ${TABLE}.est_bid_requests end ;;
  }

  measure: bids {
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: ${TABLE}.est_bids ;;
  }

  measure: wins {
    type: sum
    sql: ${TABLE}.est_wins ;;
  }

  measure: ee_throttled_bids {
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: ${TABLE}.ee_throttled_bids ;;
  }

  measure: adstxt_nofile_bidreq {
    type: sum
    sql: ${TABLE}.adstxt_nofile_bidreq ;;
  }

  measure: adstxt_unauth_bidreqs {
    type: sum
    sql: ${TABLE}.adstxt_unauth_bidreqs ;;
  }

  measure: adstxt_auth_bidreqs {
    type: sum
    sql: ${TABLE}.adstxt_auth_bidreqs ;;
  }

  measure: first_price_bidreqs {
    type: sum
    sql: ${TABLE}.est_first_price_bidreqs ;;
  }

  measure: unrully_bid_requests {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bid_requests ELSE NULL END ;;
    value_format: "#,##0,,,\"B\""
  }

  measure: unrully_bids {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bids ELSE NULL END ;;
  }

  measure: unrully_wins {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_wins ELSE NULL END ;;
  }

  measure: unrully_ee_throttled_bids {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.ee_throttled_bids ELSE NULL END ;;
  }

  measure: unrully_adstxt_nofile_bidreq {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.adstxt_nofile_bidreq ELSE NULL END ;;
  }

  measure: unrully_adstxt_unauth_bidreqs {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.adstxt_unauth_bidreqs ELSE NULL END ;;
  }

  measure: unrully_adstxt_auth_bidreqs {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.adstxt_auth_bidreqs ELSE NULL END ;;
  }

  measure: unrully_first_price_bidreqs {
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_first_price_bidreqs ELSE NULL END ;;
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
    group_label: "Deliverydate Granularity"
    label: "Deliverydate Granularity"
    description: "For dynamic Delivery period Granularity. Use with Filter Date Granularity"
    sql:  CASE
      WHEN {% parameter date_granularity %} = 'Day'
        THEN ${gmt_date}
      When {% parameter date_granularity %} ='Week'
        THEN ${gmt_week}
      WHEN {% parameter date_granularity %} = 'Month'
        THEN ${gmt_month}
      WHEN {% parameter date_granularity %} = 'Quarter'
        THEN ${gmt_quarter}
      ELSE NULL
    END ;;
    hidden:  no
  }

  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
  }

  parameter: compare_to {
    view_label: "PoP"
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

## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##


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

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${gmt_date} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${gmt_date}) + 1
            WHEN ${gmt_date} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${gmt_date}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${gmt_date} {% endcondition %}
                THEN 1
                WHEN ${gmt_date} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

  ## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##

  dimension_group: created {hidden: yes}
  dimension: ytd_only {hidden:yes}
  dimension: mtd_only {hidden:yes}
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
      month,
      month_name,
      month_num,
      year]
  }


  dimension: period {
    view_label: "PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${gmt_date} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${gmt_date} between ${period_2_start} and ${period_2_end}
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
                WHEN {% condition current_date_range %} ${gmt_date} {% endcondition %} THEN 'this'
                WHEN ${gmt_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  # Filtered measures

  measure: current_period_bid_requests {
    view_label: "PoP"
    type: sum
    sql: case when ${inventory_source_name} in ('Place Exchange', 'Vistar', 'VIOOH', 'Vizio') then ${TABLE}.est_bid_requests/50 else ${TABLE}.est_bid_requests end ;;
    value_format: "#,##0,,,\"B\""
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_bid_requests {
    view_label: "PoP"
    type: sum
    sql: case when ${inventory_source_name} in ('Place Exchange', 'Vistar', 'VIOOH', 'Vizio') then ${TABLE}.est_bid_requests/50 else ${TABLE}.est_bid_requests end ;;
    value_format: "#,##0,,,\"B\""
    filters: [period_filtered_measures: "last"]
  }

  measure: bid_requests_pop_change {
    view_label: "PoP"
    label: "Total Bid Requests period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_bid_requests} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_bid_requests} / NULLIF(${previous_period_bid_requests} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

  measure: current_period_unruly_bid_requests {
    view_label: "PoP"
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bid_requests ELSE NULL END ;;
    value_format: "#,##0,,,\"B\""
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_unruly_bid_requests {
    view_label: "PoP"
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bid_requests ELSE NULL END ;;
    value_format: "#,##0,,,\"B\""
    filters: [period_filtered_measures: "last"]
  }

  measure: unruly_bid_requests_pop_change {
    view_label: "PoP"
    label: "Unruly Bid Requests period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_unruly_bid_requests} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_unruly_bid_requests} / NULLIF(${previous_period_unruly_bid_requests} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

  measure: current_period_filtered_out_change {
    view_label: "PoP"
    type: sum
    value_format:  "0\%"
    sql: ${TABLE}.ee_throttled_bids/${TABLE}.est_bid_requests ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: current_period_filtered_out {
    view_label: "PoP"
    type: sum
    value_format:   "#,##0,,,\"B\""
    sql:  ${TABLE}.ee_throttled_bids ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: current_filtered_out_change {
    view_label: "PoP"
    #label: "Total Filtered Out period-over-period % change"
    type: number
    sql:   ${current_period_filtered_out} / NULLIF(${current_period_bid_requests} ,0) ;;
    value_format_name: percent_2
  }


  measure: previous_period_filtered_out {
    view_label: "PoP"
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: ${TABLE}.ee_throttled_bids;;
    filters: [period_filtered_measures: "last"]
  }

  measure: filtered_out_pop_change {
    view_label: "PoP"
    label: "Total Filtered Out period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_filtered_out} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_filtered_out} / NULLIF(${previous_period_filtered_out} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

  measure: current_period_unruly_filtered_out {
    view_label: "PoP"
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.ee_throttled_bids ELSE NULL END / ${TABLE}.est_bid_requests ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_unruly_filtered_out {
    view_label: "PoP"
    type: sum
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.ee_throttled_bids ELSE NULL END / ${TABLE}.est_bid_requests ;;
    filters: [period_filtered_measures: "last"]
  }

  measure: unruly_filtered_out_pop_change {
    view_label: "PoP"
    label: "Unruly Filtered Out period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_unruly_filtered_out} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_unruly_filtered_out} / NULLIF(${previous_period_unruly_filtered_out} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

  measure: current_period_bid {
    view_label: "PoP"
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: ${TABLE}.est_bids ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: current_bid_rate_change {
    view_label: "PoP"
    #label: "Total Filtered Out period-over-period % change"
    type: number
    #value_format:  "0\%"
    sql:   ${current_period_bid} / NULLIF(${current_period_bid_requests} ,0) ;;
    value_format_name: percent_2
  }

  measure: previous_period_bid {
    view_label: "PoP"
    type: sum
    value_format: "#,##0,,,\"B\""
    sql: ${TABLE}.est_bids ;;
    filters: [period_filtered_measures: "last"]
  }

  measure: previous_period_bid_rate {
    view_label: "PoP"
    #label: "Total Filtered Out period-over-period % change"
    type: number
    #value_format:  "0\%"
    sql:   ${previous_period_bid} / NULLIF(${previous_period_bid_requests} ,0) ;;
    value_format_name: percent_2
  }

  measure: bid_rate_pop_change {
    view_label: "PoP"
    label: "Total Bid Rate period-over-period % change"
    type: number
    sql: CASE WHEN ${current_bid_rate_change} = 0
                THEN NULL
                ELSE (1.0 * ${current_bid_rate_change} - NULLIF(${previous_period_bid_rate} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

  measure: current_period_unruly_bid_rate{
    view_label: "PoP"
    type: sum
    sql: COALESCE(CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bids ELSE NULL END / CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bid_requests ELSE NULL END, 0) ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_unruly_bid_rate {
    view_label: "PoP"
    type: sum
    sql: COALESCE(CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bids ELSE NULL END / CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.est_bid_requests ELSE NULL END, 0) ;;
    filters: [period_filtered_measures: "last"]
  }

  measure: unruly_filtered_out_bid_rate {
    view_label: "PoP"
    label: "Unruly Bid Rate period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_unruly_bid_rate} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_unruly_bid_rate} / NULLIF(${previous_period_unruly_bid_rate} ,0)) - 1 END ;;
    value_format_name: percent_2
  }
}
