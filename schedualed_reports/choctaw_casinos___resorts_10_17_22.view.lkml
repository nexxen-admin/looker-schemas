view: choctaw_casinos___resorts_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql:
SELECT date::date AS "Date",
     'Tremor Video' AS "Partner Name",
     c.campaign_id AS "Campaign ID",
     c.campaign_name AS "Campaign Name",
     'Self Service' AS "Service Type",
     c.advertiser_name AS "Advertiser Name",
       add2.flight_id AS "Placement ID",
       c.flight_name AS "Placement Name",
       st.screen_type_name AS "Screen Type",
       SUM(impressions) AS "Impressions",
       SUM(clicks) AS "Clicks",
       SUM(completions) AS "Completions",
       SUM(revenue + cost_data + cost_partner + cost_platform) AS "Revenue",
       (SUM(revenue + cost_data + cost_partner + cost_platform)/SUM(impressions))*1000 AS "eCPM"
FROM dwh.ad_data_daily add2
  left join dwh.campaign c on add2.flight_id = c.flight_id
    left join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE add2.flight_id IN (4454276,4454286,4454346,4454376,4454396,4454426,4455616,4459136,
                     4459146,4460086,4460096,4460106,4460136,4453536,4453566,4453596,4453616,4455496,
                     4459096,4454476,4454486,4454496,4454506,4455566,4455606,4459406, 4459416, 4459436)
      AND date >= '2022-10-04'
      AND date < CURRENT_DATE()
      AND impressions > 0
      AND data_type = 'AD_DATA'
      AND buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
GROUP BY 1,2,3,4,5,6,7,8,9
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

  dimension: placement_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser"
    sql: ${TABLE}."Advertiser Name" ;;
  }

  dimension: partner_name {
    type: string
    label: "Partner"
    sql: ${TABLE}."Partner Name" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: service_type {
    type: string
    label: "Service Type"
    sql: ${TABLE}."Service Type" ;;
  }

  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    sql: ${TABLE}."Campaign ID" ;;
  }

  dimension: screen_type {
    type: string
    label: "Screen Type"
    sql: ${TABLE}."Screen Type" ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: revenue {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Revenue ;;
  }

  dimension: e_cpm {
    type: number
    value_format: "#,##0.00"
    label: "eCPM"
    sql: ${TABLE}.eCPM ;;
  }

  set: detail {
    fields: [
      date,
      placement_id,
      advertiser_name,
      partner_name,
      campaign_name,
      placement_name,
      service_type,
      campaign_id,
      screen_type,
      impressions,
      clicks,
      completions,
      revenue,
      e_cpm
    ]
  }
}
