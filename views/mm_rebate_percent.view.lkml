view: mm_rebate_percent {
  derived_table: {
    sql: Select
            quarter(ad.date_key) as date_key,
           -- ad.date_key,
            sum(ad.sum_of_revenue) as MM_Total_Revenue,
            (sum(ad.sum_of_revenue) - 1000000) * 0.05 as rebate_value, --5% rebate because it's over 3M in total Q1 Spend
            ((sum(ad.sum_of_revenue) - 1000000) * 0.05) / sum(ad.sum_of_revenue) as eMM_Rebate_Percent,
            0.1 as NC_MM_Rebate_Percent
            From bi_new.fact_ad_daily_agg ad
            inner join bi_new.dim_dsp dsp on dsp.dsp_key = ad.DSP_Key
            inner join bi_new.dim_dsp_account da on da.dsp_account_key = dsp.dsp_account_key
            and da.dsp_account_name ilike '%mediamath%'
            Where ad.date_key >= '2022-01-01'
            and ad.date_key < '2022-04-01'  --Stopped after Q1
            and ad.sum_of_revenue > 0
            Group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_key {
    type: number
    sql: ${TABLE}.date_key ;;
  }

  dimension: mm_total_revenue {
    type: number
    sql: ${TABLE}.MM_Total_Revenue ;;
  }

  dimension: rebate_value {
    type: number
    sql: ${TABLE}.rebate_value ;;
  }

  dimension: e_mm_rebate_percent {
    type: number
    sql: ${TABLE}.eMM_Rebate_Percent ;;
  }

  dimension: nc_mm_rebate_percent {
    type: number
    sql: ${TABLE}.NC_MM_Rebate_Percent ;;
  }

  set: detail {
    fields: [
      date_key,
      mm_total_revenue,
      rebate_value,
      e_mm_rebate_percent,
      nc_mm_rebate_percent
    ]
  }
}
