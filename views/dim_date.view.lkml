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
    description: "should be used when comparing month to month while including the current not complited month -
                  in this case the - Is Before Mtd,
                  will filter the other months on exact days of the not complited month.
                  e.g when comparing last 2 monthes January and Fabuarty and the current month is Fab and the day is 16 ,
                  the - Is Before Mtd will filter Jan to be 1-16 also "
    type: yesno
    sql: DATE_PART('DAY', ${date_key_raw}::TIMESTAMP) < DATE_PART('DAY', CURRENT_TIMESTAMP) ;;

  }



  dimension: is_before_ytd {
    description: "should be used when comparing year to year while including the current not complited year -
                  in this case the - Is Before Ytd,
                  will filter the other years on exact months of the not complited year.
                  e.g when comparing last 2 years 2023 and 2022 and the current year is 2023 and the month is march,
                  the - Is Before Ytd will filter 2022 to be Jan-Mar also"
    type: yesno
    sql: DATE_PART('YEAR', ${date_key_raw}::TIMESTAMP) < DATE_PART('YEAR', CURRENT_TIMESTAMP) ;;

  }
  dimension: is_before_qtd {

    type: number
    sql: case when month(${date_key_raw}) = month(current_date-1) then ${month_number_in_quarter} end;;
  # hidden: yes
  }

  dimension: current_month_number_in_quarter{

    type: number
    sql: case when ${month_number_in_quarter} = ${is_before_qtd} then ${month_number_in_quarter} end;;

  }

  dimension: day_number_in_month {
    type: number
    sql: ${TABLE}.Day_Number_In_Month ;;
  }

  dimension: month_number_in_quarter {
    type: number
    sql: case when ${month_number} in ('1','4','7','10') then 1
         when ${month_number} in ('2','5','8','11') then 2
        when ${month_number} in ('3','6','9','12') then 3 end;;
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


  dimension:  Week_Frame {
    label: "Week_Frame"
    type: string
    sql:  CASE WHEN ${TABLE}.Date_Key >= current_date()-28 and ${TABLE}.Date_Key < current_date()-21 THEN '4 Weeks Ago'
           WHEN ${TABLE}.Date_Key >= current_date()-14 and ${TABLE}.Date_Key < current_date()-7 THEN '2 Weeks Ago'
           WHEN ${TABLE}.Date_Key >= current_date()-7 and ${TABLE}.Date_Key < current_date() THEN 'Last Week'
           ELSE 'Other' END ;;
}
}
