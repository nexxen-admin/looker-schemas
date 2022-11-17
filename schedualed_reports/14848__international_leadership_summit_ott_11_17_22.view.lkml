view: 14848__international_leadership_summit_ott_11_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
           TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
           '[14849] International Leadership Summit – OTT' AS "Custom Campaign Name",
           c.campaign_name AS "Campaign Name",
           add2.flight_id AS "Placement ID",
           c.flight_number AS "Flight Number",
           SUM(impressions) AS "Impressions",
           SUM(completions) AS "Completions",
           SUM(completions)/SUM(impressions) AS "Completions Rate",
           SUM(clicks) AS "Clicks",
           SUM(clicks)/SUM(impressions) AS "CTR",
           (SUM(impressions)/1000)*25 AS "Spend",
           SUM(placement_reach) AS "Reach",
           SUM(impressions)/SUM(placement_reach) AS "Frequency"
      FROM dwh.ad_data_daily add2
        LEFT JOIN dwh.campaign c on add2.flight_id = c.flight_id
        left outer join dwh.dma dma on dma.dma_code = add2.dma
      WHERE date >= '2022-11-15'
        AND date < CURRENT_DATE()
        AND data_type = 'AD_DATA'
        AND c.buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
        AND c.flight_id = 4492796
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
    label: "Date"
    sql: ${TABLE}."Date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: dma {
    type: string
    label: "DMA"
    sql: ${TABLE}.DMA ;;
  }

  dimension: custom_campaign_name {
    type: string
    label: "Custom Campaign Name"
    sql: ${TABLE}."Custom Campaign Name" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
    value_format: "0"
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}."Flight Number" ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
    value_format: "0"
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
    value_format: "0"
  }

  dimension: completions_rate {
    type: number
    label: "Completions Rate"
    sql: ${TABLE}."Completions Rate" ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: ctr {
    type: number
    label: "CTR"
    sql: ${TABLE}.CTR ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  dimension: reach {
    type: number
    label: "Reach"
    sql: ${TABLE}.Reach ;;
    value_format: "0"
  }

  dimension: frequency {
    type: number
    label: "Frequency"
    sql: ${TABLE}.Frequency ;;
  }

  set: detail {
    fields: [
      date,
      dma,
      custom_campaign_name,
      campaign_name,
      placement_id,
      flight_number,
      impressions,
      completions,
      completions_rate,
      clicks,
      ctr,
      spend,
      reach,
      frequency
    ]
  }
}
