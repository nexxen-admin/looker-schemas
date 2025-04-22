view: v_campaign_frequency_cap_violations {

  derived_table: {
    sql:
      SELECT
        pk_id,
        max_exposures,
        exposure_minutes,
        CASE WHEN units_in_cap > max_exposures and max_exposures <> 0
            then 1
            else 0
        END AS is_violation
        FROM
          (
            SELECT
              r1.pk_id,
              coalesce(max(fc.max_exposures),0) AS max_exposures,
              coalesce(max(fc.exposure_minutes),0) AS exposure_minutes,
              sum(r1.billable_units) as units_in_cap
            FROM rawdb.raw_impression r1
            LEFT JOIN dim.frequency_cap_view fc ON fc.level = 3 AND fc.ref_id = r1.campaign_id AND r1.eventtime >= fc.start_time and r1.eventtime < coalesce(fc.end_time, TO_TIMESTAMP('9999-12-12', 'YYYY-MM-DD'))
            LEFT JOIN rawdb.raw_impression r2 ON r1.userid = r2.userid AND r1.campaign_id = r2.campaign_id
                  AND ( (r1.eventtime > r2.eventtime AND r1.eventtime < TIMESTAMPADD(minute,coalesce(fc.exposure_minutes,0)::INTEGER, r2.eventtime))
              OR  (r2.eventtime = r1.eventtime AND r1.pk_id >= r2.pk_id))
            WHERE {% condition v_raw_impression.demand_date_date %} r1.demand_date {% endcondition %}
              AND {% condition v_raw_impression.raw_demand_date %} r1.demand_date {% endcondition %}
              AND {% condition v_raw_impression.demand_date_month %} r1.demand_date {% endcondition %}
              AND {% condition v_raw_impression.demand_date_year %} r1.demand_date {% endcondition %}
              AND {% condition v_raw_impression.eventtime_date %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.eventtime_month %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.eventtime_quarter %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.eventtime_time %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.eventtime_week %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.eventtime_year %} r1.eventtime {% endcondition %}
              AND {% condition v_raw_impression.epoch_raw_date %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_time %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_hour %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_date %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_week %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_month %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_quarter %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.epoch_year %} r1.epoch {% endcondition %}
              AND {% condition v_raw_impression.keydate_date %} r1.keydate {% endcondition %}
              AND {% condition v_raw_impression.keydate_month %} r1.keydate {% endcondition %}
              AND {% condition v_raw_impression.keydate_quarter %} r1.keydate {% endcondition %}
              AND {% condition v_raw_impression.keydate_week %} r1.keydate {% endcondition %}
              AND {% condition v_raw_impression.keydate_year %} r1.keydate {% endcondition %}
              AND {% condition v_raw_impression.local_demand_date_date %} r1.local_demand_date {% endcondition %}
              AND {% condition v_raw_impression.local_demand_date_month %} r1.local_demand_date {% endcondition %}
              AND {% condition v_raw_impression.local_demand_date_year %} r1.local_demand_date {% endcondition %}
              AND {% condition v_raw_impression.local_supply_date_date %} r1.local_supply_date {% endcondition %}
              AND {% condition v_raw_impression.local_supply_date_month %} r1.local_supply_date {% endcondition %}
              AND {% condition v_raw_impression.local_supply_date_year %} r1.local_supply_date {% endcondition %}
              AND {% condition v_raw_impression.region_date_date %} r1.region_date {% endcondition %}
              AND {% condition v_raw_impression.region_date_month %} r1.region_date {% endcondition %}
              AND {% condition v_raw_impression.region_date_year %} r1.region_date {% endcondition %}
              AND {% condition v_raw_impression.supply_date_date %} r1.supply_date {% endcondition %}
              AND {% condition v_raw_impression.supply_date_month %} r1.supply_date {% endcondition %}
              AND {% condition v_raw_impression.supply_date_year %} r1.supply_date {% endcondition %}

      {% if v_raw_impression.dst_keydate_date._is_filtered %}
      AND r1.keydate >= TIMESTAMPADD('day', -1, {% date_start v_raw_impression.dst_keydate_date %}) AND
      r1.keydate < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_keydate_date %})
      {% endif %}
      {% if v_raw_impression.dst_keydate_week._is_filtered %}
      AND r1.keydate >= TIMESTAMPADD('day', -1, {% date_start v_raw_impression.dst_keydate_week %}) AND
      r1.keydate < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_keydate_week %})
      {% endif %}
      {% if v_raw_impression.dst_keydate_month._is_filtered %}
      AND r1.keydate >= TIMESTAMPADD('day', -1, {% date_start v_raw_impression.dst_keydate_month %}) AND
      r1.keydate < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_keydate_month %})
      {% endif %}
      {% if v_raw_impression.dst_keydate_quarter._is_filtered %}
      AND r1.keydate >= TIMESTAMPADD('day', -1, {% date_start v_raw_impression.dst_keydate_quarter %}) AND
      r1.keydate < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_keydate_quarter %})
      {% endif %}
      {% if v_raw_impression.dst_keydate_year._is_filtered %}
      AND r.keydate >= TIMESTAMPADD('day', -1, {% date_start v_raw_impression.dst_keydate_year %}) AND
      r1.keydate < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_keydate_year %})
      {% endif %}

      {% if v_raw_impression.dst_epoch_raw_date._is_filtered %}
      AND r1.epoch::timestamp_ntz >= TIMESTAMPADD('day', -2, TO_TIMESTAMP({% date_start v_raw_impression.dst_epoch_raw_date %})) AND
      r1.epoch::timestamp_ntz < TIMESTAMPADD('day', 1, TO_TIMESTAMP({% date_end v_raw_impression.dst_epoch_raw_date %}))
      {% endif %}
      {% if v_raw_impression.dst_eventtime_date._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_date %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_date %})
      {% endif %}
      {% if v_raw_impression.dst_eventtime_time._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_time %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_time %})
      {% endif %}
      {% if v_raw_impression.dst_eventtime_week._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_week %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_week %})
      {% endif %}
      {% if v_raw_impression.dst_eventtime_month._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_month %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_month %})
      {% endif %}
      {% if v_raw_impression.dst_eventtime_quarter._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_quarter %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_quarter %})
      {% endif %}
      {% if v_raw_impression.dst_eventtime_year._is_filtered %}
      AND r1.eventtime >= TIMESTAMPADD('day', -2, {% date_start v_raw_impression.dst_eventtime_year %}) AND
      r1.eventtime < TIMESTAMPADD('day', 1, {% date_end v_raw_impression.dst_eventtime_year %})
      {% endif %}
      GROUP BY r1.pk_id
      ) as cfcv
      ;;
  }

  dimension: pk_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pk_id ;;
  }

  dimension: max_exposures {
    label: "Campaign Level Frequency Cap"
    view_label: "Campaign"
    type: number
    sql: ${TABLE}.max_exposures ;;
  }

  dimension: exposure_minutes{
    label: "Campaign Level Frequency Cap Period (in minutes)"
    view_label: "Campaign"
    type: number
    sql: ${TABLE}.exposure_minutes ;;
  }

  dimension: is_violation {
    type: number
    hidden: yes
    sql: ${TABLE}.is_violation ;;
  }

  measure: sum_of_violations {
    type: sum
    label: "Campaign Level Frequency Cap Violations"
    view_label: "Campaign"
    sql: ${is_violation} ;;
  }

  measure: pct_of_violations {
    label: "% of Campaign Level Frequency Cap Violations"
    type: number
    value_format_name: percent_4
    view_label: "Campaign"
    sql: ${sum_of_violations} / ${v_raw_impression.sum_impressions} ;;
  }
}
