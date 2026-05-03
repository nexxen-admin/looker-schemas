view: e2e_revenue_classified {

  derived_table: {
    sql:
      SELECT
        tc.event_month,
        UPPER(tc.Billing_Agency) AS buyer,
        bm.buyer_new AS mapped_buyer,
        tc.device_type,
        tc.impression_type,

      -- 1P Supply / 3P Demand
      SUM(CASE WHEN tc.category = 'Exch_3P_Demand' THEN tc.E2E_Revenue ELSE 0 END) AS Exch_3PD_Gross,
      SUM(CASE WHEN tc.category = 'Exch_3P_Demand' THEN tc.E2E_Cost ELSE 0 END) AS Exch_3PD_Cost,
      SUM(CASE WHEN tc.category = 'Exch_3P_Demand' THEN tc.E2E_Revenue ELSE 0 END)
      - SUM(CASE WHEN tc.category = 'Exch_3P_Demand' THEN tc.E2E_Cost ELSE 0 END) AS Exch_3PD_Net,

      -- 1P Demand / 1P Supply
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP = 'Nexxen' THEN tc.E2E_Revenue ELSE 0 END) AS "1PD_1PS_Gross",
      SUM(CASE WHEN tc.category = 'Exchange - Amobee_Non1058' THEN tc.E2E_Cost ELSE 0 END) AS "1PD_1PS_Cost",
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP = 'Nexxen' THEN tc.E2E_Revenue ELSE 0 END)
      - SUM(CASE WHEN tc.category = 'Exchange - Amobee_Non1058' THEN tc.E2E_Cost ELSE 0 END) AS "1PD_1PS_Net",

      -- 1P Demand / 3P Supply
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP != 'Nexxen' THEN tc.E2E_Revenue ELSE 0 END) AS DMND_3PS_Gross,
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' THEN tc.E2E_Cost ELSE 0 END) AS DMND_3PS_Cost,
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP != 'Nexxen' THEN tc.E2E_Revenue ELSE 0 END)
      - SUM(CASE WHEN tc.category = 'Amobee - Non1058' THEN tc.E2E_Cost ELSE 0 END) AS DMND_3PS_Net

      FROM BI.SVC_TRMRCon_Consolidated tc
      LEFT OUTER JOIN BI.SVC_Buyer_Mapping_Master bm
      ON UPPER(bm.buyer_original) = UPPER(
      CASE WHEN tc.Billing_Agency ILIKE '%bidswitch%'
      THEN 'Bidswitch' ELSE tc.Billing_Agency END)
      WHERE bm.buyer_new != 'DELETE'
      GROUP BY 1, 2, 3, 4, 5
      ;;
  }

  # --- Dimensions ---

  dimension_group: event_month {
    type: time
    timeframes: [month, quarter, year, date]
    sql: ${TABLE}.event_month ;;
    datatype: date
  }

#   dimension: buyer {
#     description: "Original Buyer"
#     type: string
#     sql: ${TABLE}.buyer ;;
#   }

