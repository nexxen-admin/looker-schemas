view: msu_admissions_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql:SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'MSU Admission' AS "Brand Name",
      CASE WHEN c.flight_number = 'F-295945' AND cr.id = 8625986 THEN '344745957'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8626006 THEN '344745936'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8626016 THEN '345372381'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673456 THEN '350601430'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673466 THEN '350601433'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673476 THEN '350601436'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8625986 THEN '345377703'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8626006 THEN '344745966'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8626016 THEN '345376221'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673456 THEN '350601418'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673466 THEN '350601424'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673476 THEN '350601427'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626206 THEN '344754421'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626216 THEN '344745657'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626226 THEN '345372336'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673256 THEN '350273954'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673346 THEN '350273963'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673256 THEN '350273966'
           ELSE '344745621' END AS "Placement ID",
      CASE WHEN c.flight_number = 'F-295945' THEN 'CTV Plus w/ Branded Frame + QR & 1P BT (Prospective Students)'
           WHEN c.flight_number = 'F-295961' THEN 'CTV Plus w/ Branded Frame + QR & 3P BT (Prospective Parents)'
           WHEN c.flight_number = 'F-295953' THEN 'OLV Plus w/ Endcard + CTA & 1P BT (Prospective Students)'
           ELSE 'CTV Plus w/ Branded frame + QR & RTG + National' END AS "Placement Name",
      CASE WHEN c.flight_number = 'F-295945' AND cr.id = 8625986 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Spartans/MakeADifference Video'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8626006 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Experience/MakeADifference Video'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8626016 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Career/MakeADifference Video'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673456 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Career/GenerationWill Video'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673466 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Experience/GenerationWill Video'
           WHEN c.flight_number = 'F-295945' AND cr.id = 8673476 THEN 'MSU_Tremor_CTVOverlay_ProspectiveStudents_National_:30 (1x1)_Spartans/GenerationWill Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8625986 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Spartans/MakeADifference Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8626006 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Experience/MakeADifference Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8626016 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Career/MakeADifference Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673456 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Career/GenerationWill Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673466 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Experience/GenerationWill Video'
           WHEN c.flight_number = 'F-295961' AND cr.id = 8673476 THEN 'MSU_Tremor_CTVOverlay_ProspectiveParents_National_:30 (1x1)_Spartans/GenerationWill Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626206 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1)_Spartans/GenerationWill Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626216 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1)_Experience/GenerationWill Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8626226 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1) _Career/GenerationWill Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673256 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1) _Career/MakeADifference Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673346 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1)_Experience/MakeADifference Video'
           WHEN c.flight_number = 'F-295953' AND cr.id = 8673256 THEN 'MSU_Tremor_OLVEndCard_ProspectiveStudents_National_:15 (1x1)_Spartans/MakeADifference Video'
           ELSE 'MSU_Tremor_CTV_Retargeting_National_:30' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-295945','F-295961','F-295953','F-295969')
  AND date >= '2022-09-01'
  AND date < CURRENT_DATE()
  AND c.buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
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

  dimension: placement_id {
    type: string
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
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
      placement_id,
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
