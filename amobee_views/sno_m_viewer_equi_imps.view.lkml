view: sno_m_viewer_equi_imps {
  derived_table: {
    sql:
        SELECT {% if sno_m_viewer_equi_imps.event_date._in_query %} event_date, {% endif %}
        {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query %} ad_exposure_frequency, {% endif %}
        {% if sno_m_viewer_equi_imps.network._in_query %} media_content_parent, {% endif %}
        {% if sno_m_viewer_equi_imps.daypart._in_query %} media_daypart_id , {% endif %}
        {% if sno_m_viewer_equi_imps.program._in_query %} media_content_name , {% endif %}
        sum(ad_impressions) as ad_impressions,
        sum(equi_ad_impressions) as equi_ad_impressions
        FROM(
        SELECT
        {% if sno_m_viewer_equi_imps.age._in_query %} v.age, {% endif %}
        {% if sno_m_viewer_equi_imps.network._in_query %} mc.media_content_parent, {% endif %}
        {% if sno_m_viewer_equi_imps.daypart._in_query %} mc.media_daypart_id , {% endif %}
        {% if sno_m_viewer_equi_imps.program._in_query %} mc.media_content_name , {% endif %}
        {% if sno_m_viewer_equi_imps.event_date._in_query %} vf.event_date , {% endif %}

        vf.viewer_key
         , rta.effective_weight
         , vf.event_duration
         , COUNT(*) as ad_exposure_frequency
         , COUNT(*) * rta.effective_weight as ad_impressions
         , 1.0 * COUNT(*) * rta.effective_weight*(vf.event_duration/30) as equi_ad_impressions
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
           AND {% condition filter_metric_type %} vf.metric_type  {% endcondition %}
           AND {% condition filter_timeperiod_month_key %} vf.timeperiod_month_key  {% endcondition %}
           AND {% condition campaign_id %} cc.campaign_id  {% endcondition %}
       GROUP BY {% if sno_m_viewer_equi_imps.age._in_query %}  v.age, {% endif %}
                {% if sno_m_viewer_equi_imps.network._in_query %} mc.media_content_parent, {% endif %}
                {% if sno_m_viewer_equi_imps.daypart._in_query %} mc.media_daypart_id , {% endif %}
                {% if sno_m_viewer_equi_imps.program._in_query %} mc.media_content_name , {% endif %}
                {% if sno_m_viewer_equi_imps.event_date._in_query %} vf.event_date , {% endif %}
                vf.viewer_key, rta.effective_weight, vf.event_duration
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
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %} event_date, media_content_parent {% endif %}
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
            and sno_m_viewer_equi_imps.program._in_query %} media_content_parent, media_daypart_id, media_content_name, event_date {% endif %}


       ;;
  }

  filter: ad_content_key {
    view_label: "Viewing Metrics"
    description: "Get the keys from Ad Finder Tool. Enter one or multiple to check exposure"
    type: string
  }

  filter: filter_metric_type {
    label: "Metric Type"
    view_label: "Viewing Metrics"
    description: "For TV live+7 ad Impressions, type 'AED7'"
    type: string
    default_value: "AED7"
  }

  filter: filter_timeperiod_month_key {
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

    dimension: ad_duration {
      view_label: "Viewing Metrics"
      hidden: no
      description: "The Ad Duration in seconds"
      type: string
      sql: ${TABLE}.event_duration;;
    }

    dimension: event_date {
      view_label: "Viewing Metrics"
      hidden: no
      description: "The Date on which viewer saw ad"
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
      value_format_name: decimal_0
      sql: ${TABLE}.equi_ad_impressions ;;
    }

    measure: ad_reach {
      view_label: "Viewing Metrics"
      hidden: yes
      type: sum
      sql: ${effective_weight} ;;
    }

    measure: ad_imps {
      view_label: "Viewing Metrics"
      label: "Raw Ad Impressions"
      type: sum
      description: "Impressions seen by the Panelist"
      sql: ${ad_impressions} ;;
    }

    measure: equi_ad_imps {
      view_label: "Viewing Metrics"
      label: "Equivalized Ad Impressions"
      type: sum
      description: "Equivalized Impressions seen by the Panelist"
      sql: ${equi_ad_impressions} ;;
    }

    measure: imps_per_unit {
      view_label: "Viewing Metrics"
      label: "Equivalized Impressions per Unit"
      type: number
      description: "Equivalized Impressions per Unit"
      sql: ${equi_ad_imps}/NULLIF(${sno_m_ad_units.total_units},0);;
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
