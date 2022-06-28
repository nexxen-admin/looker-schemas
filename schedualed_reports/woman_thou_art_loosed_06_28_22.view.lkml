view: woman_thou_art_loosed_06_28_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
           '[c14632] WTAL - OTT' AS "Custom Campaign Name",
           c.campaign_name AS "Campaign Name",
           add2.flight_id AS "Placement ID",
           c.flight_number AS "Flight Number",
           SUM(impressions) AS "Impressions",
           SUM(completions) AS "Completions",
           SUM(completions)/SUM(impressions) AS "Completions Rate",
           SUM(clicks) AS "Clicks",
           SUM(clicks)/SUM(impressions) AS "CTR",
           CASE WHEN c.flight_number IN ('F-288123', 'F-288404', 'F-288405', 'F-288406') THEN (SUM(impressions)/1000)*25
               ELSE (SUM(impressions)/1000)*32.50 END AS "Spend",
           SUM(placement_reach) AS "Reach",
           SUM(impressions)/SUM(placement_reach) AS "Frequency"
      FROM dwh.ad_data_daily add2
        LEFT JOIN dwh.campaign c on add2.flight_id = c.flight_id
      WHERE date >= '2022-06-15'
        AND date < CURRENT_DATE()
        AND add2.flight_id IN (4351966, 4351986, 4351996, 4352006, 4352016, 4352056, 4352086, 4352096)
      GROUP BY 1,2,3,4,5
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

  dimension: custom_campaign_name {
    type: string
    label: "Custom Campaign Name"
    sql: ${TABLE}."Custom Campaign Name" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
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
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
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
  }

  dimension: frequency {
    type: number
    label: "Frequency"
    sql: ${TABLE}.Frequency ;;
  }

  set: detail {
    fields: [
      date,
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
