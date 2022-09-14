view: tremor_to_unruly {
  derived_table: {
    sql: with aaa as(
      SELECT event_time,
      sum(impression_pixel) as exchange
      from andromeda.ad_data_hourly
      where rx_dsp_name ilike 'tremor%'
      and event_time >= CURRENT_DATE
      group by 1),

      bbb as (
      SELECT date ,sum(impressions) as tremor
      from dwh.ad_data_hourly
      WHERE ad_data_hourly.date >=current_date
      and ad_data_hourly.ssp_id in ('Unrulyx', 'RhythmOne')
      group by 1)

      SELECT
      date_trunc('day',COALESCE(event_time,date)) as date,
      hour(COALESCE(event_time,date)) as Hour,
      exchange ,
      tremor,
      (exchange  - tremor) diff
      from aaa join bbb on aaa.event_time = bbb.date
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}."date" ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}."Hour" ;;
  }

  measure: exchange {
    type: sum
    sql: ${TABLE}.exchange ;;
  }

  measure: tremor {
    type: sum
    sql: ${TABLE}.tremor ;;
  }

  measure: diff {
    type: sum
    sql: ${TABLE}.diff ;;
  }

  set: detail {
    fields: [date_time, hour, exchange, tremor, diff]
  }
}
