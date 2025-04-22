# The name of this view in Looker is "V Dim Dsp Date"
view: v_dim_dsp_date {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_dim_dsp_date ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_Key ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Day Number In Month" in Explore.

  dimension: day_number_in_month {
    type: number
    sql: ${TABLE}.Day_Number_In_Month ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_day_number_in_month {
    type: sum
    sql: ${day_number_in_month} ;;  }
  measure: average_day_number_in_month {
    type: average
    sql: ${day_number_in_month} ;;  }

  dimension: day_number_in_week {
    type: number
    sql: ${TABLE}.Day_Number_In_Week ;;
  }

  dimension: day_number_in_year {
    type: number
    sql: ${TABLE}.Day_Number_In_Year ;;
  }

  dimension: day_of_week_name {
    type: string
    sql: ${TABLE}.Day_Of_Week_Name ;;
  }

  dimension: day_suffix {
    type: string
    sql: ${TABLE}.Day_Suffix ;;
  }

  dimension: holiday_text {
    type: string
    sql: ${TABLE}.Holiday_Text ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.Month_Name ;;
  }

  dimension: month_number {
    type: number
    sql: ${TABLE}.Month_Number ;;
  }

  dimension: quarter_name {
    type: string
    sql: ${TABLE}.Quarter_Name ;;
  }

  dimension: quarter_name_short {
    type: string
    sql: ${TABLE}.Quarter_Name_Short ;;
  }

  dimension: quarter_number {
    type: number
    sql: ${TABLE}.Quarter_Number ;;
  }

  dimension: week_number_in_month {
    type: number
    sql: ${TABLE}.Week_Number_In_Month ;;
  }

  dimension: week_number_in_year {
    type: number
    sql: ${TABLE}.Week_Number_In_Year ;;
  }

  dimension: year_and_quarter {
    type: string
    sql: ${TABLE}.Year_And_Quarter ;;
  }

  dimension: year_number {
    type: number
    sql: ${TABLE}.Year_Number ;;
  }
  measure: count {
    type: count
    drill_fields: [day_of_week_name, quarter_name, month_name]
  }
}
