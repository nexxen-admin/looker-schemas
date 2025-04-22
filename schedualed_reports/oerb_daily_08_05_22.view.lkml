view: oerb_daily_08_05_22 {
  derived_table: {
    sql: SELECT date::date AS "Date",
'Tremor Video' AS "Partner Name",
           c.campaign_id AS "Campaign ID",
           c.campaign_name AS "Campaign Name",
           'Self Service' AS "Service Type",
           c.advertiser_name AS "Advertiser Name",
           add2.flight_id AS "Flight ID",
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
      WHERE add2.flight_id IN (4366656,4366666,4366696,4366836,4366856,4366956,4366966,4367126,4367166,4367276)
          AND date > '2022-07-01'
          AND impressions > 0
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

  dimension: flight_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}."Flight ID" ;;
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

  dimension: screen_type {
    type: string
    label: "Screen Type"
    sql: ${TABLE}."Screen Type" ;;
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
      flight_id,
      advertiser_name,
      partner_name,
      campaign_name,
      screen_type,
      placement_name,
      service_type,
      campaign_id,
      impressions,
      clicks,
      completions,
      revenue,
      e_cpm
    ]
  }
}
