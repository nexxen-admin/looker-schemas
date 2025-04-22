view: hourly_logging_audit {

  derived_table: {
    sql:
     SELECT t1.FLIGHT_MEDIA_ID
            ,t1.KEYDATE
            ,max(t2.billable_impressions) as BILLABLE_IMPRESSIONS
FROM (
  SELECT hr.KEYDATE AS KEYDATE
    ,fmd.FLIGHT_MEDIA_ID AS FLIGHT_MEDIA_ID
  FROM dim.FLIGHT_MEDIA_DETAILS fmd
  CROSS JOIN dim.HOUR_DIMENSION hr
  WHERE (
      {% condition flight_media_details_base.flight_media_id %} fmd.flight_media_id {% endcondition %}
      AND {% condition hourly_logging_audit.keydate %} hr.keydate {% endcondition %}
      )
  GROUP BY hr.KEYDATE
         ,fmd.FLIGHT_MEDIA_ID
  ) t1
LEFT OUTER JOIN (
  SELECT ha.FLIGHT_MEDIA_ID AS FLIGHT_MEDIA_ID
    ,ha.GMT_DATE AS KEYDATE
    ,sum(ha.BILLABLE_IMPRESSIONS) AS billable_impressions
  FROM rawdb.HOURLY_ANALYTICS ha
  WHERE (
      {% condition flight_media_details_base.flight_media_id %} ha.flight_media_id {% endcondition %}
      AND ha.PLACEMENT_ID = 1221
      AND {% condition hourly_logging_audit.keydate %} ha.GMT_DATE {% endcondition %}
      )
  GROUP BY ha.FLIGHT_MEDIA_ID
          ,ha.GMT_DATE
  ) t2 ON (t1.FLIGHT_MEDIA_ID = t2.FLIGHT_MEDIA_ID AND t1.KEYDATE = t2.KEYDATE)
JOIN dim.FLIGHT_MEDIA_DETAILS fmd2 ON (t1.FLIGHT_MEDIA_ID = fmd2.FLIGHT_MEDIA_ID)
WHERE (
    {% condition flight_media_details_base.flight_media_id %} t1.flight_media_id {% endcondition %}
      AND {% condition hourly_logging_audit.keydate %} t1.KEYDATE {% endcondition %}
    )
GROUP BY t1.FLIGHT_MEDIA_ID
        ,t1.KEYDATE ;;
  }

  dimension: flight_media_id {
    hidden: yes
    type: number
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: keydate {
    #hidden: yes
    type: date_time
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: billable_impressions {
    #hidden: yes
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

}
