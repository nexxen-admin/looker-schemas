view: portfolio_trends {
  label: "Portfolio Trends"
  derived_table: {
    sql:
      SELECT pt.*, c.cpu_type_description
      from OPT.PORTFOLIO_TRENDS pt
      join DIM.CAMPAIGN_DETAILS_BASE c
      on pt.campaign_id = c.campaign_id
    ;;
  }

  measure: count {
    type: count
    hidden: yes
  }

  dimension: reportyear {
    type: number
    label: "Year Number"
    hidden: no
    sql: ${TABLE}.reportyear ;;
  }

  dimension: reportdate {
    type: date
    label: "Report Month"
    hidden: no
    sql: ${TABLE}.reportdate ;;
  }

  dimension: cputype {
    type: number
    label: "Cpu Type"
    hidden: yes
    sql: ${TABLE}.cpu_type_description ;;
  }

  dimension: has_cpcv {
    type: number
    hidden: yes
    sql: case when ${TABLE}.cpu_type_description = 'CPCV' then 1 else 0 end ;;
  }

  dimension: reportmonth {
    type: number
    label: "Month Number"
    hidden: no
    sql: ${TABLE}.reportmonth ;;
  }

  dimension: reportyearmonth {
    type: string
    label: "Year Month"
    description: "The year and month in yyyyMM format"
    hidden: yes
    sql: ${TABLE}.reportyear||${TABLE}.reportmonth ;;
  }

  dimension: campaign {
    type: number
    hidden: no
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: has_hard_demo {
    type: number
    hidden: yes
    sql: ${TABLE}.has_hard_demo ;;
  }

  dimension: has_bt {
    type: number
    hidden: yes
    sql: ${TABLE}.has_bt ;;
  }

  dimension: has_abc {
    type: number
    hidden: yes
    sql: ${TABLE}.has_abc ;;
  }

  dimension: has_vpaid {
    type: number
    hidden: yes
    sql: ${TABLE}.has_vpaid ;;
  }

  dimension: imps {
    type: number
    hidden: yes
    sql: ${TABLE}.imps ;;
  }

  dimension: ccp {
    type: number
    hidden: yes
    sql: ${TABLE}.ccp ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.units ;;
  }

  dimension: rpm {
    type: number
    hidden: yes
    sql: ${TABLE}.rpm ;;
  }

  dimension: freq_bucket_id {
    type: number
    hidden: yes
    sql: ${TABLE}.freq_bucket_id ;;
  }

  dimension: freq_bucket_none {
    type: number
    hidden: yes
    sql: case when ${TABLE}.freq_bucket_id = -1 then 1 else 0 end ;;
  }

  dimension: freq_bucket_low {
    type: number
    hidden: yes
    sql: case when ${TABLE}.freq_bucket_id = 0 then 1 else 0 end ;;
  }

  dimension: freq_bucket_med {
    type: number
    hidden: yes
    sql: case when ${TABLE}.freq_bucket_id = 1 then 1 else 0 end ;;
  }

  dimension: freq_bucket_high {
    type: number
    hidden: yes
    sql: case when ${TABLE}.freq_bucket_id = 2 then 1 else 0 end ;;
  }

  dimension: plan_freq_cap_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.plan_freq_cap_hours ;;
  }

  dimension: campaign_freq_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_freq_cap ;;
  }

  dimension: campaign_freq_cap_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_freq_cap_hours ;;
  }

  dimension: plan_freq_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.plan_freq_cap ;;
  }

  dimension: coalescedunits {
    type: number
    hidden: yes
    sql: ${TABLE}.reportunits;;
  }

  measure: sum_imps {
    type: sum
    label: "Total Impressions"
    description: "The total of all Impressions"
    value_format_name: decimal_0
    sql: ${imps} ;;
  }

  measure: sum_coalescedunits {
    type: sum
    label: "Total Units"
    description: "The total of coalesced units with CCP"
    value_format_name: decimal_0
    sql: ${coalescedunits}  ;;
  }

  measure: sum_ccp {
    type: sum
    label: "Total CCP"
    description: "The total of all CCP"
    value_format_name: decimal_0
    sql: ${ccp} ;;
  }

  measure: sum_bt_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${has_bt} ;;
  }

  measure: sum_vpaid_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${has_vpaid} ;;
  }

  measure: sum_abc_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${has_abc} ;;
  }

  measure: sum_cpcv_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${has_cpcv} ;;
  }

  measure: sum_freq_cap_none_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${freq_bucket_none} ;;
  }

  measure: sum_freq_cap_low_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${freq_bucket_low} ;;
  }

  measure: sum_freq_cap_med_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${freq_bucket_med} ;;
  }

  measure: sum_freq_cap_high_units {
    type: sum
    hidden: yes
    sql: ${coalescedunits}*${freq_bucket_high} ;;
  }

  measure: pct_total {
    type: number
    label: "%Total"
    description: "The pct of Units for pivoting"
    value_format_name: percent_0
    sql: ${coalescedunits}/${sum_coalescedunits} ;;
  }

  measure: pct_bt {
    type: number
    label: "%BT"
    description: "The pct of CCP where campaign has BT targeting"
    value_format_name: percent_0
    sql: COALESCE(${sum_bt_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_cpcv {
    type: number
    label: "%CPCV"
    description: "The pct of CCP where campaign has CPCV"
    value_format_name: percent_0
    sql: COALESCE(${sum_cpcv_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_freq_cap_none_ccp {
    type: number
    label: "%No Freq Cap"
    description: "The pct of units where campaign has no Freq Cap"
    value_format_name: percent_0
    sql: COALESCE(${sum_freq_cap_none_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_freq_cap_low_ccp {
    type: number
    label: "%Lo Freq Cap"
    description: "The pct of units where campaign has a low Freq Cap"
    value_format_name: percent_0
    sql: COALESCE(${sum_freq_cap_low_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_freq_cap_med_ccp {
    type: number
    label: "%Med Freq Cap"
    description: "The pct of units where campaign has a medium Freq Cap"
    value_format_name: percent_0
    sql: COALESCE(${sum_freq_cap_med_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_freq_cap_high_ccp {
    type: number
    label: "%Hi Freq Cap"
    description: "The pct of units where campaign has a high Freq Cap"
    value_format_name: percent_0
    sql: COALESCE(${sum_freq_cap_high_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_vpaid_ccp {
    type: number
    label: "%VPAID"
    description: "The pct of units where campaign has VPAID "
    value_format_name: percent_0
    sql: COALESCE(${sum_vpaid_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

  measure: pct_abc_ccp {
    type: number
    label: "%ABC"
    description: "The pct of units where campaign has BT targeting"
    value_format_name: percent_0
    sql: COALESCE(${sum_abc_units}/nullif(${sum_coalescedunits},0),0) ;;
  }

}
