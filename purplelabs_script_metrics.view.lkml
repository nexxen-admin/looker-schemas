
view: purplelabs_script_metrics {
  derived_table: {
    sql: WITH firstp_data AS (
        SELECT
          fnd.date_key_in_timezone::date AS date,
          dda.advertiser_id,
          dda.advertiser_name,
          ddli.line_item_id AS line_item_id,
          ddli.line_item_name AS line_item_name,
          ddio.insertion_order_id AS insertion_order_id,
          ddio.insertion_order_name AS insertion_order_name,
          SUM(fnd.impressions) AS impressions,
          SUM(fnd.cost) AS cost,
          SUM(fnd.clicks) as clicks,
          SUM(fnd.actions) as actions
        FROM BI_DSP.fact_nexxen_dsp fnd
          INNER JOIN BI_DSP.dim_dsp_advertiser dda ON dda.advertiser_id_key = fnd.advertiser_id_key
          INNER JOIN BI_DSP.dim_dsp_line_item ddli ON ddli.line_item_id_key = fnd.line_item_key
          INNER JOIN BI_DSP.dim_dsp_insertion_order ddio ON ddio.insertion_order_id = ddli.insertion_order_id
          INNER JOIN BI_DSP.dim_dsp_market m on m.market_id_key = fnd.market_id_key
        WHERE fnd.date_key_in_timezone >= '2025-05-01'
          AND fnd.date_key_in_timezone < CURRENT_DATE
          AND (fnd.impressions > 0 OR fnd.cost > 0)
          AND m.market_id = 2139
        GROUP BY 1,2,3,4,5,6,7
      ),

      agg_purplelabs_data AS (
        SELECT
          date::DATE AS date,
          adgroup_id,
          campaign_id,
          SUM(new_prescribers) as new_prescribers,
          sum(nrx_dispensed) as nrx_dispensed,
          sum(nrx_dispensed_patient_cnt) as nrx_dispensed_patient_cnt,
          sum(nrxmx_cnt) as nrxmx_cnt,
          sum(patient_nrx_cnt) as patient_nrx_cnt,
          sum(trxmx_cnt) as trxmx_cnt,
          sum(trxmx_dispensed) as trxmx_dispensed
        FROM SunFlower.purplelab_script_metrics
        WHERE date >= '2025-05-01'
          AND date < CURRENT_DATE
        GROUP BY 1, 2,3
      ),

      purplelabs_line_items AS (
      Select adgroup_id
      From agg_purplelabs_data
      Group by 1)

      SELECT coalesce(p.date,f.date) AS cohort_start_date,
        f.advertiser_id,
        f.advertiser_name,
        f.insertion_order_id,
        f.insertion_order_name,
        coalesce(p.adgroup_id,f.line_item_id) as adgroup_id,
        f.line_item_name,
        f.line_item_id,
        coalesce(p.campaign_id,f.insertion_order_id) as campaign_id,
        p.new_prescribers as new_prescribers,
        p.nrx_dispensed as nrx_dispensed,
        p.nrx_dispensed_patient_cnt as nrx_dispensed_patient_cnt,
        p.nrxmx_cnt as nrxmx_cnt,
        p.patient_nrx_cnt as patient_nrx_cnt,
        p.trxmx_cnt as trxmx_cnt,
        p.trxmx_dispensed as trxmx_dispensed,
        COALESCE(f.impressions, 0) AS impressions,
        COALESCE(f.cost, 0) AS cost,
        COALESCE(f.clicks, 0) AS clicks,
        COALESCE(f.actions, 0) AS actions
      From firstp_data f
        inner join purplelabs_line_items pli on pli.adgroup_id = f.line_item_id
        left outer join agg_purplelabs_data p ON p.date::date = f.date::date
                        AND p.adgroup_id = f.line_item_id
                                 and p.campaign_id = f.insertion_order_id
      ORDER BY 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cohort_start_date {
    type: date
    sql: ${TABLE}.cohort_start_date ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }

  dimension: adgroup_id {
    type: number
    sql: ${TABLE}.adgroup_id ;;
  }

  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  measure: new_prescribers {
    type: sum
    sql: ${TABLE}.new_prescribers ;;
  }

  measure: nrx_dispensed {
    type: sum
    sql: ${TABLE}.nrx_dispensed ;;
  }

  measure: nrx_dispensed_patient_cnt {
    type: sum
    sql: ${TABLE}.nrx_dispensed_patient_cnt ;;
  }

  measure: nrxmx_cnt {
    type: sum
    sql: ${TABLE}.nrxmx_cnt ;;
  }

  measure: patient_nrx_cnt {
    type: sum
    sql: ${TABLE}.patient_nrx_cnt ;;
  }

  measure: trxmx_cnt {
    type: sum
    sql: ${TABLE}.trxmx_cnt ;;
  }

  measure: trxmx_dispensed {
    type: sum
    sql: ${TABLE}.trxmx_dispensed ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: actions {
    type: sum
    sql: ${TABLE}.actions ;;
  }

  set: detail {
    fields: [
        cohort_start_date,
  advertiser_id,
  advertiser_name,
  insertion_order_id,
  insertion_order_name,
  adgroup_id,
  line_item_name,
  line_item_id,
  campaign_id,
  new_prescribers,
  nrx_dispensed,
  nrx_dispensed_patient_cnt,
  nrxmx_cnt,
  patient_nrx_cnt,
  trxmx_cnt,
  trxmx_dispensed,
  impressions,
  cost,
  clicks,
  actions
    ]
  }
}
