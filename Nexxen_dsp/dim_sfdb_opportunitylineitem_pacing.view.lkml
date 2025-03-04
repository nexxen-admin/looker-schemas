view: dim_sfdb_opportunitylineitem_pacing {
derived_table: {
  sql: WITH base AS (
SELECT
    dim_sfdb_opportunitylineitem.opportunitylineitem_key AS "line_item_id",
        (DATE(dim_dsp_package_budget_schedule.start_date_in_timezone )) AS "start_date",
        (DATE(dim_dsp_package_budget_schedule.end_date_in_timezone )) AS "end_date",
        DATE(dim_dsp_package_budget_schedule.end_date_in_timezone )-DATE(dim_dsp_package_budget_schedule.start_date_in_timezone )+1 AS "campaign_length",
    dim_sfdb_opportunitylineitem.units__c  AS "budgeted_units",
        (DATE(v_dim_dsp_date.Date_Key )) AS "key_date",
        DATE(v_dim_dsp_date.Date_Key )-DATE(dim_dsp_package_budget_schedule.start_date_in_timezone )+1 AS "day_of_campaign",
        DATE(dim_dsp_package_budget_schedule.end_date_in_timezone )-DATE(v_dim_dsp_date.Date_Key )+1 AS "days_left",
        dim_sfdb_opportunitylineitem.units__c/(DATE(dim_dsp_package_budget_schedule.end_date_in_timezone )-DATE(dim_dsp_package_budget_schedule.start_date_in_timezone )+1) AS "daily_goal",
        dim_dsp_advertiser.advertiser_id,
    COALESCE(SUM(fact_nexxen_dsp.delivery_units ), 0) AS "delivered_units"
FROM BI_DSP.fact_nexxen_dsp  AS fact_nexxen_dsp
INNER JOIN BI_DSP.v_dim_dsp_date  AS v_dim_dsp_date ON v_dim_dsp_date.Date_Key = fact_nexxen_dsp.date_key_in_timezone
INNER JOIN BI_DSP.dim_dsp_advertiser  AS dim_dsp_advertiser ON dim_dsp_advertiser.advertiser_id_key = fact_nexxen_dsp.advertiser_id_key
INNER JOIN BI_DSP.v_dim_dsp_package_budget_schedule  AS dim_dsp_package_budget_schedule ON dim_dsp_package_budget_schedule.package_budget_schedule_key=fact_nexxen_dsp.package_budget_schedule_key
INNER JOIN BI_DSP.dim_sfdb_opportunitylineitem  AS dim_sfdb_opportunitylineitem ON dim_sfdb_opportunitylineitem.opportunitylineitem_key =fact_nexxen_dsp.opportunitylineitem_key
WHERE dim_dsp_package_budget_schedule.start_date_in_timezone IS NOT NULL
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
)
SELECT b.*,
    daily_goal * day_of_campaign AS "run_total_goal",
    SUM(delivered_units) OVER (PARTITION  BY line_item_id ORDER BY key_date) AS "run_total_delivered",
    delivered_units/((budgeted_units - run_total_delivered)/days_left) AS "daily_pacing",
    CASE WHEN key_date=MAX(key_date) OVER (PARTITION BY line_item_id) THEN SUM(delivered_units) OVER (PARTITION  BY line_item_id ORDER BY key_date)/(daily_goal * day_of_campaign) END AS "last_day_pacing"
FROM base  b --INNER JOIN BI_DSP.advertisers_email  AS adv_em ON b.advertiser_id=adv_em.advertiser_id
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ;;
}

dimension: pk {
  primary_key: yes
  sql: CONCAT(${TABLE}.line_item_id, ${TABLE}.key_date) ;;
  hidden: yes
}

dimension: line_item_id {
  type: number
  sql: ${TABLE}.line_item_id ;;
  hidden:  yes
}

  dimension: date_key_date {
    type: number
    sql: ${TABLE}.key_date ;;
    hidden:  yes
  }

dimension: daily_pacing_dim {
  type: number
  value_format: "0.00%"
  sql: ${TABLE}.daily_pacing ;;
  hidden: yes
}

  dimension: last_day_pacing_dim {
    type: number
    value_format: "0.00%"
    sql: ${TABLE}.last_day_pacing;;
    hidden: yes
  }

  measure: total_pacing {
    type: average
    label: "Total Pacing - MSD"
    value_format: "0.0%"
    sql: ISNULL(${last_day_pacing_dim},0) ;;
  }
}
