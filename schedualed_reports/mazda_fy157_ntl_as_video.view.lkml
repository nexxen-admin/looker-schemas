view: mazda_fy157_ntl_as_video {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: Select date::date as Event_Date,
        'FY157_NTL_AS_Video' as Campaign,
        ad.flight_id,
        ad.creative_id,
        ad.screen_type,
        Case when ad.screen_type in ('2','3','-1') then bi.DCM_Mobile_PI
          else bi.DCM_Desktop_PI end as DCM_Placement_ID,
        Case when ad.screen_type in ('2','3','-1') then bi.DCM_Mobile_Placement_Name
          else bi.DCM_Desktop_Placement_Name end as DCM_Placement_Name,
        DCM_Package_ID,
        DCM_Package_Name,
        case when cr.name ilike '%AA-70618%' then 'MAZDA CX-50 DGM 2 FEATURE BUILD & PRICE'
          when cr.name ilike '%AA-70620%' then 'MAZDA CX-50 DGM 1 FEATURE BUILD & PRICE'
          when cr.name ilike '%AA-70621%' then 'MAZDA CX-50 DGM 2 FEATURE DISCOVER MORE'
          when cr.name ilike '%AA-70622%' then 'MAZDA CX-50 DGM 1 FEATURE DISCOVER MORE'
          else '-' end as creative_name,
        case when line_number = 'L00142933' then 25.50
          when line_number = 'L00142934' then 19
          when line_number = 'L00143242' then 18
          else 0 end as CPM,
        sum(ad.impressions) as Impressions,
        sum(ad.completions) as Completions,
        sum(clicks) as Clicks,
        sum(ad.progress25) as "25% Video Finish",
        sum(ad.progress50) as "50% Video Finish",
        sum(ad.progress75) as "75% Video Finish",
        sum(ad.progress100) as "100% Video Finish",
        (sum(ad.impressions)/1000) *
        case when line_number = 'L00142933' then 25.50
          when line_number = 'L00142934' then 19
          when line_number = 'L00143242' then 18
          else 0 end  as Spend
      From dwh.ad_data_daily ad
        inner join dwh.campaign c on c.flight_id = ad.flight_id
        left outer join dwh.creative cr on cr.id = ad.creative_id
        left outer join bi.SVC_Mazda_FY157_Mapping bi on bi.flight_id = ad.flight_id
                              and bi.creative_id = ad.creative_id
      Where ad.date >= current_date()-30
        and ad.date < current_date()
        and data_type = 'AD_DATA'
        --and c.campaign_id = '4272906'
        and c.campaign_id in ('4363916',
                              '4363946',
                              '4363986',
                              '4364046',
                              '4364096',
                              '4364186',
                              '4364296',
                              '4364426',
                              '4365596',
                              '4365676',
                              '4367356',
                              '4368726',
                              '4368966',
                              '4370636',
                              '4372146')
        and ad.impressions > 0
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    label: "Date"
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: campaign {
    type: string
    label: "Campaign"
    sql: ${TABLE}.Campaign ;;
  }

  dimension: flight_id {
    type: number
    sql: ${TABLE}.flight_id ;;
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }

  dimension: screen_type {
    type: number
    sql: ${TABLE}.screen_type ;;
  }

  dimension: dcm_placement_id {
    type: number
    label: "DCM Placement ID"
    sql: ${TABLE}.DCM_Placement_ID ;;
  }

  dimension: dcm_placement_name {
    type: string
    label: "DCM Placement Name"
    sql: ${TABLE}.DCM_Placement_Name ;;
  }

  dimension: dcm_package_id {
    type: number
    label: "DCM Package ID"
    sql: ${TABLE}.DCM_Package_ID ;;
  }

  dimension: dcm_package_name {
    type: string
    label: "DCM Package Name"
    sql: ${TABLE}.DCM_Package_Name ;;
  }

  dimension: ad_group {
    type: string
    label: "Ad Group"
    sql: ${TABLE}.Ad_Group ;;
  }

  dimension: creative_name {
    type: string
    label: "Creative"
    sql: ${TABLE}.creative_name ;;
  }

  dimension: cpm {
    type: number
    label: "CPM"
    sql: ${TABLE}.CPM ;;
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

  dimension: 25_video_finish {
    type: number
    label: "25% Video Finish"
    sql: ${TABLE}."25% Video Finish" ;;
  }

  dimension: 50_video_finish {
    type: number
    label: "50% Video Finish"
    sql: ${TABLE}."50% Video Finish" ;;
  }

  dimension: 75_video_finish {
    type: number
    label: "75% Video Finish"
    sql: ${TABLE}."75% Video Finish" ;;
  }

  dimension: 100_video_finish {
    type: number
    label: "100% Video Finish"
    sql: ${TABLE}."100% Video Finish" ;;
  }

  dimension: spend {
    type: number
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [
      event_date,
      campaign,
      flight_id,
      creative_id,
      screen_type,
      dcm_placement_id,
      dcm_placement_name,
      ad_group,
      creative_name,
      cpm,
      impressions,
      completions,
      clicks,
      25_video_finish,
      50_video_finish,
      75_video_finish,
      100_video_finish,
      spend
    ]
  }
}
