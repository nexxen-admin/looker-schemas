view: duncan_channon_covered_ca {
  derived_table: {
    sql: Select date::date as 'DATE',
        'FY22 Special Enrollment (SE22)' as "CAMPAIGN NAME",
        '174057' as "CAMPAIGN ID",
        d.ft_placement_name as "PLACEMENT NAME",
        d.ft_placement_id as "PLACEMENT ID",
        d.ft_creative_name as "CREATIVE",
        '' as "CREATIVE ID",
        sum(ad.impressions) as 'IMPRESSIONS',
        sum(ad.clicks) as 'CLICKS',
        sum(ad.progress0) as "QUARTILE 0",
        sum(ad.progress100) as "COMPLETIONS"
      From dwh.ad_data_daily ad
        inner join bi.svc_di_covered_california_mapping d on d.tvdsp_creative_id = ad.creative_id::varchar
        left outer join dwh.campaign c on c.flight_id = ad.flight_id
      Where date >= '2022-02-01'
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
    sql: ${TABLE}."DATE"
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
    sql: ${TABLE}.CREATIVE ;;
  }

  dimension: creative_id {
    type: string
    label: "CREATIVE ID"
    sql: ${TABLE}."CREATIVE ID" ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: quartile_0 {
    type: number
    label: "QUARTILE 0"
    sql: ${TABLE}."QUARTILE 0" ;;
  }

  dimension: completions {
    type: number
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
