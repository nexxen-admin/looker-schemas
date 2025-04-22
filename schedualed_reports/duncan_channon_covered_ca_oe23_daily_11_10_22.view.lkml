view: duncan_channon_covered_ca_oe23_daily_11_10_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: Select date::date as "Date",
        'FY22-23 Open Enrollment (OE22)' as "Campaign Name",
        '4481866' as "Campaign ID",
        ad.flight_id as "Flight ID",
        c.flight_number as "Flight_Number",
        CASE WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_SocialUnifiedData+In-Market+&A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_SocialUnifiedData+In-Market+&A25-64_ForYou+Dec31_'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_SocialUnifiedData+In-Market+&A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_SocialUnifiedData+In-Market+&A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_ForYou+Dec31_'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_ForYou+Dec31_'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_ForYou+Dec31_'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Both+Dec31_'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_ForYou+Dec31_'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Heart+Dec31_'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Invisible+Dec31_'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667286 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667266 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667276 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Uninsured_TVIntelligenceReach+LinearTVSpotSuppression+&A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_CordCutters+&A25-64_Both+Dec31_'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_CordCutters+&A25-64_ForYou+Dec31_'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_CordCutters+&A25-64_Heart+Dec31_'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Uninsured_CordCutters+&A25-64_Invisible+Dec31_'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Both+Dec31_'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_ForYou+Dec31_'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Heart+Dec31_'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Invisible+Dec31_'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667286 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Both+Dec31_'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667266 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Heart+Dec31_'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667276 THEN 'DC_CC_FY22_OE23_AA_English_Tremor_CA_Video_Cross_15s_Awareness_CPM_SS_VCR_Behavioral_Prospecting_Broad_TVIntelligenceReach+LinearTVSpotSuppression+SuppressUninsured+&A25-64&HHI25k+_Invisible+Dec31_'
           WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_Cordcutters+SuppressUninsured+&A25-64&HHI25k+_Both+Dec31_'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_Cordcutters+SuppressUninsured+&A25-64&HHI25k+_ForYou+Dec31_'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_Cordcutters+SuppressUninsured+&A25-64&HHI25k+_Heart+Dec31_'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666216 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_Cordcutters+SuppressUninsured+&A25-64&HHI25k+_Invisible+Dec31_'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666226 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Both+Dec31_'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666196 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_ForYou+Dec31_'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666206 THEN 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Heart+Dec31_'
           ELSE 'DC_CC_FY22_OE23_MC_English_Tremor_CA_CTV_CTV_30s_Awareness_CPM_SS_IR_Behavioral_Prospecting_Broad_SuppressUninsured+&A25-64&HHI25k+_Invisible+Dec31_ ' END AS "Placement Name",
       CASE WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666226 THEN '6871637'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666196 THEN '6871634'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666206 THEN '6871635'
           WHEN ad.flight_id = 4482246 AND c.flight_Number = 'F-303973' AND ad.creative_id = 8666216 THEN '6871636'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666226 THEN '6871649'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666196 THEN '6871646'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666206 THEN '6871647'
           WHEN ad.flight_id = 4482226 AND c.flight_Number = 'F-303974' AND ad.creative_id = 8666216 THEN '6871648'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666226 THEN '6871629'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666196 THEN '6871626'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666206 THEN '6871627'
           WHEN ad.flight_id = 4481916 AND c.flight_Number = 'F-303956' AND ad.creative_id = 8666216 THEN '6871628'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666226 THEN '6871750'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666196 THEN '6871747'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666206 THEN '6871748'
           WHEN ad.flight_id = 4482236 AND c.flight_Number = 'F-303971' AND ad.creative_id = 8666216 THEN '6871749'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666226 THEN '6871653'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666196 THEN '6871650'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666206 THEN '6871651'
           WHEN ad.flight_id = 4482186 AND c.flight_Number = 'F-303975' AND ad.creative_id = 8666216 THEN '6871652'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667286 THEN '6871757'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667266 THEN '6871755'
           WHEN ad.flight_id = 4482276 AND c.flight_Number = 'F-303976' AND ad.creative_id = 8667276 THEN '6871756'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666226 THEN '6871641'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666196 THEN '6871638'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666206 THEN '6871639'
           WHEN ad.flight_id = 4482216 AND c.flight_Number = 'F-303969' AND ad.creative_id = 8666216 THEN '6871640'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666226 THEN '6871754'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666196 THEN '6871751'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666206 THEN '6871752'
           WHEN ad.flight_id = 4482196 AND c.flight_Number = 'F-303972' AND ad.creative_id = 8666216 THEN '6871753'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667286 THEN '6871760'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667266 THEN '6871758'
           WHEN ad.flight_id = 4482266 AND c.flight_Number = 'F-303977' AND ad.creative_id = 8667276 THEN '6871759'
           WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666226 THEN '6871645'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666196 THEN '6871642'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666206 THEN '6871643'
            WHEN ad.flight_id = 4482256 AND c.flight_Number = 'F-303970' AND ad.creative_id = 8666216 THEN '6871644'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666226 THEN '6871633'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666196 THEN '6871630'
            WHEN ad.flight_id = 4482206 AND c.flight_Number = 'F-303968' AND ad.creative_id = 8666206 THEN '6871631'
           ELSE '6871632' END AS "Placement ID",
        CASE WHEN ad.creative_id = 8666196 THEN 'For You :30'
           WHEN ad.creative_id = 8666206 THEN 'Heart :30'
           WHEN ad.creative_id = 8666216 THEN 'Invisible :30'
           WHEN ad.creative_id = 8666226 THEN 'Both :30'
           WHEN ad.creative_id = 8667266 THEN 'Heart :15'
           WHEN ad.creative_id = 8667276 THEN 'Invisible :15'
       ELSE 'Both :15' END AS "Creative Name",
        sum(ad.impressions) as "Impressions",
        sum(ad.clicks) as "Clicks",
        sum(ad.progress0) as "Quartile 0",
        sum(ad.completions) as "Completions"
