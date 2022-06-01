view: california_tobacco_control_program_flavors_06_01_22 {
  derived_table: {
    sql: WITH svc_california_tobacco_control_program__flavors_mapping AS (
      SELECT id as tvdsp_creative_id,
           name as tvdsp_creative_name,
           CASE WHEN id = 8547956 THEN '6526515'
               WHEN id = 8547946 THEN '6526514'
                  ELSE '6526508' END AS ft_placement_id,
           CASE WHEN id = 8547956 THEN '30S_NON-SKIP_WORTHWHILE-MOMENTS_WANP'
               WHEN id = 8547946 THEN 'DC_CTCP_2022_Q2_FLAVORS-WANP_MC_EN_TREMOR_STATEWIDE_VIDEO_CTV_INCITE-EDUCATE_CPM_1x1IMP_3P_CHANGEMAKERS-OR-PARENTS-A30+_30S_NON-SKIP_BTS-KITO_WANP'
                 ELSE '30S_NON-SKIP_BTS-YAZMIN_WANP' END AS ft_placement_name,
           CASE WHEN id = 8547956 THEN 'Worthwhile Moments QR Code'
                WHEN id = 8547946 THEN 'BTS Kito QR Code'
                  ELSE 'BTS Yazmin QR Code' END AS ft_creative_name,
           '183209' AS ft_campaign_id,
           'DC_CTCP_2022_Q2_FLAVORS-WANP_MC_AAB_EN' AS ft_campaign_name
      FROM dwh.creative c
      WHERE id IN (8547956, 8547946, 8547936)
      GROUP BY 1,2,3,4,5,6,7
      )

      Select date::date as 'DATE',
      d.ft_campaign_name as "CAMPAIGN NAME",
      d.ft_campaign_id as "CAMPAIGN ID",
      d.ft_placement_name as "PLACEMENT NAME",
      d.ft_placement_id as "PLACEMENT ID",
      d.ft_creative_name as "CREATIVE",
      '' as "CREATIVE ID",
      sum(ad.impressions) as 'IMPRESSIONS',
      sum(ad.clicks) as 'CLICKS',
      sum(ad.progress0) as "QUARTILE 0",
      sum(ad.progress100) as "COMPLETIONS"
      From dwh.ad_data_daily ad
      inner join svc_california_tobacco_control_program__flavors_mapping d on d.tvdsp_creative_id = ad.creative_id::varchar
      left outer join dwh.campaign c on c.flight_id = ad.flight_id
      Where date >= '2022-05-23'
      and date < current_date()
      and data_type = 'AD_DATA'
      and buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
      Group by 1, 2, 3, 4, 5, 6, 7
      Order by 1, 2, 3, 4, 5, 6
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "DATE"
    sql: ${TABLE}."DATE" ;;
    html: {{ rendered_value | date: "%F" }} ;;
  }

  dimension: campaign_name {
    type: string
    label: "CAMPAIGN NAME"
    sql: ${TABLE}."CAMPAIGN NAME" ;;
  }

  dimension: campaign_id {
    type: string
    label: "CAMPAIGN ID"
    sql: ${TABLE}."CAMPAIGN ID" ;;
  }

  dimension: placement_name {
    type: string
    label: "PLACEMENT NAME"
    sql: ${TABLE}."PLACEMENT NAME" ;;
  }

  dimension: placement_id {
    type: string
    label: "PLACEMENT ID"
    sql: ${TABLE}."PLACEMENT ID" ;;
  }

  dimension: creative {
    type: string
    label: "CREATIVE"
    sql: ${TABLE}.CREATIVE ;;
  }

  dimension: creative_id {
    type: string
    label: "CREATIVE ID"
    sql: ${TABLE}."CREATIVE ID" ;;
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

  dimension: quartile_0 {
    type: number
    label: "QUARTILE 0"
    sql: ${TABLE}."QUARTILE 0" ;;
  }

  dimension: completions {
    type: number
    label: "COMPLETIONS"
    sql: ${TABLE}.COMPLETIONS ;;
  }

  set: detail {
    fields: [
      date,
      campaign_name,
      campaign_id,
      placement_name,
      placement_id,
      creative,
      creative_id,
      impressions,
      clicks,
      quartile_0,
      completions
    ]
  }
}
