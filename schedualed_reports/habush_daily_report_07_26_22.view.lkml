view: habush_daily_report_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT add2.date::date as date,
     c.advertiser_name,
     'AS0096331 - Habush Habush & Rottier (Hiebing, Wisconsin): Habush Habush & Rottier 2022 CTV RFP' AS "campaign_name",
     c.flight_number,
     CASE WHEN cr.id =   8485006 THEN '1077700431'
    WHEN cr.id =  8484996 THEN '1077700430'
    WHEN cr.id =  8465196 THEN '1077586660'
    WHEN cr.id =  8525816 THEN '1077912480'
    WHEN cr.id =  8525826 THEN '1077912479'
    WHEN cr.id =  8571326 THEN '1078092944'
    WHEN cr.id =  8571346 THEN '1078092945'
    WHEN cr.id =  8525736 THEN '1077912482'
    WHEN cr.id =  8525746 THEN '1077912481'
    WHEN cr.id =  8571156 THEN '1078092914'
    WHEN cr.id =  8571146 THEN '1078092915'
    WHEN cr.id =  8485066 THEN '1077700425'
    WHEN cr.id =  8485056 THEN '1077700424'
    WHEN cr.id =  8465226 THEN '1077586654'
    WHEN cr.id =  8485026 THEN '1077700427'
    WHEN cr.id =  8485016 THEN '1077700426'
    WHEN cr.id =  8465206 THEN '1077586656'
    WHEN cr.id =  8485046 THEN '1077700429'
    WHEN cr.id =  8485036 THEN '1077700428'
    WHEN cr.id =  8465216 THEN '1077586658'
    WHEN cr.id =  8525856 THEN '1077912484'
    WHEN cr.id =  8525866 THEN '1077912483'
    WHEN cr.id =  8525876 THEN '1077912488'
    WHEN cr.id =  8525886 THEN '1077912487'
    WHEN cr.id =  8525836 THEN '1077912492'
    WHEN cr.id =  8525846 THEN '1077912491'
    WHEN cr.id =  8525756 THEN '1077912486'
    WHEN cr.id =  8525766 THEN '1077912485'
    WHEN cr.id =  8525796 THEN '1077912490'
    WHEN cr.id =  8525806 THEN '1077912489'
    WHEN cr.id =  8525776 THEN '1077912494'
    WHEN cr.id =  8525786 THEN '1077912493'
    WHEN cr.id =  8571456 THEN '1078092916'
    WHEN cr.id =  8571466 THEN '1078092917'
    WHEN cr.id =  8571476 THEN '1078092920'
    WHEN cr.id =  8571486 THEN '1078092921'
    WHEN cr.id =  8571506 THEN '1078092924'
    WHEN cr.id =  8571496 THEN '1078092925'
    WHEN cr.id =  8571196 THEN '1078092918'
    WHEN cr.id =  8571186 THEN '1078092919'
    WHEN cr.id =  8571176 THEN '1078092922'
    WHEN cr.id =  8571166 THEN '1078092923'
    WHEN cr.id =  8571136 THEN '1078092926'
    WHEN cr.id =  8571126 THEN '1078092927'
    WHEN cr.id =  8485086 THEN '1077700557'
    WHEN cr.id =  8485076 THEN '1077700556'
    WHEN cr.id =  8465236 THEN '1077586666'
    WHEN cr.id =  8525976 THEN '1077912937'
    WHEN cr.id =  8525986 THEN '1077912936'
    WHEN cr.id =  8571356 THEN '1078092928'
    WHEN cr.id =  8571376 THEN '1078092929'
    WHEN cr.id =  8525916 THEN '1077912939'
    WHEN cr.id =  8525926 THEN '1077912938'
    WHEN cr.id =  8571276 THEN '1078092930'
    WHEN cr.id =  8571286 THEN '1078092931'
    WHEN cr.id =  8485146 THEN '1077700553'
    WHEN cr.id =  8485136 THEN '1077700552'
    WHEN cr.id =  8465266 THEN '1077586662'
    WHEN cr.id =  8485106 THEN '1077700559'
    WHEN cr.id =  8485096 THEN '1077700558'
    WHEN cr.id =  8465246 THEN '1077586668'
    WHEN cr.id =  8525996 THEN '1077912941'
    WHEN cr.id =  8526006 THEN '1077912940'
    WHEN cr.id =  8526016 THEN '1077912945'
    WHEN cr.id =  8526026 THEN '1077912944'
    WHEN cr.id =  8526036 THEN '1077912949'
    WHEN cr.id =  8526046 THEN '1077912948'
    WHEN cr.id =  8525956 THEN '1077912943'
    WHEN cr.id =  8525966 THEN '1077912942'
    WHEN cr.id =  8525936 THEN '1077912947'
    WHEN cr.id =  8525946 THEN '1077912946'
    WHEN cr.id =  8525896 THEN '1077912951'
    WHEN cr.id =  8525906 THEN '1077912950'
    WHEN cr.id =  8571396 THEN '1078092932'
    WHEN cr.id =  8571406 THEN '1078092933'
    WHEN cr.id =  8571416 THEN '1078092936'
    WHEN cr.id =  8571426 THEN '1078092937'
    WHEN cr.id =  8571446 THEN '1078092940'
    WHEN cr.id =  8571436 THEN '1078092941'
    WHEN cr.id =  8571266 THEN '1078092934'
    WHEN cr.id =  8571256 THEN '1078092935'
    WHEN cr.id =  8571246 THEN '1078092942'
    WHEN cr.id =  8571236 THEN '1078092943'
    WHEN cr.id =  8571216 THEN '1078092938'
    WHEN cr.id =  8571206 THEN '1078092939'
    WHEN cr.id =  8485126 THEN '1077700555'
    WHEN cr.id =  8485116 THEN '1077700554'
    WHEN cr.id =  8465256 THEN '1077586664'
    WHEN cr.id =  8465296 THEN '1077586670'
    ELSE '1077586671' END AS "Sizmek Placement ID's",
      SUM(impressions) AS "Impressions",
      SUM(completions) AS "Completions",
      SUM(clicks) AS "Clicks",
      SUM(completions) / SUM(impressions) AS "VCR",
      SUM(revenue) as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.creative cr on add2.creative_id = cr.id
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

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}.campaign_name ;;
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
      campaign_name,
      flight_number,
      sizmek_placement_ids,
      impressions,
      completions,
      clicks,
      vcr,
      spend
    ]
  }
}
