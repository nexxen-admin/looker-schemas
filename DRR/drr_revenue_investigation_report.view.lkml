view: drr_revenue_investigation_report {
    sql_table_name: bi.DRR_Daily_Revenue_Report ;;

#--------------------------------------------------DIMENSIONS-------------------------------------------------------

    dimension: category {
      type: string
      sql: ${TABLE}.Category ;;
      drill_fields: [subcategory]
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
      drill_fields: [file_record]
    }
    dimension: subcategory {
      type: string
      sql: ${TABLE}.Subcategory ;;
      drill_fields: [region]
    }

    parameter: dimension_value_parameter {
      hidden: yes
      label: "Dimension"
      type: unquoted
      allowed_value: {
        value:"category"
        label:"Category"
        }
      allowed_value: {
        value:"subcategory"
        label:"Subcategory"
        }
      allowed_value: {
        value:"region"
        label:"Region"
        }
      allowed_value: {
        value:"file_record"
        label:"File Record"}
    }

    dimension: dimension_from_parameter {
      hidden: yes
      type: string
      label_from_parameter: dimension_value_parameter
      sql: {% if dimension_value_parameter._parameter_value == "category" %} ${category}
          {%elsif dimension_value_parameter._parameter_value == "subcategory" %} ${subcategory}
          {%elsif dimension_value_parameter._parameter_value == "region" %} ${region}
          {%elsif dimension_value_parameter._parameter_value == "file_record" %} ${file_record}
      {% endif %};;
    }

  parameter: measure_value_parameter {
    hidden: yes
    label: "Measure for variance analysis"
    type: unquoted
    allowed_value: {
      value:"net_rev"
      label:"Net Revenue"
    }
    allowed_value: {
      value:"rev"
      label:"Revenue"
    }
    allowed_value: {
      value:"cost"
      label:"Cost"
    }
  }

  measure: measure_from_parameter_var {
    hidden: yes
    type: number
    label: "Absolute Dollar Variance Threshold"
    sql: {% if measure_value_parameter._parameter_value == "net_rev" %} ${net_revenue_var}
          {%elsif measure_value_parameter._parameter_value == "rev" %} ${revenue_var}
          {%elsif measure_value_parameter._parameter_value == "cost" %} ${cost_var}
      {% endif %};;
  }

  measure: measure_from_parameter_var_perc {
    type: number
    label: "Percentage Variance Threshold"
    sql: {% if measure_value_parameter._parameter_value == "net_rev" %} ${net_revenue_var_perc}
          {%elsif measure_value_parameter._parameter_value == "rev" %} ${revenue_var_perc}
          {%elsif measure_value_parameter._parameter_value == "cost" %} ${cost_var_perc}
      {% endif %};;
  }

#--------------------------------------------------POP-------------------------------------------------------
    filter: current_date_range {
      type: date
      label: "Cohort 1"
      description: "Select the first date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
      sql: ${period} IS NOT NULL ;;
    }

  filter: previous_date_range {
    type: date
    label: "Cohort 2"
    description: "Select the second date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
  }

    dimension: day_in_period {
      hidden: yes
      description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
      type: number
      sql:CASE
            WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${event_raw}) + 1
            WHEN {% condition previous_date_range %} ${event_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start previous_date_range %} AS TIMESTAMP), ${event_raw}) + 1
            END
        ;;
    }

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
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

    dimension: order_for_period {
      hidden: yes
      type: number
      sql:  CASE
                WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
                THEN 1
                WHEN {% condition previous_date_range %} ${event_raw} {% endcondition %}
                THEN 2
                END;;
    }

    dimension: period {

      label: "Period"
      description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
      type: string
      hidden: yes
      order_by_field: order_for_period
      sql:CASE WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
            OR {% condition previous_date_range %} ${event_raw} {% endcondition %}
                THEN 'YES' END;;
    }

    dimension: period_filtered_measures {
      hidden: yes
      description: "We are just using this for the filtered measures"
      type: string
      sql:CASE
          WHEN {% condition current_date_range %} ${event_raw} {% endcondition %} THEN 'this'
          WHEN {% condition previous_date_range %} ${event_raw} {% endcondition %} THEN 'previous'END;;
    }

  filter: mtd_only {
    label: "MTD"
    type: yesno
    sql:  EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE()) ;;
    description: "Filters the data to be only month to date"
  }

