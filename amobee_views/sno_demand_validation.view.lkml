view: sno_demand_validation {

  label: "Snowflake Demand Validation"

  sql_table_name: (
    SELECT
        'demand_mart.daily_core_stats' AS table_name
      , CONCAT('daily_load_demand_core_stats_', TO_VARCHAR(grouped.demand_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , fmd.starttimezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM demand_mart.daily_core_stats t
      JOIN dim.flight_media_details fmd
        ON t.flight_media_id = fmd.flight_media_id
      WHERE {% condition sno_demand_raw_impression_validation.demand_date %} demand_date {% endcondition %}
      GROUP BY
          t.demand_date
        , fmd.starttimezone_id
    ) grouped
    JOIN demand_mart.load_tracking lt
      ON lt.schema_name = 'demand_mart'
        AND lt.table_name = 'daily_core_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand_mart.daily_domain_stats' AS table_name
      , CONCAT('daily_load_demand_domain_stats_', TO_VARCHAR(grouped.demand_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , fmd.starttimezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM demand_mart.daily_domain_stats t
      JOIN dim.flight_media_details fmd
        ON t.flight_media_id = fmd.flight_media_id
      WHERE {% condition sno_demand_raw_impression_validation.demand_date %} demand_date {% endcondition %}
      GROUP BY
          t.demand_date
        , fmd.starttimezone_id
    ) grouped
    JOIN demand_mart.load_tracking lt
      ON lt.schema_name = 'demand_mart'
        AND lt.table_name = 'daily_domain_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand_mart.daily_daypart_stats' AS table_name
      , CONCAT('daily_load_demand_daypart_stats_', TO_VARCHAR(grouped.demand_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , fmd.starttimezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM demand_mart.daily_daypart_stats t
      JOIN dim.flight_media_details fmd
        ON t.flight_media_id = fmd.flight_media_id
      WHERE {% condition sno_demand_raw_impression_validation.demand_date %} demand_date {% endcondition %}
      GROUP BY
          t.demand_date
        , fmd.starttimezone_id
    ) grouped
    JOIN demand_mart.load_tracking lt
      ON lt.schema_name = 'demand_mart'
        AND lt.table_name = 'daily_daypart_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand_mart.daily_geo_stats' AS table_name
      , CONCAT('daily_load_demand_geo_stats_', TO_VARCHAR(grouped.demand_date, 'YYYYMMDD_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , fmd.starttimezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM demand_mart.daily_geo_stats t
      JOIN dim.flight_media_details fmd
        ON t.flight_media_id = fmd.flight_media_id
      WHERE {% condition sno_demand_raw_impression_validation.demand_date %} demand_date {% endcondition %}
      GROUP BY
          t.demand_date
        , fmd.starttimezone_id
    ) grouped
    JOIN demand_mart.load_tracking lt
      ON lt.schema_name = 'demand_mart'
        AND lt.table_name = 'daily_geo_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date
  ) ;;

    dimension: demand_date {
      type: date
      label: "Demand Date"
      sql: ${TABLE}.demand_date ;;
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
