view: sno_supply_raw_impression_validation {

  label: "Supply Raw Impression Validation"

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
      FROM rawdb.raw_impression t
      JOIN dim.placement_details pd
        ON t.placement_id = pd.placement_id
      WHERE {% condition supply_date %} supply_date {% endcondition %}
      GROUP BY
          t.supply_date
        , pd.placement_timezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'rawdb'
        AND lt.table_name = 'raw_impression'
        AND grouped.supply_date <= lt.load_through_date
  );;

    dimension: supply_date {
      type: date
      label: "Supply Date"
      description: "Be carefull not to set filter to more than several days!"
      sql: ${TABLE}.supply_date ;;
    }

    dimension: timezone_id {
      type: number
      sql: ${TABLE}.timezone_id ;;
    }

    dimension: impressions {
      type: number
      sql: ${TABLE}.impressions ;;
    }

  }
