view: aep_ohio_weekly_4_22_22 {
  derived_table: {
    sql: SELECT  date::date as "Date",
        flight_id as "Flight ID",
        CASE WHEN flight_id = 4280666 THEN 'AS0097157_L00143287_F-278028_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280676 THEN 'AS0097157_L00143287_F-278037_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280696 THEN 'AS0097157_L00143287_F-278039_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280786 THEN 'AS0097157_L00143287_F-278041_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280826 THEN 'AS0097157_L00143287_F-278045_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280866 THEN 'AS0097157_L00143287_F-278043_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280886 THEN 'AS0097157_L00143287_F-278047_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280896 THEN 'AS0097157_L00143287_F-278052_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280916 THEN 'AS0097157_L00143287_F-278056_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4280946 THEN 'AS0097157_L00143287_F-278054_AEPOhio_CTV_CPM_SS_30_BT_SYND_ZIPs_0406'
                         WHEN flight_id = 4281506 THEN 'AS0097157_L00143288_F-278030_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281626 THEN 'AS0097157_L00143288_F-278060_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281636 THEN 'AS0097157_L00143288_F-278062_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281696 THEN 'AS0097157_L00143288_F-278064_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281726 THEN 'AS0097157_L00143288_F-278068_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281746 THEN 'AS0097157_L00143288_F-278066_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281756 THEN 'AS0097157_L00143288_F-278072_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281766 THEN 'AS0097157_L00143288_F-278070_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281776 THEN 'AS0097157_L00143288_F-278076_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281786 THEN 'AS0097157_L00143288_F-278074_AEPOhio_AllScreen_CPM_SS_30_BT_SYND_ZIPs_AllStream_0406'
                         WHEN flight_id = 4281816 THEN 'AS0097157_L00143290_F-278034_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281826 THEN 'AS0097157_L00143290_F-278094_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281836 THEN 'AS0097157_L00143290_F-278098_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281846 THEN 'AS0097157_L00143290_F-278096_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281856 THEN 'AS0097157_L00143290_F-278100_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281866 THEN 'AS0097157_L00143290_F-278102_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281876 THEN 'AS0097157_L00143290_F-278113_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281886 THEN 'AS0097157_L00143290_F-278111_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         WHEN flight_id = 4281896 THEN 'AS0097157_L00143290_F-278117_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406'
                         ELSE 'AS0097157_L00143290_F-278115_AEPOhio_CTV_CPM_SS_30_BT_TVRTG_ZIPs_0406' END AS "Placement Name",
        CASE WHEN creative_id = 8507696 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63266_CTV'
                        WHEN creative_id = 8507766 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63267_CTV'
                        WHEN creative_id = 8507776 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63268_CTV'
                        WHEN creative_id = 8507796 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63269_CTV'
                        WHEN creative_id = 8507806 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63270_CTV'
                        WHEN creative_id = 8507816 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63271_CTV'
                        WHEN creative_id = 8507836 THEN 'AS0097157_L00143287_L00143290_AEPOhio_AA-63272_CTV'
                        WHEN creative_id = 8507906 THEN 'AS0097157_L00143288_AEPOhio_AA-63266_DMT'
                        WHEN creative_id = 8507916 THEN 'AS0097157_L00143288_AEPOhio_AA-63267_DMT'
                        WHEN creative_id = 8507926 THEN 'AS0097157_L00143288_AEPOhio_AA-63268_DMT'
                        WHEN creative_id = 8507946 THEN 'AS0097157_L00143288_AEPOhio_AA-63269_DMT'
                        WHEN creative_id = 8507966 THEN 'AS0097157_L00143288_AEPOhio_AA-63270_DMT'
                        WHEN creative_id = 8507976 THEN 'AS0097157_L00143288_AEPOhio_AA-63271_DMT'
                      ELSE 'AS0097157_L00143288_AEPOhio_AA-63272_DMT' END as "Creative Name",
        CASE WHEN flight_id IN (4280916, 4280946, 4281896, 4281926, 4281776, 4281786) THEN 'SWEPCO'
                  WHEN flight_id IN (4280886, 4280896, 4281876, 4281886, 4281756, 4281766) THEN 'PSO'
                  WHEN flight_id IN (4280826, 4280866, 4281856, 4281866, 4281726, 4281746) THEN 'INMI'
                  WHEN flight_ID IN (4280696, 4280786, 4281836, 4281846, 4281636, 4281696) THEN 'Appalachian Power'
                  ELSE 'AEP Ohio' END as "Audience",
        CASE WHEN flight_id IN(4280826, 4280916, 4280896, 4280676, 4280786,
                     4281876, 4281836, 4281896, 4281826, 4281866,
                     4281696, 4281776, 4281726, 4281626, 4281756) THEN 'Millennial/GenZ' ELSE 'Boomers/GenX' END as "BT Targeting",
        SUM(impressions) as "Impressions",
        SUM(clicks) as "Clicks",
        (SUM(clicks)/SUM(impressions)) as "CTR",
        SUM(completions) as "Completions",
        (SUM(completions)/SUM(impressions)) as "Completions Rate"
FROM dwh.ad_data_daily add2
WHERE date >= '2022-04-06'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4280696, 4280826, 4280886, 4280916,
            4280666, 4280896, 4280946, 4280676,
            4280786, 4280866, 4281876, 4281836,
            4281816, 4281846, 4281896, 4281886,
            4281856, 4281826, 4281866, 4281926,
            4281636, 4281696, 4281776, 4281726,
            4281746, 4281506, 4281626, 4281756,
            4281786, 4281766)
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
    sql: ${TABLE}."Date" ;;
  }

  dimension: flight_id {
    type: number
    label: "Flight ID"
    sql: ${TABLE}."Flight ID" ;;
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

  dimension: audience {
    type: string
    sql: ${TABLE}.Audience ;;
  }

  dimension: bt_targeting {
    type: string
    label: "BT Targeting"
    sql: ${TABLE}."BT Targeting" ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: ctr {
    type: number
    sql: ${TABLE}.CTR ;;
  }

  dimension: completions {
    type: number
    sql: ${TABLE}.Completions ;;
  }

  dimension: completions_rate {
    type: number
    label: "Completions Rate"
    sql: ${TABLE}."Completions Rate" ;;
  }

  set: detail {
    fields: [
      date,
      flight_id,
      placement_name,
      creative_name,
      audience,
      bt_targeting,
      impressions,
      clicks,
      ctr,
      completions,
      completions_rate
    ]
  }
}