# Filtered measures


    measure: revenue_first {
      group_label: "Revenue"
      label: "Revenue - Cohort 1"
      type: sum
      sql:  ${TABLE}.Revenue ;;
      value_format: "$#,##0"
      filters: [period_filtered_measures: "this"]
    }

    measure: revenue_second{
      group_label: "Revenue"
      label: "Revenue - Cohort 2"
      type: sum
      sql: ${TABLE}.Revenue ;;
      value_format: "$#,##0"
      filters: [period_filtered_measures: "previous"]
    }

    measure: revenue_var {
      group_label: "Revenue"
      label: "Revenue Dollar Variance"
      type: number
      sql: ${revenue_first}-${revenue_second} ;;
      value_format: "$#,##0"
    }

  measure: revenue_var_perc {
    group_label: "Revenue"
    label: "Revenue % Variance"
    type: number
    sql: ${revenue_first}/${revenue_second} -1;;
    value_format: "0.00%"
  }

  measure: cost_first {
    group_label: "Cost"
    label: "Cost - Cohort 1"
    type: sum
    sql:  ${TABLE}.Cost ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: cost_second{
    group_label: "Cost"
    label: "Cost - Cohort 2"
    type: sum
    sql: ${TABLE}.Cost ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "previous"]
  }

  measure: cost_var {
    group_label: "Cost"
    label: "Cost Dollar Variance"
    type: number
    sql: ${cost_first}-${cost_second} ;;
    value_format: "$#,##0"
  }

  measure: cost_var_perc {
    group_label: "Cost"
    label: "Cost % Variance"
    type: number
    sql: ${cost_first}/${cost_second} -1 ;;
    value_format: "0.00%"
  }

    measure: net_revenue_first {
      group_label: "Net Revenue"
      label: "Net Revenue - Cohort 1"
      type: sum
      sql:  ${TABLE}.Revenue -  ${TABLE}.Cost ;;
      value_format: "$#,##0"
      filters: [period_filtered_measures: "this"]
    }

    measure: net_revenue_second{
      group_label: "Net Revenue"
      label: "Net Revenue - Cohort 2"
      type: sum
      sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
      value_format: "$#,##0"
      filters: [period_filtered_measures: "previous"]
    }

  measure: net_revenue_var {
    group_label: "Net Revenue"
    label: "Net Revenue Dollar Variance"
    type: number
    sql: ${net_revenue_first}-${net_revenue_second} ;;
    value_format: "$#,##0"
  }

  measure: net_revenue_var_perc {
    group_label: "Net Revenue"
    label: "Net Revenue % Variance"
    type: number
    sql: ${net_revenue_first}/${net_revenue_second} -1 ;;
    value_format: "0.00%"
  }

    measure: gp_first {
      group_label: "GP %"
      label: "GP % - Cohort 1"
      type: number
      sql:  ${net_revenue_first}/${revenue_first} ;;
      value_format: "0.00%"
    }

  measure: gp_second {
    group_label: "GP %"
    label: "GP % - Cohort 2"
    type: number
    sql:  ${net_revenue_second}/${revenue_second} ;;
    value_format: "0.00%"
  }

  measure: gp_var {
    group_label: "GP %"
    label: "GP % Variance"
    type: number
    sql: ${gp_first}-${gp_second} ;;
    value_format: "0.00%"
  }

  measure: gp_var_perc {
    group_label: "GP %"
    label: "GP % % Variance"
    type: number
    sql: ${gp_first}/${gp_second} -1 ;;
    value_format: "0.00%"
  }


  }
