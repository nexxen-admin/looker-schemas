view: sno_frequency_by_tier {

  derived_table: {
    sql:  SELECT
    {% if sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query %}
     coalesce(ft.pl_plan_id, ft2.pl_plan_id) as PLAN_ID
    ,coalesce(ft.campaign_id, ft2.campaign_id) as CAMPAIGN_ID
    {% elsif sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query == false %}
     coalesce(ft.campaign_id, ft2.campaign_id) as CAMPAIGN_ID
    {% elsif sno_frequency_by_tier.plan_id._in_query
       and sno_frequency_by_tier.campaign_id._in_query == false %}
     coalesce(ft.pl_plan_id, ft2.pl_plan_id) as PLAN_ID
    {% else %}{% endif %}
  ,ft.frequency as FREQUENCY
  ,max(ft2.TOTAL_SAMPLED_UNITS) as TOTAL_SAMPLED_UNITS
  ,max(ft.BILLABLE_UNITS) as BILLABLE_UNITS
  ,max(ft.COMPLETION_PCT_IMPRESSIONS) as COMPLETION_PCT_IMPRESSIONS
  ,max(ft.CLICKS) as CLICKS
  ,max(ft.COMPLETED_PCT_IMPRESSIONS) as COMPLETED_PCT_IMPRESSIONS
  ,max(ft.COMPLETED_75) as COMPLETED_75
  ,max(ft.COMPLETED_50) as COMPLETED_50
  ,max(ft.COMPLETED_25) as COMPLETED_25
  ,max(ft.COMPLETED_100) as COMPLETED_100
  ,max(ft.CLICK_IMPRESSIONS) as CLICK_IMPRESSIONS
FROM (
  SELECT
    {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     u1.pl_plan_id
    ,u1.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     u1.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     u1.pl_plan_id
    {% else %}{% endif %}
    ,frequency
    ,sum(u1.billable_units) as billable_units
    ,sum(clicks) as CLICKS
    ,sum(click_impressions) as CLICK_IMPRESSIONS
    ,sum(completed_25) as COMPLETED_25
    ,sum(completed_50) as COMPLETED_50
    ,sum(completed_75) as COMPLETED_75
    ,sum(completed_100) as COMPLETED_100
    ,sum(completed_pct_impressions) as COMPLETED_PCT_IMPRESSIONS
    ,sum(completion_pct_impressions)  as COMPLETION_PCT_IMPRESSIONS
  FROM (
      SELECT
    {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     cd.pl_plan_id
    ,fmd.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     fmd.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     cd.pl_plan_id
    {% else %}{% endif %}
      ,us.userid
      ,sum(us.impressions) frequency
      ,sum(us.billable_units) billable_units
      ,sum(us.clicks) clicks
      ,sum(us.click_impressions) click_impressions
      ,sum(us.completed_25) completed_25
      ,sum(us.completed_50) completed_50
      ,sum(us.completed_75) completed_75
      ,sum(us.completed_100) completed_100
      ,sum(us.completed_pct_impressions) completed_pct_impressions
      ,sum(us.completion_pct_impressions) completion_pct_impressions
    FROM demand.ctd_core_user_sample us
    JOIN dim.flight_media_details fmd ON (us.flight_media_id = fmd.flight_media_id)
    JOIN dim.campaign_details cd  on (fmd.campaign_id = cd.campaign_id)
    WHERE
      {% if sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query %}
      {% condition sno_frequency_by_tier.campaign_id %} fmd.campaign_id {% endcondition %}
    AND {% condition sno_frequency_by_tier.plan_id %} cd.pl_plan_id {% endcondition %}
    {% elsif sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query == false %}
      {% condition sno_frequency_by_tier.campaign_id %} fmd.campaign_id {% endcondition %}
  {% elsif sno_frequency_by_tier.plan_id._in_query
       and sno_frequency_by_tier.campaign_id._in_query == false %}
     {% condition sno_frequency_by_tier.plan_id %} cd.pl_plan_id {% endcondition %}
  {% else %}{% endif %}
        GROUP BY
    {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     cd.pl_plan_id
    ,fmd.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     fmd.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     cd.pl_plan_id
    {% else %}{% endif %}
      ,us.userid
    ) u1
  WHERE frequency <= 7
  GROUP BY
     {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     u1.pl_plan_id
    ,u1.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     u1.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     u1.pl_plan_id
    {% else %}{% endif %}
    ,frequency
  ) ft
FULL OUTER JOIN (
  SELECT
    {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     cd.pl_plan_id
    ,fmd.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     fmd.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     cd.pl_plan_id
    {% else %}{% endif %}
    ,sum(mus.BILLABLE_UNITS) TOTAL_SAMPLED_UNITS
  FROM demand_mart.MONTHLY_CORE_USER_SAMPLE mus
  JOIN dim.FLIGHT_MEDIA_DETAILS fmd ON (mus.FLIGHT_MEDIA_ID = fmd.FLIGHT_MEDIA_ID)
  JOIN dim.CAMPAIGN_DETAILS cd ON (fmd.campaign_id = cd.campaign_id)
  WHERE
      {% if sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query %}
      {% condition sno_frequency_by_tier.campaign_id %} fmd.campaign_id {% endcondition %}
    AND {% condition sno_frequency_by_tier.plan_id %} cd.pl_plan_id {% endcondition %}
    {% elsif sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query == false %}
      {% condition sno_frequency_by_tier.campaign_id %} fmd.campaign_id {% endcondition %}
  {% elsif sno_frequency_by_tier.plan_id._in_query
       and sno_frequency_by_tier.campaign_id._in_query == false %}
     {% condition sno_frequency_by_tier.plan_id %} cd.pl_plan_id {% endcondition %}
  {% else %}{% endif %}
  GROUP BY
    {% if sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query %}
     cd.pl_plan_id
    ,fmd.campaign_id
    {% elsif sno_frequency_by_tier.campaign_id._in_query and sno_frequency_by_tier.plan_id._in_query == false %}
     fmd.campaign_id
    {% elsif sno_frequency_by_tier.plan_id._in_query and sno_frequency_by_tier.campaign_id._in_query == false %}
     cd.pl_plan_id
    {% else %}{% endif %}
  ) ft2 ON
      {% if sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query %}
     (ft.campaign_id = ft2.campaign_id) AND (ft.pl_plan_id = ft2.pl_plan_id)
    {% elsif sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query == false %}
     (ft.campaign_id = ft2.campaign_id)
    {% elsif sno_frequency_by_tier.plan_id._in_query
       and sno_frequency_by_tier.campaign_id._in_query == false %}
     (ft.pl_plan_id = ft2.pl_plan_id)
    {% else %}{% endif %}
GROUP BY
    {% if sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query %}
     coalesce(ft.pl_plan_id, ft2.pl_plan_id)
    ,coalesce(ft.campaign_id, ft2.campaign_id)
    {% elsif sno_frequency_by_tier.campaign_id._in_query
       and sno_frequency_by_tier.plan_id._in_query == false %}
     coalesce(ft.campaign_id, ft2.campaign_id)
    {% elsif sno_frequency_by_tier.plan_id._in_query
       and sno_frequency_by_tier.campaign_id._in_query == false %}
     coalesce(ft.pl_plan_id, ft2.pl_plan_id)
    {% else %}{% endif %}
  ,ft.frequency
      ;;
  }

  dimension: campaign_id {
    label: "Campaign ID"
    view_label: "Campaign"
    description: "The system id of the Campaign."
    type: number
    sql: ${TABLE}.CAMPAIGN_ID ;;
    value_format_name: id
  }

  dimension: plan_id {
    label: "Plan ID"
    view_label: "Plan"
    description: "The system ID of the Plan"
    type: number
    sql: ${TABLE}.PLAN_ID ;;
    value_format_name: id
  }

  dimension: frequency {
    label: "Frequency"
    view_label: "Frequency Facets"
    description: "Tiers 1-7. Number of times in which viewers saw Campaign or Plan."
    type: number
    sql: ${TABLE}.FREQUENCY ;;
  }

  dimension: total_sampled_units {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_SAMPLED_UNITS ;;
  }

  dimension: billable_units {
    type: number
    hidden: yes
    sql: ${TABLE}.BILLABLE_UNITS ;;
  }

  dimension: completion_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  dimension: completed_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  dimension: completed_25 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  dimension: completed_50 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  dimension: completed_75 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  dimension: completed_100 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  dimension: click_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICKS ;;
  }

######## MEASURES ###########

  measure: sum_billable_units {
    type: sum
    hidden: yes
    label: "Billable Units"
    sql: ${billable_units} ;;
  }

  measure: sum_total_sampled_units {
    type: sum
    hidden: yes
    sql: ${TABLE}.TOTAL_SAMPLED_UNITS ;;
  }

  measure: sum_completion_pct_impressions {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  measure: sum_completed_pct_impressions {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  measure: sum_completed_25 {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  measure: sum_completed_50 {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  measure: sum_completed_75 {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  measure: sum_completed_100 {
    type: sum
    hidden: yes
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  measure: sum_click_impressions {
    type: sum
    hidden: yes
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  measure: sum_clicks {
    type: sum
    hidden: yes
    sql: ${TABLE}.CLICKS ;;
  }

  measure: ctr {
    type: number
    label: "CTR"
    view_label: "Frequency by Measures"
    description: "The Click Through Rate for the displayed frequency bucket."
    value_format_name: percent_2
    sql: ${sum_clicks}*1 / ${sum_click_impressions} ;;
  }

  measure: vtr {
    type: number
    label: "VTR"
    view_label: "Frequency by Measures"
    description: "The View Through Rate for the displayed frequency bucket."
    value_format_name: percent_2
    sql: ${sum_completed_100} / ${sum_completed_pct_impressions} ;;
  }

  measure: vcr {
    type: number
    label: "VCR"
    view_label: "Frequency by Measures"
    description: "The Video Completion Rate for the displayed frequency bucket."
    value_format_name: percent_2
    sql: (((${sum_completed_25}*0.25) + (${sum_completed_50}*0.5) + (${sum_completed_75}*.75) + (${sum_completed_100})) / ${sum_completed_pct_impressions}) ;;
  }

  measure: percent_of_units {
    type: number
    label: "Percent of Units"
    view_label: "Frequency by Measures"
    description: "Percent of Billable Units that were served within a given frequency bucket."
    value_format_name: percent_0
    sql: ${sum_billable_units} / ${sum_total_sampled_units} ;;
  }

}
