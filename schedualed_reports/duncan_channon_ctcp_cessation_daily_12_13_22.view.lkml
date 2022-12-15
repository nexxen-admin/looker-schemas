view: duncan_channon_ctcp_cessation_daily_12_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT Date_Key::date as "date",
Flight_ID,
     'DC_CTCP_2022_Q4_CESSATION_MC' AS "DCM Campaign Name",
     '2880559' AS "DCM Campaign ID",
     CASE WHEN Flight_ID = 4518266 AND Creative_ID = 8695486 THEN 'DC_CTCP_2022_Q4_CESSATION_MC_EN_TREMOR_STATEWIDE_VIDEO_CTV_INCITE_CPM_1x1_PREDICTIVE_SMOKERS-21+_30S__STEVEN_'
          WHEN Flight_ID = 4518266 AND Creative_ID = 8695476 THEN 'DC_CTCP_2022_Q4_CESSATION_MC_EN_TREMOR_STATEWIDE_VIDEO_CTV_INCITE_CPM_1x1_PREDICTIVE_SMOKERS-21+_30S__GEORGE_'
          WHEN Flight_ID = 4518306 AND Creative_ID = 8695466  THEN 'DC_CTCP_2022_Q4_CESSATION_MC_EN_TREMOR_STATEWIDE_VIDEO_CTV_INCITE_CPM_1x1_PREDICTIVE_VAPERS-18-24_30S__RYAN_'
          ELSE 'DC_CTCP_2022_Q4_CESSATION_MC_EN_TREMOR_STATEWIDE_VIDEO_CTV_INCITE_CPM_1x1_PREDICTIVE_VAPERS-25+_30S__RYAN_' END AS "DCM Placement Name",
     CASE WHEN Flight_ID = 4518266 AND Creative_ID = 8695486 THEN '353538113'
          WHEN Flight_ID = 4518266 AND Creative_ID = 8695476 THEN '353538116'
          WHEN Flight_ID = 4518306 AND Creative_ID = 8695466 THEN '353894463'
          ELSE '353546651' END AS "DCM Placement ID",
     CASE WHEN Creative_ID = 8695486 THEN 'Steven :30'
          WHEN Creative_ID = 8695476 THEN 'George :30'
          ELSE 'Ryan :30' END AS "Creative Name",
     SUM(Revenue) AS "Spend",
     SUM(Impressions) AS "Impressions",
     SUM(Clicks) AS "Clicks",
     SUM(Impressions) AS "Views",
     SUM(Completions) AS "Completed Views",
     SUM(Completions)/SUM(Impressions) AS "VCR",
     SUM(Clicks)/SUM(Impressions) AS "CTR"
FROM BI_TVDSP.Fact_Ad_Events_Daily faed
WHERE Date_Key >= '2022-12-12'
  AND Date_Key < CURRENT_DATE()
  AND Flight_ID IN (4518316, 4518306, 4518266)
GROUP BY 1,2,3,4,5,6,7
ORDER BY 1 ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "DATE"
    sql: ${TABLE}."date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: dcm_campaign_name {
    type: string
    label: "DCM CAMPAIGN NAME"
    sql: ${TABLE}."DCM Campaign Name" ;;
  }

  dimension: dcm_campaign_id {
    type: string
    label: "DCM CAMPAIGN ID"
    sql: ${TABLE}."DCM Campaign ID" ;;
  }

  dimension: dcm_placement_name {
    type: string
    label: "DCM PLACEMENT NAME"
    sql: ${TABLE}."DCM Placement Name" ;;
  }

  dimension: dcm_placement_id {
    type: string
    label: "DCM PLACEMENT ID"
    sql: ${TABLE}."DCM Placement ID" ;;
  }

  dimension: creative_name {
    type: string
    label: "CREATIVE NAME"
    sql: ${TABLE}."Creative Name" ;;
  }

  dimension: spend {
    type: number
    label: "SPEND"
    sql: ${TABLE}.Spend ;;
  }

  dimension: impressions {
    type: number
    label: "IMPRESSIONS"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    label: "CLICKS"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: views {
    type: number
    label: "VIEWS"
    sql: ${TABLE}.Views ;;
  }

  dimension: completed_views {
    type: number
    label: "COMPLETED VIEWS"
    sql: ${TABLE}."Completed Views" ;;
  }

  dimension: vcr {
    type: number
    label: "VCR"
    sql: ${TABLE}.VCR ;;
  }

  dimension: ctr {
    type: number
    label: "CTR"
    sql: ${TABLE}.CTR ;;
  }

  set: detail {
    fields: [
      date,
      dcm_campaign_name,
      dcm_campaign_id,
      dcm_placement_name,
      dcm_placement_id,
      creative_name,
      spend,
      impressions,
      clicks,
      views,
      completed_views,
      vcr,
      ctr
    ]
  }
}
