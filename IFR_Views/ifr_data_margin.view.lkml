
view: ifr_data_margin {
  sql_table_name: financial.ifr_data_margin ;;
  # derived_table: {
  #   sql: with rs as
  #         (select rs.period_name,
  #                 rs.impression_date :: date,
  #                 rs.advertiser_home_mkt_id,
  #                 rs.advertiser_home_mkt_name,
  #                 rs.advertiser_name,
  #                 rs.advertiser_id,
  #                 sum(rs.turn_fee) as turn_fee,
  #                 SUM(rs.total_billable) as total_billable
  #         from fact_programmatic_revenue_summary_by_day rs
  #         where rs."source" = 'BILLINGS'
  #             and ifr_period >= '2023-01-01'
  #             and rs.advertiser_home_mkt_id in ('141',
  #                                               '861',
  #                                               '927',
  #                                               '999',
  #                                               '1356',
  #                                               '1379',
  #                                               '1405',
  #                                               '1472',
  #                                               '1602',
  #                                               '2048',
  #                                               '2107',
  #                                               '2139',
  #                                               '2143',
  #                                               '2147',
  #                                               '2145',
  #                                               '2149')
  #         group by 1,
  #                   2,
  #                   3,
  #                   4,
  #                   5,
  #                   6 ), -- data cost
  #     --
  #     d as
  #         ( SELECT d.period_name,
  #                 d.impression_date :: date as impression_date,
  #                 d.market_id,
  #                 d.market_name,
  #                 d.advertiser_id,
  #                 d.advertiser_name,
  #                 d.data_product_description as product,
  #                 sum(d.turn_fee) as data_cost_adj
  #         FROM fact_programmatic_decom d
  #         WHERE d.date_period :: date >= '2023-01-01'
  #         group by 1,
  #                   2,
  #                   3,
  #                   4,
  #                   5,
  #                   6,
  #                   7 )
  #     select period_name,
  #           impression_date,
  #           advertiser_Home_mkt_id,
  #           advertiser_home_mkt_name,
  #           advertiser_id,
  #           advertiser_name,
  #           unnest(array['total_billable', 'turn_fee']) as product,
  #           unnest(array[total_billable, turn_fee]) as turn_fee,
  #           total_billable
  #     FROM rs
  #     UNION ALL
  #     SELECT d.period_name,
  #           d.impression_date,
  #           d.market_id,
  #           d.market_name,
  #           d.advertiser_id,
  #           d.advertiser_name,
  #           d.product,
  #           data_cost_adj,
  #           rs.total_billable
  #     FROM d
  #     LEFT JOIN rs ON rs.period_name = d.period_name
  #     AND rs.advertiser_id = d.advertiser_id
  #     AND rs.impression_date = d.impression_date ;;
  # }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: period_name {
    type: string
    sql: ${TABLE}."period_name" ;;
  }

  dimension: impression_date {
    type: date
    sql: ${TABLE}."impression_date" ;;
  }

  dimension: advertiser_home_mkt_id {
    type: string
    label: "market id"
    sql: ${TABLE}."advertiser_home_mkt_id" ;;
  }

  dimension: advertiser_home_mkt_name {
    type: string
    label: "market name"
    sql: ${TABLE}."advertiser_home_mkt_name" ;;
  }

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}."advertiser_id" ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}."advertiser_name" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."product" ;;
  }

  measure: turn_fee {
    type: sum
    sql: ${TABLE}."turn_fee" ;;
  }

  measure: total_billable {
    type: sum
    sql: ${TABLE}."total_billable" ;;
  }

  set: detail {
    fields: [
        period_name,
  impression_date,
  advertiser_home_mkt_id,
  advertiser_home_mkt_name,
  advertiser_id,
  advertiser_name,
  product,
  turn_fee,
  total_billable
    ]
  }
}
