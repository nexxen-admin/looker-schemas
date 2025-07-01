view: tp_deepsee_web_domain_r {
  sql_table_name: Andromeda.tp_deepsee_web_domain_r ;;

  dimension: ad_clutter {
    type: yesno
    sql: ${TABLE}.ad_clutter ;;
  }
  dimension: admin_author_rate {
    type: number
    sql: ${TABLE}.admin_author_rate ;;
  }
  dimension: ads_txt_rows {
    type: number
    sql: ${TABLE}.ads_txt_rows ;;
  }
  dimension: ads_txt_size_pctl {
    type: number
    sql: ${TABLE}.ads_txt_size_pctl ;;
  }
  dimension: web_domain_compliance_status {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.high_risk_violations = 1 THEN 'Rejected'
      ELSE 'OK'
    END ;;
  }
  dimension: web_domain_rejected_reason {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.high_risk_violations = 1 THEN 'High Risk'
      ELSE NULL
    END ;;
  }
  dimension: ads_txt_verifiable {
    type: string
    sql: ${TABLE}.ads_txt_verifiable ;;
  }
  dimension: ads_txt_verifiable_rate {
    type: number
    sql: ${TABLE}.ads_txt_verifiable_rate ;;
  }
  dimension: adult_flag {
    type: yesno
    sql: ${TABLE}.adult_flag ;;
  }
  dimension: author_avg_name_length_non_domain {
    type: number
    sql: ${TABLE}.author_avg_name_length_non_domain ;;
  }
  dimension: author_contains_domain_name_rate {
    type: number
    sql: ${TABLE}.author_contains_domain_name_rate ;;
  }
  dimension: author_details {
    type: string
    sql: ${TABLE}.author_details ;;
  }
  dimension: authors_detected {
    type: number
    sql: ${TABLE}.authors_detected ;;
  }
  dimension: avg_ads_per_snapshot {
    type: number
    sql: ${TABLE}.avg_ads_per_snapshot ;;
  }
  dimension: avg_ads_per_snapshot_pctl {
    type: number
    sql: ${TABLE}.avg_ads_per_snapshot_pctl ;;
  }
  dimension: avg_crawl_peak_density {
    type: number
    sql: ${TABLE}.avg_crawl_peak_density ;;
  }
  dimension: avg_crawl_peak_density_non_native {
    type: number
    sql: ${TABLE}.avg_crawl_peak_density_non_native ;;
  }
  dimension: avg_density_per_snapshot {
    type: number
    sql: ${TABLE}.avg_density_per_snapshot ;;
  }
  dimension: avg_density_per_snapshot_non_native {
    type: number
    sql: ${TABLE}.avg_density_per_snapshot_non_native ;;
  }
  dimension: avg_density_per_snapshot_pctl {
    type: number
    sql: ${TABLE}.avg_density_per_snapshot_pctl ;;
  }
  dimension: avg_polarity {
    type: string
    sql: ${TABLE}.avg_polarity ;;
  }
  dimension: avg_pop_ups {
    type: number
    sql: ${TABLE}.avg_pop_ups ;;
  }
  dimension: avg_redirects {
    type: number
    sql: ${TABLE}.avg_redirects ;;
  }
  dimension: avg_sentiment {
    type: string
    sql: ${TABLE}.avg_sentiment ;;
  }
  dimension: avg_subjectivity {
    type: string
    sql: ${TABLE}.avg_subjectivity ;;
  }
  dimension: big_mover_flag {
    type: yesno
    sql: ${TABLE}.big_mover_flag ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: deepsee_inferred_owner_or_manager {
    type: string
    sql: ${TABLE}.deepsee_inferred_owner_or_manager ;;
  }
  dimension: domain {
    type: string
    sql: ${TABLE}."domain" ;;
  }
  dimension: embedded {
    type: yesno
    sql: ${TABLE}.embedded ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension: has_malware {
    type: number
    sql: ${TABLE}.has_malware ;;
  }
  dimension: has_porn_script {
    type: yesno
    sql: ${TABLE}.has_porn_script ;;
  }
  dimension: high_risk_ux {
    type: string
    sql: ${TABLE}.high_risk_ux ;;
  }
  dimension: high_risk_violations {
    type: yesno
    sql: ${TABLE}.high_risk_violations ;;
  }
  dimension: low_quality_text_rate_high_confidence {
    type: number
    sql: ${TABLE}.low_quality_text_rate_high_confidence ;;
  }
  dimension: low_quality_text_rate_low_confidence {
    type: number
    sql: ${TABLE}.low_quality_text_rate_low_confidence ;;
  }
  dimension: low_quality_text_rate_med_confidence {
    type: number
    sql: ${TABLE}.low_quality_text_rate_med_confidence ;;
  }
  dimension: malware_sessions_rate {
    type: number
    sql: ${TABLE}.malware_sessions_rate ;;
  }
  dimension: manager {
    type: string
    sql: ${TABLE}.manager ;;
  }
  dimension: manager_refresh_time {
    type: number
    sql: ${TABLE}.manager_refresh_time ;;
  }
  dimension: max_ads_in_viewport {
    type: number
    sql: ${TABLE}.max_ads_in_viewport ;;
  }
  dimension: max_ads_in_viewport_pctl {
    type: number
    sql: ${TABLE}.max_ads_in_viewport_pctl ;;
  }
  dimension: max_density {
    type: number
    sql: ${TABLE}.max_density ;;
  }
  dimension: max_density_pctl {
    type: number
    sql: ${TABLE}.max_density_pctl ;;
  }
  dimension: mfa {
    type: yesno
    sql: ${TABLE}.mfa ;;
  }
  dimension: mfa_subdomain {
    type: yesno
    sql: ${TABLE}.mfa_subdomain ;;
  }
  dimension: newly_registered {
    type: yesno
    sql: ${TABLE}.newly_registered ;;
  }
  dimension: owner {
    type: string
    sql: ${TABLE}."owner" ;;
  }
  dimension: pages_evaluated_for_sentiment {
    type: number
    sql: ${TABLE}.pages_evaluated_for_sentiment ;;
  }
  dimension: pages_evaluated_for_text_quality {
    type: number
    sql: ${TABLE}.pages_evaluated_for_text_quality ;;
  }
  dimension: peak_to_mean_density_ratio {
    type: number
    sql: ${TABLE}.peak_to_mean_density_ratio ;;
  }
  dimension: peak_to_mean_density_ratio_non_native {
    type: number
    sql: ${TABLE}.peak_to_mean_density_ratio_non_native ;;
  }
  dimension: piracy {
    type: yesno
    sql: ${TABLE}.piracy ;;
  }
  dimension: plugins_uniqueness {
    type: string
    sql: ${TABLE}.plugins_uniqueness ;;
  }
  dimension: pop_creator {
    type: yesno
    sql: ${TABLE}.pop_creator ;;
  }
  dimension: pop_script_sessions_rate {
    type: number
    sql: ${TABLE}.pop_script_sessions_rate ;;
  }
  dimension: pop_sourced {
    type: yesno
    sql: ${TABLE}.pop_sourced ;;
  }
  dimension: porn_script_sessions_rate {
    type: number
    sql: ${TABLE}.porn_script_sessions_rate ;;
  }
  dimension: possible_misinfo {
    type: yesno
    sql: ${TABLE}.possible_misinfo ;;
  }
  dimension: refresh_avg {
    type: number
    sql: ${TABLE}.refresh_avg ;;
  }
  dimension: refresh_pctl_75 {
    type: number
    sql: ${TABLE}.refresh_pctl_75 ;;
  }
  dimension: refresh_pctl_90 {
    type: number
    sql: ${TABLE}.refresh_pctl_90 ;;
  }
  dimension: requests_pctl {
    type: number
    sql: ${TABLE}.requests_pctl ;;
  }
  dimension: spoofed {
    type: yesno
    sql: ${TABLE}.spoofed ;;
  }
  dimension: spoofer {
    type: yesno
    sql: ${TABLE}.spoofer ;;
  }
  dimension: template_site {
    type: yesno
    sql: ${TABLE}.template_site ;;
  }
  dimension: template_uniqueness {
    type: string
    sql: ${TABLE}.template_uniqueness ;;
  }
  dimension: theme_uniqueness {
    type: string
    sql: ${TABLE}.theme_uniqueness ;;
  }
  dimension: threatfox_details {
    type: string
    sql: ${TABLE}.threatfox_details ;;
  }
  dimension: top_language {
    type: string
    sql: ${TABLE}.top_language ;;
  }
  dimension: tranco_rank {
    type: number
    sql: ${TABLE}.tranco_rank ;;
  }
  dimension: weight_pctl {
    type: number
    sql: ${TABLE}.weight_pctl ;;
  }
  measure: count {
    type: count
  }
}
