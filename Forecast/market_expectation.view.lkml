view: market_expectation {
  sql_table_name: BI_DSP.MARKET_EXPECTATION ;;

  dimension: chance_team {
    type: string
    sql: CASE WHEN ${TABLE}.Chance_Team='ENTER' THEN 'Enterprise Sales'
              WHEN ${TABLE}.Chance_Team='STRAT' THEN 'Strategic Sales'
              WHEN ${TABLE}.Chance_Team='ALL' THEN 'All' END;;
  }

  dimension: new_vs_exisiting_customer {
    type: string
    sql: ${TABLE}.New_VS_Exisitng ;;
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
  measure: nr_booked_cleared {
    type: sum
    label: "NR Booked"
    value_format: "$#,##0"
    sql: CASE WHEN ${TABLE}.chance_team='ALL' THEN null ELSE  ${TABLE}.NR_Booked END ;;
    # hidden: yes
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
    sql: CASE WHEN ${TABLE}.NR_PACING=0 THEN null ELSE ${TABLE}.NR_PACING END  ;;
  }
  measure: status {
    type: number
    value_format: "0%"
    hidden: yes
    sql: ${nr_booked_cleared}/${nr_budget}  ;;
  }
  measure: html_kpi_nr_booked {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              NR Booked
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ nr_booked_cleared._rendered_value }}
              </div>
            </div>;;
  }
  measure: html_kpi_nr_budget {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              NR Budget
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ nr_budget._rendered_value }}
              </div>
            </div>;;
  }
}
