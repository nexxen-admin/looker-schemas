view: sno_demand_raw_impression_validation {

  label: "Demand Raw Impression Validation"

  sql_table_name: (
    SELECT
        grouped.demand_date
      , grouped.timezone_id
      , grouped.impressions
    FROM (
      SELECT
          t.demand_date
        , fmd.starttimezone_id AS timezone_id
        , SUM(t.impressions) AS impressions
      FROM rawdb.raw_impression t
      JOIN dim.flight_media_details fmd
        ON t.flight_media_id = fmd.flight_media_id
      WHERE {% condition demand_date %} demand_date {% endcondition %}
      GROUP BY
          t.demand_date
        , fmd.starttimezone_id
    ) grouped
    JOIN dim.load_tracking lt
      ON lt.schema_name = 'rawdb'
        AND lt.table_name = 'raw_impression'
        AND grouped.demand_date <= lt.load_through_date
  );;

  dimension: demand_date {
    type: date
    label: "Demand Date"
    description: "Be carefull not to set filter to more than several days!"
    sql: ${TABLE}.demand_date ;;
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
