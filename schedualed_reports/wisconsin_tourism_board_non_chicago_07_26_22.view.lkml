view: wisconsin_tourism_board_non_chicago_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT add2.date::date as date,
           c.advertiser_name,
           'AS0097273 - WI Tourism (Hiebing, Wisconsin): 2022 Summer Awareness Campaign - OTHER/NON-CHICAGO DMAs' AS "campaign_name",
           c.flight_number,
           CASE WHEN flight_number = 'F-279853' AND cr.duration = 30 THEN '1077837589'
               WHEN flight_number = 'F-279853' AND cr.duration = 15 THEN '1077837590'
                 WHEN flight_number = 'F-279861' AND cr.duration = 30 THEN '1077990593'
                 WHEN flight_number = 'F-279861' AND cr.duration = 15 THEN '1077990594'
                 WHEN flight_number = 'F-279854' AND cr.duration = 30 THEN '1077837591'
                 WHEN flight_number = 'F-279854' AND cr.duration = 15 THEN '1077837592'
                 WHEN flight_number = 'F-279862' AND cr.duration = 30 THEN '1077990599'
                 WHEN flight_number = 'F-279862' AND cr.duration = 15 THEN '1077990600'
                 WHEN flight_number = 'F-279855' AND cr.duration = 30 THEN '1077837593'
                 WHEN flight_number = 'F-279855' AND cr.duration = 15 THEN '1077837594'
                 WHEN flight_number = 'F-279863' AND cr.duration = 30 THEN '1077990605'
                 WHEN flight_number = 'F-279863' AND cr.duration = 15 THEN '1077990606'
                 WHEN flight_number = 'F-279859' AND cr.duration = 30 THEN '1077837603'
                 WHEN flight_number = 'F-279859' AND cr.duration = 15 THEN '1077837604'
                 WHEN flight_number = 'F-279867' AND cr.duration = 30 THEN '1077990635'
                 WHEN flight_number = 'F-279867' AND cr.duration = 15 THEN '1077990636'
                 WHEN flight_number = 'F-279858' AND cr.duration = 30 THEN '1077837601'
                 WHEN flight_number = 'F-279858' AND cr.duration = 15 THEN '1077837602'
                 WHEN flight_number = 'F-279866' AND cr.duration = 30 THEN '1077990629'
                 WHEN flight_number = 'F-279866' AND cr.duration = 15 THEN '1077990630'
                 WHEN flight_number = 'F-279857' AND cr.duration = 30 THEN '1077837599'
                 WHEN flight_number = 'F-279857' AND cr.duration = 15 THEN '1077837600'
                 WHEN flight_number = 'F-279865' AND cr.duration = 30 THEN '1077990623'
                 WHEN flight_number = 'F-279865' AND cr.duration = 15 THEN '1077990624'
                 WHEN flight_number = 'F-279711' AND cr.duration = 30 THEN '1077837597'
                 WHEN flight_number = 'F-279711' AND cr.duration = 15 THEN '1077837598'
                 WHEN flight_number = 'F-279860' AND cr.duration = 30 THEN '1077990617'
                 WHEN flight_number = 'F-279860' AND cr.duration = 15 THEN '1077990618'
                 WHEN flight_number = 'F-279856' AND cr.duration = 30 THEN '1077837595'
                 WHEN flight_number = 'F-279856' AND cr.duration = 15 THEN '1077837596'
                 WHEN flight_number = 'F-279864' AND cr.duration = 30 THEN '1077990611'
                 WHEN flight_number = 'F-279864' AND cr.duration = 15 THEN '1077990612'
                 WHEN flight_number = 'F-279869' AND cr.duration = 30 THEN '1077884162'
                 WHEN flight_number = 'F-279869' AND cr.duration = 15 THEN '1077884163'
                 WHEN flight_number = 'F-279870' AND cr.duration = 30 THEN '1077884154'
                 WHEN flight_number = 'F-279870' AND cr.duration = 15 THEN '1077884155'
                 WHEN flight_number = 'F-279871' AND cr.duration = 30 THEN '1077884156'
                 WHEN flight_number = 'F-279871' AND cr.duration = 15 THEN '1077884157'
                 WHEN flight_number = 'F-279872' AND cr.duration = 30 THEN '1077884158'
                 WHEN flight_number = 'F-279872' AND cr.duration = 15 THEN '1077884159'
                 WHEN flight_number = 'F-279873' AND cr.duration = 30 THEN '1077884160'
                 WHEN flight_number = 'F-279873' AND cr.duration = 15 THEN '1077884161'
                 WHEN flight_number = 'F-279874' AND cr.duration = 30 THEN '1077884164'
                 WHEN flight_number = 'F-279874' AND cr.duration = 15 THEN '1077884165'
                 WHEN flight_number = 'F-279875' AND cr.duration = 30 THEN '1077884166'
                 WHEN flight_number = 'F-279875' AND cr.duration = 15 THEN '1077884167'
                 WHEN flight_number = 'F-279876' AND cr.duration = 30 THEN '1077884168'
                 WHEN flight_number = 'F-279876' AND cr.duration = 15 THEN '1077884169'
                 WHEN flight_number = 'F-279877' AND cr.duration = 30 THEN '1077990683'
                 WHEN flight_number = 'F-279877' AND cr.duration = 15 THEN '1077990684'
                 WHEN flight_number = 'F-279878' AND cr.duration = 30 THEN '1077990659'
                 WHEN flight_number = 'F-279878' AND cr.duration = 15 THEN '1077990660'
                 WHEN flight_number = 'F-279879' AND cr.duration = 30 THEN '1077990665'
                 WHEN flight_number = 'F-279879' AND cr.duration = 15 THEN '1077990666'
                 WHEN flight_number = 'F-279880' AND cr.duration = 30 THEN '1077990671'
                 WHEN flight_number = 'F-279880' AND cr.duration = 15 THEN '1077990672'
                 WHEN flight_number = 'F-279881' AND cr.duration = 30 THEN '1077990677'
                 WHEN flight_number = 'F-279881' AND cr.duration = 15 THEN '1077990678'
                 WHEN flight_number = 'F-279882' AND cr.duration = 30 THEN '1077990689'
                 WHEN flight_number = 'F-279882' AND cr.duration = 15 THEN '1077990690'
                 WHEN flight_number = 'F-279883' AND cr.duration = 30 THEN '1077990695'
                 WHEN flight_number = 'F-279883' AND cr.duration = 15 THEN '1077990696'
                 WHEN flight_number = 'F-279884' AND cr.duration = 30 THEN '1077990701'
                 WHEN flight_number = 'F-279884' AND cr.duration = 15 THEN '1077990702'
                 WHEN flight_number = 'F-279885' AND cr.duration = 30 THEN '1077837581'
                 WHEN flight_number = 'F-279885' AND cr.duration = 15 THEN '1077837582'
                 WHEN flight_number = 'F-279886' AND cr.duration = 30 THEN '1077837573'
                 WHEN flight_number = 'F-279886' AND cr.duration = 15 THEN '1077837574'
                 WHEN flight_number = 'F-279887' AND cr.duration = 30 THEN '1077837575'
                 WHEN flight_number = 'F-279887' AND cr.duration = 15 THEN '1077837576'
                 WHEN flight_number = 'F-279888' AND cr.duration = 30 THEN '1077837577'
                 WHEN flight_number = 'F-279888' AND cr.duration = 15 THEN '1077837578'
                 WHEN flight_number = 'F-279889' AND cr.duration = 30 THEN '1077837579'
                 WHEN flight_number = 'F-279889' AND cr.duration = 15 THEN '1077837580'
                 WHEN flight_number = 'F-279890' AND cr.duration = 30 THEN '1077837583'
                 WHEN flight_number = 'F-279890' AND cr.duration = 15 THEN '1077837584'
                 WHEN flight_number = 'F-279891' AND cr.duration = 30 THEN '1077837585'
                 WHEN flight_number = 'F-279891' AND cr.duration = 15 THEN '1077837586'
                 WHEN flight_number = 'F-279892' AND cr.duration = 30 THEN '1077837587'
                 WHEN flight_number = 'F-279892' AND cr.duration = 15 THEN '1077837588'
                 WHEN flight_number = 'F-279893' AND cr.duration = 30 THEN '1077990569'
                 WHEN flight_number = 'F-279893' AND cr.duration = 15 THEN '1077990570'
                 WHEN flight_number = 'F-279894' AND cr.duration = 30 THEN '1077990545'
                 WHEN flight_number = 'F-279894' AND cr.duration = 15 THEN '1077990546'
                 WHEN flight_number = 'F-279895' AND cr.duration = 30 THEN '1077990551'
                 WHEN flight_number = 'F-279895' AND cr.duration = 15 THEN '1077990552'
                 WHEN flight_number = 'F-279896' AND cr.duration = 30 THEN '1077990557'
                 WHEN flight_number = 'F-279896' AND cr.duration = 15 THEN '1077990558'
                 WHEN flight_number = 'F-279897' AND cr.duration = 30 THEN '1077990563'
                 WHEN flight_number = 'F-279897' AND cr.duration = 15 THEN '1077990564'
                 WHEN flight_number = 'F-279898' AND cr.duration = 30 THEN '1077990575'
                 WHEN flight_number = 'F-279898' AND cr.duration = 15 THEN '1077990576'
                 WHEN flight_number = 'F-279899' AND cr.duration = 30 THEN '1077990581'
                 WHEN flight_number = 'F-279899' AND cr.duration = 15 THEN '1077990582'
                 WHEN flight_number = 'F-279900' AND cr.duration = 30 THEN '1077990587'
                 WHEN flight_number = 'F-279900' AND cr.duration = 15 THEN '1077990588'
                 WHEN flight_number = 'F-279715' AND cr.duration = 30 THEN '1077837607'
                 WHEN flight_number = 'F-279715' AND cr.duration = 15 THEN '1077837608'
                 WHEN flight_number = 'F-279901' AND cr.duration = 30 THEN '1077837605'
                 WHEN flight_number = 'F-279901' AND cr.duration = 15 THEN '1077837606'
                 WHEN flight_number = 'F-279902' AND cr.duration = 30 THEN '1077837609'
                 WHEN flight_number = 'F-279902' AND cr.duration = 15 THEN '1077837610'
                 WHEN flight_number = 'F-279906' AND cr.duration = 30 THEN '1077990647'
                 WHEN flight_number = 'F-279906' AND cr.duration = 15 THEN '1077990648'
                 WHEN flight_number = 'F-279907' AND cr.duration = 30 THEN '1077990641'
                 WHEN flight_number = 'F-279907' AND cr.duration = 15 THEN '1077990642'
                 WHEN flight_number = 'F-279908' AND cr.duration = 30 THEN '1077990653'
                 WHEN flight_number = 'F-279908' AND cr.duration = 15 THEN '1077990654'
                 WHEN flight_number = 'F-279719' AND cr.duration = 30 THEN '1077884182'
                 WHEN flight_number = 'F-279719' AND cr.duration = 15 THEN '1077884183'
                 WHEN flight_number = 'F-279916' AND cr.duration = 30 THEN '1077884170'
                 WHEN flight_number = 'F-279916' AND cr.duration = 15 THEN '1077884171'
                 WHEN flight_number = 'F-279917' AND cr.duration = 30 THEN '1077884172'
                 WHEN flight_number = 'F-279917' AND cr.duration = 15 THEN '1077884173'
                 WHEN flight_number = 'F-279918' AND cr.duration = 30 THEN '1077884174'
                 WHEN flight_number = 'F-279918' AND cr.duration = 15 THEN '1077884175'
                 WHEN flight_number = 'F-279919' AND cr.duration = 30 THEN '1077884176'
                 WHEN flight_number = 'F-279919' AND cr.duration = 15 THEN '1077884177'
                 WHEN flight_number = 'F-279920' AND cr.duration = 30 THEN '1077884184'
                 WHEN flight_number = 'F-279920' AND cr.duration = 15 THEN '1077884185'
                 WHEN flight_number = 'F-279921' AND cr.duration = 30 THEN '1077884178'
                 WHEN flight_number = 'F-279921' AND cr.duration = 15 THEN '1077884179'
                 WHEN flight_number = 'F-279922' AND cr.duration = 30 THEN '1077884180'
                 WHEN flight_number = 'F-279922' AND cr.duration = 15 THEN '1077884181'
                 WHEN flight_number = 'F-279923' AND cr.duration = 30 THEN '1077990743'
                 WHEN flight_number = 'F-279923' AND cr.duration = 15 THEN '1077990744'
                 WHEN flight_number = 'F-279924' AND cr.duration = 30 THEN '1077990707'
                 WHEN flight_number = 'F-279924' AND cr.duration = 15 THEN '1077990708'
                 WHEN flight_number = 'F-279925' AND cr.duration = 30 THEN '1077990713'
                 WHEN flight_number = 'F-279925' AND cr.duration = 15 THEN '1077990714'
                 WHEN flight_number = 'F-279926' AND cr.duration = 30 THEN '1077990719'
                 WHEN flight_number = 'F-279926' AND cr.duration = 15 THEN '1077990720'
                 WHEN flight_number = 'F-279927' AND cr.duration = 30 THEN '1077990725'
                 WHEN flight_number = 'F-279927' AND cr.duration = 15 THEN '1077990726'
                 WHEN flight_number = 'F-279928' AND cr.duration = 30 THEN '1077990749'
                 WHEN flight_number = 'F-279928' AND cr.duration = 15 THEN '1077990750'
                 WHEN flight_number = 'F-279929' AND cr.duration = 30 THEN '1077990731'
                 WHEN flight_number = 'F-279929' AND cr.duration = 15 THEN '1077990732'
                 WHEN flight_number = 'F-279930' AND cr.duration = 30 THEN '1077990737'
                 WHEN flight_number = 'F-279930' AND cr.duration = 15 THEN '1077990738'
                 WHEN flight_number = 'F-279723' AND cr.duration = 30 THEN '1077837611'
                 WHEN flight_number = 'F-279723' AND cr.duration = 15 THEN '1077837612'
                 WHEN flight_number = 'F-279931' AND cr.duration = 30 THEN '1077990755'
                 ELSE '1077990756' END AS "Sizmek Placement ID's",
             SUM(impressions) AS "Impressions",
             SUM(clicks) AS "Clicks",
             SUM(completions) AS Completions,
             SUM(completions) / SUM(impressions) AS "VCR",
             SUM(revenue) as "Spend"
      FROM dwh.ad_data_daily add2
        left outer join dwh.campaign c on add2.flight_id = c.flight_id
        left outer join dwh.creative cr on add2.creative_id = cr.id
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

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}.campaign_name ;;
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
      campaign_name,
      sizmek_placement_ids,
      impressions,
      clicks,
      completions,
      vcr,
      spend
    ]
  }
}
