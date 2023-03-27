view: aur_demand_core_stats_validation {

  label: "Aurora Demand Core Stats Validation"

  sql_table_name: (
    SELECT
        grouped.demand_date
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
        WHERE {% condition aur_demand_validation.demand_date %} demand_date {% endcondition %}
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
  );;

  dimension: demand_date {
    type: date
    label: "Demand Date"
    sql: ${TABLE}.demand_date ;;
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
