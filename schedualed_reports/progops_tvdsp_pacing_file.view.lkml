view: progops_tvdsp_pacing_file {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: WITH variables AS (
          SELECT
              TIMESTAMPADD(DAY, -1, current_timestamp AT TIME ZONE 'America/New_York')::date AS yesterday,
              '$FM999,999,999,999,999.00' AS usd,
              'FM999,999,999,999,999.00%' AS percent_2,
              'FM999,999,999,999,999.000%' AS percent_3,
              'FM999,999,999,999,999' AS interger
      ),

      flights AS (
      SELECT
      c.campaign_name,
      c.line_number,
      c.flight_number,
      c.flight_id,
      c.status,
      c.start_date::date,
      c.end_date::date,
      c.booked_rate,
      c.booked_amount, -- imps
      c.adjusted_amount, -- padding
      c.budget, -- $ USD
      c.kpi,
      TIMESTAMPDIFF(DAY, c.start_date, c.end_date)+1 AS flight_duration,
      TIMESTAMPDIFF(DAY, c.start_date, v.yesterday)+1 AS days_elasped,
      TIMESTAMPDIFF(DAY, v.yesterday, c.end_date) AS days_remaining,
      sfu.full_name AS CSM,
      sfu2.full_name AS Seller,
      sfo.adsale_number,
      sfo.stage,
      sff.ad_unit_type,
      sff.group_name,
      sff.target_details,
      sff.currency_code -- USD or CAD

      FROM variables v, dwh.campaign c
      LEFT JOIN Andromeda.sf_flight sff ON c.flight_number = sff.flight_number
      LEFT JOIN Andromeda.sf_opportunity sfo ON sff.opportunity_id = sfo.id
      LEFT JOIN Andromeda.sf_user sfu ON sfo.csm_id = sfu.id
      LEFT JOIN Andromeda.sf_user sfu2 ON sfo.seller_id = sfu2.id
      LEFT JOIN Andromeda.sf_account sa ON sfo.billing_agency = sa.id

      WHERE c.buy_type = 'Guaranteed_Managed_Service'
      AND c.start_date::date <= v.yesterday
      AND c.end_date::date >= v.yesterday
      AND (sa.billing_country IN ('United States', 'Canada') OR sa.billing_country IS NULL)
      AND sa.name IS NOT NULL
      ),

      metrics AS (
      SELECT
      m.flight_id,
      ZEROIFNULL(SUM(m.impressions)) AS impressions_ctd,
      ZEROIFNULL(SUM(m.completions)) AS completions_ctd,
      ZEROIFNULL(SUM(m.clicks)) AS clicks_ctd,
      ZEROIFNULL(SUM(m.revenue)) AS revenue_ctd,
      ZEROIFNULL(SUM(m.cost_inventory)) AS cost_inventory_ctd,
      ZEROIFNULL(SUM(CASE WHEN m.date::date = v.yesterday THEN m.impressions ELSE NULL END)) AS impressions_pd,
      ZEROIFNULL(SUM(CASE WHEN m.date::date = v.yesterday THEN m.completions ELSE NULL END)) AS completions_pd,
      ZEROIFNULL(SUM(CASE WHEN m.date::date = v.yesterday THEN m.clicks ELSE NULL END)) AS clicks_pd,
      ZEROIFNULL(SUM(CASE WHEN m.date::date = v.yesterday THEN m.revenue ELSE NULL END)) AS revenue_pd,
      ZEROIFNULL(SUM(CASE WHEN m.date::date = v.yesterday THEN m.cost_inventory ELSE NULL END)) AS cost_inventory_pd

      FROM variables v, dwh.metrics_sessions_daily m

      WHERE m.flight_id IN (SELECT flight_id FROM flights)
      AND m.date::date <= v.yesterday

      GROUP BY 1
      ),

      flights_metrics_raw AS (

      SELECT
      -- dimensions
      f.CSM,
      f.Seller,
      f.campaign_name,
      f.flight_number,
      f.flight_id,
      f.ad_unit_type,
      f.group_name,
      f.target_details,
      f.status,
      f.booked_amount,
      f.adjusted_amount,
      f.budget,
      f.kpi,
      f.start_date,
      f.end_date,
      f.days_remaining,
      CASE WHEN f.budget > m.revenue_ctd THEN NULL ELSE 'DIF' END AS dif_rev,
      CASE WHEN f.booked_amount + f.adjusted_amount > m.impressions_ctd THEN NULL ELSE 'DIF' END AS dif_imps,
      -- measures
      ---- cost & margin
      m.revenue_ctd,
      m.cost_inventory_ctd,
      m.cost_inventory_ctd/NULLIFZERO(m.impressions_ctd)*1000 AS ecpm_ctd,
      (m.revenue_pd-m.cost_inventory_pd)/NULLIFZERO(m.revenue_pd) AS margin_pd,
      (m.revenue_ctd-m.cost_inventory_ctd)/NULLIFZERO(m.revenue_ctd) AS margin_ctd,
      ---- KPI
      m.completions_pd/NULLIFZERO(m.impressions_pd) AS vcr_pd,
      m.completions_ctd/NULLIFZERO(m.impressions_ctd) AS vcr_ctd,
      m.clicks_pd/NULLIFZERO(m.impressions_pd) AS ctr_pd,
      m.clicks_ctd/NULLIFZERO(m.impressions_ctd) AS ctr_ctd,
      ---- pacing
      m.impressions_pd,
      m.impressions_ctd,
      m.impressions_pd/(NULLIFZERO(GREATEST(0, ((f.booked_amount+f.adjusted_amount)-(m.impressions_ctd-m.impressions_pd))/(f.days_remaining+1)))) AS pacing_imps_pd,
      m.impressions_ctd/NULLIFZERO((f.days_elasped*(f.booked_amount+f.adjusted_amount)/f.flight_duration)) AS pacing_imps_ctd,
      m.revenue_pd/NULLIFZERO((GREATEST(0, (f.budget-(m.revenue_ctd-m.revenue_pd))/(f.days_remaining+1)))) AS pacing_rev_pd,
      m.revenue_ctd/NULLIFZERO((f.days_elasped*f.budget/f.flight_duration)) AS pacing_rev_ctd,
      GREATEST(0, ((f.budget-(m.revenue_ctd-m.revenue_pd))/(f.days_remaining+1)-m.revenue_pd)*(f.days_remaining+1)) AS rev_risk

      FROM metrics m
      LEFT JOIN flights f ON m.flight_id = f.flight_id
      )

      -- formatted output
      SELECT
      -- dimensions
      r.CSM,
      r.Seller,
      r.campaign_name AS "DSP Campaign Name",
      r.flight_number AS "Flight Number",
      r.flight_id::varchar AS "DSP Placement ID",
      r.ad_unit_type AS "SF Ad Unit Type",
      r.group_name AS "SF Group Name",
      r.target_details AS "SF Target Details",
      r.status AS "DSP Flight Status",
      TO_CHAR(r.booked_amount, v.interger) AS "DSP Booked Quantity",
      TO_CHAR(r.adjusted_amount, v.interger) AS "DSP Adjusted Quantity",
      TO_CHAR(r.budget, v.usd) AS "DSP Booked Revenue",
      r.kpi AS "DSP KPI",
      r.start_date AS "DSP Flight Start Date",
      r.end_date AS "DSP Flight End Date",
      r.days_remaining AS "DSP Remaining Days",
      IFNULL(r.dif_rev, '-') AS "DIF (Revenue)",
      IFNULL(r.dif_imps, '-') AS "DIF (Quantity)",
      -- measures
      ---- cost & margin
      TO_CHAR(r.revenue_ctd, v.usd) AS "CTD Revenue",
      TO_CHAR(r.cost_inventory_ctd, v.usd) AS "CTD Inventory Cost",
      TO_CHAR(r.ecpm_ctd, v.usd) AS "CTD eCPM",
      IFNULL(TO_CHAR(r.margin_pd * 100, v.percent_2), '-') AS "PD Margin",
      IFNULL(TO_CHAR(r.margin_ctd * 100, v.percent_2), '-')  AS "CTD Margin",
      ---- KPI
      IFNULL(TO_CHAR(r.vcr_pd * 100, v.percent_2), '-') AS "PD VCR",
      IFNULL(TO_CHAR(r.vcr_ctd * 100, v.percent_2), '-') AS "CTD VCR",
      IFNULL(TO_CHAR(r.ctr_pd * 100, v.percent_3), '-') AS "PD CTR",
      IFNULL(TO_CHAR(r.ctr_ctd * 100, v.percent_3), '-') AS "CTD CTR",
      ---- pacing
      TO_CHAR(r.impressions_pd, v.interger) AS "PD Delivered Quantity",
      TO_CHAR(r.impressions_ctd, v.interger) AS "CTD Delivered Quantity",
      IFNULL(TO_CHAR(r.pacing_imps_pd * 100, v.percent_2), '-') AS "PD Pacing (Quantity)",
      IFNULL(TO_CHAR(r.pacing_imps_ctd * 100, v.percent_2), '-') AS "CTD Pacing (Quantity)",
      IFNULL(TO_CHAR(r.pacing_rev_pd * 100, v.percent_2), '-') AS "PD Pacing (Revenue)",
      IFNULL(TO_CHAR(r.pacing_rev_ctd * 100, v.percent_2), '-') AS "CTD Pacing (Revenue)",
      TO_CHAR(r.rev_risk, v.usd) AS "Revenue Risk"

      FROM flights_metrics_raw r, variables v
      ORDER BY 1, 2, 3, 4
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: csm {
    type: string
    label: "CSM"
    sql: ${TABLE}.CSM ;;
  }

  dimension: seller {
    type: string
    label: "Seller"
    sql: ${TABLE}.Seller ;;
  }

  dimension: dsp_campaign_name {
    type: string
    label: "DSP Campaign Name"
    sql: ${TABLE}."DSP Campaign Name" ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}."Flight Number" ;;
  }

  dimension: dsp_placement_id {
    type: string
    label: "DSP Placement ID"
    sql: ${TABLE}."DSP Placement ID" ;;
  }

  dimension: sf_ad_unit_type {
    type: string
    label: "SF Ad Unit Type"
    sql: ${TABLE}."SF Ad Unit Type" ;;
  }

  dimension: sf_group_name {
    type: string
    label: "SF Group Name"
    sql: ${TABLE}."SF Group Name" ;;
  }

  dimension: sf_target_details {
    type: string
    label: "SF Target Details"
    sql: ${TABLE}."SF Target Details" ;;
  }

  dimension: dsp_flight_status {
    type: string
    label: "DSP Flight Status"
    sql: ${TABLE}."DSP Flight Status" ;;
  }

  dimension: dsp_booked_quantity {
    type: string
    label: "DSP Booked Quantity"
    sql: ${TABLE}."DSP Booked Quantity" ;;
  }

  dimension: dsp_adjusted_quantity {
    type: string
    label: "DSP Adjusted Quantity"
    sql: ${TABLE}."DSP Adjusted Quantity" ;;
  }

  dimension: dsp_booked_revenue {
    type: string
    label: "DSP Booked Revenue"
    sql: ${TABLE}."DSP Booked Revenue" ;;
  }

  dimension: dsp_kpi {
    type: string
    label: "DSP KPI"
    sql: ${TABLE}."DSP KPI" ;;
  }

  dimension: dsp_flight_start_date {
    type: date
    label: "DSP Flight Start Date"
    sql: ${TABLE}."DSP Flight Start Date" ;;
  }

  dimension: dsp_flight_end_date {
    type: date
    label: "DSP Flight End Date"
    sql: ${TABLE}."DSP Flight End Date" ;;
  }

  dimension: dsp_remaining_days {
    type: number
    label: "DSP Remaining Days"
    sql: ${TABLE}."DSP Remaining Days" ;;
  }

  dimension: dif_revenue {
    type: string
    label: "DIF (Revenue)"
    sql: ${TABLE}."DIF (Revenue)" ;;
  }

  dimension: dif_quantity {
    type: string
    label: "DIF (Quantity)"
    sql: ${TABLE}."DIF (Quantity)" ;;
  }

  dimension: ctd_revenue {
    type: number
    label: "CTD Revenue"
    sql: ${TABLE}."CTD Revenue" ;;
  }

  dimension: ctd_inventory_cost {
    type: number
    label: "CTD Inventory Cost"
    sql: ${TABLE}."CTD Inventory Cost" ;;
  }

  dimension: ctd_e_cpm {
    type: number
    label: "CTD eCPM"
    sql: ${TABLE}."CTD eCPM" ;;
  }

  dimension: pd_margin {
    type: number
    label: "PD Margin"
    sql: ${TABLE}."PD Margin" ;;
  }

  dimension: ctd_margin {
    type: number
    label: "CTD Margin"
    sql: ${TABLE}."CTD Margin" ;;
  }

  dimension: pd_vcr {
    type: number
    label: "PD VCR"
    sql: ${TABLE}."PD VCR" ;;
  }

  dimension: ctd_vcr {
    type: number
    label: "CTD VCR"
    sql: ${TABLE}."CTD VCR" ;;
  }

  dimension: pd_ctr {
    type: number
    label: "PD CTR"
    sql: ${TABLE}."PD CTR" ;;
  }

  dimension: ctd_ctr {
    type: number
    label: "CTD CTR"
    sql: ${TABLE}."CTD CTR" ;;
  }

  dimension: pd_delivered_quantity {
    type: number
    label: "PD Delivered Quantity"
    sql: ${TABLE}."PD Delivered Quantity" ;;
  }

  dimension: ctd_delivered_quantity {
    type: number
    label: "CTD Delivered Quantity"
    sql: ${TABLE}."CTD Delivered Quantity" ;;
  }

  dimension: pd_pacing_quantity {
    type: number
    label: "PD Pacing (Quantity)"
    sql: ${TABLE}."PD Pacing (Quantity)" ;;
  }

  dimension: ctd_pacing_quantity {
    type: number
    label: "CTD Pacing (Quantity)"
    sql: ${TABLE}."CTD Pacing (Quantity)" ;;
  }

  dimension: pd_pacing_revenue {
    type: number
    label: "PD Pacing (Revenue)"
    sql: ${TABLE}."PD Pacing (Revenue)" ;;
  }

  dimension: ctd_pacing_revenue {
    type: number
    label: "CTD Pacing (Revenue)"
    sql: ${TABLE}."CTD Pacing (Revenue)" ;;
  }

  dimension: revenue_risk {
    type: number
    label: "Revenue Risk"
    sql: ${TABLE}."Revenue Risk" ;;
  }

  set: detail {
    fields: [
      csm,
      seller,
      dsp_campaign_name,
      flight_number,
      dsp_placement_id,
      sf_ad_unit_type,
      sf_group_name,
      sf_target_details,
      dsp_flight_status,
      dsp_booked_quantity,
      dsp_adjusted_quantity,
      dsp_booked_revenue,
      dsp_kpi,
      dsp_flight_start_date,
      dsp_flight_end_date,
      dsp_remaining_days,
      dif_revenue,
      dif_quantity,
      ctd_revenue,
      ctd_inventory_cost,
      ctd_e_cpm,
      pd_margin,
      ctd_margin,
      pd_vcr,
      ctd_vcr,
      pd_ctr,
      ctd_ctr,
      pd_delivered_quantity,
      ctd_delivered_quantity,
      pd_pacing_quantity,
      ctd_pacing_quantity,
      pd_pacing_revenue,
      ctd_pacing_revenue,
      revenue_risk
    ]
  }
}
