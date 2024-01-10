view: publishers_report_monthly_for_finance {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: select year(ssd.event_time) as year,
       month(ssd.event_time) as month,--DATE_PART('YEAR', ssd.event_time)||'-0'||DATE_PART('MONTH', ssd.event_time) as 'month',
        ssd.publisher_id,
        ssd.publisher_name,
        pub.ACCOUNTING_ID,
       ssd.placement_id,
       ssd.placement_name,
       SUM(ssd.pub_requests) as pub_requests,
        SUM(ssd.slot_requests) as slot_requests,
        SUM(ssd.rx_requests) as rx_requests,
       SUM(ssd.opportunities) as opportunities,
       SUM(ssd.bids) as bids,
       SUM(ssd.slot_attempts) as slot_attempts,
       SUM(ssd.attempts) as attempts,
       SUM(ssd.impswins) as impswins,
       SUM(ssd.impressions) as impressions,
       SUM(ssd.clicks) as clicks,
       SUM(ssd.revenue) as revenue,
       sum(platform_fee) as Tech_fee,
       SUM(ssd.cost) as cost,
       SUM(ssd.firstparty_revenue) as firstparty_revenue,
       SUM(ssd.thirdparty_revenue) as thirdparty_revenue
       ,CASE WHEN SUM(ssd.pub_requests) = 0 THEN 0 ELSE SUM(ssd.attempts) * 100.0 / SUM(ssd.pub_requests) END as bid_rate
       ,CASE WHEN SUM(ssd.attempts) = 0 THEN 0 ELSE SUM(ssd.impswins) * 100.0 / SUM(ssd.attempts) END as win_rate
       ,CASE WHEN SUM(ssd.pub_requests) = 0 THEN 0 ELSE SUM(ssd.impressions) * 100.0 / SUM(ssd.pub_requests) END as fill_rate
       FROM Andromeda.supply_stat_summary_daily as ssd
       left join andromeda.rx_dim_supply_publisher_r as pub on ssd.publisher_id=pub.publisher_id
       --WHERE ssd.event_time>='2023-12-01'--MONTH(ssd.event_time) =month(current_date-1) and case when to_char(ssd.event_time, 'mm/dd')= '12/31' then year(ssd.event_time) = year(current_date-1)
       --else year(ssd.event_time) = year(current_date) end
       where ((( ssd.event_time ) >= ((DATE_TRUNC('day', (ADD_MONTHS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)), -1) +
       (MIDNIGHT_SECONDS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP))) || ' second')::INTERVAL)))) AND
       ( ssd.event_time ) < ((DATE_TRUNC('day', (ADD_MONTHS((ADD_MONTHS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)), -1) +
       (MIDNIGHT_SECONDS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP))) || ' second')::INTERVAL), 1) +
       (MIDNIGHT_SECONDS((ADD_MONTHS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)), -1) +
       (MIDNIGHT_SECONDS(DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP))) || ' second')::INTERVAL)) || ' second')::INTERVAL))))))
       GROUP BY year(ssd.event_time),month(ssd.event_time)--DATE_PART('MONTH', ssd.event_time),DATE_PART('YEAR', ssd.event_time)
       ,ssd.publisher_id,ssd.publisher_name,pub.ACCOUNTING_ID , ssd.placement_id, ssd.placement_name
      ORDER BY SUM(ssd.revenue) DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month {
    type: string
    sql: ${TABLE}."month" ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}."year" ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: accounting_id {
    type: string
    sql: ${TABLE}.ACCOUNTING_ID ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  measure: pub_requests {
    type: sum
    sql: ${TABLE}.pub_requests ;;
  }

  measure: slot_requests {
    type: sum
    sql: ${TABLE}.slot_requests ;;
  }

  measure: rx_requests {
    type: sum
    sql: ${TABLE}.rx_requests ;;
  }

  measure: opportunities {
    type: sum
    sql: ${TABLE}.opportunities ;;
  }

  measure: bids {
    type: sum
    sql: ${TABLE}.bids ;;
  }

  measure: slot_attempts {
    type: sum
    sql: ${TABLE}.slot_attempts ;;
  }

  measure: attempts {
    type: sum
    sql: ${TABLE}.attempts ;;
  }

  measure: impswins {
    label: "Wins"
    type: sum
    sql: ${TABLE}.impswins ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  measure: firstparty_revenue {
    type: sum
    sql: ${TABLE}.firstparty_revenue ;;
  }

  measure: thirdparty_revenue {
    type: sum
    sql: ${TABLE}.thirdparty_revenue ;;
  }

  measure: bid_rate {
    type: average
    sql: ${TABLE}.bid_rate ;;
  }

  measure: win_rate {
    type: average
    sql: ${TABLE}.win_rate ;;
  }

  measure: tech_fee {
    type: sum
    sql: ${TABLE}.Tech_fee ;;
  }

  measure: fill_rate {
    type: average
    sql: ${TABLE}.fill_rate ;;
  }

  set: detail {
    fields: [
      month,
      publisher_id,
      publisher_name,
      accounting_id,
      placement_id,
      placement_name,
      pub_requests,
      slot_requests,
      rx_requests,
      opportunities,
      bids,
      slot_attempts,
      attempts,
      impswins,
      impressions,
      clicks,
      revenue,
      cost,
      firstparty_revenue,
      thirdparty_revenue,
      bid_rate,
      win_rate,
      fill_rate
    ]
  }
}
