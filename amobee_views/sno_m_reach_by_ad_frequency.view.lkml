view: sno_m_reach_by_ad_frequency {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
        select ad_exposure_frequency, sum(effective_weight)  as reach
        FROM(
        SELECT
        viewer_key
        ,effective_weight
        , COUNT(*) as ad_exposure_frequency
          from(
       select distinct vf.viewer_key, rta.effective_weight,vf.media_content_key,event_epoch
            FROM VIEWERSHIP.VIEWING_FACT vf
      JOIN VIEWERSHIP.MEDIA_CONTENT mc
       ON vf.media_content_key = mc.media_content_key
       JOIN VIEWERSHIP.VIEWER_RTA_GROUP rta
       ON vf.viewer_key = rta.viewer_key
           AND vf.timeperiod_month_key = rta.timeperiod_date_key
       JOIN DIM.converged_campaign cc
       ON cc.str_target_group_id = rta.rta_group_id
       WHERE rta.timeperiod_type = 'm'
           AND {% condition ad_content_key %} vf.ad_content_key {% endcondition %}
           AND (vf.metric_type = 'AED7')
           AND {% condition timeperiod_month_key %} vf.timeperiod_month_key {% endcondition %}
           AND {% condition campaign_id %} cc.campaign_id {% endcondition %}
          )
       GROUP BY viewer_key, effective_weight
          order by ad_exposure_frequency
          )
       GROUP BY ad_exposure_frequency
         ;;
  }

  filter: ad_content_key {
    view_label: "Viewing Metrics"
    description: "The Ad Content Keys to measure exposure against. Obtained from the Ad Finder Tool."
    type: string
  }

  filter: campaign_id{
    view_label: "Viewing Metrics"
    description: "The Campaign ID which has Strategic Target to measure exposure against."
    type: number
  }

  filter: timeperiod_month_key {
    view_label: "Viewing Metrics"
    description: "The Month for which insights are needed. Eg. for May 2018 use 201805"
    type: number
  }

  dimension: ad_exposure_frequency {
    view_label: "Viewing Metrics"
    hidden: no
    description: "Ad Exposure Frequency"
    type: number
    sql: ${TABLE}.ad_exposure_frequency ;;
  }

  dimension: reach {
    view_label: "Viewing Metrics"
    hidden: no
    description: "Ad Reach"
    type: number
    sql: ${TABLE}.reach ;;
  }
}