From dwh.ad_data_daily ad
      left outer join dwh.campaign c on c.flight_id = ad.flight_id
Where date >= '2022-11-01'
      and date < current_date()
      and ad.flight_id IN (4482246, 4482226, 4481916, 4482236, 4482186, 4482276, 4482216, 4482196, 4482266, 4482256, 4482206)
       and data_type = 'AD_DATA'
       and buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
Group by 1, 2, 3, 4, 5, 6, 7, 8
Order by 1 ASC
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

  dimension: campaign_name {
    type: string
    label: "CAMPAIGN NAME"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: campaign_id {
    type: string
    label: "CAMPAIGN ID"
    sql: ${TABLE}."Campaign ID" ;;
  }

  dimension: flight_id {
    type: number
    label: "FLIGHT ID"
    sql: ${TABLE}."Flight ID" ;;
  }

  dimension: flight_number {
    type: string
    label: "FLIGHT NUMBER"
    sql: ${TABLE}.Flight_Number ;;
  }

  dimension: placement_name {
    type: string
    label: "PLACEMENT NAME"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: placement_id {
    type: string
    label: "PLACEMENT ID"
    sql: ${TABLE}."Placement ID" ;;
  }

  dimension: creative_name {
    type: string
    label: "CREATIVE NAME"
    sql: ${TABLE}."Creative Name" ;;
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

  dimension: quartile_0 {
    type: number
    label: "QUARTILE 0"
    sql: ${TABLE}."Quartile 0" ;;
  }

  dimension: completions {
    type: number
    label: "COMPLETIONS"
    sql: ${TABLE}.Completions ;;
  }

  set: detail {
    fields: [
      date,
      campaign_name,
      campaign_id,
      flight_id,
      flight_number,
      placement_name,
      placement_id,
      creative_name,
      impressions,
      clicks,
      quartile_0,
      completions
    ]
  }
}
