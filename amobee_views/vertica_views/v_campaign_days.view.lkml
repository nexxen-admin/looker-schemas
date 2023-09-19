view: v_campaign_days {
  label: "Campaign"
  derived_table: {
    sql_trigger_value: select EXTRACT(HOUR FROM TIMESTAMPADD (mi, 5, GETDATE())) ;;
    sql:
      SELECT
         fd.CAMPAIGN_ID,
        COUNT(DISTINCT td.KEYDATE) / 24 AS CAMPAIGN_TOTAL_DAYS,
        COUNT(DISTINCT CASE WHEN td.KEYDATE >= TIMESTAMPADD(DAY, 1, fmd.LOAD_THROUGH_DATE) THEN td.KEYDATE END) / 24 AS CAMPAIGN_REMAINING_DAYS
      FROM DIM.FLIGHT_DETAILS_VIEW fd
      JOIN (SELECT flight_id, LOAD_THROUGH_DATE
            FROM DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW f
                JOIN (select START_TIMEZONE, max(LOAD_THROUGH_DATE) as LOAD_THROUGH_DATE
                      from   RAWDB.LOAD_TRACKING
                      where SCHEMA_NAME = 'DEMAND_MART' AND
                            TABLE_NAME = 'DAILY_CORE_STATS'
                      group by START_TIMEZONE) lt
                ON f.STARTTIMEZONE_ID = lt.START_TIMEZONE) fmd
            ON fd.flight_id = fmd.flight_id
          JOIN
            (SELECT KEYDATE FROM DIM.HOUR_DIMENSION hd join (
                    SELECT DATE_TRUNC('HOUR', MIN(BEGIN_DATETIME_LOCAL)) as min_time,
                           MAX(END_DATETIME_LOCAL) as max_time
                    FROM DIM.FLIGHT_DETAILS_VIEW) lm
                ON hd.KEYDATE>=lm.min_time AND hd.KEYDATE<=lm.max_time
                )
                td
            ON td.KEYDATE >= DATE_TRUNC('HOUR', fd.BEGIN_DATETIME_LOCAL) AND
               td.KEYDATE < fd.END_DATETIME_LOCAL
      WHERE
        fd.BEGIN_DATETIME_LOCAL < fd.END_DATETIME_LOCAL AND
        fd.FLIGHT_ACTIVE = 1
      GROUP BY
        fd.CAMPAIGN_ID; ;;
  }

  dimension: campaign_id  {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: Campaign_total_days {
    type: number
    description: "The total number of days in the campaign."
    label: "Campaign Total Days"
    value_format_name: decimal_2
    sql: ${TABLE}.CAMPAIGN_TOTAL_DAYS ;;
  }

  measure: campaign_total_days  {
    type: max
    description: "The total number of days in the campaign."
    label: "Campaign Total Days"
    value_format_name: decimal_2
    sql: ${TABLE}.CAMPAIGN_TOTAL_DAYS ;;
  }

  measure: campaign_remaining_days  {
    type: max
    description: "The total number of days remaining in the campaign."
    label: "Campaign Remaining Days"
    value_format_name: decimal_2
    sql: ${TABLE}.CAMPAIGN_REMAINING_DAYS ;;
  }

  measure: campaign_elapsed_days  {
    type: number
    description: "The total number of days that have elasped since the beginning of the campaign."
    label: "Campaign Elapsed Days"
    value_format_name: decimal_2
    sql: ${campaign_total_days} - ${campaign_remaining_days}  ;;
  }
}
