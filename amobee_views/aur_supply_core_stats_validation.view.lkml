view: aur_supply_core_stats_validation {

  label: "Aurora Supply Core Stats Validation"

  sql_table_name: (
    SELECT
        grouped.supply_date
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
        WHERE {% condition aur_supply_validation.supply_date %} supply_date {% endcondition %}
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
  );;

  dimension: supply_date {
    type: date
    label: "Supply Date"
    sql: ${TABLE}.supply_date ;;
  }

  dimension: timezone_id {
    type: number
    sql: ${TABLE}.timezone_id ;;
    value_format_name: id
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

}
