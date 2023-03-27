view: sno_tv_ads_reach_frequency_quarterly_facts {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
        SELECT
         vf.viewer_key
         , rta.effective_weight
         , COUNT(*) as ad_exposure_frequency
         , COUNT(*) * rta.effective_weight as ad_impressions
       FROM VIEWERSHIP.VIEWING_FACT vf
       JOIN VIEWERSHIP.VIEWER_RTA_GROUP rta
       ON vf.viewer_key = rta.viewer_key
           AND vf.timeperiod_quarter_key = rta.timeperiod_date_key
       WHERE rta.timeperiod_type = 'q'
           AND {% condition ad_content_key %} vf.ad_content_key  {% endcondition %}
           AND {% condition metric_type %} vf.metric_type  {% endcondition %}
           AND {% condition timeperiod_quarter_key %} vf.timeperiod_quarter_key  {% endcondition %}
           AND {% condition rta_group_id %} rta.rta_group_id  {% endcondition %}
       GROUP BY vf.viewer_key, rta.effective_weight
       ;;
  }

  filter: ad_content_key {
    view_label: "Viewing Metrics"
    description: "Get the keys from Ad Finder Tool. Enter one or multiple to check exposure"
    type: string
  }

  filter: metric_type {
    view_label: "Viewing Metrics"
    description: "For TV live+7 ad Impressions, type 'AED7'"
    type: string
    default_value: "AED7"
  }

  filter: timeperiod_quarter_key {
    view_label: "Viewing Metrics"
    description: "Select the quarter to get ad reach/frequency report. Eg. 2017Q2 is 201702"
    label: "Quarter"
    type: number
  }

  filter: rta_group_id {
    view_label: "TV Panelist"
    hidden: no
    description: "RTA group viewer belongs to"
    type: number
  }

  dimension: ad_exposure_frequency {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The total number of ads seen by viewer"
    type: number
    sql: ${TABLE}.ad_exposure_frequency ;;
  }


  dimension: effective_weight {
    view_label: "Viewing Metrics"
    hidden: yes
    description: "Weight of the Panelist"
    type: number
    sql: ${TABLE}.effective_weight ;;
  }

  dimension: ad_impressions {
    view_label: "Viewing Metrics"
    hidden: yes
    description: "Impressions seen by the Panelist"
    type: number
    sql: ${TABLE}.ad_impressions ;;
  }

  measure: ad_reach_by_freq {
    view_label: "Viewing Metrics"
    type: sum
    sql: ${effective_weight} ;;
  }

  measure: ad_imps_by_freq {
    view_label: "Viewing Metrics"
    type: sum
    sql: ${ad_impressions} ;;
  }

}
