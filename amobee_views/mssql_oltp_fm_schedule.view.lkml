view: mssql_oltp_max_fm_schedule {
  label: "Flight Media Schedule"

  derived_table: {
    sql: SELECT fm.flight_id as FLIGHT_ID
         ,max(DATEADD(minute,-1,DATEADD(hour,t.utc_offset,fms.end_datetm))) as END_DATE
    FROM AN_MAIN..flight_media (NOLOCK) fm
    LEFT JOIN AN_MAIN..flight_media_schedule (NOLOCK) fms ON fm.flight_media_id = fms.flight_media_id
    LEFT JOIN AN_MAIN..flight (NOLOCK) flt ON fm.flight_id = flt.flight_id
    JOIN AN_MAIN..campaign (NOLOCK) c on c.campaign_id = flt.campaign_id
    JOIN AN_MAIN..timezone (NOLOCK) t on t.timezone_id = c.timezone_id
    WHERE fms.active = 1
  GROUP BY fm.flight_id

       ;;
  }

  dimension: flight_id {
    type: number
    hidden: yes
    label: "Flight ID"
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: max_fm_schedule_enddate {
    type: date_time
    label: "Creative Schedule End Date"
    sql: ${TABLE}.END_DATE  ;;
  }

}
