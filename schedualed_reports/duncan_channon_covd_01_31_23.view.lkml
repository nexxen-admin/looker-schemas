view: duncan_channon_covd_01_31_23 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT Date_Key::date as "Date",
        CASE WHEN df.Flight_ID = 4570806 AND dc.Creative_ID = 8719226 THEN 'DC_CVT_FY23_Q4_PHASE2_MC'
             WHEN df.Flight_ID = 4570976 AND dc.Creative_ID = 8719256 THEN 'DC_CVT_FY23_Q4_PHASE2_MC'
             WHEN df.Flight_ID = 4571096 AND dc.Creative_ID = 8719296 THEN 'DC_CVT_FY23_Q4_PHASE2_MC'
             WHEN df.Flight_ID = 4571346 AND dc.Creative_ID = 8719236 THEN 'DC_CVT_FY23_Q4_PHASE2_MC'
             ELSE 'DC_CVT_FY23_Q4_PHASE2_MC' END AS "DCM CAMPAIGN NAME",
        CASE WHEN df.Flight_ID = 4570806 AND dc.Creative_ID = 8719226 THEN '29054401'
             WHEN df.Flight_ID = 4570976 AND dc.Creative_ID = 8719256 THEN '29054401'
             WHEN df.Flight_ID = 4571096 AND dc.Creative_ID = 8719296 THEN '29054401'
             WHEN df.Flight_ID = 4571346 AND dc.Creative_ID = 8719236 THEN '29054401'
             ELSE '29054401' END AS "DCM CAMPAIGN ID",
        CASE WHEN df.Flight_ID = 4570806 AND dc.Creative_ID = 8719226 THEN 'DC_CVT_FY23_Q4_PHASE2_MC_EN_TREMOR_CA_VIDEO_CTV_AWARENESS_CPM_1x1_NONSKIP_30s_RECOVER-SMOOTHER_3P_A18-49-HIGH-RISK_'
             WHEN df.Flight_ID = 4570976 AND dc.Creative_ID = 8719256 THEN 'DC_CVT_FY23_Q4_PHASE2_MC_EN_TREMOR_CA_VIDEO_CTV_AWARENESS_CPM_1x1_NONSKIP_30s_RECOVER-SMOOTHER_3P_A50+-PRIORITY-POPULATIONS_'
             WHEN df.Flight_ID = 4571096 AND dc.Creative_ID = 8719296 THEN 'DC_CVT_FY23_Q4_PHASE2_MC_EN_TREMOR_CA_VIDEO_CTV_AWARENESS_CPM_1x1_NONSKIP_30s_RECOVER-SMOOTHER_3P_AAB_'
             WHEN df.Flight_ID = 4571346 AND dc.Creative_ID = 8719236 THEN 'DC_CVT_FY23_Q4_PHASE2_MC_EN_TREMOR_CA_VIDEO_CTV_AWARENESS_CPM_1x1_NONSKIP_30s_RECOVER-SMOOTHER_GEOGRAPHIC_RURAL_'
             ELSE 'DC_CVT_FY23_Q4_PHASE2_MC_EN_TREMOR_CA_VIDEO_CTV_AWARENESS_CPM_1x1_NONSKIP_30s_RECOVER-SMOOTHER_BEHAVIORAL_A18-49-HIGH-RISK_' END AS "DCM PLACEMENT NAME",
        CASE WHEN df.Flight_ID = 4570806 AND dc.Creative_ID = 8719226 THEN '356704775'
             WHEN df.Flight_ID = 4570976 AND dc.Creative_ID = 8719256 THEN '357050044'
             WHEN df.Flight_ID = 4571096 AND dc.Creative_ID = 8719296 THEN '357038901'
             WHEN df.Flight_ID = 4571346 AND dc.Creative_ID = 8719236 THEN '357031758'
             ELSE '357051862' END AS "DCM PLACEMENT ID",
        CASE WHEN df.Flight_ID = 4570806 AND dc.Creative_ID = 8719226 THEN 'Recover Smoother :30'
             WHEN df.Flight_ID = 4570976 AND dc.Creative_ID = 8719256 THEN 'Recover Smoother :30'
             WHEN df.Flight_ID = 4571096 AND dc.Creative_ID = 8719296 THEN 'Recover Smoother :30'
             WHEN df.Flight_ID = 4571346 AND dc.Creative_ID = 8719236 THEN 'Recover Smoother :30'
             ELSE 'Recover Smoother :30' END AS "DCM CREATIVE NAME",
        SUM(sum_of_Revenue) AS "SPEND",
        SUM(sum_of_Impressions) AS "IMPRESSIONS",
        SUM(sum_of_Clicks) AS "CLICKS",
        SUM(sum_of_Impressions) AS "VIEWS",
        SUM(sum_of_Completions) AS "COMPLETED VIEWS",
        SUM(sum_of_Completions) / SUM(sum_of_Impressions) AS "VCR",
        SUM(sum_of_Clicks) / SUM(sum_of_Impressions) AS "CTR"
FROM BI_TVDSP.Fact_Ad_Events_Daily_Agg faeda
  INNER JOIN BI_TVDSP.Dim_Flight df on faeda.Flight_Key = df.Flight_Key
  INNER JOIN BI_TVDSP.Dim_Creative dc on faeda.Creative_Key = dc.Creative_Key
WHERE faeda.Date_Key >= '2023-01-24'
  AND faeda.Date_Key < CURRENT_DATE()
  AND df.Flight_ID IN (4570806,4570976,4571096,4571346,4570496)
GROUP BY 1,2,3,4,5,6
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
    sql: ${TABLE}."Date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: dcm_campaign_name {
    type: string
    label: "DCM CAMPAIGN NAME"
    sql: ${TABLE}."DCM CAMPAIGN NAME" ;;
  }

  dimension: dcm_campaign_id {
    type: string
    label: "DCM CAMPAIGN ID"
    sql: ${TABLE}."DCM CAMPAIGN ID" ;;
  }

  dimension: dcm_placement_name {
    type: string
    label: "DCM PLACEMENT NAME"
    sql: ${TABLE}."DCM PLACEMENT NAME" ;;
  }

  dimension: dcm_placement_id {
    type: string
    label: "DCM PLACEMENT ID"
    sql: ${TABLE}."DCM PLACEMENT ID" ;;
  }

  dimension: dcm_creative_name {
    type: string
    label: "DCM CREATIVE NAME"
    sql: ${TABLE}."DCM CREATIVE NAME" ;;
  }

  dimension: spend {
    type: number
    label: "SPEND"
    sql: ${TABLE}.SPEND ;;
  }

  dimension: impressions {
    type: number
    label: "IMPRESSIONS"
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  dimension: clicks {
    type: number
    label: "CLICKS"
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: views {
    type: number
    label: "VIEWS"
    sql: ${TABLE}.VIEWS ;;
  }

  dimension: completed_views {
    type: number
    label: "COMPLETED VIEWS"
    sql: ${TABLE}."COMPLETED VIEWS" ;;
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
      dcm_creative_name,
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
