view: amherst_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'Amherst' AS "Brand Name",
      CASE WHEN c.flight_number = 'F-297135' THEN 'CTV Plus w/ Branded Frame + QR, 1P, DMA (Traditional Students)'
           WHEN c.flight_number = 'F-297143' THEN 'OLV Plus w/ Custom CTA, 1P, DMA (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297151' THEN 'CTV Plus w/ Branded Frame + QR, 1P, Zip (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297159' THEN 'OLV Plus w/ Custom CTA, 1P, Zip (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297167' THEN 'CTV Plus w/ Branded Frame + QR, 3P, DMA (Prospective Student Parents)'
           WHEN c.flight_number = 'F-297175' THEN 'CTV Plus w/ Branded Frame + QR, 3P, Zip (Prospective Student Parents)'
           WHEN c.flight_number = 'F-297191' THEN 'OLV Plus w/ Custom CTA, 1P, DMA (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297192' THEN 'CTV Plus w/ Branded Frame + QR, 3P, DMA (Prospective Student Parents)'
           WHEN c.flight_number = 'F-297193' THEN 'CTV Plus w/ Branded Frame + QR, 3P, DMA (Non-Traditional Students)'
           WHEN c.flight_number = 'F-297194' THEN 'CTV Plus w/ Branded Frame + QR, 3P, Zip (Prospective Student Parents)'
           WHEN c.flight_number = 'F-297195' THEN 'CTV Plus w/ Branded Frame + QR, 1P, Zip (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297196' THEN 'CTV Plus w/ Branded Frame + QR, 1P, DMA (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297197' THEN 'OLV Plus w/ Custom CTA, 1P, Zip (Traditional Prospective Students)'
           WHEN c.flight_number = 'F-297198' THEN 'CTV Plus w/ Branded Frame + QR, 3P, DMA (Non-Traditional Students)'
           ELSE 'OLV RTG' END AS "Placement Name",
      CASE WHEN c.flight_number IN ('F-297143', 'F-297159', 'F-297191', 'F-297197', 'F-297183') THEN 'Amherst 15s Std Asset'
           ELSE 'Amherst 30s Std Asset' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-297135','F-297143','F-297151','F-297159','F-297167','F-297175','F-297191','F-297192','F-297193','F-297194','F-297195','F-297196','F-297197','F-297198','F-297183')
  AND date >= '2022-09-06'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  AND (impressions > 0 or completions > 0 or clicks > 0)
GROUP BY 1,2,3,4,5,6
ORDER BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "Date"
    sql: ${TABLE}."Date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}."Flight Number" ;;
  }

  dimension: creative_id {
    type: number
    label: "Creative ID"
    sql: ${TABLE}."Creative ID" ;;
  }

  dimension: brand_name {
    type: string
    label: "Brand Name"
    sql: ${TABLE}."Brand Name" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: creative_name {
    type: string
    label: "Creative Name"
    sql: ${TABLE}."Creative Name" ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
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
      flight_number,
      creative_id,
      brand_name,
      placement_name,
      creative_name,
      impressions,
      completions,
      clicks,
      vcr,
      spend
    ]
  }
}
