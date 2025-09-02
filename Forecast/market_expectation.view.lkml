view: market_expectation {
  sql_table_name: BI_DSP.MARKET_EXPECTATION ;;

  dimension: chance_team {
    type: string
    sql: ${TABLE}.Chance_Team ;;
  }


  dimension_group: report_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.report_month ;;
  }
  measure: nr_booked {
    type: sum
    label: "NR Booked"
    value_format: "$#,##0"
    sql: ${TABLE}.NR_Booked ;;
  }
  measure: nr_budget {
    type: sum
    label: "NR Budget"
    value_format: "$#,##0"
    sql: ${TABLE}.NR_Budget ;;
  }
  measure: nr_pacing {
    type: average
    label: "NR Pace %"
    value_format: "0%"
    sql: ${TABLE}.NR_PACING ;;
  }
}
