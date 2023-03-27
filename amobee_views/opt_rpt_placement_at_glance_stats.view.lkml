view: opt_rpt_placement_at_glance_stats {
  view_label: "Placement At A Glance"
  sql_table_name: opt_rpt.dbo.placement_at_glance_stats ;;

  dimension: brand_freq_cap {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.brand_freq_cap ;;
    label: "Brand Freq Cap Units"
  }

  dimension: brand_freq_cap_mins {
    type: number
    sql: ${TABLE}.brand_freq_cap_mins ;;
    label: "Brand Freq Cap Minutes"
  }

  dimension: bt_avg_pct {
    type: number
    sql: ${TABLE}.bt_avg_pct ;;
    label: "Average BT Coverage%"
  }

  dimension: bt_pct_over_index {
    type: number
    sql: ${TABLE}.bt_pct_over_index ;;
    hidden: yes
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    label: "Country"
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
    value_format_name: id
    label: "Country Id"
  }

  dimension_group: createdon {
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.createdon ;;
    label: "Updated"
  }

  measure: ctr {
    type: average
    sql: ${TABLE}.ctr ;;
    label: "CTR%"
    value_format_name: decimal_2

  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}.currency_id ;;
    hidden: yes
  }

  dimension: deal_type {
    type: string
    label: "Buy Type"
    sql: ${TABLE}.deal_type ;;
  }

  dimension: delivery_range_cap {
    type: number
    sql: ${TABLE}.delivery_range_cap ;;
    value_format_name: decimal_0
    label: "Delivery Cap"
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
    label: "Device Type"
  }

  dimension: device_type_id {
    type: number
    sql: ${TABLE}.device_type_id ;;
    label: "Device Type Id"
    value_format_name: id
  }

  dimension: drop_off_pct {
    type: number
    sql: ${TABLE}.drop_off_pct ;;
    value_format_name: percent_2
    label: "Drop Off%"
  }

  dimension: exclusion_reason {
    type: string
    sql: ${TABLE}.exclusion_reason ;;
    label: "Exclusion Reason"
  }

  dimension: floor_bid {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.floor_bid ;;
    label: "Floor Bid"
  }

  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
    label: "Format Type"
  }

  dimension: format_type_id {
    type: number
    sql: ${TABLE}.format_type_id ;;
    label: "Format Type Id"
    value_format_name: id
  }

  dimension: freq_cap {
    type: number
    sql: ${TABLE}.freq_cap ;;
    label: "Freq Cap Units"
  }

  dimension: freq_cap_hours {
    type: number
    sql: ${TABLE}.freq_cap_hours ;;
    label: "Freq Cap Hours"
  }

  dimension: in_opt {
    type: number
    sql: ${TABLE}.in_opt ;;
    label: "In Optimization"
  }

  dimension: is_dead {
    type: number
    sql: ${TABLE}.is_dead ;;
    label: "Is Dead"
  }


  dimension: is_matchbuy {
    type: number
    sql: ${TABLE}.is_matchbuy ;;
    label: "Is Match Buy"
  }

  dimension: is_pod {
    type: number
    sql: ${TABLE}.is_pod ;;
    label: "Is Pod"
  }

  dimension: max_ad_duration {
    type: number
    sql: ${TABLE}.max_ad_duration ;;
    label: "Max Ad Duration"
  }

  dimension: max_bid {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.max_bid ;;
    label: "Max Bid"
  }

  measure: measurable {
    type: average
    value_format_name: percent_1
    sql: ${TABLE}.measurable ;;
    label: "Measurable%"
  }

  dimension: min_ad_duration {
    type: number
    sql: ${TABLE}.min_ad_duration ;;
    label: "Min Ad Duration"
  }

  dimension: min_bid {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.min_bid ;;
    label: "Min Bid"
  }

  dimension: min_imps {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.min_pct ;;
    label: "Min Fill Requirement Imps"
  }

  dimension: min_pct {
    type: number
    sql: ${TABLE}.min_imps ;;
    value_format_name: percent_1
    label: "Min Fill Requirement%"
  }

  measure: num_bts {
    type: average
    value_format_name: decimal_0
    sql: ${TABLE}.num_bts ;;
    label: "Average #BTs"
  }

  dimension: opt_run_id {
    type: number
    sql: ${TABLE}.opt_run_id ;;
    label: "Optimization Run Id"
    value_format_name: id
  }

  dimension: partner_name {
    type: string
    sql: ${TABLE}.partner_name ;;
    label: "Publisher"
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
    label: "Placement Id"
    value_format_name: id
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
    label: "Placement Name"
  }

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}.platform_client_id ;;
    label: "Platform Client Id"
    value_format_name: id
  }

  dimension: pod_duration {
    type: number
    sql: ${TABLE}.pod_duration ;;
    label: "Pod Duration"
  }

  dimension_group: rundate {
    label: "Optimization Run"
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.run_date ;;
  }

  measure: today_allocated {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_allocated ;;
    label: "Today Allocated Impressions"
  }

  dimension_group: today {
    label: "Today"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.today_date ;;
  }

  measure: today_house_imps {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_house_imps ;;
    label: "Today House Impressions"
  }

  measure: today_house_risk {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_house_risk ;;
    label: "Today House Risk"
  }

  measure: today_imps {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_imps ;;
    label: "Today Impressions"
  }

  measure: today_m_actual {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_m_actual ;;
    label: "Today Requests Actual"
  }

  measure: today_m_forecast {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_m_forecast ;;
    label: "Today Requests Forecast"
  }

  measure: today_m_override {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.today_m_override ;;
    hidden: yes
    label: "Today Requests Forecast Override"
  }

  measure: ttid_pct {
    type: average
    sql: ${TABLE}.ttid_pct ;;
    label: "Known Users%"
    value_format_name: percent_1
  }

  measure: no_ttid_pct {
    type: average
    sql: 1-${TABLE}.ttid_pct ;;
    label: "Unknown Users%"
    value_format_name: percent_1
  }

  measure: viewable {
    type: average
    value_format_name: percent_1
    sql: ${TABLE}.viewable ;;
    label: "Viewable%"
  }

  measure: vpaid_pct {
    type: average
    value_format_name: percent_1
    sql: ${TABLE}.vpaid_pct ;;
    label: "VPAID%"
  }

  measure: vtr {
    type: average
    value_format_name: percent_1
    sql: ${TABLE}.vtr ;;
    label: "VTR%"
  }

  measure: yest_allocated {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.yest_allocated ;;
    label: "Yesterday Allocated Impressions"
  }

  dimension_group: yest {
    label: "Yesterday"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.yest_date ;;
  }

  measure: yest_house_imps {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.yest_house_imps ;;
    label: "Yesterday House Impressions"
  }

  measure: yest_imps {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.yest_imps ;;
    label: "Yesterday Impressions"
  }

  measure: yest_m_actual {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.yest_m_actual ;;
    label: "Yesterday Requests Actual"
  }

  measure: yest_m_forecast {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.yest_m_forecast ;;
    label: "Yesterday Requests Forecast"
  }

  measure: yest_m_override {
    type: sum
    sql: ${TABLE}.yest_m_override ;;
    label: "Yesterday Requests Forecast Override"
    hidden:  yes
  }

  measure: count {
    type: count
    drill_fields: [partner_name, placement_name]
  }
}
