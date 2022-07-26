view: habush_daily_report_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT add2.date::date as date,
           c.advertiser_name,
           c.flight_number,
           CASE WHEN c.flight_number = 'F-265134' THEN '1077700430, 1077700431'
               WHEN c.flight_number = 'F-266984' THEN '1077700426, 1077700427'
               WHEN c.flight_number = 'F-266985' THEN '1077700428, 1077700429'
               WHEN c.flight_number = 'F-266983' THEN '1077700424, 1077700425'
               WHEN c.flight_number = 'F-265144' THEN '1077700556, 1077700557'
               WHEN c.flight_number = 'F-266988' THEN '1077700558, 1077700559'
               WHEN c.flight_number = 'F-267060' THEN '1077700554, 1077700555'
               WHEN c.flight_number = 'F-266986' THEN '1077700552, 1077700553'
               WHEN c.flight_number = 'F-266974' THEN '1077912482, 1077912481'
               WHEN c.flight_number = 'F-266992' THEN '1077912486, 1077912485'
               WHEN c.flight_number = 'F-266994' THEN '1077912494, 1077912493'
               WHEN c.flight_number = 'F-266993' THEN '1077912490, 1077912489'
               WHEN c.flight_number = 'F-265137' THEN '1077912480, 1077912479'
               WHEN c.flight_number = 'F-266991' THEN '1077912492, 1077912491'
               WHEN c.flight_number = 'F-266989' THEN '1077912484, 1077912483'
               WHEN c.flight_number = 'F-266990' THEN '1077912488, 1077912487'
               WHEN c.flight_number = 'F-267033' THEN '1077912951, 1077912950'
               WHEN c.flight_number = 'F-266975' THEN '1077912939, 1077912938'
               WHEN c.flight_number = 'F-267032' THEN '1077912947, 1077912946'
               WHEN c.flight_number = 'F-267031' THEN '1077912943, 1077912942'
               WHEN c.flight_number = 'F-265147' THEN '1077912937, 1077912936'
               WHEN c.flight_number = 'F-267028' THEN '1077912941, 1077912940'
               WHEN c.flight_number = 'F-267029' THEN '1077912945, 1077912944'
               WHEN c.flight_number = 'F-267030' THEN '1077912949, 1077912948'
               WHEN c.flight_number = 'F-267040' THEN '1078092926, 1078092927'
               WHEN c.flight_number = 'F-266977' THEN '1078092914, 1078092915'
               WHEN c.flight_number = 'F-267039' THEN '1078092922, 1078092923'
               WHEN c.flight_number = 'F-267037' THEN '1078092918, 1078092919'
               WHEN c.flight_number = 'F-265140' THEN '1078092944, 1078092945'
               WHEN c.flight_number = 'F-267034' THEN '1078092916, 1078092917'
               WHEN c.flight_number = 'F-267035' THEN '1078092920, 1078092921'
               WHEN c.flight_number = 'F-267036' THEN '1078092924, 1078092925'
               WHEN c.flight_number = 'F-267059' THEN '1078092938, 1078092939'
               WHEN c.flight_number = 'F-267058' THEN '1078092942, 1078092943'
               WHEN c.flight_number = 'F-267044' THEN '1078092934, 1078092935'
               WHEN c.flight_number = 'F-266978' THEN '1078092930, 1078092931'
               WHEN c.flight_number = 'F-265150' THEN '1078092928, 1078092929'
               WHEN c.flight_number = 'F-267041' THEN '1078092932, 1078092933'
               WHEN c.flight_number = 'F-267042' THEN '1078092936, 1078092937'
               ELSE '1078092940, 1078092941' END AS "Sizmek Placement ID's",
             SUM(impressions) AS "Impressions",
             SUM(completions) AS Completions,
             SUM(completions) / SUM(impressions) AS "VCR",
             SUM(revenue) as "Spend"
      FROM dwh.ad_data_daily add2
        left outer join dwh.campaign c on add2.flight_id = c.flight_id
      WHERE c.flight_number IN('F-265134','F-265137','F-265140','F-265142','F-265144','F-265147','F-265150','F-265152',
                    'F-265887','F-266974','F-266975','F-266977','F-266978','F-266985','F-266986','F-266979',
                    'F-266989','F-266990','F-266980','F-266988','F-266991','F-266983','F-266992','F-266994',
                    'F-266993','F-266984','F-267028','F-267029','F-267032','F-267030','F-267031','F-267040',
                    'F-267033','F-267034','F-267041','F-267035','F-267047','F-267036','F-267048','F-267044',
                    'F-267042','F-267037','F-267043','F-267046','F-267049','F-267039','F-267050','F-267051',
                    'F-267055','F-267052','F-267053','F-267060','F-267054','F-267056','F-267057','F-267058','F-267059')
        AND date >= '2022-02-01'
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
      completions,
      vcr,
      spend
    ]
  }
}
