view: campaign_pacing_by_day {
  derived_table: {
    sql:
      WITH _DATE_DIM AS (
        SELECT
          TIMESTAMPADD('DAY', ROW_NUMBER() OVER (ORDER BY cd.CAMPAIGN_ID) - 1, (SELECT DATE_TRUNC('DAY', MIN(fd.BEGIN_DATETIME_LOCAL)) FROM DIM.FLIGHT_DETAILS_VIEW fd WHERE fd.FLIGHT_ACTIVE = 1)) AS DATE
        FROM
          DIM.CAMPAIGN_DETAILS_BASE_VIEW cd
        ORDER BY
          DATE
        LIMIT
          10000 -- Snowflake does not allow to specify limit as a query, 10000 should be enough
      ), _FLIGHT_STATS AS (
        SELECT
          t.CAMPAIGN_ID,
          t.FLIGHT_ID,
          t.DATE,
          t.CPU_TYPE_ID,
          t.ELAPSED_TIME / t.TOTAL_TIME * t.TARGET_GROSS_SPEND AS EXPECTED_GROSS_SPEND,
          t.ELAPSED_TIME / t.TOTAL_TIME * t.TARGET_UNITS AS EXPECTED_UNITS
        FROM
        (
          SELECT
            fd.CAMPAIGN_ID,
            fd.FLIGHT_ID,
            dd.DATE,
            MAX(cd.CPU_TYPE_ID) AS CPU_TYPE_ID,
            CAST(DATEDIFF('SECOND', MIN(fd.BEGIN_DATETIME_LOCAL), MAX(fd.END_DATETIME_LOCAL)) AS FLOAT) AS TOTAL_TIME,
            CAST(DATEDIFF('SECOND', GREATEST(MIN(fd.BEGIN_DATETIME_LOCAL), dd.DATE), LEAST(MAX(fd.END_DATETIME_LOCAL), TIMESTAMPADD('DAY', 1, dd.DATE))) AS FLOAT) AS ELAPSED_TIME,
            CAST(MAX(b.BUDGET) * (1 + MAX(fmd.AGENCY_FEE)) AS FLOAT) AS TARGET_GROSS_SPEND,
            CAST(MAX(b.UNITS) AS FLOAT) AS TARGET_UNITS
          FROM
            DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW fmd
              JOIN DIM.FLIGHT_DETAILS_VIEW fd
                ON fd.FLIGHT_ID = fmd.FLIGHT_ID
              JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW cd
                ON fd.CAMPAIGN_ID = cd.CAMPAIGN_ID
              JOIN RAWDB.LOAD_TRACKING lt
                ON fmd.STARTTIMEZONE_ID = lt.START_TIMEZONE AND
                   lt.SCHEMA_NAME = 'DEMAND_MART' AND
                   lt.TABLE_NAME = 'DAILY_CORE_STATS'
              JOIN DIM.DEMAND_UNITS_BUDGET_VIEW b
                ON fmd.FLIGHT_ID = b.FLIGHT_ID AND
                   b.FLIGHT_MEDIA_ID IS NULL
              JOIN _DATE_DIM dd
                ON dd.DATE >= DATE_TRUNC('DAY', fd.BEGIN_DATETIME_LOCAL) AND
                   dd.DATE < fd.END_DATETIME_LOCAL
          WHERE
            fd.BEGIN_DATETIME_LOCAL < fd.END_DATETIME_LOCAL AND
            fd.FLIGHT_ACTIVE = 1 AND
            {% condition campaign_details_base.campaign_id %} cd.CAMPAIGN_ID {% endcondition %}
          GROUP BY
            fd.CAMPAIGN_ID,
            fd.FLIGHT_ID,
            dd.DATE
          HAVING
            dd.DATE <= MAX(lt.LOAD_THROUGH_DATE)
        ) AS t
      ), _FLIGHT_DELIVERY_STATS AS (
        SELECT
          fmd.FLIGHT_ID,
          s.DEMAND_DATE,
          CAST(SUM(s.DEMAND_REVENUE) * (1 + MAX(fmd.AGENCY_FEE)) AS FLOAT) AS GROSS_SPEND,
          CAST(SUM(s.BILLABLE_UNITS) AS FLOAT) AS BILLABLE_UNITS
        FROM
          DEMAND_MART.DAILY_CORE_STATS s
            JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW fmd
              ON s.FLIGHT_MEDIA_ID = fmd.FLIGHT_MEDIA_ID
        WHERE
          {% condition campaign_details_base.campaign_id %} fmd.CAMPAIGN_ID {% endcondition %}
        GROUP BY
          fmd.FLIGHT_ID,
          s.DEMAND_DATE
      )
      SELECT
        fs.CAMPAIGN_ID,
        fs.DATE AS PACING_DEMAND_DATE,
        CASE
          WHEN MAX(fs.CPU_TYPE_ID) IN (4, 5) THEN
            COALESCE(SUM(SUM(fds.GROSS_SPEND)) OVER (PARTITION BY fs.CAMPAIGN_ID ORDER BY fs.DATE) / NULLIF(SUM(SUM(fs.EXPECTED_GROSS_SPEND)) OVER (PARTITION BY fs.CAMPAIGN_ID ORDER BY fs.DATE), 0), 0)
          ELSE
            COALESCE(SUM(SUM(fds.BILLABLE_UNITS)) OVER (PARTITION BY fs.CAMPAIGN_ID ORDER BY fs.DATE) / NULLIF(SUM(SUM(fs.EXPECTED_UNITS)) OVER (PARTITION BY fs.CAMPAIGN_ID ORDER BY fs.DATE), 0), 0)
        END AS PACING
      FROM
        _FLIGHT_STATS fs
          LEFT JOIN _FLIGHT_DELIVERY_STATS fds
            ON fs.FLIGHT_ID = fds.FLIGHT_ID AND
               fs.DATE = fds.DEMAND_DATE
      GROUP BY
        fs.CAMPAIGN_ID,
        fs.DATE ;;
  }

  dimension: campaign_id  {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: demand_date  {
    type: date_raw
    hidden: yes
    sql: ${TABLE}.PACING_DEMAND_DATE ;;
  }

  measure: pacing  {
    type: max
    description: "Historical Campaign Pacing (intended to be used at Campaign ID and Demand Date level)."
    label: "Campaign Pacing by Day"
    value_format_name: percent_2
    sql: ${TABLE}.PACING ;;
  }
}
