view: v_required_delivery_today {

  derived_table: {
    sql: SELECT d.flight_media_id AS FLIGHT_MEDIA_ID
          ,CASE
          WHEN CURRENT_DATE () > d.end_datetm
            THEN 0
          ELSE (u.units - coalesce(b.billable_units, 0)) / (datediff(d, CURRENT_DATE (), d.end_datetm) + 1)
          END AS CCP_LOCAL
      FROM dim.flight_media_details_base_view d
      JOIN (
        SELECT flight_media_id
          ,sum(units) AS units
        FROM dim.demand_units_budget_view
        WHERE flight_media_id IS NOT NULL
          AND flight_media_id IN (
            SELECT flight_media_id
            FROM dim.flight_media_details_base_view f
            WHERE CURRENT_DATE () BETWEEN f.begin_datetm
                AND TIMESTAMPADD(day, 1, f.end_datetm)
            )
        GROUP BY flight_media_id
        ) u ON d.flight_media_id = u.flight_media_id
      LEFT JOIN (
        SELECT s.flight_media_id
          ,sum(billable_units) AS billable_units
        FROM demand_mart.daily_core_stats s
        WHERE s.flight_media_id IN (
            SELECT flight_media_id
            FROM dim.flight_media_details_base_view f
            WHERE CURRENT_DATE () BETWEEN f.begin_datetm
                AND TIMESTAMPADD(day, 1, f.end_datetm)
            )
        GROUP BY s.flight_media_id
        ) b ON d.flight_media_id = b.flight_media_id

      UNION

      SELECT d.flight_media_id
      ,0
      FROM dim.flight_media_details_base_view d
      WHERE CURRENT_DATE () NOT BETWEEN d.begin_datetm
      AND TIMESTAMPADD(day, 1, d.end_datetm)
      ;;
  }

  dimension: flight_media_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: ccp_local {
    hidden: yes
    type: number
    sql: ${TABLE}.CCP_LOCAL ;;
  }

  measure: sum_ccp_local {
    type: sum
    label: "Required Delivery Today"
    view_label: "Flight"
    description: "Planned Units - Billable Units Delivered / Remaining Days"
    value_format_name: decimal_0
    sql: ${ccp_local} ;;
  }
}
