view: aur_demand_validation {

  label: "Aurora Demand Validation"

  sql_table_name: (
    SELECT
        'demand.daily_geo_stats' AS table_name
      , CONCAT('Daily_Load_KDemand_Geo_Stats_', DATE_FORMAT(grouped.demand_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , cd.timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            demand_date
          , campaign_id
          , SUM(impressions) AS impressions
        FROM demand.daily_geo_stats
        WHERE {% condition demand_date %} demand_date {% endcondition %}
        GROUP BY
            demand_date
          , campaign_id
      ) t
      JOIN dim.campaign_details cd
        ON t.campaign_id = cd.campaign_id
      GROUP BY
          t.demand_date
        , cd.timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'demand'
        AND lt.table_name = 'daily_geo_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand.daily_core_stats' AS table_name
      , CONCAT('Daily_Load_KDemand_Core_Stats_', DATE_FORMAT(grouped.demand_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , cd.timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            demand_date
          , campaign_id
          , SUM(impressions) AS impressions
        FROM demand.daily_core_stats
        WHERE {% condition demand_date %} demand_date {% endcondition %}
        GROUP BY
            demand_date
          , campaign_id
      ) t
      JOIN dim.campaign_details cd
        ON t.campaign_id = cd.campaign_id
      GROUP BY
          t.demand_date
        , cd.timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'demand'
        AND lt.table_name = 'daily_core_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand.daily_daypart_stats' AS table_name
      , CONCAT('Daily_Load_KDemand_Daypart_Stats_', DATE_FORMAT(grouped.demand_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , cd.timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            demand_date
          , campaign_id
          , SUM(impressions) AS impressions
        FROM demand.daily_daypart_stats
        WHERE {% condition demand_date %} demand_date {% endcondition %}
        GROUP BY
            demand_date
          , campaign_id
      ) t
      JOIN dim.campaign_details cd
        ON t.campaign_id = cd.campaign_id
      GROUP BY
          t.demand_date
        , cd.timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'demand'
        AND lt.table_name = 'daily_daypart_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date

    UNION ALL

    SELECT
        'demand.daily_domain_stats' AS table_name
      , CONCAT('Daily_Load_KDemand_Domain_Stats_', DATE_FORMAT(grouped.demand_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , cd.timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            demand_date
          , campaign_id
          , SUM(impressions) AS impressions
        FROM demand.daily_domain_stats
        WHERE {% condition demand_date %} demand_date {% endcondition %}
        GROUP BY
            demand_date
          , campaign_id
      ) t
      JOIN dim.campaign_details cd
        ON t.campaign_id = cd.campaign_id
      GROUP BY
          t.demand_date
        , cd.timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'demand'
        AND lt.table_name = 'daily_domain_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.demand_date <= lt.load_through_date
  ) ;;

  dimension: demand_date {
    type: date
    label: "Demand Date"
    description: "Be carefull not to set filter to more than several days!"
    sql: ${TABLE}.demand_date ;;
  }

  dimension: timezone_id {
    type: number
    sql: ${TABLE}.timezone_id ;;
    value_format_name: id
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