#   dimension: mapped_buyer {
#     type: string
#     sql: ${TABLE}.mapped_buyer ;;
# }

  dimension: buyer {
    label: "Original Customer"
    description: "Original Customer"
    type: string
    sql: ${TABLE}.buyer ;;
  }
  dimension: mapped_buyer {
    label: "Mapped Customer"
    type: string
    sql: ${TABLE}.mapped_buyer ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: impression_type {
    type: string
    sql: ${TABLE}.impression_type ;;
  }

  # --- Measures ---

  # --- 1P Supply / 3P Demand ---

  measure: 1p_supply_3p_demand_gross {
    label: "1P Supply- 3P Demand Gross"
    description: "Gross revenue of 3P demand running through the exchange (monetized on 1P Supply)"
    type: sum
    sql: ${TABLE}.Exch_3PD_Gross ;;
    value_format: "$#,##0"

  }

  measure: 1p_supply_3p_demand_cost {
    label: "1P Supply-3P Demand Cost"
    description: "Cost of 3P demand running through the exchange"
    type: sum
    sql: ${TABLE}.Exch_3PD_Cost ;;
    value_format: "$#,##0"
  }

  measure: 1p_supply_3p_demand_net {
    label: "1P Supply-3P Demand Net"
    description: "Net of 3P demand running through the exchange"
    type: sum
    sql: ${TABLE}.Exch_3PD_Net ;;
    value_format: "$#,##0"
  }

  # --- 1P Demand / 1P Supply ---

  measure: 1p_demand_1p_supply_gross {
    label: "1P Demand-1P Supply Gross"
    description: "Gross revenue for 1P demand running on 1P supply (this is the revenue recognized by the DSP)"
    type: sum
    sql: ${TABLE}."1PD_1PS_Gross" ;;
    value_format: "$#,##0"
  }

  measure: 1p_demand_1p_supply_cost {
    label: "1P Demand-1P Supply Cost"
    description: "Cost for 1P demand running on 1P supply (this is the cost recognized by the Exchange)"
    type: sum
    sql: ${TABLE}."1PD_1PS_Cost" ;;
    value_format: "$#,##0"
  }

  measure: 1p_demand_1p_supply_net {
    label: "1P Demand-1P Supply Net"
    description: "Net of 1P demand running on 1P supply"
    type: sum
    sql: ${TABLE}."1PD_1PS_Net" ;;
    value_format: "$#,##0"
  }

  # --- 1P Demand / 3P Supply ---

  measure: 1p_demand_3p_supply_gross {
    label: "1P Demand-3P Supply Gross"
    description: "Gross revenue for 1P demand running with 3P supply"
    type: sum
    sql: ${TABLE}.DMND_3PS_Gross ;;
    value_format: "$#,##0"
  }

  measure: 1p_demand_3p_supply_cost {
    label: "1P Demand-3P Supply Cost"
    description: "Cost of 1P demand running with 3P supply"
    type: sum
    sql: ${TABLE}.DMND_3PS_Cost ;;
    value_format: "$#,##0"
  }

  measure: 1p_demand_3p_supply_net {
    label: "1P Demand-3P Supply Net"
    description: "Net of 1P demand running on 3P supply"
    type: sum
    sql: ${TABLE}.DMND_3PS_Net ;;
    value_format: "$#,##0"
  }


  measure: total_net_e2e_revenue {
    label: "Total Net E2E Revenue"
    description: "Sum of net revenue across all three classification categories"
    type: number
    sql: ${1p_supply_3p_demand_net}
          + ${1p_demand_1p_supply_net}
          + ${1p_demand_3p_supply_net} ;;
    value_format: "$#,##0"
  }

  measure: 1p_supply_3p_demand_net_pct {
    label: "1P Supply – 3P Demand Net %"
    description: "Share of revenue generated from 3rd-party demand on 1st-party supply. Calculated as 1P Supply-3P Demand Net / Total Net E2E Revenue."
    type: number
    sql: ${1p_supply_3p_demand_net} / NULLIF(${total_net_e2e_revenue}, 0) ;;
    value_format: "0.00%"
  }

  measure: 1p_demand_1p_supply_net_pct {
    label: "1P Demand – 1P Supply Net %"
    description: "Share of revenue generated from 1st-party demand on 1st-party supply. Calculated as 1P Demand-1P Supply Net / Total Net E2E Revenue."
    type: number
    sql: ${1p_demand_1p_supply_net} / NULLIF(${total_net_e2e_revenue}, 0) ;;
    value_format: "0.00%"
  }

  measure: 1p_demand_3p_supply_net_pct {
    label: "1P Demand – 3P Supply Net %"
    description: "Share of revenue generated from 1st-party demand on 3rd-party supply. Calculated as 1P Demand-3P Supply Net / Total Net E2E Revenue."
    type: number
    sql: ${1p_demand_3p_supply_net} / NULLIF(${total_net_e2e_revenue}, 0) ;;
    value_format: "0.00%"
  }
  measure: total_gross {
    label: "Total Gross Revenue"
    type: number
    sql: ${1p_supply_3p_demand_gross}
      + ${1p_demand_1p_supply_gross}
      + ${1p_demand_3p_supply_gross} ;;
      value_format: "$#,##0"
  }

  measure: total_cost {
    label: "Total Cost"
    type: number
    sql: ${1p_supply_3p_demand_cost}
      + ${1p_demand_1p_supply_cost}
      + ${1p_demand_3p_supply_cost} ;;
      value_format: "$#,##0"
  }

# --- Demand Classification Totals (1P Demand-1P Supply + 1P Demand-3P Supply) ---

  measure: demand_total_revenue_gross {
    label: "Demand Total Revenue Gross"
    description: "Gross revenue across all 1P Demand classifications: 1P Demand-1P Supply Gross + 1P Demand-3P Supply Gross"
    type: number
    sql: ${1p_demand_1p_supply_gross} + ${1p_demand_3p_supply_gross} ;;
    value_format: "$#,##0"
  }
  measure: demand_total_cost {
    label: "Demand Total Cost"
    description: "Total cost across all 1P Demand classifications: 1P Demand-1P Supply Cost + 1P Demand-3P Supply Cost"
    type: number
    sql: ${1p_demand_1p_supply_cost} + ${1p_demand_3p_supply_cost} ;;
    value_format: "$#,##0"
  }
  measure: demand_total_net {
    label: "Demand Total Net"
    description: "Total net revenue across all 1P Demand classifications: 1P Demand-1P Supply Net + 1P Demand-3P Supply Net"
    type: number
    sql: ${1p_demand_1p_supply_net} + ${1p_demand_3p_supply_net} ;;
    value_format: "$#,##0"
  }

# --- Supply Classification Totals (1P Demand-1P Supply + 1P Supply-3P Demand) ---
  measure: supply_total_revenue_gross {
    label: "Supply Total Revenue Gross"
    description: "Gross revenue across all 1P Supply classifications: 1P Demand-1P Supply Gross + 1P Supply-3P Demand Gross"
    type: number
    sql: ${1p_demand_1p_supply_gross} + ${1p_supply_3p_demand_gross} ;;
    value_format: "$#,##0"
  }
  measure: supply_total_cost {
    label: "Supply Total Cost"
    description: "Total cost across all 1P Supply classifications: 1P Demand-1P Supply Cost + 1P Supply-3P Demand Cost"
    type: number
    sql: ${1p_demand_1p_supply_cost} + ${1p_supply_3p_demand_cost} ;;
    value_format: "$#,##0"
  }
  measure: supply_total_net {
    label: "Supply Total Net"
    description: "Total net revenue across all 1P Supply classifications: 1P Demand-1P Supply Net + 1P Supply-3P Demand Net"
    type: number
    sql: ${1p_demand_1p_supply_net} + ${1p_supply_3p_demand_net} ;;
    value_format: "$#,##0"
  }

}
