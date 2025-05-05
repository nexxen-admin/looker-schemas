view: hisense_brand_postal_code {
  derived_table: {
    sql: select DISTINCT DATE(viewing_start_utc) as date,
                DD.name AS brand_name,
                postal_code
        from dragon.viewership_ad_sessions_daily AA
        INNER JOIN dragon.ad_fingerprint BB
        ON AA.dt_known_id = BB.dt_known_id

        INNER JOIN dragon.ad CC
        ON BB.ad_tremor_id = CC.ad_tremor_id

        INNER JOIN dragon.brand DD
        ON CC.brand_tremor_id = DD.brand_tremor_id

        WHERE viewing_start_utc > TRUNC(NOW()) - INTERVAL '1 month'
              AND AA.country = 'gb'

         ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }


  set: detail {
    fields: [date,brand_name, postal_code]
  }
}
