view: the_north_face_phase_1_bi_weekly_11_04_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT Date_Key::date as date,
           df.Flight_ID AS "Flight ID",
           c.Campaign_Name AS "Campaign Name",
           dc.Country_Name AS "Country",
           st.Screen_Type_Name as "Screen Type",
           SUM(impressions) as "Impressions",
           SUM(Completions) AS "Video Completes",
           SUM(Placement_Reach) AS "Reach"
      FROM BI_TVDSP.Fact_Ad_Events_Daily add2
        INNER JOIN BI_TVDSP.Dim_Flight df on add2.Flight_Key = df.Flight_Key
        INNER JOIN BI_TVDSP.Dim_Campaign c on c.Campaign_Key = df.Campaign_Key
        INNER JOIN BI_TVDSP.Dim_Country dc  on add2.Country_Key = dc.Country_Key
        INNER JOIN BI_TVDSP.Dim_Screen_Type st on add2.Screen_Type_Key = st.Screen_Type_Key
      WHERE Date_Key >= '2022-10-03'
        AND Date_Key < CURRENT_DATE()
        AND df.Flight_ID IN (4451416,4451426,4451456,4451476,4474336,4474346,4474356)
      GROUP BY 1,2,3,4,5
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
    sql: ${TABLE}."date" ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: flight_id {
    type: number
    label: "Flight ID"
    sql: ${TABLE}."Flight ID" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: country {
    type: string
    label: "Market"
    sql: ${TABLE}.Country ;;
  }

  dimension: screen_type {
    type: string
    label: "Channel"
    sql: ${TABLE}."Screen Type" ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: video_completes {
    type: number
    label: "Video Completes"
    sql: ${TABLE}."Video Completes" ;;
  }

  dimension: reach {
    type: number
    label: "Reach"
    sql: ${TABLE}.Reach ;;
  }

  set: detail {
    fields: [
      date,
      flight_id,
      campaign_name,
      country,
      screen_type,
      impressions,
      video_completes,
      reach
    ]
  }
}
