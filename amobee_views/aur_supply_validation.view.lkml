view: aur_supply_validation {

  label: "Aurora Supply Validation"

  sql_table_name: (
    SELECT
        'supply.daily_placement_core_stats' AS table_name
      , CONCAT('Daily_Load_KSupply_Placement_Core_Stats_', DATE_FORMAT(grouped.supply_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            supply_date
          , placement_id
          , SUM(impressions) AS impressions
        FROM supply.daily_placement_core_stats
        WHERE {% condition supply_date %} supply_date {% endcondition %}
        GROUP BY
            supply_date
          , placement_id
      ) t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'supply'
        AND lt.table_name = 'daily_placement_core_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date

    UNION ALL

    SELECT
        'supply.daily_placement_domain_stats' AS table_name
      , CONCAT('Daily_Load_KSupply_Placement_Domain_Stats_', DATE_FORMAT(grouped.supply_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            supply_date
          , placement_id
          , SUM(impressions) AS impressions
        FROM supply.daily_placement_domain_stats
        WHERE {% condition supply_date %} supply_date {% endcondition %}
        GROUP BY
            supply_date
          , placement_id
      ) t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'supply'
        AND lt.table_name = 'daily_placement_domain_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date

    UNION ALL

    SELECT
        'supply.daily_supply_core_stats' AS table_name
      , CONCAT('Daily_Load_KSupply_Core_Stats_', DATE_FORMAT(grouped.supply_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            supply_date
          , placement_id
          , SUM(impressions) AS impressions
        FROM supply.daily_supply_core_stats
        WHERE {% condition supply_date %} supply_date {% endcondition %}
        GROUP BY
            supply_date
          , placement_id
      ) t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'supply'
        AND lt.table_name = 'daily_supply_core_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date

    UNION ALL

    SELECT
        'supply.daily_placement_pdata_stats' AS table_name
      , CONCAT('daily_load_ksupply_pdata_stats_', DATE_FORMAT(grouped.supply_date, '%Y%m%d_'), grouped.timezone_id) AS job_execution_unique_id
      , grouped.supply_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.supply_date
        , pd.placement_timezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM (
        SELECT
            supply_date
          , placement_id
          , SUM(impressions) AS impressions
        FROM supply.daily_placement_pdata_stats
        WHERE {% condition supply_date %} supply_date {% endcondition %}
        GROUP BY
            supply_date
          , placement_id
      ) t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'supply'
        AND lt.table_name = 'daily_placement_pdata_stats'
        AND grouped.timezone_id = lt.start_timezone
        AND grouped.supply_date <= lt.load_through_date
    ) ;;

  dimension: supply_date {
    type: date
    label: "Supply Date"
    description: "Be carefull not to set filter to more than several days!"
    sql: ${TABLE}.supply_date ;;
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
