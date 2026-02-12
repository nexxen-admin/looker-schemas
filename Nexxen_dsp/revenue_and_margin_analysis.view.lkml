view: revenue_and_margin_analysis {
  derived_table: {
    # Non-Persistent Mode (Standard Subquery)
    # datagroup_trigger: CleanCash_datagroup
    # indexes: ["account_name", "date_month"]

    sql:
      SELECT
          dim_sfdb_account."name" AS account_name,
          v_dim_sfdb_related_account."name" AS related_brand_name,
          dim_dsp_advertiser.advertiser_name AS advertiser_name,

          -- DATE COLUMN FOR DIMENSION GROUP (Cast to DATE type)
          CAST(DATE_TRUNC('month', fact_nexxen_dsp.date_key_in_timezone) AS DATE) AS join_date,

          -- Keep existing string columns if needed for specific logic, but dimension_group replaces them mostly
          TO_CHAR(DATE_TRUNC('month', fact_nexxen_dsp.date_key_in_timezone), 'YYYY-MM') AS date_month,

          -- Measures
          COALESCE(SUM(fact_nexxen_dsp.inventory_cost), 0) AS inventory_cost,
          COALESCE(SUM(fact_nexxen_dsp.fdw_cost), 0) AS fdw_cost,
          COALESCE(SUM(fact_nexxen_dsp.impressions), 0) AS impressions,
          SUM(billing_unified_revenue.locked_final_billable_revenue_after_adj_usd) AS revenue_usd

      FROM BI_DSP.fact_nexxen_dsp AS fact_nexxen_dsp

      INNER JOIN BI_DSP.dim_sfdb_account AS dim_sfdb_account
      ON fact_nexxen_dsp.account_id_key = dim_sfdb_account.account_id_key

      INNER JOIN BI_DSP.dim_dsp_advertiser AS dim_dsp_advertiser
      ON fact_nexxen_dsp.advertiser_id_key = dim_dsp_advertiser.advertiser_id_key

      INNER JOIN BI_DSP.dim_sfdb_opportunity AS dim_sfdb_opportunity
      ON fact_nexxen_dsp.opportunity_id_key = dim_sfdb_opportunity.opportunity_id_key

      LEFT JOIN BI_DSP.v_dim_sfdb_related_account AS v_dim_sfdb_related_account
      ON dim_sfdb_opportunity.related_account__c = v_dim_sfdb_related_account.id

      INNER JOIN BI_DSP.dim_sfdb_opportunitylineitem AS dim_sfdb_opportunitylineitem
      ON fact_nexxen_dsp.opportunitylineitem_key = dim_sfdb_opportunitylineitem.opportunitylineitem_key

      LEFT JOIN BI_DSP.billing_unified_revenue AS billing_unified_revenue
      ON billing_unified_revenue.case_safe_opp_line_item_id = dim_sfdb_opportunitylineitem.id
      AND billing_unified_revenue.date_key = CAST(DATE_TRUNC('month', fact_nexxen_dsp.date_key_in_timezone) AS DATE)

      -- Filter: Adjust range as needed
      WHERE fact_nexxen_dsp.date_key_in_timezone >= '2024-01-01'

      GROUP BY 1, 2, 3, 4, 5
      ;;
  }

  # --- DIMENSIONS ---

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${account_name} || '-' || ${date_key_in_timezone_month} || '-' || ${related_brand_name} ;;
  }

  # --- NEW DIMENSION GROUP ---
  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date in Timezone"
    sql: ${TABLE}.join_date ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
    drill_fields: [related_brand_name]
  }

  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  dimension: account_name_drill_to_related_brand {
    type: string
    label: "Account Name (Drill to Related Brand)"
    description: "Click to drill down into Related Brand details"
    sql: ${account_name} ;;
    drill_fields: [
      related_brand_name,
      total_revenue,
      margin_usd,
      margin_percent
    ]
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  # Keep the manual string dimensions if you rely on them for specific SQL logic,
  # otherwise dimension_group covers them.
  dimension: date_month_string {
    label: "Month (String)"
    hidden: yes
    type: string
    sql: ${TABLE}.date_month ;;
  }

  parameter: top_x_rank_limit {
    type: unquoted
    label: "Top X Accounts"
    view_label: "Dashboard Filters"
    description: "Select number of top accounts to display"
    default_value: "5"
    allowed_value: { label: "Top 5" value: "5" }
    allowed_value: { label: "Top 10" value: "10" }
    allowed_value: { label: "Top 15" value: "15" }
    allowed_value: { label: "Top 20" value: "20" }
  }

  measure: top_x_limit_value {
    type: number
    label: "Top X Limit Value"
    #hidden: yes
    sql: MAX({% parameter top_x_rank_limit %}) ;;
  }

  # --- MEASURES ---

  measure: total_revenue {
    type: sum
    label: "Revenue USD (Locked)"
    sql: ${TABLE}.revenue_usd ;;
    value_format: "$#,##0.00"
  }

  measure: total_inventory_cost {
    type: sum
    label: "Inventory Cost"
    sql: ${TABLE}.inventory_cost ;;
    value_format: "$#,##0.00"
  }

  measure: total_fdw_cost {
    type: sum
    label: "FDW Cost"
    sql: ${TABLE}.fdw_cost ;;
    value_format: "$#,##0.00"
  }

  measure: total_impressions {
    type: sum
    label: "Impressions"
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: total_data_external_cost {
    type: number
    label: "Total Data & External Adserver Cost USD"
    sql: ${total_fdw_cost} - ${total_inventory_cost} ;;
    value_format: "$#,##0.00"
  }

  measure: margin_usd {
    type: number
    label: "Margin USD"
    sql: ${total_revenue} - ${total_inventory_cost} - ${total_data_external_cost} ;;
    value_format: "$#,##0.00"
  }

  measure: margin_percent {
    type: number
    label: "Margin %"
    sql: ${margin_usd} / NULLIF(${total_revenue},0) ;;
    value_format: "0.00%"
  }
}
