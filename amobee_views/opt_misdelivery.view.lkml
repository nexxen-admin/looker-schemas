view: opt_misdelivery {
  view_label: "Allocation vs Delivery"

  derived_table: {
    sql:
      SELECT a.*, b.ccp, b.icp, b.overage_threshold, b.smoothness_lower, b.smoothness_upper,
      convert(varchar,a.cluster_id) +'-'+convert(varchar,a.keydate) as cluster_keydate,
       convert(varchar,a.campaign_id) +'-'+convert(varchar,a.keydate) as campaign_keydate,
       convert(varchar,a.placement_id) +'-'+convert(varchar,a.keydate) as placement_keydate
      from an_research..opt_misdelivery a (nolock)
      left join (select campaign_id,keydate,sum(ccp) as ccp, sum(icp) as icp, sum(overage_threshold) as overage_threshold,
      sum(smoothness_lower) as smoothness_lower, sum(smoothness_upper) as smoothness_upper
      from an_research..op_plan_fm_info (nolock)
      group by campaign_id,keydate)
      b
      on a.campaign_id = b.campaign_id
      and a.keydate= b.keydate

    ;;
  }


  dimension_group: utc_date {
    type: time
    label: "UTC"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: ""
    sql: ${TABLE}.keydate ;;
  }

dimension: placement_keydate {
  type:  string
  sql: ${TABLE}.placement_keydate ;;
  hidden: yes
}
dimension: campaign_keydate {
    type:  string
    sql: ${TABLE}.campaign_keydate ;;
    hidden: yes
}

dimension: cluster_keydate {
    type:  string
    sql: ${TABLE}.cluster_keydate ;;
    hidden: yes
}

dimension: placement_id {
  type: number
  label: "Placement ID"
  value_format_name: id
  description: ""
  sql: ${TABLE}.placement_id ;;
}


dimension: cluster_id {
  type: number
  label: "Cluster ID"
  value_format_name: id
  description: ""
  sql: ${TABLE}.cluster_id ;;
}


dimension: flight_media_id {
  type: number
  label: "Flight Media ID"
  value_format_name: id

  description: ""
  sql: ${TABLE}.flight_media_id ;;
}

dimension: flight_id {
  type: number
  label: "Flight ID"
  value_format_name: id

  description: ""
  sql: ${TABLE}.flight_id ;;
}

dimension: campaign_id {
  type: number
  label: "Campaign ID"
  value_format_name: id
  description: ""
  sql: ${TABLE}.campaign_id;;
}

dimension: country_id {
  type: number
  hidden: yes
  sql: ${TABLE}.country_id ;;
}


measure: min_allocation {
  type: sum
  label: "Min Allocation"
  value_format_name: decimal_0
  description: ""
  sql: ${TABLE}.min_allocation ;;
}

measure: mean_allocation {
  type: sum
  label: "Mean Allocation"
  value_format_name: decimal_0
  description: "Allocated Impressions"
  sql: ${TABLE}.mean_allocation ;;
}


measure: max_allocation {
  type: sum
  label: "Max Allocation"
  value_format_name: decimal_0
  description: ""
  sql: ${TABLE}.max_allocation ;;
}



  measure: min_allocation_share {
    type: sum
    label: "Min Allocation Share"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.min_allocation_share ;;
    hidden: yes
  }

  measure: mean_allocation_share {
    type: average
    label: "Mean Allocation Share"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.mean_allocation_share ;;
  }


  measure: max_allocation_share {
    type: sum
    label: "Max Allocation Share"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.max_allocation_share ;;
    hidden:  yes
  }

  measure: pct_of_runs {
    type: average
    label: "Percent of Runs"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.pct_of_runs ;;
  }

  measure: impressions {
    type: sum
    label: "Impressions"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.impressions ;;
  }

 measure: impressions_share {
    type: average
    label: "Impressions Share"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.impressions_share ;;
  }

  dimension: platform_client_id {
    type: number
    label: "Platform Client ID"
    value_format_name: id
    description: ""
    sql: ${TABLE}.platform_client_id ;;
    hidden: yes
  }

  measure: max_hours_delivered {
    type: average
    label: "Max Hours Delivered"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.max_hours_delivered ;;
  }

  measure: q_forecast {
    type: sum_distinct
    label: "Q Forecast"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.q_forecast ;;
    sql_distinct_key: ${TABLE}.cluster_keydate ;;
  }

  measure: q_actual {
    type: sum_distinct
    label: "Q Actual"
    value_format_name: percent_2
    description: ""
    sql: ${TABLE}.q_actual ;;
    sql_distinct_key: ${TABLE}.cluster_keydate ;;
  }

  measure: m_forecast {
    type: sum_distinct
    label: "M Forecast"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.M_forecast ;;
    sql_distinct_key: ${TABLE}.placement_keydate ;;
  }

  measure: m_actual {
    type: sum_distinct
    label: "M Actual"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.m_actual ;;
    sql_distinct_key: ${TABLE}.placement_keydate ;;
  }


  dimension_group: createdon {
    type: time
    label: "Created On"
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: ""
    sql: ${TABLE}.createdon ;;
  }


  measure: min_effec_alloc {
    type: sum
    label: "Min Effective Allocation"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.min_effec_alloc ;;
  }

  measure: mean_effec_alloc {
    type: sum
    label: "Mean Effective Allocation"
    value_format_name: decimal_0
    description: "Allocated Units"
    sql: ${TABLE}.mean_effec_alloc ;;
  }


  measure: max_effec_alloc {
    type: sum
    label: "Max Effective Allocation"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.max_effec_alloc ;;
  }

  measure: actual_units{
    type: sum
    label: "Actual Units"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.actual_units ;;
  }

  measure: mean_bids_alloc {
    type: sum
    label: "Mean Bids Allocation"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.mean_bids_alloc ;;
  }

  measure: actual_bids {
    type: sum
    label: "Actual Bids"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.actual_bids ;;
  }

  measure: domain_md {
    type: sum
    label: "Domain Misdelivery"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.domain_md ;;
  }

  measure: winrate_md {
    type: sum
    label: "Winrate Misdelivery"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.winrate_md ;;
  }

  measure: volume_md {
    type: sum
    label: "Volume Misdelivery"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.volume_md ;;
  }

  measure: comp_md {
    type: sum
    label: "Comp Misdelivery"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.comp_md ;;
  }

  measure: share_md {
    type: sum
    label: "Share Misdelivery"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.share_md ;;
  }

  measure: mean_prk {
    type: average
    label: "Mean Audience Size"
    value_format_name: percent_3
    description: ""
    sql: ${TABLE}.mean_prk ;;
  }

  measure: expected_bid_price {
    type: average
    label: "Expected Bid Price"
    value_format_name: decimal_2
    description: ""
    sql: ${TABLE}.expected_bid_price ;;
  }

  measure: actual_bid_price {
    type: average
    label: "Actual Bid Price"
    value_format_name: decimal_2
    description: ""
    sql: ${TABLE}.actual_bid_price ;;
  }

  measure: expected_payout {
    type: average
    label: "Expected Payout"
    value_format_name: decimal_2
    description: ""
    sql: ${TABLE}.expected_payout ;;
  }

  measure: actual_bpayout {
    type: average
    label: "Actual Payout"
    value_format_name: decimal_2
    description: ""
    sql: ${TABLE}.actual_payout ;;
  }

  measure: forecast_click {
    type: sum
    label: "Forecast Clicks"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.forecast_click ;;
  }

  measure: actual_click {
    type: sum
    label: "Actual Clicks"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.actual_click ;;
  }

  measure: forecast_completed {
    type: sum
    label: "Forecast Completed"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.forecast_completed ;;
  }

  measure: actual_completed {
    type: sum
    label: "Actual Completed"
    description: ""
    sql: ${TABLE}.actual_completed ;;
    value_format_name: decimal_0
  }


 measure: smoothness_lower {
    type:  sum_distinct
    label: "Campaign Lower Smoothness"
    sql:  ${TABLE}.smoothness_lower ;;
  value_format_name: decimal_0
  sql_distinct_key: ${TABLE}.campaign_keydate ;;
  }
  measure: smoothness_upper {
    type:  sum_distinct
    label: "Campaign Upper Smoothness"
    sql:  ${TABLE}.smoothness_upper ;;
    value_format_name: decimal_0
    sql_distinct_key: ${TABLE}.campaign_keydate ;;
  }
  measure: icp {
    type: sum_distinct
    label: "Campaign ICP"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.icp ;;
    sql_distinct_key: ${TABLE}.campaign_keydate ;;
  }

  measure: ccp {
    type: sum_distinct
    label: "Campaign CCP"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.ccp ;;
    sql_distinct_key: ${TABLE}.campaign_keydate ;;
  }

  measure:overage_threshold {
    type:  sum_distinct
    label: "Campaign Overage Threshold"
    value_format_name:  decimal_0
    sql:  ${TABLE}.overage_threshold ;;
    sql_distinct_key: ${TABLE}.campaign_keydate ;;
  }

  measure: alloc_actual_delta {
    type: sum
    label: "Allocation - Actual"
    description: "Allocation - Actual"
    value_format_name: decimal_0
    sql: ${TABLE}.mean_effec_alloc - ${TABLE}.actual_units ;;

  }


  measure: alloc_pacing {
    type: sum
    label: "Allocation / CCP"
    description: "Allocation / CCP"
    value_format_name: percent_2
    sql: 1.00*${TABLE}.mean_effec_alloc/case when ${TABLE}.ccp>0 then ${TABLE}.ccp when ${TABLE}.mean_effec_alloc>0 then ${TABLE}.mean_effec_alloc else 1 end;;

  }

  measure: actual_pacing {
    type: sum
    label: "Actual / CCP"
    description: "Actual / CCP"
    value_format_name: percent_2
    sql: 1.00*${TABLE}.actual_units/case when ${TABLE}.ccp>0 then ${TABLE}.ccp when ${TABLE}.actual_units>0 then ${TABLE}.actual_units else 1 end;;

  }

}
