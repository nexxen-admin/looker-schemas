view: sno_m_viewer_facts {
  derived_table: {
    sql:
        SELECT
        {% if sno_m_viewer_facts.age._in_query %} v.age, {% endif %}
        {% if sno_m_viewer_facts.network._in_query %} mc.media_content_parent, {% endif %}
        {% if sno_m_viewer_facts.daypart._in_query %} mc.media_daypart_id , {% endif %}
        {% if sno_m_viewer_facts.program._in_query %} mc.media_content_name , {% endif %}
        vf.viewer_key
         , rta.effective_weight
         , MIN(vf.event_date) as event_date
         , COUNT(*) as ad_exposure_frequency
         , COUNT(*) * rta.effective_weight as ad_impressions
         , COUNT(*) * rta.effective_weight*(mc.instance_duration/30) as equi_ad_impressions
       FROM VIEWERSHIP.VIEWING_FACT vf
      JOIN VIEWERSHIP.MEDIA_CONTENT mc
       ON vf.media_content_key = mc.media_content_key
       JOIN VIEWERSHIP.VIEWER_RTA_GROUP rta
       ON vf.viewer_key = rta.viewer_key
           AND vf.timeperiod_month_key = rta.timeperiod_date_key
       JOIN dim.converged_campaign cc
       ON cc.str_target_group_id = rta.rta_group_id
       WHERE rta.timeperiod_type = 'm'
           AND {% condition ad_content_key %} vf.ad_content_key  {% endcondition %}
           AND {% condition metric_type %} vf.metric_type  {% endcondition %}
           AND {% condition timeperiod_month_key %} vf.timeperiod_month_key  {% endcondition %}
           AND {% condition campaign_id %} cc.campaign_id  {% endcondition %}
       GROUP BY {% if sno_m_viewer_facts.age._in_query %}  v.age, {% endif %}
                {% if sno_m_viewer_facts.network._in_query %} mc.media_content_parent, {% endif %}
                {% if sno_m_viewer_facts.daypart._in_query %} mc.media_daypart_id , {% endif %}
                {% if sno_m_viewer_facts.program._in_query %} mc.media_content_name , {% endif %}
                vf.viewer_key, rta.effective_weight
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

  filter: timeperiod_month_key {
    view_label: "Viewing Metrics"
    description: "Select the month to get ad reach/frequency report. Eg. May 2017 is 201705"
    label: "Month"
    type: number
  }

  filter: campaign_id {
    view_label: "Strategic Target Audience"
    hidden: no
    description: "Campaign who's strategic target you are want to check exposure for"
    type: number
  }

  dimension: event_date {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The Date on which viewer first saw ad"
    type: string
    sql: ${TABLE}.event_date;;
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

  dimension: equi_ad_impressions {
    view_label: "Viewing Metrics"
    hidden: yes
    description: "Equivalized Impressions seen by the Panelist"
    type: number
    sql: ${TABLE}.equi_ad_impressions ;;
  }

  measure: ad_reach {
    view_label: "Viewing Metrics"
    type: sum
    sql: ${effective_weight} ;;
  }

  measure: ad_imps {
    view_label: "Viewing Metrics"
    type: sum
    description: "Impressions seen by the Panelist"
    sql: ${ad_impressions} ;;
  }

  measure: equi_ad_imps {
    view_label: "Viewing Metrics"
    type: sum
    description: "Equivalized Impressions seen by the Panelist"
    sql: ${equi_ad_impressions} ;;
  }

  dimension: age {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The age of panelist"
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: daypart {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The daypart on which ad was shown"
    type: string
    sql: ${TABLE}.media_daypart_id ;;
  }

  dimension: network {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The network on which ad was shown"
    type: string
    sql: ${TABLE}.media_content_parent ;;
  }

  dimension: program {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The program on which ad was shown"
    type: string
    sql: ${TABLE}.media_content_name ;;
  }


}
