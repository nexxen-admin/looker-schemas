connection: "snowflake"

include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project




explore: sno_m_viewer_equi_imps {

  view_name: sno_m_viewer_equi_imps
  label: "Monthly Reach and Impressions"
  description: "This can be used to obtain reach/impressions by total exposure count for a broadcast month for the Strategic Target.  It can be aggregated
  by date, age, exposure counts, network, daypart or program."

  join: sno_m_ad_units {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_m_viewer_equi_imps.network._in_query
            or sno_m_viewer_equi_imps.daypart._in_query
            or sno_m_viewer_equi_imps.program._in_query %}{% else %} TRUE {% endif%}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} ${sno_m_viewer_equi_imps.network} =  ${sno_m_ad_units.network}{% endif %}

          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %} ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_ad_units.daypart}{% endif %}

          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false %} ${sno_m_viewer_equi_imps.program} =  ${sno_m_ad_units.program}{% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false %} ${sno_m_viewer_equi_imps.network} =  ${sno_m_ad_units.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_ad_units.daypart}{% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_ad_units.network}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_ad_units.program}{% endif %}

          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false %}
            ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_ad_units.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_ad_units.program}{% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_ad_units.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_ad_units.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_ad_units.program}{% endif %}

          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_ad_units.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_ad_units.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_ad_units.program}
            AND ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_ad_units.event_date}{% endif %}
            ;;
  }

  join: sno_m_viewer_reach {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_m_viewer_equi_imps.network._in_query
      or sno_m_viewer_equi_imps.daypart._in_query
      or sno_m_viewer_equi_imps.program._in_query
      or sno_m_viewer_equi_imps.event_date._in_query
      or sno_m_viewer_equi_imps.ad_exposure_frequency._in_query %}{% else %} TRUE {% endif%}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}{% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false % %}
            ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}{% endif %}
          {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %}
            ${sno_m_viewer_equi_imps.ad_exposure_frequency} =  ${sno_m_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.ad_exposure_frequency} =  ${sno_m_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}
            AND ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}{% endif %}
            ;;
  }join: sno_m_viewer_total_reach {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_m_viewer_equi_imps.network._in_query
      or sno_m_viewer_equi_imps.daypart._in_query
      or sno_m_viewer_equi_imps.program._in_query
      or sno_m_viewer_equi_imps.event_date._in_query
      or sno_m_viewer_equi_imps.ad_exposure_frequency._in_query %}{% else %} TRUE {% endif%}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}{% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false % %}
            ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}{% endif %}
          {% if sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %}
            ${sno_m_viewer_equi_imps.ad_exposure_frequency} =  ${sno_m_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.event_date._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.ad_exposure_frequency} =  ${sno_m_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.program._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}{% endif %}
          {% if sno_m_viewer_equi_imps.event_date._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.network._in_query == false
            and sno_m_viewer_equi_imps.daypart._in_query == false
            and sno_m_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query == false %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}{% endif %}
          {% if sno_m_viewer_equi_imps.network._in_query
            and sno_m_viewer_equi_imps.daypart._in_query
            and sno_m_viewer_equi_imps.program._in_query
            and sno_m_viewer_equi_imps.event_date._in_query %}
            ${sno_m_viewer_equi_imps.network} =  ${sno_m_viewer_reach.network}
            AND ${sno_m_viewer_equi_imps.daypart} =  ${sno_m_viewer_reach.daypart}
            AND ${sno_m_viewer_equi_imps.program} =  ${sno_m_viewer_reach.program}
            AND ${sno_m_viewer_equi_imps.event_date} =  ${sno_m_viewer_reach.event_date}{% endif %}
            ;;
  }
}


