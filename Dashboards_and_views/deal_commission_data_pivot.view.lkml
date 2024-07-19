view: deal_commission_data_pivot {
  derived_table: {
    sql: WITH s AS (
SELECT deal_id, personnel_name, event_date, totalrevenue, SalesSplitRevenue, SalesSplitNetRevenue, SalesSplitRevenue_No_Rebate, SalesSplitNetRevenue_No_Rebate
FROM "BI_New"."Deal_commission_data"
where personnel_role='Sales'
),
adops AS (
SELECT deal_id, personnel_name, event_date, totalrevenue, OpsSplitRevenue, OpsSplitNetRevenue
FROM "BI_New"."Deal_commission_data"
where personnel_role='AdOps'
),
acc AS (
SELECT event_date, agency, brand, deal_id, deal_start, deal_end, rebate_percent, deal_description, office, personnel_name, dsp_name, buy_type, totalrevenue, cogs, barter_rebate, gross_revenue, net_revenue, AMSplitRevenue, AMSplitNetRevenue
FROM "BI_New"."Deal_commission_data"
where personnel_role='Account Manager'
),
calc AS (
SELECT deal_id, event_date, totalrevenue, SUM(totalrevenue) as totalrev, SUM(CASE WHEN personnel_role='Sales' THEN 1 ELSE 0 END) as cnt, SUM(net_revenue) as netrev
FROM "BI_New"."Deal_commission_data"
group by deal_id, event_date, totalrevenue
)
SELECT acc.event_date, agency, brand, acc.deal_id, deal_start, deal_end, rebate_percent, deal_description, office, dsp_name, buy_type,
        s.personnel_name as sales, adops.personnel_name AS adops, acc.personnel_name AS account_manager,
        totalrev/cnt as total_revenue, netrev/cnt as net_revenue,
        SalesSplitRevenue, OpsSplitRevenue/cnt as OpsSplitRevenue, AMSplitRevenue/cnt as AMSplitRevenue,
        SalesSplitNetRevenue, OpsSplitNetRevenue/cnt as OpsSplitNetRevenue, AMSplitNetRevenue/cnt as AMSplitNetRevenue,
        SalesSplitRevenue_No_Rebate, SalesSplitNetRevenue_No_Rebate
FROM acc LEFT JOIN adops ON acc.deal_id=adops.deal_id AND acc.event_date=adops.event_date AND acc.totalrevenue=adops.totalrevenue
        LEFT JOIN s ON s.deal_id=acc.deal_id AND s.event_date=acc.event_date AND s.totalrevenue=acc.totalrevenue
        LEFT JOIN calc ON acc.deal_id=calc.deal_id AND acc.event_date=calc.event_date AND acc.totalrevenue=calc.totalrevenue
 ;;
  }

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }


  dimension: deal_start {
    type: date
    sql: ${TABLE}.deal_start ;;
  }

  dimension: deal_end {
    type: date
    sql: ${TABLE}.deal_end ;;
  }


  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: buy_type {
    type: string
    sql: ${TABLE}.Buy_Type ;;
  }


  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.dsp_name ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.net_revenue ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
  }

  dimension: sales {
    type: string
    sql: ${TABLE}.sales ;;
  }

  dimension: adops {
    type: string
    sql: ${TABLE}.adops ;;
  }

  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }


  measure: sales_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitNetRevenue ;;
  }

  measure: sales_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitRevenue ;;
  }

  measure: ops_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitNetRevenue ;;
  }

  measure: ops_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitRevenue ;;
  }

  measure: am_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitNetRevenue ;;
  }

  measure: am_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitRevenue ;;
  }

  measure: sales_split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitNetRevenue_No_Rebate ;;
  }

  measure: sales_split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitRevenue_No_Rebate ;;
  }

  measure: total_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.total_revenue ;;
  }


  dimension: rebate_percent {
    type: number
    sql: ${TABLE}.rebate_percent;;
  }

  measure: count {
    type: count
    drill_fields: [deal_id, sales]
  }
}
