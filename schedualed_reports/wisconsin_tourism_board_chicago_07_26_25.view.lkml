view: wisconsin_tourism_board_chicago_07_26_25 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT add2.date::date as date,
           c.advertiser_name,
           c.flight_number,
           CASE WHEN c.flight_number = 'F-278719' THEN '1077843496, 1077843497'
               WHEN c.flight_number = 'F-278720' THEN '1077990840, 1077990841'
               WHEN c.flight_number = 'F-278728' THEN '1077843495, 1077843494'
               WHEN c.flight_number = 'F-278729' THEN '1077990839, 1077990838'
               WHEN c.flight_number = 'F-278731' THEN '1077843493, 1077843492'
               WHEN c.flight_number = 'F-278732' THEN '1077990837, 1077990836'
               WHEN c.flight_number = 'F-278735' THEN '1077852120, 1077852119'
               WHEN c.flight_number = 'F-278736' THEN '1077990843, 1077990842'
               WHEN c.flight_number = 'F-278739' THEN '1077852122, 1077852121'
               ELSE '1077990845, 1077990844' END AS "Sizmek Placement ID's",
             SUM(impressions) AS "Impressions",
             SUM(clicks) AS "Clicks",
             SUM(completions) AS Completions,
             SUM(completions) / SUM(impressions) AS "VCR",
             SUM(revenue) as "Spend"
      FROM dwh.ad_data_daily add2
        left outer join dwh.campaign c on add2.flight_id = c.flight_id
      WHERE c.flight_number IN('F-278719','F-278720','F-278728','F-278729','F-278731','F-278732','F-278735','F-278736','F-278739','F-278740')
        AND date >= '2022-04-11'
        AND date < CURRENT_DATE()
        AND impressions > 0
      GROUP BY 1,2,3,4
      ORDER BY 1 ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "Date"
    sql: ${TABLE}."date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser Name"
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}.flight_number ;;
  }

  dimension: sizmek_placement_ids {
    type: string
    label: "Sizmek Placement ID's"
    sql: ${TABLE}."Sizmek Placement ID's" ;;
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

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: vcr {
    type: number
    label: "VCR"
    sql: ${TABLE}.VCR ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [
      date,
      advertiser_name,
      flight_number,
      sizmek_placement_ids,
      impressions,
      clicks,
      completions,
      vcr,
      spend
    ]
  }
}
