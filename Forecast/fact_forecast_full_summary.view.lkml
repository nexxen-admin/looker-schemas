view: fact_forecast_full_summary {
  sql_table_name: BI_DSP.v_fact_forecast_full_summary ;;

  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension: team {
    type: string
    sql: ${TABLE}.Team ;;
  }
  measure: gross_revenue_booked {
    type: sum
    label: "GR Booked"
    value_format: "$#,##0"
    sql: ${TABLE}.gross_revenue_booked ;;
  }
  measure: gross_revenue_budget {
    type: sum
    label: "GR Budget"
    value_format: "$#,##0"
    sql: ${TABLE}.gross_revenue_budget ;;
  }
  measure: gr_pace {
    type: number
    label: "GR Pace %"
    value_format: "0%"
    sql: CASE WHEN ${gross_revenue_budget}=0 THEN null ELSE ${gross_revenue_booked}/${gross_revenue_budget} END ;;
  }
  measure: net_revenue_booked {
    type: sum
    label: "NR Booked"
    value_format: "$#,##0"
    sql: ${TABLE}.net_revenue_booked ;;
  }
  measure: net_revenue_budget {
    type: sum
    label: "NR Budget"
    value_format: "$#,##0"
    sql: ${TABLE}.net_revenue_budget ;;
  }
  measure: nr_pace {
    type: number
    label: "NR Pace %"
    value_format: "0%"
    sql: CASE WHEN ${net_revenue_budget}=0 THEN null ELSE ${net_revenue_booked}/${net_revenue_budget} END;;
  }
}
