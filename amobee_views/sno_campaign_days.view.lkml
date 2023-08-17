view: campaign_days {
  label: "Campaign"
  derived_table: {
    sql_trigger_value: select hour(dateadd(m, 5, current_time())) ;;
    sql:
      SELECT
        fd.CAMPAIGN_ID,
        COUNT(DISTINCT td.TIME) / 24 AS CAMPAIGN_TOTAL_DAYS,
        COUNT(DISTINCT CASE WHEN td.TIME >= DATEADD('DAY', 1, lt.LOAD_THROUGH_DATE) THEN td.TIME END) / 24 AS CAMPAIGN_REMAINING_DAYS
      FROM
        DIM.FLIGHT_MEDIA_DETAILS_BASE fmd
          JOIN DIM.FLIGHT_DETAILS fd
            ON fd.flight_id = fmd.flight_id
         JOIN DIM.LOAD_TRACKING lt
            ON lt.SCHEMA_NAME = 'rawdb' AND
               lt.TABLE_NAME = 'daily_analytics'
          JOIN
          (
            SELECT
              DATEADD('HOUR', ROW_NUMBER() OVER (ORDER BY cd.CAMPAIGN_ID) - 1, (SELECT DATE_TRUNC('HOUR', MIN(fd2.BEGIN_DATETIME_LOCAL)) FROM DIM.FLIGHT_DETAILS fd2 WHERE fd2.FLIGHT_ACTIVE = 1)) AS TIME
            FROM
              DIM.CAMPAIGN_DETAILS_BASE cd
            ORDER BY
              TIME
            LIMIT
              150000 -- Snowflake does not allow to specify limit as a query, 150000 should be enough
          ) td
            ON td.TIME >= DATE_TRUNC('HOUR', fd.BEGIN_DATETIME_LOCAL) AND
               td.TIME < fd.END_DATETIME_LOCAL
      WHERE
        fd.BEGIN_DATETIME_LOCAL < fd.END_DATETIME_LOCAL AND
        fd.FLIGHT_ACTIVE = 1
      GROUP BY
        fd.CAMPAIGN_ID ;;
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
