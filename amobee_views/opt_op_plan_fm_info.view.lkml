view: opt_op_plan_fm_info {
  label: "Campaign Details"

  derived_table: {
    sql:
      SELECT
        cmp.audit_factor,
        a.begin_datetm,
        a.campaign_freq_cap,
        a.campaign_id,
        a.campaign_status_id,
        a.icp,
        a.ccp,
        a.overage_threshold,
        a.cpu,
        a.cpu_type_id,
        a.creative_format_type_id,
        a.demo_composition_vendor_id,
        a.device_type_id,
        a.duration,
        a.end_datetm,
        a.flight_media_id,
        a.fm_freq_cap,
        a.force_min_comp,
        a.format_type_id,
        a.freq_knowns,
        a.is_bt_targ,
        a.is_domain_targ,
        a.is_geo_targ,
        a.is_other_targ,
        a.is_whiteops,
        a.is_zip_targ,
        a.isguaranteed,
        a.keydate,
        a.kpi_target,
        a.min_comp_pct,
        a.plan_freq_cap,
        a.platform_client_id,
        a.rta_group_id,
        a.smoothness_lower,
        a.smoothness_upper,
        a.ssl_eligible,
        a.usd_cpu,
        c.description AS cpu_type_description,
        p.description AS platform_client,
        d.description AS device_type,
        f.description AS format_type,
        cmp.campaign_name,
        coalesce(cph.priority, a.priority) AS priority
      FROM an_research..op_plan_fm_info a (NOLOCK)
      LEFT JOIN an_main..cpu_type c (NOLOCK)
        ON c.cpu_type_id = a.cpu_type_id
      LEFT JOIN an_main..device_type d (NOLOCK)
        ON d.device_type_id = a.device_type_id
      LEFT JOIN an_main..format_type f (NOLOCK)
        ON f.format_type_id = a.format_type_id
      LEFT JOIN an_main..platform_client p (NOLOCK)
        ON p.platform_client_id = a.platform_client_id
      LEFT JOIN an_main..campaign cmp (NOLOCK)
        ON a.campaign_id = cmp.campaign_id
      LEFT JOIN (
          SELECT
            cph.campaign_id,
            cph.priority
          FROM (
            SELECT
              campaign_id,
              priority,
              ROW_NUMBER() over (partition by campaign_id order by changedon desc) as _rn
            FROM an_smart..campaign_priority_history (NOLOCK)
            ) cph
          WHERE cph._rn = 1) cph
        ON a.campaign_id = cph.campaign_id
      WHERE {% condition opt_misdelivery.campaign_id %} a.campaign_id {% endcondition %}
        AND {% condition campaign_id %} a.campaign_id {% endcondition %} ;;
  }

  dimension: campaign_id {
    description: "campaign_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: campaign_name {
    description: "campaign_name"
    type: string
    sql: ${TABLE}.campaign_name ;;
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

  dimension_group: flight_start {
    type: time
    label: "Flight Start"
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
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension_group: dst_flight_start {
    type: time
    label: "[DST] Flight Local Start"
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
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${opt_main_timezone_offset_op_plan_fm_flight_start.utc_offset}, ${TABLE}.begin_datetm)
      else ${TABLE}.begin_datetm end ;;
  }

  dimension_group: flight_end {
    type: time
    label: "Flight End"
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
    sql: ${TABLE}.end_datetm ;;
  }

  dimension_group: dst_flight_end {
    type: time
    label: "[DST] Flight Local End"
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
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${opt_main_timezone_offset_op_plan_fm_flight_end.utc_offset}, ${TABLE}.end_datetm)
      else ${TABLE}.end_datetm end ;;
  }

  dimension: campaign_status_id {
    description: "campaign_status_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.campaign_status_id ;;
  }

  dimension: cpu_type_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.cpu_type_id ;;
  }

  dimension: device_type_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.device_type_id ;;
  }

  dimension: format_type_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.format_type_id ;;
  }

  dimension: flight_media_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: cpu_type {
    type: string
    label: "Cpu Type"
    sql: ${TABLE}.cpu_type_description ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.device_type ;;
  }

  dimension: format_type {
    type: string
    label: "Format Type"
    sql: ${TABLE}.format_type ;;
  }

  dimension: platform_client {
    type: string
    label: "Platform Client"
    sql: ${TABLE}.platform_client ;;
  }

  dimension: platform_client_id {
    type: number
    label: "Platform Client Id"
    value_format_name:  id
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: cpu {
    type: number
    sql: ${TABLE}.cpu ;;
    value_format_name: decimal_2
  }

  dimension: usd_cpu {
    type:  number
    sql: ${TABLE}.usd_cpu ;;
  }

  dimension: isguaranteed {
    type: number
    sql: ${TABLE}.isguaranteed ;;
    label: "Zero Waste"
  }

  dimension: min_comp_pct {
    type: number
    sql: ${TABLE}.min_comp_pct ;;
  }

  dimension: force_min_comp {
    type: number
    sql: ${TABLE}.force_min_comp ;;
  }

  dimension: demo_composition_vendor_id {
    type: number
    sql: ${TABLE}.demo_composition_vendor_id ;;
  }

  dimension: audit_factor {
    type: number
    sql: ${TABLE}.audit_factor ;;
  }

  dimension: rta_group_id {
    type: number
    sql: ${TABLE}.rta_group_id ;;
    value_format_name: id
  }

  dimension: fm_freq_cap {
    type: string
    sql: ${TABLE}.fm_freq_cap ;;
  }

  dimension: campaign_freq_cap {
    type: string
    sql: ${TABLE}.campaign_freq_cap ;;
  }

  dimension: plan_freq_cap {
    type: string
    sql: ${TABLE}.plan_freq_cap ;;
  }

  dimension: ssl_eligible {
    type: number
    sql: ${TABLE}.ssl_eligible ;;
  }

  dimension: priority {
    type: string
    sql: case when ${TABLE}.priority = -1 then 'Low' when ${TABLE}.priority = 1 then 'High' else 'Medium' end ;;
  }

  dimension: smoothness_lower {
    type: number
    sql: ${TABLE}.smoothness_lower ;;
  }

  dimension: smoothness_upper {
    type: number
    sql: ${TABLE}.smoothness_upper ;;
  }

  measure: icp {
    type: sum
    label: "ICP"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.icp ;;
  }

  measure: ccp {
    type: sum
    label: "CCP"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.ccp ;;
  }

  measure:overage_threshold {
    type: sum
    label: "Overage Threshold"
    value_format_name:  decimal_0
    sql: ${TABLE}.overage_threshold ;;
  }

  dimension: kpi_target {
    type: string
    sql: ${TABLE}.kpi_target ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: freq_knowns {
    type: number
    sql: ${TABLE}.freq_knowns;;
  }

  dimension: creative_format_type_id {
    type: number
    sql: ${TABLE}.creative_format_type_id ;;
    value_format_name: id
  }

  dimension: is_geo_targ {
    type: number
    sql: ${TABLE}.is_geo_targ ;;
  }

  dimension: is_bt_targ {
    label: "Has BT"
    type: number
    sql: ${TABLE}.is_bt_targ ;;
  }

  dimension: is_zip_targ {
    type: number
    sql: ${TABLE}.is_zip_targ ;;
  }

  dimension: is_domain_targ {
    type: number
    sql: ${TABLE}.is_domain_targ ;;
  }

  dimension: is_other_targ {
    type: number
    sql: ${TABLE}.is_other_targ ;;
  }

  dimension: is_whiteops {
    type: number
    sql: ${TABLE}.is_whiteops ;;
  }
}
