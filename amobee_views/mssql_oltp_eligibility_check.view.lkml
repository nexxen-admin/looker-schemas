view: mssql_oltp_eligibility_check {


  derived_table: {
    sql: SELECT c.campaign_id AS CAMPAIGN_ID
  ,t2.flight_id AS FLIGHT_ID
FROM (
  SELECT t.flight_id
    ,MAX(t.date_a) AS fm_end_datetm
  FROM (
    SELECT fm.flight_id
      ,fms.flight_media_id
      ,fms.begin_datetm
      ,fms.end_datetm
      ,fms.active AS active_schedule
      ,fm.iseligible AS fm_is_eligible
      ,CASE
        WHEN fms.active = 0
          AND fm.iseligible = 1
          THEN flt.end_datetm
        WHEN fms.flight_media_id IS NULL
          AND fm.iseligible = 1
          THEN flt.end_datetm
        ELSE fms.end_datetm
        END AS date_a
    FROM AN_MAIN..flight_media (NOLOCK) fm
    LEFT JOIN AN_MAIN..flight_media_schedule (NOLOCK) fms ON fm.flight_media_id = fms.flight_media_id
    LEFT JOIN AN_MAIN..flight (NOLOCK) flt ON fm.flight_id = flt.flight_id
    WHERE fm.active = 1
      AND flt.active = 1
      AND NOT (
        fms.active = 0
        AND fm.iseligible = 0
        )
    ) t
  JOIN AN_MAIN..flight (NOLOCK) flt ON t.flight_id = flt.flight_id
  GROUP BY t.flight_id
  ) t2
JOIN AN_MAIN..flight (NOLOCK) f ON f.flight_id = t2.flight_id
JOIN AN_MAIN..campaign (NOLOCK) c ON f.campaign_id = c.campaign_id
JOIN AN_MAIN..timezone (NOLOCK) tz ON f.starttimezone_id = tz.timezone_id
WHERE c.active = 1
  AND t2.fm_end_datetm != f.end_datetm
  AND f.end_datetime_local > GETDATE()
  AND c.campaign_status_id = 1
  AND t2.fm_end_datetm <= DATEADD(day, 7, getdate())

UNION

SELECT c.campaign_id AS campaign_id
  ,t.flight_id AS flight_id
FROM (
  SELECT f.flight_id
    ,SUM(CASE
        WHEN COALESCE(fm.iseligible, 0) = 1
          THEN 1
        ELSE 0
        END) AS eligible_flight_media
  FROM AN_MAIN..flight (NOLOCK) f
  LEFT JOIN AN_MAIN..flight_media (NOLOCK) fm ON f.flight_id = fm.flight_id
    AND fm.active = 1
  WHERE f.active = 1
  GROUP BY f.flight_id
  ) t
JOIN AN_MAIN..flight (NOLOCK) f ON f.flight_id = t.flight_id
JOIN AN_MAIN..campaign (NOLOCK) c ON f.campaign_id = c.campaign_id
WHERE c.campaign_status_id = 1
  AND t.eligible_flight_media = 0
  AND f.end_datetime_local > GETDATE()
  AND f.begin_datetime_local < DATEADD(DAY, 7, GETDATE())
  AND f.flight_id NOT IN (
    SELECT DISTINCT t.flight_id
    FROM (
      SELECT c.campaign_id AS campaign_id
        ,fm.flight_id AS flight_id
        ,flt.begin_datetm AS flight_begin_date
        ,flt.end_datetm AS flight_end_date
        ,fm.flight_media_id
        ,fms.begin_datetm
        ,fms.end_datetm
        ,fm.active AS active_fm
        ,fms.active AS active_schedule
        ,fm.iseligible AS eligible_fm
      FROM AN_MAIN..flight_media(NOLOCK) fm
      LEFT JOIN AN_MAIN..flight_media_schedule(NOLOCK) fms ON fm.flight_media_id = fms.flight_media_id
      LEFT JOIN AN_MAIN..flight(NOLOCK) flt ON fm.flight_id = flt.flight_id
      LEFT JOIN AN_MAIN..campaign(NOLOCK) c ON c.campaign_id = flt.campaign_id
      WHERE flt.active = 1
        AND fm.active = 1
        AND fms.active = 1
        AND fm.iseligible = 0
        AND (GETDATE() NOT BETWEEN fms.begin_datetm
            AND fms.end_datetm)
        AND flt.begin_datetm > GETDATE()
        AND fms.end_datetm > GETDATE()
      ) t
    )
 ;;
  }

  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: flight_id {
    type: number
    hidden: yes
    label: "Flight ID"
    sql: ${TABLE}.FLIGHT_ID ;;
  }

}
