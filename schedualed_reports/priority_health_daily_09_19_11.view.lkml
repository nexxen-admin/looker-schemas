view: priority_health_daily_09_19_11 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql:SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'Priority Health' AS "Brand Name",
      CASE WHEN c.flight_number = 'F-300482' THEN '346299285'
           WHEN c.flight_number = 'F-300486' THEN '346297029'
           WHEN c.flight_number = 'F-300490' THEN '346270813'
           WHEN c.flight_number = 'F-300497' THEN '345984341'
           WHEN c.flight_number = 'F-300504' THEN '346272760'
           WHEN c.flight_number = 'F-300508' THEN '346271953'
           WHEN c.flight_number = 'F-300512' THEN '346297053'
           WHEN c.flight_number = 'F-300516' THEN '346269382'
           WHEN c.flight_number = 'F-300520' THEN '346301169'
           WHEN c.flight_number = 'F-300524' THEN '346270804'
           WHEN c.flight_number = 'F-300528' THEN '346266361'
           WHEN c.flight_number = 'F-300494' THEN '346299285'
           WHEN c.flight_number = 'F-300498' THEN '345984341'
           WHEN c.flight_number = 'F-300501' THEN '346297029'
           WHEN c.flight_number = 'F-300505' THEN '346272760'
           WHEN c.flight_number = 'F-300509' THEN '346271953'
           WHEN c.flight_number = 'F-300513' THEN '346297053'
           WHEN c.flight_number = 'F-300517' THEN '346269382'
           WHEN c.flight_number = 'F-300521' THEN '346301169'
           WHEN c.flight_number = 'F-300525' THEN '346270804'
           WHEN c.flight_number = 'F-300529' THEN '346266361'
           WHEN c.flight_number = 'F-300495' THEN '346299285'
           WHEN c.flight_number = 'F-300499' THEN '345984341'
           WHEN c.flight_number = 'F-300502' THEN '346297029'
           WHEN c.flight_number = 'F-300506' THEN '346272760'
           WHEN c.flight_number = 'F-300510' THEN '346271953'
           WHEN c.flight_number = 'F-300514' THEN '346297053'
           WHEN c.flight_number = 'F-300518' THEN '346269382'
           WHEN c.flight_number = 'F-300522' THEN '346301169'
           WHEN c.flight_number = 'F-300526' THEN '346270804'
           WHEN c.flight_number = 'F-300530' THEN '346266361'
           WHEN c.flight_number = 'F-300569' THEN '346270813'
           ELSE '346270813' END AS "Placement ID",
      CASE WHEN c.flight_number IN('F-300482', 'F-300497', 'F-300494', 'F-300498', 'F-300495', 'F-300499') THEN 'CTV Plus, BT Targeting, DMA'
           WHEN c.flight_number IN('F-300490', 'F-300568', 'F-300569') THEN 'OLV Plus RTG'
           ELSE 'OLV Plus, Contextual Targeting, DMA' END AS "Placement Name",
      CASE WHEN c.flight_number = 'F-300482' THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
           WHEN c.flight_number = 'F-300486' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
           WHEN c.flight_number = 'F-300490' THEN 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15'
           WHEN c.flight_number = 'F-300497' THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
           WHEN c.flight_number = 'F-300504' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
           WHEN c.flight_number = 'F-300508' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
           WHEN c.flight_number = 'F-300512' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
           WHEN c.flight_number = 'F-300516' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
           WHEN c.flight_number = 'F-300520' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
           WHEN c.flight_number = 'F-300524' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
           WHEN c.flight_number = 'F-300528' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
           WHEN c.flight_number = 'F-300494' THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
           WHEN c.flight_number = 'F-300498' THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
           WHEN c.flight_number = 'F-300501' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
           WHEN c.flight_number = 'F-300505' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
           WHEN c.flight_number = 'F-300509' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
           WHEN c.flight_number = 'F-300513' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
           WHEN c.flight_number = 'F-300517' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
           WHEN c.flight_number = 'F-300521' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
           WHEN c.flight_number = 'F-300525' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
           WHEN c.flight_number = 'F-300529' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
           WHEN c.flight_number = 'F-300495' THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
           WHEN c.flight_number = 'F-300499' THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
           WHEN c.flight_number = 'F-300502' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
           WHEN c.flight_number = 'F-300506' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
           WHEN c.flight_number = 'F-300510' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
           WHEN c.flight_number = 'F-300514' THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
           WHEN c.flight_number = 'F-300518' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
           WHEN c.flight_number = 'F-300522' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
           WHEN c.flight_number = 'F-300526' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
           WHEN c.flight_number = 'F-300530' THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
           WHEN c.flight_number = 'F-300569' THEN 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15'
           ELSE 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-300482','F-300486','F-300490','F-300497','F-300504','F-300508','F-300512',
              'F-300516','F-300520','F-300524','F-300528','F-300494','F-300498','F-300501',
                'F-300505','F-300509','F-300513','F-300517','F-300521','F-300525','F-300529',
                'F-300568','F-300495','F-300499','F-300502','F-300506','F-300510','F-300514',
              'F-300518','F-300522','F-300526','F-300530','F-300569')
  AND date >= '2022-09-15'
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
