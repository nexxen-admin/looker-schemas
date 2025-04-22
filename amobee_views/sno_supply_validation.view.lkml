view: sno_supply_validation {

  label: "Snowflake Supply Validation"

  sql_table_name: (
    SELECT
        'supply_mart.daily_placement_core_stats' AS table_name
      , CONCAT('daily_load_supply_placement_core_stats_', TO_VARCHAR(grouped.supply_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM supply_mart.daily_placement_core_stats t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      WHERE {% condition sno_supply_raw_impression_validation.supply_date %} supply_date {% endcondition %}
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN supply_mart.load_tracking lt
      ON lt.schema_name = 'supply_mart'
        AND lt.table_name = 'daily_placement_core_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date

    UNION ALL

    SELECT
        'supply_mart.daily_placement_domain_stats' AS table_name
      , CONCAT('daily_load_supply_placement_domain_stats_', TO_VARCHAR(grouped.supply_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM supply_mart.daily_placement_domain_stats t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      WHERE {% condition sno_supply_raw_impression_validation.supply_date %} supply_date {% endcondition %}
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN supply_mart.load_tracking lt
      ON lt.schema_name = 'supply_mart'
        AND lt.table_name = 'daily_placement_domain_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date

    UNION ALL

    SELECT
        'supply.hourly_core_metrics' AS table_name
      , CONCAT('hourly_load_supply_core_metrics_', TO_VARCHAR(grouped.supply_date, 'YYYYMMDD..')) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          TO_DATE(t.supply_date) AS supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM supply.hourly_core_metrics t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      WHERE {% condition sno_supply_raw_impression_validation.supply_date %} supply_date {% endcondition %}
      GROUP BY
          TO_DATE(t.supply_date)
        , pd.placement_timezone_id
    ) grouped
    JOIN supply.load_tracking lt
      ON lt.schema_name = 'supply'
        AND lt.table_name = 'hourly_core_metrics'
        AND grouped.supply_date <= TO_DATE(DATEADD(DAY, -1, lt.load_through_date))

    UNION ALL

    SELECT
        'rawdb.hourly_analytics' AS table_name
      , CONCAT('hourly_load_rawdb_hourly_analytics_', TO_VARCHAR(grouped.supply_date, 'YYYYMMDD..')) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          TO_DATE(t.supply_date) AS supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM rawdb.hourly_analytics t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      WHERE {% condition sno_supply_raw_impression_validation.supply_date %} supply_date {% endcondition %}
      GROUP BY
          TO_DATE(t.supply_date)
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'rawdb'
        AND lt.table_name = 'hourly_analytics'
        AND grouped.supply_date <= TO_DATE(DATEADD(DAY, -1, lt.load_through_date))
  );;

  dimension: supply_date {
    type: date
    label: "Supply Date"
    sql: ${TABLE}.supply_date ;;
  }

  dimension: timezone_id {
    type: number
    sql: ${TABLE}.timezone_id ;;
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: job_execution_unique_id {
    type: string
    sql: ${TABLE}.job_execution_unique_id ;;
  }

}
