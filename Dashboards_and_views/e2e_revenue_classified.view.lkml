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
      SUM(CASE WHEN tc.category = 'Exch_3P_Demand'
      THEN tc.E2E_Revenue ELSE 0 END) AS gross_3pd,
      SUM(CASE WHEN tc.category = 'Exch_3P_Demand'
      THEN tc.E2E_Cost ELSE 0 END) AS cost_3pd,

      -- 1P Demand / 1P Supply
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP = 'Nexxen'
      THEN tc.E2E_Revenue ELSE 0 END) AS gross_1pd_1ps,
      SUM(CASE WHEN tc.category = 'Exchange - Amobee_Non1058'
      THEN tc.E2E_Cost ELSE 0 END) AS cost_1pd_1ps,

      -- 1P Demand / 3P Supply
      SUM(CASE WHEN tc.category = 'Amobee - Non1058' AND tc.SSP != 'Nexxen'
      THEN tc.E2E_Revenue ELSE 0 END) AS gross_1pd_3ps,
      SUM(CASE WHEN tc.category = 'Amobee - Non1058'
      THEN tc.E2E_Cost ELSE 0 END) AS cost_1pd_3ps

      FROM BI.SVC_TRMRCon_Consolidated tc
      LEFT JOIN BI.SVC_Buyer_Mapping_Master bm
      ON UPPER(bm.buyer_original) = UPPER(
      CASE WHEN tc.Billing_Agency ILIKE '%bidswitch%'
      THEN 'Bidswitch' ELSE tc.Billing_Agency END)
      GROUP BY 1, 2, 3, 4, 5
      ;;

    datagroup_trigger: your_etl_datagroup
  }

# --- Dimensions ---

  dimension_group: event_month {
    type: time
    timeframes: [month, quarter, year]
    sql: ${TABLE}.event_month ;;
    datatype: date
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.buyer ;;
  }

  dimension: mapped_buyer {
    type: string
    sql: ${TABLE}.mapped_buyer ;;
    description: "Standardized buyer name from mapping table"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: impression_type {
    type: string
    sql: ${TABLE}.impression_type ;;
  }

  # --- 1P Supply / 3P Demand ---
  measure: 1p_supply_3p_demand_gross {
    label: "1P Supply - 3P Demand Gross"
    type: sum
    sql: ${TABLE}.gross_3pd ;;
    value_format_name: usd_0
  }

  measure: 1p_supply_3p_demand_cost {
    label: "1P Supply - 3P Demand Cost"
    type: sum
    sql: ${TABLE}.cost_3pd ;;
    value_format_name: usd_0
  }

  measure: 1p_supply_3p_demand_net {
    label: "1P Supply - 3P Demand Net"
    type: number
    sql: ${1p_supply_3p_demand_gross} - ${1p_supply_3p_demand_cost} ;;
    value_format_name: usd_0
  }

  # --- 1P Demand / 1P Supply ---
  measure: 1p_demand_1p_supply_gross {
    label: "1P Demand - 1P Supply Gross"
    type: sum
    sql: ${TABLE}.gross_1pd_1ps ;;
    value_format_name: usd_0
  }

  measure: 1p_demand_1p_supply_cost {
    label: "1P Demand - 1P Supply Cost"
    type: sum
    sql: ${TABLE}.cost_1pd_1ps ;;
    value_format_name: usd_0
  }

  measure: 1p_demand_1p_supply_net {
    label: "1P Demand - 1P Supply Net"
    type: number
    sql: ${1p_demand_1p_supply_gross} - ${1p_demand_1p_supply_cost} ;;
    value_format_name: usd_0
  }

  # --- 1P Demand / 3P Supply ---
  measure: 1p_demand_3p_supply_gross {
    label: "1P Demand - 3P Supply Gross"
    type: sum
    sql: ${TABLE}.gross_1pd_3ps ;;
    value_format_name: usd_0
  }

  measure: 1p_demand_3p_supply_cost {
    label: "1P Demand - 3P Supply Cost"
    type: sum
    sql: ${TABLE}.cost_1pd_3ps ;;
    value_format_name: usd_0
  }

  measure: 1p_demand_3p_supply_net {
    label: "1P Demand - 3P Supply Net"
    type: number
    sql: ${1p_demand_3p_supply_gross} - ${1p_demand_3p_supply_cost} ;;
    value_format_name: usd_0
  }

  # --- Totals for reconciliation ---
  measure: total_gross {
    type: number
    sql: ${1p_supply_3p_demand_gross}
       + ${1p_demand_1p_supply_gross}
       + ${1p_demand_3p_supply_gross} ;;
    value_format_name: usd_0
  }

  measure: total_net {
    type: number
    sql: ${1p_supply_3p_demand_net}
       + ${1p_demand_1p_supply_net}
       + ${1p_demand_3p_supply_net} ;;
    value_format_name: usd_0
  }

}