explore: sno_q_viewer_equi_imps {

  view_name: sno_q_viewer_equi_imps
  label: "Quarterly Reach and Impressions"
  description: "This can be used to obtain reach/impressions by total exposure count for a broadcast quarter for the Strategic Target.  It can be aggregated
  by date, age, exposure counts, network, daypart or program."

  join: sno_q_ad_units {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_q_viewer_equi_imps.network._in_query
            or sno_q_viewer_equi_imps.daypart._in_query
            or sno_q_viewer_equi_imps.program._in_query %}{% else %} TRUE {% endif%}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${sno_q_viewer_equi_imps.network} =  ${sno_q_ad_units.network}{% endif %}

          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %} ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_ad_units.daypart}{% endif %}

          {% if sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false %} ${sno_q_viewer_equi_imps.program} =  ${sno_q_ad_units.program}{% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query == false %} ${sno_q_viewer_equi_imps.network} =  ${sno_q_ad_units.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_ad_units.daypart}{% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_ad_units.network}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_ad_units.program}{% endif %}

          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false %}
            ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_ad_units.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_ad_units.program}{% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_ad_units.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_ad_units.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_ad_units.program}{% endif %}

          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_ad_units.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_ad_units.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_ad_units.program}
            AND ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_ad_units.event_date}{% endif %}
            ;;
  }

  join: sno_q_viewer_reach {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_q_viewer_equi_imps.network._in_query
      or sno_q_viewer_equi_imps.daypart._in_query
      or sno_q_viewer_equi_imps.program._in_query
      or sno_q_viewer_equi_imps.event_date._in_query
      or sno_q_viewer_equi_imps.ad_exposure_frequency._in_query %}{% else %} TRUE {% endif%}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}{% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false % %}
            ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}{% endif %}
          {% if sno_q_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %}
            ${sno_q_viewer_equi_imps.ad_exposure_frequency} =  ${sno_q_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}
            AND ${sno_q_viewer_equi_imps.ad_exposure_frequency} =  ${sno_q_viewer_reach.ad_exposure_frequency}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}
            AND ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_reach.program}
            AND ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_reach.event_date}{% endif %}
            ;;
  }

  join: sno_q_viewer_total_reach {
    relationship: many_to_one
    type: left_outer
    sql_on:
          {% if sno_q_viewer_equi_imps.network._in_query
      or sno_q_viewer_equi_imps.daypart._in_query
      or sno_q_viewer_equi_imps.program._in_query
      or sno_q_viewer_equi_imps.event_date._in_query
      or sno_q_viewer_equi_imps.ad_exposure_frequency._in_query %}{% else %} TRUE {% endif%}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}{% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false % %}
            ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}{% endif %}
          {% if sno_q_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %}
            ${sno_q_viewer_equi_imps.ad_exposure_frequency} =  ${sno_q_viewer_total_reach.ad_exposure_frequency}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.event_date._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}
            AND ${sno_q_viewer_equi_imps.ad_exposure_frequency} =  ${sno_q_viewer_total_reach.ad_exposure_frequency}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}
            AND ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.program._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}{% endif %}
          {% if sno_q_viewer_equi_imps.event_date._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.network._in_query == false
            and sno_q_viewer_equi_imps.daypart._in_query == false
            and sno_q_viewer_equi_imps.ad_exposure_frequency._in_query == false %}
            ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query == false %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}{% endif %}
          {% if sno_q_viewer_equi_imps.network._in_query
            and sno_q_viewer_equi_imps.daypart._in_query
            and sno_q_viewer_equi_imps.program._in_query
            and sno_q_viewer_equi_imps.event_date._in_query %}
            ${sno_q_viewer_equi_imps.network} =  ${sno_q_viewer_total_reach.network}
            AND ${sno_q_viewer_equi_imps.daypart} =  ${sno_q_viewer_total_reach.daypart}
            AND ${sno_q_viewer_equi_imps.program} =  ${sno_q_viewer_total_reach.program}
            AND ${sno_q_viewer_equi_imps.event_date} =  ${sno_q_viewer_total_reach.event_date}{% endif %}
            ;;
  }
}

explore: quarterly_reach_by_ad_frequency{

  view_name: sno_q_reach_by_ad_frequency
  label: "Quarterly Ad Exposure Reach Buckets"
  fields: [ALL_FIELDS*]
  description: "This can be used to obtain the Quarterly Reach by Ad Exposure Frequency"
}

explore: monthly_reach_by_ad_frequency{

  view_name: sno_m_reach_by_ad_frequency
  label: "Monthly Ad Exposure Reach Buckets"
  fields: [ALL_FIELDS*]
  description: "This can be used to obtain the Monthly Reach by Ad Exposure Frequency"
}
