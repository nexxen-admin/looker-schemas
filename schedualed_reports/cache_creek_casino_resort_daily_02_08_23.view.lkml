view: cache_creek_casino_resort_daily_02_08_23 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT faeda.Date_Key::date as "Date",
           'Tremor Video' AS "Partner Name",
           dc.Campaign_ID AS "Campaign ID",
           dc.Campaign_Name AS "Campaign Name",
           'Self Service' AS "Service Type",
           df.Flight_ID AS "Placement ID",
           df.Flight_Name AS "Placement Name",
           dst.Screen_Type_Name AS "Screen Type",
           SUM(faeda.sum_of_Impressions) AS "Impressions",
           SUM(faeda.sum_of_Clicks) AS "Clicks",
           SUM(faeda.sum_of_Completions) AS "Completions",
           SUM(faeda.sum_of_Revenue + faeda.sum_of_Cost_Data + faeda.sum_of_Cost_Partner + faeda.sum_of_Cost_Platform) AS "Revenue",
           (SUM(faeda.sum_of_Revenue + faeda.sum_of_Cost_Data + faeda.sum_of_Cost_Partner + faeda.sum_of_Cost_Platform)/SUM(sum_of_Impressions))*1000 AS "eCPM"
      FROM BI_TVDSP.Fact_Ad_Events_Daily_Agg faeda
        INNER JOIN BI_TVDSP.Dim_Flight df on faeda.Flight_Key = df.Flight_Key
        INNER JOIN BI_TVDSP.Dim_Campaign dc on df.Campaign_Key = dc.Campaign_Key
        INNER JOIN BI_TVDSP.Dim_Screen_Type dst on faeda.Screen_Type_Key = dst.Screen_Type_Key
      WHERE df.flight_ID IN (4540266, 4540276, 4540236, 4540216, 4540246, 4540226)
        AND faeda.Date_Key >= '2023-01-04'
        AND faeda.Date_Key < CURRENT_DATE()
        AND faeda.sum_of_Impressions > 0
      GROUP BY 1,2,3,4,5,6,7,8
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

  dimension: partner_name {
    type: string
    label: "Partner Name"
    sql: ${TABLE}."Partner Name" ;;
  }

  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    sql: ${TABLE}."Campaign ID" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: service_type {
    type: string
    label: "Service Type"
    sql: ${TABLE}."Service Type" ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
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
      partner_name,
      campaign_id,
      campaign_name,
      service_type,
      placement_id,
      placement_name,
      screen_type,
      impressions,
      clicks,
      completions,
      revenue,
      e_cpm
    ]
  }
}
