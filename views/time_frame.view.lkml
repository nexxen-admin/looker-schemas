view: time_frame {
  derived_table: {
    sql: Select
        CASE WHEN d.date_key >= current_date()-28 and d.date_key < current_date()-21 THEN '4 Weeks Ago'
                 WHEN d.date_key >= current_date()-14 and d.date_key < current_date()-7 THEN '2 Weeks Ago'
                 WHEN d.date_key >= current_date()-7 and d.date_key < current_date() THEN 'Last Week'
                 ELSE 'Other' END as TIME_FRAME
      From bi_new.fact_ad_daily_agg d
      where (d.date_key >= current_date()-28 and d.date_key < current_date()-21)
                  or (d.date_key >= current_date()-14 and d.date_key < current_date()-7)
                  or (d.date_key >= current_date()-7 and d.date_key < current_date())

      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: time_frame {
    type: string
    sql: ${TABLE}.TIME_FRAME ;;
  }

  set: detail {
    fields: [time_frame]
  }
}
