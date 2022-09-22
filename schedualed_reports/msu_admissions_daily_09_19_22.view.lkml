view: msu_admissions_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'MSU Admission' AS "Brand Name",
      CASE WHEN c.flight_number = 'F-295945' THEN 'CTV Plus w/ Branded Frame + QR & 1P BT (Prospective Students)'
           WHEN c.flight_number = 'F-295961' THEN 'CTV Plus w/ Branded Frame + QR & 3P BT (Proespective Parents)'
           WHEN c.flight_number = 'F-295953' THEN 'OLV Plus w/ Endcard + CTA & 1P BT (Prospective Students)'
           ELSE 'CTV Plus w/ Branded frame + QR & RTG + National' END AS "Placement Name",
      CASE WHEN cr.id = 8625986 AND c.flight_number = 'F-295945' THEN 'MSU Spartans Custom'
           WHEN cr.id = 8626006 AND c.flight_number = 'F-295945' THEN 'MSU Experience Custom'
           WHEN cr.id = 8626016 AND c.flight_number = 'F-295945' THEN 'MSU Career Custom'
           WHEN cr.id = 8625986 AND c.flight_number = 'F-295961' THEN 'MSU Spartans Custom'
           WHEN cr.id = 8626006 AND c.flight_number = 'F-295961' THEN 'MSU Experience Custom'
           WHEN cr.id = 8626016 AND c.flight_number = 'F-295961' THEN 'MSU Career Custom'
           WHEN cr.id = 8626206 AND c.flight_number = 'F-295953' THEN 'MSU Spartans Custom OLV'
           WHEN cr.id = 8626216 AND c.flight_number = 'F-295953' THEN 'MSU Experience Custom OLV'
           WHEN cr.id = 8626226 AND c.flight_number = 'F-295953' THEN 'MSU Career Custom OLV'
           ELSE 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1) Experience' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-295945','F-295961','F-295953', 'F-295969')
  AND date >= '2022-09-01'
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
