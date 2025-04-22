view: sno_m_viewer_reach {
  derived_table: {
    sql:
      SELECT {% if sno_m_viewer_equi_imps.event_date._in_query %} event_date, {% endif %}
      {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query %} ad_exposure_frequency, {% endif %}
      {% if sno_m_viewer_equi_imps.network._in_query %} media_content_parent, {% endif %}
        {% if sno_m_viewer_equi_imps.daypart._in_query %} media_daypart_id , {% endif %}
        {% if sno_m_viewer_equi_imps.program._in_query %} media_content_name , {% endif %}
        sum(effective_weight) as effective_weight
        FROM(
        SELECT
        {% if sno_m_viewer_equi_imps.network._in_query %} media_content_parent, {% endif %}
        {% if sno_m_viewer_equi_imps.daypart._in_query %} media_daypart_id , {% endif %}
        {% if sno_m_viewer_equi_imps.program._in_query %} media_content_name , {% endif %}
        viewer_key,
        effective_weight
         , MIN(event_date) as event_date
         , COUNT(*) as ad_exposure_frequency
       FROM (
         select distinct vf.viewer_key, rta.effective_weight,vf.media_content_key,event_epoch,mc.media_content_parent, vf.event_date,
         mc.media_daypart_id ,
         mc.media_content_name from
         VIEWERSHIP.VIEWING_FACT vf
      JOIN VIEWERSHIP.MEDIA_CONTENT mc
       ON vf.media_content_key = mc.media_content_key
       JOIN VIEWERSHIP.VIEWER_RTA_GROUP rta
       ON vf.viewer_key = rta.viewer_key
           AND vf.timeperiod_month_key = rta.timeperiod_date_key
       JOIN DIM.converged_campaign cc
       ON cc.str_target_group_id = rta.rta_group_id
       WHERE rta.timeperiod_type = 'm'
           AND {% condition sno_m_viewer_equi_imps.ad_content_key %} vf.ad_content_key  {% endcondition %}
           AND {% condition sno_m_viewer_equi_imps.filter_metric_type %} vf.metric_type  {% endcondition %}
           AND {% condition sno_m_viewer_equi_imps.filter_timeperiod_month_key %} vf.timeperiod_month_key  {% endcondition %}
           AND {% condition sno_m_viewer_equi_imps.campaign_id %} cc.campaign_id  {% endcondition %})
       GROUP BY viewer_key, effective_weight
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} , media_content_parent {% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} , media_daypart_id {% endif %}
          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false %} , media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false %} , media_content_parent, media_daypart_id {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false %} , media_content_parent, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false %} , media_daypart_id, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query %} , media_content_parent, media_daypart_id, media_content_name {% endif %}
          )
          GROUP BY
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_content_parent {% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_daypart_id {% endif %}
          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} event_date {% endif %}
          {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} ad_exposure_frequency {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_content_parent, media_daypart_id {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_content_parent, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} media_daypart_id, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} event_date, ad_exposure_frequency {% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} event_date, media_content_parent} {% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} event_date , media_daypart_id {% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} event_date, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query %} media_content_parent, media_daypart_id, media_content_name {% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query %} event_date, media_content_parent, media_daypart_id, media_content_name {% endif %}

       ;;
  }

  dimension: primary_key {
    type:  string
    primary_key: yes
    hidden: yes
    sql:  {% if sno_m_viewer_equi_imps.network._in_query
      or sno_m_viewer_equi_imps.daypart._in_query
      or sno_m_viewer_equi_imps.program._in_query
      or sno_m_viewer_equi_imps.event_date._in_query
      or sno_m_viewer_equi_imps.ad_exposure_frequency._in_query %}{% else %} TRUE {% endif%}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${network} {% endif %}

          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${daypart} {% endif %}

          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${program} {% endif %}

          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${event_date} {% endif %}

          {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} ${ad_exposure_frequency} {% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${network}||${daypart} {% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${network}||${program} {% endif %}

          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${daypart}||${program} {% endif %}

          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} ${event_date}||${ad_exposure_frequency} {% endif %}

          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${event_date}||${network} {% endif %}

          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${event_date}||${daypart} {% endif %}

          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} ${event_date}||${program} {% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query %} ${network}||${daypart}||${program} {% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query %} ${network}||${daypart}||${program}||${event_date} {% endif %}
            ;;

    }

    dimension: event_date {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The Date on which viewer first saw ad"
      type: string
      sql: ${TABLE}.event_date;;
    }

    dimension: ad_exposure_frequency {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The total number of ads seen by viewer"
      type: number
      sql: ${TABLE}.ad_exposure_frequency ;;
    }

    dimension: daypart {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The daypart on which ad was shown"
      type: string
      sql: ${TABLE}.media_daypart_id ;;
    }

    dimension: network {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The network on which ad was shown"
      type: string
      sql: ${TABLE}.media_content_parent ;;
    }

    dimension: program {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The program on which ad was shown"
      type: string
      sql: ${TABLE}.media_content_name ;;
    }

    dimension: effective_weight {
      view_label: "Viewing Metrics"
      hidden: no
      description: "Weight of the Panelist"
      type: number
      sql: ${TABLE}.effective_weight ;;
    }

    measure: incremental_ad_reach {
      view_label: "Viewing Metrics"
      hidden: no
      type: sum
      sql: ${effective_weight} ;;
    }

  }
