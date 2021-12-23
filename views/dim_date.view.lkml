view: dim_date {
  sql_table_name: BI_New.V_Dim_Date ;;

  dimension_group: date_key {
    label: " "
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

  dimension: is_before_mtd {

    type: yesno
    sql: DATE_PART('DAY', ${date_key_raw}::TIMESTAMP) < DATE_PART('DAY', CURRENT_TIMESTAMP) ;;

  }

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
  }

  dimension: last_14_days_flag {
    type: number
    sql: ${TABLE}.Last_14_Days_Flag ;;
  }

  dimension: last_180_days_flag {
    type: number
    sql: ${TABLE}.Last_180_Days_Flag ;;
  }

  dimension: last_30_days_flag {
    type: number
    sql: ${TABLE}.Last_30_Days_Flag ;;
  }

  dimension: last_90_days_flag {
    type: number
    sql: ${TABLE}.Last_90_Days_Flag ;;
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
    drill_fields: [quarter_name, month_name, day_of_week_name]
  }
}
