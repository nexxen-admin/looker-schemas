view: deal_split_owner {
  sql_table_name: BI_New.fact_deal_split_owner ;;

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
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

  dimension: rebate_percent {
    type: number
    sql: CASE WHEN ${TABLE}.gross_revenue_record_split=0 THEN 0 ELSE  ${TABLE}.barter_rebate_Record_Split/${TABLE}.gross_revenue_record_split END ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
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


# -------------------------------UNSPLIT MEASURES-----------------------------------------

  measure: gross_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Gross (Deal) Revenue"
    sql: ${TABLE}.unsplit_gross_revenue ;;
  }

  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Net Revenue"
    description: "Total Revenue minus Cogs"
    sql: ${TABLE}.Unsplit_Net_After_Barter ;;
  }

  measure: cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Unsplit_COGS ;;
  }

  measure: total_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Total Revenue"
    description: "Unsplit Gross Revenue minus Barter Rebate"
    sql: ${TABLE}.Unsplit_Gross_After_Barter ;;
  }


# -------------------------------AM SPLIT MEASURES-----------------------------------------

  measure: amsplit_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplit_Cogs ;;
  }

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

  measure: barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Unsplit_Barter_Rebate ;;
  }

  measure: split_barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.barter_rebate_Record_Split ;;
  }


# -------------------------------OPS SPLIT MEASURES-----------------------------------------

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

  measure: ops_split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplit_Net_WithoutRebate ;;
  }

  measure: ops_split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplit_Gross_Revenue ;;
  }

# -------------------------------SALES SPLIT MEASURES-----------------------------------------

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


# -------------------------------MERGED MEASURES-----------------------------------------

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

 }
