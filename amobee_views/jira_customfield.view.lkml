view: jira_customfield{
  derived_table: {
    sql:
         SELECT
         sum(CASE
              WHEN (CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC'))::date = gs.date_calender
                  and extract(EPOCH FROM (CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC')))- extract(EPOCH FROM DATE(CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC'))) <  ("START_HOUR" * 3600 + "START_MINUTE" * 60)
                    THEN  ("START_HOUR" * 3600 + "START_MINUTE" * 60)
              WHEN  DATE(nwd."FORMATTED_DATE") = gs.date_calender THEN 0
              WHEN (CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC'))::date = gs.date_calender
                    THEN least(extract(EPOCH FROM (CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC')))- extract(EPOCH FROM DATE(CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC'))), (coalesce(bh."END_HOUR",24)* 3600 + bh."END_MINUTE" * 60) )
              WHEN   tc."ZONE_ID" is null THEN 86400
            ELSE (coalesce(bh."END_HOUR",24)* 3600 + bh."END_MINUTE" * 60)
            END - CASE
                    WHEN  DATE(nwd."FORMATTED_DATE") = gs.date_calender THEN 0
                    WHEN (("START_TIME" at time zone 'UTC+7') at time zone coalesce(tc."ZONE_ID" ,'UTC'))::date = gs.date_calender
                          THEN  greatest((extract(EPOCH FROM ("START_TIME" at time zone 'UTC+7') at time zone coalesce(tc."ZONE_ID" ,'UTC')))- extract(EPOCH FROM DATE(("START_TIME" at time zone 'UTC+7') at time zone coalesce(tc."ZONE_ID" ,'UTC'))),  ("START_HOUR" * 3600  + "START_MINUTE" * 60))
                  WHEN   tc."ZONE_ID" is null THEN 0
                  ELSE  ("START_HOUR" * 3600 + "START_MINUTE" * 60)
            END) over(PARTITION BY "ISSUE_ID", "SLA_ID" ) AS work_time,
      iss."START_TIME",
      iss."END_TIME",
      iss."SLA_ID",
      iss."ISSUE_ID",
      iss."CYCLE_START_TIME",
      iss."DEADLINE",
      iss."BREACHED",
      iss."ELAPSED_DURATION_MILLIS",
      iss."REMAINING_DURATION_MILLIS",
      iss."PAUSED_DURATION_MILLIS",
      iss."SLA_DURATION_MILLIS",
      iss."STATE",
      iss."OVERDUE_DURATION_MILLIS",
      tc."NAME"
    FROM
      public."AO_C5D949_ISSUE_SLA" iss
    LEFT JOIN public."AO_C5D949_SLA_GOAL" sg ON iss."GOAL_ID" = sg."ID"
    LEFT JOIN public."AO_C5D949_TTS_CALENDAR" tc ON sg."CALENDAR_ID"= tc."ID"
    LEFT JOIN (
                SELECT  to_char(gs, 'DAY') AS "DAY",
                        date_trunc('day', gs):: date AS date_calender
                FROM generate_series (
                                        (
                                          SELECT min("START_TIME")   FROM public."AO_C5D949_ISSUE_SLA"
                                        ),
                                        CURRENT_TIMESTAMP + interval '1 day', '1 day'::interval
                                      ) AS gs
              ) AS gs on (gs."date_calender") between ("START_TIME" at time zone 'UTC+7')::date AND (CURRENT_TIMESTAMP::timestamptz at time zone coalesce(tc."ZONE_ID" ,'UTC'))::date
   LEFT JOIN public."AO_C5D949_TTS_BUSINESS_HOUR" bh ON trim(gs."DAY") = trim(bh."WORKING_DAY") AND bh."CALENDAR_ID" = sg."CALENDAR_ID"
   LEFT JOIN public."AO_C5D949_TTS_NON_WORKING_DATE" nwd ON nwd."CALENDAR_ID" =sg."CALENDAR_ID" AND DATE(nwd."FORMATTED_DATE") = DATE(gs.date_calender)
   WHERE 1=1
   {% if jira_customfieldvalue_apssd_bell_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_bell_resolution_sla._in_query
    or jira_customfieldvalue_apssd_default_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_default_resolution_sla._in_query
    or jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}

    AND (

    {% if jira_customfieldvalue_apssd_bell_acknowledge_sla._in_query %} iss."SLA_ID" = 3
    {% if jira_customfieldvalue_apssd_bell_resolution_sla._in_query
    or jira_customfieldvalue_apssd_default_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_default_resolution_sla._in_query
    or jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
       OR
    {% endif %}
    {% endif %}

    {% if jira_customfieldvalue_apssd_bell_resolution_sla._in_query %}  iss."SLA_ID" = 4
    {% if jira_customfieldvalue_apssd_default_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_default_resolution_sla._in_query
    or jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}

    {% if jira_customfieldvalue_apssd_default_acknowledge_sla._in_query %} iss."SLA_ID" = 64
    {% if jira_customfieldvalue_apssd_default_resolution_sla._in_query
    or jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_default_resolution_sla._in_query %} iss."SLA_ID" = 65
    {% if jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_disney_acknowledge_sla._in_query %} iss."SLA_ID" = 66
    {% if jira_customfieldvalue_apssd_disney_resolution_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_disney_resolution_sla._in_query %} iss."SLA_ID" = 67
    {% if  jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query
    or jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_mediacorp_acknowledge_sla._in_query %} iss."SLA_ID" = 68
    {% if jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query
    or jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_mediacorp_resolution_sla._in_query %} iss."SLA_ID" = 69
    {% if jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query
    or customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_customfieldvalue_apssd_yahoo_resolution_sla._in_query %} iss."SLA_ID" = 70
    {% if customfieldvalue_itv_resolution_v2_benchmark._in_query
    or customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if customfieldvalue_itv_resolution_v2_benchmark._in_query %} iss."SLA_ID" = 14
    {% if customfieldvalue_itv_time_to_acknowledge_sla._in_query
    or jira_tts_itv_resolution_sla._in_query
    %}
     OR
    {% endif %}
    {% endif %}
    {% if customfieldvalue_itv_time_to_acknowledge_sla._in_query %} iss."SLA_ID" = 15
    {% if jira_tts_itv_resolution_sla._in_query %}
     OR
    {% endif %}
    {% endif %}
    {% if jira_tts_itv_resolution_sla._in_query %} iss."SLA_ID" = 71 {% endif %}
      )
    {% endif %}
    ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}."ISSUE_ID" ;;
  }

  dimension: sla_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SLA_ID" ;;
  }

  dimension: succeeded {
    type: yesno
    label: "Succeeded"
    sql:
      CASE
          WHEN ${TABLE}."STATE" <> 'RUNNING' and ${TABLE}."BREACHED"= true THEN false
          WHEN ${TABLE}."STATE" <> 'RUNNING' and ${TABLE}."BREACHED"= false THEN true
          WHEN ${TABLE}."STATE" = 'RUNNING' and  CURRENT_TIMESTAMP at time zone 'UTC' > ( ${TABLE}."DEADLINE" + interval '3 hour') at time zone 'UTC' THEN false
      ELSE true
      END ;;
  }

  dimension: state {
    type: string
    label: "State"
    sql: ${TABLE}."STATE" ;;

  }

  dimension: goal_time {
    type: string
    label: "Goal Time"
    sql: (to_timestamp((${TABLE}."SLA_DURATION_MILLIS")::float / 1000) at time zone 'UTC' - '1970-01-01') ;;
  }

  dimension: pause_time {
    type: string
    label: "Pause Time"
    sql: (to_timestamp((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000) at time zone 'UTC' - '1970-01-01') ;;
  }

  dimension: pause_time_sec {
    type: number
    label: "Pause Time (In Seconds)"
    sql: ((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000) ;;
  }

  dimension: goal_time_sec {
    type: number
    label: "Goal Time (In Seconds)"
    sql: ((${TABLE}."SLA_DURATION_MILLIS")::float / 1000) ;;
  }

  dimension: remaining_time_sec {
    type: number
    label: "Remaining Time (In Seconds)"
    description: "This field is calculated on Looker side and is not guaranteed to match what you see in Jira perfectly."
    sql:
      CASE
          WHEN ${TABLE}."STATE" = 'RUNNING'
                THEN (((${TABLE}."SLA_DURATION_MILLIS")::float / 1000) - (${TABLE}.work_time - ((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000)))
      ELSE ((${TABLE}."REMAINING_DURATION_MILLIS")::float / 1000)
      END ;;
  }

  dimension: remaining_time {
    type: string
    label: "Remaining Time"
    description: "This field is calculated on Looker side and is not guaranteed to match what you see in Jira perfectly."
    sql:
      CASE
          WHEN ${TABLE}."STATE" = 'RUNNING'
                THEN (to_timestamp(((${TABLE}."SLA_DURATION_MILLIS")::float / 1000)- (${TABLE}.work_time - ((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000) ))  at time zone 'UTC' - '1970-01-01')
      ELSE (to_timestamp((${TABLE}."REMAINING_DURATION_MILLIS")::float / 1000) at time zone 'UTC' - '1970-01-01')
      END ;;
  }

  dimension: elapsed_time_sec {
    type: number
    label: "Elapsed Time (In Seconds)"
    description: "This field is calculated on Looker side and is not guaranteed to match what you see in Jira perfectly."
    sql:
      CASE
        WHEN ${TABLE}."STATE" = 'RUNNING' THEN  (${TABLE}.work_time - ((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000)  )
      ELSE ((${TABLE}."ELAPSED_DURATION_MILLIS")::float / 1000)
      END ;;
  }

  dimension: elapsed_time {
    type: string
    label: "Elapsed Time"
    description: "This field is calculated on Looker side and is not guaranteed to match what you see in Jira perfectly."
    sql:
      CASE
        WHEN ${TABLE}."STATE" = 'RUNNING' THEN  (to_timestamp((${TABLE}.work_time - ((${TABLE}."PAUSED_DURATION_MILLIS")::float / 1000) )) at time zone 'UTC' - '1970-01-01')
      ELSE (to_timestamp((${TABLE}."ELAPSED_DURATION_MILLIS")::float / 1000) at time zone 'UTC' - '1970-01-01')
      END ;;
  }

  dimension: calendar_name {
    type: string
    label: "Calendar Name"
    sql: ${TABLE}."NAME" ;;
  }

  dimension_group: deadline_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Deadline Time"
    sql: ${TABLE}."DEADLINE" ;;
  }

  dimension: name_sla {
    type: string
    label: "Name SLA"
    sql: CASE
           WHEN ${TABLE}."SLA_ID" = 3 THEN 'Bell Acknowledge SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 4 THEN 'Bell Resolution SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 14 THEN 'ITVSD: Resolution SLA - V2 Benchmark (TTS)'
           WHEN ${TABLE}."SLA_ID" = 15 THEN 'ITVSD: Time to Acknowledge SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 64 THEN 'Default Acknowledge SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 65 THEN 'Default Resolution SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 66 THEN 'Disney Acknowledge SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 67 THEN 'Disney Resolution SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 68 THEN 'Mediacorp Acknowledge SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 69 THEN 'Mediacorp Resolution SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 70 THEN 'Yahoo Resolution SLA (TTS)'
           WHEN ${TABLE}."SLA_ID" = 71 THEN 'ITV Resolution SLA (TTS)'
       END ;;
  }

  dimension_group: start_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Start Time"
    sql: ${TABLE}."START_TIME" ;;
  }

  dimension_group: stop_time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Stop Time"
    sql: ${TABLE}."END_TIME" ;;
  }
}
