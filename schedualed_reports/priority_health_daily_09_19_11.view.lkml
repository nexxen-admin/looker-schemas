view: priority_health_daily_09_19_11 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql:SELECT date::date as "Date",
      c.flight_number AS "Flight Number",
      cr.id AS "Creative ID",
      'Priority Health' AS "Brand Name",
      CASE WHEN cr.id = 8635256 THEN '346299285'
       WHEN cr.id = 8635176 THEN '346297029'
         WHEN cr.id = 8635166 THEN '346270813'
         WHEN cr.id = 8635266 THEN '345984341'
         WHEN cr.id = 8635186 THEN '346272760'
       WHEN cr.id = 8635196 THEN '346271953'
       WHEN cr.id = 8635206 THEN '346297053'
       WHEN cr.id = 8635216 THEN '346269382'
         WHEN cr.id = 8635226 THEN '346301169'
       WHEN cr.id = 8635236 THEN '346270804'
       WHEN cr.id = 8635246 THEN '346266361'
       WHEN cr.id = 8635256 THEN '346299285'
       WHEN cr.id = 8635266 THEN '345984341'
       WHEN cr.id = 8635176 THEN '346297029'
       WHEN cr.id = 8635186 THEN '346272760'
       WHEN cr.id = 8635196 THEN '346271953'
       WHEN cr.id = 8635206 THEN '346297053'
       WHEN cr.id = 8635216 THEN '346269382'
       WHEN cr.id = 8635226 THEN '346301169'
       WHEN cr.id = 8635236 THEN '346270804'
       WHEN cr.id = 8635246 THEN '346266361'
       WHEN cr.id = 8635166 THEN '346270813'
         WHEN cr.id = 8635256 THEN '346299285'
       WHEN cr.id = 8635266 THEN '345984341'
       WHEN cr.id = 8635176 THEN '346297029'
       WHEN cr.id = 8635186 THEN '346272760'
       WHEN cr.id = 8635196 THEN '346271953'
       WHEN cr.id = 8635206 THEN '346297053'
       WHEN cr.id = 8635216 THEN '346269382'
       WHEN cr.id = 8635226 THEN '346301169'
       WHEN cr.id = 8635236 THEN '346270804'
       WHEN cr.id = 8635246 THEN '346266361'
       WHEN cr.id = 8635166 THEN '346270813'
       WHEN cr.id = 8668676 THEN '351072562'
       WHEN cr.id = 8669016 THEN '351072568'
       WHEN cr.id = 8669006 THEN '351072550'
       WHEN cr.id = 8669026 THEN '351072556'
       WHEN cr.id = 8668686 THEN '351072526'
         WHEN cr.id = 8668696 THEN '351072532'
         WHEN cr.id = 8668706 THEN '351072538'
         WHEN cr.id = 8668716 THEN '351072544'
       WHEN cr.id = 8668866 THEN '351072481'
       WHEN cr.id = 8668796 THEN '351072484'
       WHEN cr.id = 8668936 THEN '351072490'
       WHEN cr.id = 8668726 THEN '351072496'
       WHEN cr.id = 8668946 THEN '351072463'
       WHEN cr.id = 8668736 THEN '351072466'
         WHEN cr.id = 8668876 THEN '351072559'
       WHEN cr.id = 8668806 THEN '351072565'
       WHEN cr.id = 8668886 THEN '351072511'
       WHEN cr.id = 8668816 THEN '351072517'
       WHEN cr.id = 8668956 THEN '351072523'
       WHEN cr.id = 8668746 THEN '351072529'
       WHEN cr.id = 8668896 THEN '351072502'
       WHEN cr.id = 8668826 THEN '351072508'
       WHEN cr.id = 8668966 THEN '351072514'
       WHEN cr.id = 8668756 THEN '351072520'
       WHEN cr.id = 8668906 THEN '351072469'
         WHEN cr.id = 8668836 THEN '351072472'
         WHEN cr.id = 8668976 THEN '351072475'
       WHEN cr.id = 8668766 THEN '351072478'
       WHEN cr.id = 8668916 THEN '351072535'
       WHEN cr.id = 8668846 THEN '351072541'
       WHEN cr.id = 8668986 THEN '351072547'
       WHEN cr.id = 8668776 THEN '351072553'
       WHEN cr.id = 8668926 THEN '351072487'
       WHEN cr.id = 8668856 THEN '351072493'
         WHEN cr.id = 8668996 THEN '351072499'
         WHEN cr.id = 8668786 THEN '351072505'
           ELSE '346270813' END AS "Placement ID",
      CASE WHEN c.flight_number IN ('F-300482', 'F-300497', 'F-300494', 'F-300498', 'F-300495', 'F-300499') THEN 'CTV Plus, BT Targeting, DMA'
           WHEN c.flight_number IN ('F-300490', 'F-300568', 'F-300569') THEN 'OLV Plus RTG'
           ELSE 'OLV Plus, Contextual Targeting, DMA' END AS "Placement Name",
      CASE WHEN cr.id = 8635256 THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
       WHEN cr.id = 8635176 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
         WHEN cr.id = 8635166 THEN 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15'
         WHEN cr.id = 8635266 THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
         WHEN cr.id = 8635186 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
       WHEN cr.id = 8635196 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
       WHEN cr.id = 8635206 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
       WHEN cr.id = 8635216 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
         WHEN cr.id = 8635226 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
       WHEN cr.id = 8635236 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
       WHEN cr.id = 8635246 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
       WHEN cr.id = 8635256 THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
       WHEN cr.id = 8635266 THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
       WHEN cr.id = 8635176 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
       WHEN cr.id = 8635186 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
       WHEN cr.id = 8635196 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
       WHEN cr.id = 8635206 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
       WHEN cr.id = 8635216 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
       WHEN cr.id = 8635226 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
       WHEN cr.id = 8635236 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
       WHEN cr.id = 8635246 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
       WHEN cr.id = 8635166 THEN 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15'
         WHEN cr.id = 8635256 THEN 'PH_Tremor_CTV_Behavioral_Detroit_:30'
       WHEN cr.id = 8635266 THEN 'PH_Tremor_CTV_Behavioral_GrandRapids_:30'
       WHEN cr.id = 8635176 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 2)'
       WHEN cr.id = 8635186 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 3)'
       WHEN cr.id = 8635196 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 4)'
       WHEN cr.id = 8635206 THEN 'PH_Tremor_AllScreen_KeywordList_Detroit_:15 (Line 5)'
       WHEN cr.id = 8635216 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 7)'
       WHEN cr.id = 8635226 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 8)'
       WHEN cr.id = 8635236 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 9)'
       WHEN cr.id = 8635246 THEN 'PH_Tremor_AllScreen_KeywordList_GrandRapids_:15 (Line 10)'
       WHEN cr.id = 8635166 THEN 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15'
       WHEN cr.id = 8668676 THEN 'PH_Tremor_CTVOverlay_Behavioral_Detroit_1x1_:30 Workout (PerfectFit)+QR Code'
       WHEN cr.id = 8669016 THEN 'PH_Tremor_CTVOverlay_Behavioral_Detroit_1x1_:30 Skate (LittleDaredevil)+QR Code'
       WHEN cr.id = 8669006 THEN 'PH_Tremor_CTVOverlay_Behavioral_GrandRapids_1x1_:30 Workout (PerfectFit)+QR Code'
       WHEN cr.id = 8669026 THEN 'PH_Tremor_CTVOverlay_Behavioral_GrandRapids_1x1_:30 Skate (LittleDaredevil)+QR Code'
       WHEN cr.id = 8668686 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_Detroit_1x1_:15 Workout (PerfectFit)+Get Coverage'
         WHEN cr.id = 8668696 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_Detroit_1x1_:15 Workout (PerfectFit)+Find A Plan'
         WHEN cr.id = 8668706 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_Detroit_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
         WHEN cr.id = 8668716 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_Detroit_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668866 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_Detroit_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668796 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_Detroit_1x1_:15 Workout (PerfectFit)+Find A Plan'
       WHEN cr.id = 8668936 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_Detroit_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668726 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_Detroit_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668946 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_Detroit_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668736 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_Detroit_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
         WHEN cr.id = 8668876 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_Detroit_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668806 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_Detroit_1x1_:15 Workout (PerfectFit)+Find A Plan'
       WHEN cr.id = 8668886 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_Detroit_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668816 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_Detroit_1x1_:15 Workout (PerfectFit)+Find A Plan'
       WHEN cr.id = 8668956 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_Detroit_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668746 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_Detroit_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668896 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_GrandRapids_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668826 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_GrandRapids_1x1_:15 Workout (PerfectFit)+Find A Plan'
       WHEN cr.id = 8668966 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668756 THEN 'PH_Tremor_OLVAllScreen_Lifestyle&HealthyLiving_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668906 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_GrandRapids_1x1_:15 Workout (PerfectFit)+Get Coverage'
         WHEN cr.id = 8668836 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_GrandRapids_1x1_:15 Workout (PerfectFit)+Find A Plan'
         WHEN cr.id = 8668976 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668766 THEN 'PH_Tremor_OLVAllScreen_TalkShow&MentalHealth_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668916 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_GrandRapids_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668846 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_GrandRapids_1x1_:15 Workout (PerfectFit)+Find A Plan'
       WHEN cr.id = 8668986 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
       WHEN cr.id = 8668776 THEN 'PH_Tremor_OLVAllScreen_Sports&Active_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
       WHEN cr.id = 8668926 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_GrandRapids_1x1_:15 Workout (PerfectFit)+Get Coverage'
       WHEN cr.id = 8668856 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_GrandRapids_1x1_:15 Workout (PerfectFit)+Find A Plan'
         WHEN cr.id = 8668996 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Get Coverage'
         WHEN cr.id = 8668786 THEN 'PH_Tremor_OLVAllScreen_ConditionSpecific&Wellness_GrandRapids_1x1_:15 Skate (LittleDaredevil)+Find A Plan'
           ELSE 'PH_Tremor_AllScreen_Retargeting_AllMarkets_:15' END AS "Creative Name",
    SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE c.flight_number IN ('F-300482','F-300486','F-300490','F-300497','F-300504','F-300508',
              'F-300512','F-300516','F-300520','F-300524','F-300528','F-300494','F-300498','F-300501','F-300505',
              'F-300509','F-300513','F-300517','F-300521','F-300525','F-300529','F-300568','F-300495','F-300499',
              'F-300502','F-300506','F-300510','F-300514','F-300518','F-300522','F-300526','F-300530','F-300569')
  AND date >= '2022-09-15'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  AND c.buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
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
