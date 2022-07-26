view: wisconsin_tourism_board_non_chicago_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT add2.date::date as date,
           c.advertiser_name,
           c.flight_number,
           CASE WHEN flight_number = 'F-279853' THEN '1077837590, 1077837589'
                 WHEN flight_number = 'F-279861' THEN '1077990594, 1077990593'
                 WHEN flight_number = 'F-279854' THEN '1077837592, 1077837591'
                 WHEN flight_number = 'F-279862' THEN '1077990600, 1077990599'
                 WHEN flight_number = 'F-279855' THEN '1077837594, 1077837593'
                 WHEN flight_number = 'F-279863' THEN '1077990606, 1077990605'
                 WHEN flight_number = 'F-279859' THEN '1077837604, 1077837603'
                 WHEN flight_number = 'F-279867' THEN '1077990636, 1077990635'
                 WHEN flight_number = 'F-279858' THEN '1077837602, 1077837601'
                 WHEN flight_number = 'F-279866' THEN '1077990630, 1077990629'
                 WHEN flight_number = 'F-279857' THEN '1077837600, 1077837599'
                 WHEN flight_number = 'F-279865' THEN '1077990624, 1077990623'
                 WHEN flight_number = 'F-279711' THEN '1077837598, 1077837597'
                 WHEN flight_number = 'F-279860' THEN '1077990618, 1077990617'
                 WHEN flight_number = 'F-279856' THEN '1077837596, 1077837595'
                 WHEN flight_number = 'F-279864' THEN '1077990612, 1077990611'
                 WHEN flight_number = 'F-279869' THEN '1077884163, 1077884162'
                 WHEN flight_number = 'F-279870' THEN '1077884155, 1077884154'
                 WHEN flight_number = 'F-279871' THEN '1077884157, 1077884156'
                 WHEN flight_number = 'F-279872' THEN '1077884159, 1077884158'
                 WHEN flight_number = 'F-279873' THEN '1077884161, 1077884160'
                 WHEN flight_number = 'F-279874' THEN '1077884165, 1077884164'
                 WHEN flight_number = 'F-279875' THEN '1077884167, 1077884166'
                 WHEN flight_number = 'F-279876' THEN '1077884169, 1077884168'
                 WHEN flight_number = 'F-279877' THEN '1077990684, 1077990683'
                 WHEN flight_number = 'F-279878' THEN '1077990660, 1077990659'
                 WHEN flight_number = 'F-279879' THEN '1077990666, 1077990665'
                 WHEN flight_number = 'F-279880' THEN '1077990672, 1077990671'
                 WHEN flight_number = 'F-279881' THEN '1077990678, 1077990677'
                 WHEN flight_number = 'F-279882' THEN '1077990690, 1077990689'
                 WHEN flight_number = 'F-279883' THEN '1077990696, 1077990695'
                 WHEN flight_number = 'F-279884' THEN '1077990702, 1077990701'
                 WHEN flight_number = 'F-279885' THEN '1077837582, 1077837581'
                 WHEN flight_number = 'F-279886' THEN '1077837574, 1077837573'
                 WHEN flight_number = 'F-279887' THEN '1077837576, 1077837575'
                 WHEN flight_number = 'F-279888' THEN '1077837578, 1077837577'
                 WHEN flight_number = 'F-279889' THEN '1077837580, 1077837579'
                 WHEN flight_number = 'F-279890' THEN '1077837584, 1077837583'
                 WHEN flight_number = 'F-279891' THEN '1077837586, 1077837585'
                 WHEN flight_number = 'F-279892' THEN '1077837588, 1077837587'
                 WHEN flight_number = 'F-279893' THEN '1077990570, 1077990569'
                 WHEN flight_number = 'F-279894' THEN '1077990546, 1077990545'
                 WHEN flight_number = 'F-279895' THEN '1077990552, 1077990551'
                 WHEN flight_number = 'F-279896' THEN '1077990558, 1077990557'
                 WHEN flight_number = 'F-279897' THEN '1077990564, 1077990563'
                 WHEN flight_number = 'F-279898' THEN '1077990576, 1077990575'
                 WHEN flight_number = 'F-279899' THEN '1077990582, 1077990581'
                 WHEN flight_number = 'F-279900' THEN '1077990588, 1077990587'
                 WHEN flight_number = 'F-279715' THEN '1077837608, 1077837607'
                 WHEN flight_number = 'F-279901' THEN '1077837606, 1077837605'
                 WHEN flight_number = 'F-279902' THEN '1077837610, 1077837609'
                 WHEN flight_number = 'F-279906' THEN '1077990648, 1077990647'
                 WHEN flight_number = 'F-279907' THEN '1077990642, 1077990641'
                 WHEN flight_number = 'F-279908' THEN '1077990654, 1077990653'
                 WHEN flight_number = 'F-279719' THEN '1077884183, 1077884182'
                 WHEN flight_number = 'F-279916' THEN '1077884171, 1077884170'
                 WHEN flight_number = 'F-279917' THEN '1077884173, 1077884172'
                 WHEN flight_number = 'F-279918' THEN '1077884175, 1077884174'
                 WHEN flight_number = 'F-279919' THEN '1077884177, 1077884176'
                 WHEN flight_number = 'F-279920' THEN '1077884185, 1077884184'
                 WHEN flight_number = 'F-279921' THEN '1077884179, 1077884178'
                 WHEN flight_number = 'F-279922' THEN '1077884181, 1077884180'
                 WHEN flight_number = 'F-279923' THEN '1077990744, 1077990743'
                 WHEN flight_number = 'F-279924' THEN '1077990708, 1077990707'
                 WHEN flight_number = 'F-279925' THEN '1077990714, 1077990713'
                 WHEN flight_number = 'F-279926' THEN '1077990720, 1077990719'
                 WHEN flight_number = 'F-279927' THEN '1077990726, 1077990725'
                 WHEN flight_number = 'F-279928' THEN '1077990750, 1077990749'
                 WHEN flight_number = 'F-279929' THEN '1077990732, 1077990731'
                 WHEN flight_number = 'F-279930' THEN '1077990738, 1077990737'
                 WHEN flight_number = 'F-279723' THEN '1077837612, 1077837611'
                 ELSE '1077990756, 1077990755' END AS "Sizmek Placement ID's",
             SUM(impressions) AS "Impressions",
             SUM(clicks) AS "Clicks",
             SUM(completions) AS Completions,
             SUM(completions) / SUM(impressions) AS "VCR",
             SUM(revenue) as "Spend"
      FROM dwh.ad_data_daily add2
        left outer join dwh.campaign c on add2.flight_id = c.flight_id
      WHERE c.flight_number IN('F-279853','F-279861','F-279854','F-279862','F-279855','F-279863','F-279859','F-279867','F-279858',
                   'F-279866','F-279857','F-279865','F-279711','F-279860','F-279856','F-279864','F-279869','F-279870',
                   'F-279871','F-279872','F-279873','F-279874','F-279875','F-279876','F-279877','F-279878','F-279879',
                   'F-279880','F-279881','F-279882','F-279883','F-279884', 'F-279885','F-279886','F-279887','F-279888',
                   'F-279889','F-279890','F-279891','F-279892','F-279893','F-279894','F-279895','F-279896','F-279897',
                   'F-279898','F-279899','F-279900','F-279715','F-279901','F-279902','F-279906','F-279907','F-279908',
                   'F-279719','F-279916','F-279917','F-279918','F-279919','F-279920','F-279921','F-279922','F-279923','F-279924','F-279925','F-279926','F-279927','F-279928','F-279929','F-279930,''F-279723','F-279931')
        AND date >= '2022-04-15'
        AND date < CURRENT_DATE()
        AND impressions > 0
      GROUP BY 1,2,3,4
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

  dimension: advertiser_name {
    type: string
    label: "Advertiser Name"
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}.flight_number ;;
  }

  dimension: sizmek_placement_ids {
    type: string
    label: "Sizmek Placement ID's"
    sql: ${TABLE}."Sizmek Placement ID's" ;;
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

  dimension: vcr {
    type: number
    label: "VCR"
    sql: ${TABLE}.VCR ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [
      date,
      advertiser_name,
      flight_number,
      sizmek_placement_ids,
      impressions,
      clicks,
      completions,
      vcr,
      spend
    ]
  }
}
