view: fact_sfdb_forecast_snapshot {
  sql_table_name: BI_DSP.fact_sfdb_forecast_snapshot ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}.Account_Manager ;;
  }
  dimension: account_manager_2 {
    type: string
    sql: ${TABLE}.Account_Manager_2 ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}.Deal_Type ;;
  }
  dimension: forecast_bet {
    type: number
    sql: ${TABLE}.Forecast_Bet ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: CASE
           WHEN ${TABLE}.GR_Forecast_Full_Credit IS NULL THEN 0
           ELSE ${TABLE}.GR_Forecast_Full_Credit
         END ;;
    label: "GR Forecast Full Credit"
  }
  dimension: holding_company {
    type: string
    sql: ${TABLE}.Holding_company ;;
  }
  dimension: io_booked_units {
    type: number
    sql: ${TABLE}.IO_Booked_Units ;;
  }
  dimension: io_group_name {
    type: string
    sql: ${TABLE}.IO_Group_Name ;;
  }
  dimension: io_region {
    type: string
    sql: ${TABLE}.IO_Region ;;
  }
  dimension: io_sales_team {
    type: string
    sql: ${TABLE}.IO_Sales_Team ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}.IO_Super_Region ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}.IO_Type ;;
  }
  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.Opportunity_Owner ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.Related_Brand_ID ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension_group: schedule_revenue_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_end_date ;;
  }
  dimension_group: schedule_revenue_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_start_date ;;
  }
  dimension: snapshot_booked_full_credit {
    type: number
    sql: ${TABLE}.snapshot_booked_full_credit ;;
  }
  dimension_group: snapshot {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.snapshot_date ;;
  }
  dimension: snapshot_net_revenue_booked {
    type: number
    sql: ${TABLE}.snapshot_net_revenue_booked ;;
  }
  dimension: snapshot_nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
    label: "NR Forecast Full Credit"
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}.Social_Specialist ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}.TV_Specialist ;;
  }

  measure:sum_snapshot_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.snapshot_nr_forecast_full_credit ;;
    label: "Sum NR Forecast Full Credit"
  }

  measure:sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.gr_forecast_full_credit ;;
  }

  measure:sum_revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure:sum_snapshot_net_revenue_booked {
    type: sum
    sql: ${TABLE}.snapshot_net_revenue_booked ;;
  }

  measure:sum_snapshot_booked_full_credit {
    type: sum
    sql: ${TABLE}.gr_snapshot_booked_full_credit ;;
  }

  # --- New Measures for Min/Max Date Comparison ---
  # These measures use Liquid templating to directly get the min/max date from the applied filter.

  measure: sum_revenue_at_min_date {
    type: sum
    sql: CASE WHEN ${snapshot_date} = {% date_start fact_sfdb_forecast_snapshot.snapshot_date %} THEN ${TABLE}.revenue ELSE NULL END ;; # Corrected: Removed sql: | and outer DATE() cast
    value_format_name: usd
    label: "Sum Revenue (Min Date)"
    description: "Sum of revenue for the earliest date selected in the filter on the 'snapshot' dimension."
  }

  measure: sum_revenue_at_max_date {
    type: sum
    sql: CASE WHEN ${snapshot_date} = {% date_end fact_sfdb_forecast_snapshot.snapshot_date %} THEN ${TABLE}.revenue ELSE NULL END ;; # Corrected: Removed sql: | and outer DATE() cast
    value_format_name: usd
    label: "Sum Revenue (Max Date)"
    description: "Sum of revenue for the latest date selected in the filter on the 'snapshot' dimension."
  }




  measure: count {
    type: count
    drill_fields: [related_brand_name, account_name, opportunity_name, io_group_name]
  }
}
