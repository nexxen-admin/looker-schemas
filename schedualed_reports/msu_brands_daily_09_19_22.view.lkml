view: msu_brands_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'MSU Brand' AS "Brand Name",
      CASE WHEN c.flight_number = 'F-295999' THEN 'CTV w/ Branded Frame + QR & 1P BT (Alumni & National)'
           WHEN c.flight_number = 'F-296007' THEN 'CTV w/ Branded Frame + QR & 3P BT (Informed Public)'
           WHEN c.flight_number = 'F-296015' THEN 'CTV w/ Branded Frame +  & QR & 1P BT (Internal)'
           WHEN c.flight_number = 'F-296016' THEN 'CTV w/ Branded Frame + QR & 3P BT (Local, State & Federal Government Employees'
           ELSE 'CTV w/ Branded Frame + QR & RTG' END AS "Placement Name",
      CASE WHEN cr.id = 8624086 THEN 'MSU_Tremor_CTV_Alumni_National_:30_Brand'
           WHEN cr.id = 8624096 THEN 'MSU_Tremor_CTV_InformedPublic_Michigan_:30_Brand'
           WHEN cr.id = 8624106 THEN 'MSU_Tremor_CTV_Alumni_Internal_National_:30_Brand'
           WHEN cr.id = 8624116 THEN 'MSU_Tremor_CTV_GovernmentEmployees_Michigan_:30_Brand'
           ELSE 'MSU_Tremor_CTV_Retargeting_National_:30_Brand' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-295999','F-296007','F-296015','F-296016','F-295991')
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
    label: "Impressions"
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
