# The name of this view in Looker is "V Dim Date"
view: v_dim_date {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Date ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    label: "Date"
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
    sql: ${TABLE}.Date_Key ;;

  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Day Number In Month" in Explore.

  dimension: day_number_in_month {
    type: number
    sql: ${TABLE}.Day_Number_In_Month ;;
  }

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

  dimension: last_120_days_flag {
    type: number
    sql: ${TABLE}.Last_120_Days_Flag ;;
    hidden: yes
  }

  dimension: last_14_days_flag {
    type: number
    sql: ${TABLE}.Last_14_Days_Flag ;;
    hidden: yes
  }

  dimension: last_180_days_flag {
    type: number
    sql: ${TABLE}.Last_180_Days_Flag ;;
    hidden: yes
  }

  dimension: last_30_days_flag {
    type: number
    sql: ${TABLE}.Last_30_Days_Flag ;;
    hidden: yes
  }

  dimension: last_7_days_flag {
    type: number
    sql: ${TABLE}.Last_7_Days_Flag ;;
    hidden: yes
  }

  dimension: last_90_days_flag {
    type: number
    sql: ${TABLE}.Last_90_Days_Flag ;;
    hidden: yes
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

  dimension: year_and_month {
    type: string
    sql: ${TABLE}.Year_And_Month ;;
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
    drill_fields: [quarter_name, month_name, day_of_week_name]
    hidden: yes
  }
}
