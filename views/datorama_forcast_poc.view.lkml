# The name of this view in Looker is "Datorama Forcast Poc"
view: datorama_forcast_poc {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.datorama_forcast_poc ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Name" in Explore.

  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }

  measure: booked_access_credit {
    type: sum
    label: "TL Booked"
    value_format: "#,##0"
    sql: ${TABLE}.Booked_ACCESS_Credit ;;
  }

  dimension: day1 {
    type: date
    label: "Day"
    sql: ${TABLE}.Day1 ;;
    hidden: yes
  }
  dimension: date {
    type: date
    label: "Day"
    sql: ${TABLE}.Date ;;
  }

  dimension: deal_type {
    type: string
    sql: ${TABLE}.Deal_Type ;;
  }

  measure: delta_nr_booked {
    type: sum
    label: "Delta (NR Booked)"
    value_format: "#,##0.00"
    sql: ${TABLE}.Delta_NR_Booked ;;
  }

  measure: delta_nr_forecast_new {
    type: sum
    label:"Delta (NR Forecast) (NEW)"
    value_format: "#,##0.00"
    sql: ${TABLE}.Delta_NR_Forecast_NEW ;;
  }

  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }

  dimension: holding_company {
    type: string
    sql: ${TABLE}.Holding_Company ;;
  }

  dimension: month1 {
    type: string
    label: "Month"
    sql: ${TABLE}.Month1 ;;
  }

  measure: net_revenue_booked {
    type: sum
    sql: ${TABLE}.Net_Revenue_Booked ;;
  }

  measure: new_forecast_test_v3 {
    type: sum
    label:"TL Forecast"
    value_format: "#,##0"
    sql: ${TABLE}.New_Forecast_Test_v3 ;;
  }

  measure: new_net_revenue_forecast_test_v3 {
    type: sum
    label: "NR Forecast"
    value_format: "$0.00,,\" M\""
   sql: ${TABLE}.New_Net_Revenue_Forecast_Test_v3 ;;
  }

  measure: pct_of_target_nr_booked {
    type: average
    sql: ${TABLE}.pct_of_Target_NR_Booked ;;
  }

  measure: pct_of_target_nr_forecast_new {
    type: average
    sql: ${TABLE}.pct_of_Target_NR_Forecast_NEW ;;
  }

  dimension: platform_team {
    type: string
    sql: ${TABLE}.Platform_Team ;;
  }

  dimension: related_brand {
    type: string
    sql: ${TABLE}.Related_Brand ;;
  }

  dimension: revenue_line {
    type: string
    sql: ${TABLE}.Revenue_Line ;;
  }

  measure: sales_rep_target_usd_nr {
    type: sum
    label: "NR Target"
    value_format: "$0.00,,\" M\""
    sql: ${TABLE}.Sales_Rep_Target_USD_NR ;;
  }

  measure: count {
    type: count
    drill_fields: [account_name]
  }
}
