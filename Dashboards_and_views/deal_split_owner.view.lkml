view: deal_split_owner {
  sql_table_name: BI_New.fact_deal_split_owner ;;

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  measure: amsplit_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Cogs ;;
  }

  # dimension: deal_start {
  #   type: date
  #   sql: ${TABLE}.deal_start ;;
  # }

  # dimension: deal_end {
  #   type: date
  #   sql: ${TABLE}.deal_end ;;
  # }

  measure: amsplit_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Net_After_Barter ;;
  }

  measure: amsplit_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Gross_After_BR ;;
  }

  measure: amsplit_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Net_WithoutRebate ;;
  }

  measure: amsplit_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Gross_Revenue ;;
  }

  dimension: barter_rebate_dim {
    type: number
    sql: ${TABLE}.Unsplit_Barter_Rebate ;;
  }

  measure: barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Unsplit_Barter_Rebate ;;
  }


  dimension: brand {
    type: string
    drill_fields: [agency]
    sql: ${TABLE}.brand ;;
  }

  dimension: buy_type {
    type: string
    drill_fields: [brand, agency]
    sql: ${TABLE}.Buy_Type ;;
  }

  measure: cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Unsplit_COGS ;;
  }

  dimension: deal_description {
    type: string
    sql: ${TABLE}.Deal_Description ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.dsp_name ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }

  dimension: db_updated_number {
    type: number
    sql: EXTRACT(EPOCH FROM ${db_update_raw}) ;;
    label: "DB Updated Unix Time"
    hidden: yes
  }

  measure: max_database_update_timestamp {
    type: max
    sql: ${db_updated_number} ;;
    label: "Max DB Update"
    hidden: yes
  }


  measure: final_database_last_update {
    type: string
    sql: TO_CHAR(TO_TIMESTAMP(${max_database_update_timestamp}), 'YYYY-MM-DD HH24:MI:SS') ;;
    label: "Deal Commision Data DB Update Date"
    html:
    <div style="font-family: Arial, sans-serif; font-size: 11px; line-height: 1.5; text-align: center; color: #000000;">
      <span style="font-weight: normal; word-spacing: 4px;">Deal Commision Data DB Update Date (UTC)</span><br>
      <span style="word-spacing: 15px;">{{ rendered_value }}</span>
    </div> ;;}

  measure: gross_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Gross (Deal) Revenue"
    sql: ${TABLE}.Unsplit_Gross_After_Barter ;;
  }

  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Net Revenue"
    sql: ${TABLE}.Unsplit_Net_After_Barter ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
  }

  measure: ops_split_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplit_Cogs ;;
  }

  measure: ops_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplit_Net_After_Barter ;;
  }

  measure: ops_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplit_Gross_After_BR ;;
  }

  dimension: personnel_name {
    type: string
    sql: ${TABLE}.rx_personnel_name ;;
  }

  dimension: personnel_role {
    type: string
    sql: ${TABLE}.rx_personnel_role ;;
  }

  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type_detail ;;
  }

  measure: sales_split_barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Barter_Rebate ;;
  }

  measure: sales_split_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Cogs ;;
  }

  measure: sales_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Net_After_Barter ;;
  }

  measure: sales_split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Net_WithoutRebate ;;
  }

  measure: sales_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Gross_After_BR ;;
  }

  measure: sales_split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplit_Gross_Revenue ;;
  }

  # measure: total_revenue {
  #   type: sum
  #   value_format: "$#,##0.00"
  #   sql: ${TABLE}.TotalRevenue ;;
  # }

  measure: split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.rx_personnel_role='account manager' then CAST(${TABLE}.AMSplit_Gross_After_BR AS float)
              when ${TABLE}.rx_personnel_role='sales' then CAST(${TABLE}.SalesSplit_Gross_after_BR AS float)
              else CAST(${TABLE}.OpsSplit_Gross_After_BR AS float) end  ;;
  }

  measure: split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.rx_personnel_role='account manager' then CAST(${TABLE}.AMSplit_Net_After_Barter AS float)
              when ${TABLE}.rx_personnel_role='sales' then CAST(${TABLE}.SalesSplit_Net_After_Barter AS float)
              else CAST(${TABLE}.OpsSplit_Net_After_Barter AS float) end  ;;
  }

  measure: split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.rx_personnel_role='sales' then CAST(${TABLE}.SalesSplit_Gross_Revenue AS float)
      else null end  ;;
  }

  measure: split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.rx_personnel_role='sales' then CAST(${TABLE}.SalesSplit_Net_WithoutRebate AS float)
      else null end  ;;
  }

  # dimension: rebate_percent {
  #   type: number
  #   sql: ${TABLE}.rebate_percent;;
  # }

  # dimension: days_in_quarter{
  #   type: number
  #   sql:   datediff('day',${adjusted_delivered_start_date},case when ${deal_end} >=
  #     '2024-12-31' then '2024-12-31' else ${deal_end} end)+1;;
  # }

  # dimension: yesterday_date {
  #   type: date
  #   sql: date_trunc('day',current_timestamp)-1 ;;
  #   hidden: yes
  # }

  # dimension: adjusted_delivered_start_date {
  #   type: date
  #   sql: case when ${deal_start} > ${quarter_start} then ${deal_start} else ${quarter_start} end ;;
  # }

  # dimension: adjusted_delivered_end_date {
  #   type: date
  #   sql: case when ${deal_end} > ${yesterday_date} then
  #     ${yesterday_date} else ${deal_end} end ;;
  # }

  # dimension: days_so_far {
  #   type: number
  #   sql: datediff('day',${adjusted_delivered_start_date},${adjusted_delivered_end_date})+1 ;;
  # }

  # measure: current_q_daily_run_rate {
  #   type: number
  #   sql: ${split_revenue} / nullif(${max_days_so_far},0) ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: quarter_start {
  #   type: date
  #   sql: date_trunc('quarter',current_timestamp) ;;
  # }

  # measure: max_days_so_far {
  #   type: max
  #   sql: ${days_so_far} ;;
  #   hidden: yes
  # }

  # measure: max_days_in_quarter {
  #   type: max
  #   sql: ${days_in_quarter} ;;
  #   hidden: yes
  # }

  # measure: current_q_projected_split_rev {
  #   type: number
  #   sql: (${split_revenue} / nullif(${max_days_so_far},0))*${max_days_in_quarter} ;;
  #   value_format: "$#,##0.00"
  # }

 }
