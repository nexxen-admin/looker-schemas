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
  dimension: seller {
    type: string
    sql: ${TABLE}.Seller_key ;;
  }
  dimension: seller_key {
    type: string
    sql: LOWER(${TABLE}.Seller_key) ;;
    hidden: yes
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
  dimension: nr_budget {
    type: number
    sql: CASE WHEN ${TABLE}.Team = 'Strategic Sales' AND (${forecast_dim_sfdb_user.RVP_Sales_team} IS NULL OR ${forecast_dim_sfdb_user.RVP_Sales_team}='Unknown') THEN 0
    ELSE ${TABLE}.net_revenue_budget END;;
    hidden: yes
  }
  measure: net_revenue_budget {
    type: sum
    label: "NR Budget"
    value_format: "$#,##0"
    sql: ${nr_budget} ;;
  }
  measure: nr_pace {
    type: number
    label: "NR Pace %"
    value_format: "0%"
    sql: CASE WHEN ${net_revenue_budget}=0 THEN null ELSE ${net_revenue_booked}/${net_revenue_budget} END;;
  }
  measure: html_kpi_gr_booked {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              GR Booked
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ gross_revenue_booked._rendered_value }}
              </div>
            </div>;;
  }
  measure: html_kpi_gr_budget {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              GR Budget
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ gross_revenue_budget._rendered_value }}
              </div>
            </div>;;
  }
  measure: html_kpi_nr_booked {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              NR Booked
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ net_revenue_booked._rendered_value }}
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
                {{ net_revenue_budget._rendered_value }}
              </div>
            </div>;;
  }


}
