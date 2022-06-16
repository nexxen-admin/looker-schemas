view: altamed_health_services_06_16_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: WITH TVDSP_transactional_data AS(
      SELECT date::date as "Date",
           c.flight_number as "Flight_Number",
           c.flight_name as "Placement_Name",
           SUM(impressions) as "Impressions",
           SUM(clicks) as "Clicks",
           SUM(progress0) as "Quartile 0",
           SUM(completions) as "Completions",
           CASE WHEN c.flight_number IN ('F-280051', 'F-287464', 'F-287465', 'F-287466') THEN 0
               WHEN c.flight_number IN ('F-280044', 'F-280045', 'F-280046', 'F-280047', 'F-280048', 'F-280049', 'F-280050', 'F-280078') THEN (SUM(impressions)/1000) * 16.00
               ELSE (SUM(impressions)/1000) * 24.00 END as "Spend"
      FROM dwh.ad_data_daily add2
        LEFT JOIN dwh.campaign c ON add2.flight_id = c.flight_id
      WHERE c.flight_number IN ('F-280051', 'F-287464', 'F-287465', 'F-287466', 'F-280044', 'F-280045', 'F-280046', 'F-280047', 'F-280048', 'F-280049', 'F-280050', 'F-280078', 'F-280030', 'F-280031', 'F-280032', 'F-280033', 'F-280034', 'F-280035', 'F-280036', 'F-280058')
          AND date >= '2022-04-18'
          AND date < CURRENT_DATE()
          AND impressions > 0
      GROUP BY 1,2,3
      ),

      amobee_transactional_data AS(
      SELECT event_time::date as "Date",
      amobee_flight_no as "Flight_Number",
      line_item_name as "Placement_Name",
      SUM(impressions) as "Impressions",
      SUM(clicks) as "Clicks",
      0 as "Quartile 0 ",
      SUM(completions) as "Completions",
      (SUM(impressions)/1000) * 4 as "Spend"
      FROM dwh.tp_amobee_daily_report tadr
      WHERE amobee_flight_no IN ('F-280037', 'F-280038', 'F-280039', 'F-280040', 'F-280041', 'F-280042', 'F-280043', 'F-280069')
      AND event_time >= '2022-04-18'
      AND event_time < CURRENT_DATE()
      AND impressions > 0
      GROUP BY 1,2,3
      )

      SELECT *
      FROM TVDSP_transactional_data
      GROUP BY 1,2,3,4,5,6,7,8


      UNION

      SELECT *
      FROM amobee_transactional_data
      GROUP BY 1,2,3,4,5,6,7,8
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "Day"
    sql: ${TABLE}."Date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}.Flight_Number ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: quartile_0 {
    type: number
    label: "Quartile 0"
    sql: ${TABLE}."Quartile 0" ;;
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: spend {
    type: number
    value_format: "$#.00;($#.00)"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [
      date,
      flight_number,
      placement_name,
      impressions,
      clicks,
      quartile_0,
      completions,
      spend
    ]
  }
}
