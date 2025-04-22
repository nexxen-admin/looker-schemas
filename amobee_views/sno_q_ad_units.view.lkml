view: sno_q_ad_units {
  derived_table: {
    sql:
        SELECT
        {% if sno_q_viewer_equi_imps.event_date._in_query %} vf.event_date, {% endif %}
        {% if sno_q_viewer_equi_imps.network._in_query %} mc.media_content_parent, {% endif %}
        {% if sno_q_viewer_equi_imps.daypart._in_query %} mc.media_daypart_id , {% endif %}
        {% if sno_q_viewer_equi_imps.program._in_query %} mc.media_content_name , {% endif %}
         COUNT(distinct vf.event_start_datetime, vf.ad_content_key) as units
       FROM VIEWERSHIP.VIEWING_FACT vf
      JOIN VIEWERSHIP.MEDIA_CONTENT mc
       ON vf.media_content_key = mc.media_content_key
      JOIN VIEWERSHIP.VIEWER_RTA_GROUP rta
       ON vf.viewer_key = rta.viewer_key
           AND vf.timeperiod_quarter_key = rta.timeperiod_date_key
           AND rta.rta_group_id = 70327
       WHERE rta.timeperiod_type = 'q'
           AND {% condition sno_q_viewer_equi_imps.filter_metric_type %} vf.metric_type  {% endcondition %}
           AND {% condition sno_q_viewer_equi_imps.filter_timeperiod_quarter_key %} vf.timeperiod_quarter_key  {% endcondition %}
       GROUP BY {% if sno_q_viewer_equi_imps.network._in_query and sno_q_viewer_equi_imps.daypart._in_query == false and sno_q_viewer_equi_imps.program._in_query == false %} mc.media_content_parent {% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} mc.media_daypart_id {% endif %}
          {% if sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false %}  mc.media_content_name {% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query == false %}  mc.media_content_parent, mc.media_daypart_id {% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false %} mc.media_content_parent, mc.media_content_name {% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false %} mc.media_daypart_id, mc.media_content_name {% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query %} mc.media_content_parent, mc.media_daypart_id, mc.media_content_name {% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.program._in_query %} vf.event_date, mc.media_content_parent, mc.media_daypart_id, mc.media_content_name {% endif %}
       ;;
  }

  dimension: primary_key {
    type:  string
    primary_key: yes
    hidden: yes
    sql:  {% if sno_q_viewer_equi_imps.network._in_query
      or sno_q_viewer_equi_imps.daypart._in_query
      or sno_q_viewer_equi_imps.event_date._in_query
      or sno_q_viewer_equi_imps.program._in_query %}{% else %} TRUE {% endif%}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${network} {% endif %}

          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${daypart} {% endif %}

          {% if sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false %} ${program} {% endif %}

          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false %} ${event_date} {% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${network}||${daypart} {% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false %} ${network}||${program} {% endif %}

          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.network._in_query == false %} ${daypart}||${program} {% endif %}

          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.network._in_query == false %} ${event_date}||${program} {% endif %}

          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${event_date}||${network} {% endif %}

          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${event_date}||${daypart} {% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query %} ${network}||${daypart}||${program} {% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.program._in_query %} ${network}||${daypart}||${program}||${event_date} {% endif %}
            ;;
    }

    dimension: event_date {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The date on which ad was shown"
      type: string
      sql: ${TABLE}.event_date ;;
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

    dimension: units {
      view_label: "Viewing Metrics"
      hidden: yes
      description: "The total number of ads seen in inventory"
      type: number
      sql: ${TABLE}.units ;;
    }

    measure: total_units {
      view_label: "Viewing Metrics"
      label: "Total Units"
      hidden:  no
      type: sum
      description: "Total Ad Spots in the inventory"
      sql: ${units} ;;
    }


  }
