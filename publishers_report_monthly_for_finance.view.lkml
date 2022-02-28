view: publishers_report_monthly_for_finance {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT
        '2022-0'||DATE_PART('MONTH', ssd.event_time) as 'month',
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
       SUM(ssd.clicks) as clicks,SUM(ssd.revenue) as revenue,
       SUM(ssd.cost) as cost,
       SUM(ssd.firstparty_revenue) as firstparty_revenue,
       SUM(ssd.thirdparty_revenue) as thirdparty_revenue
       ,CASE WHEN SUM(ssd.pub_requests) = 0 THEN 0 ELSE SUM(ssd.attempts) * 100.0 / SUM(ssd.pub_requests) END as bid_rate
       ,CASE WHEN SUM(ssd.attempts) = 0 THEN 0 ELSE SUM(ssd.impswins) * 100.0 / SUM(ssd.attempts) END as win_rate
       ,CASE WHEN SUM(ssd.pub_requests) = 0 THEN 0 ELSE SUM(ssd.impressions) * 100.0 / SUM(ssd.pub_requests) END as fill_rate
       FROM Andromeda.supply_stat_summary_daily as ssd
       left join andromeda.rx_dim_supply_publisher_r as pub on ssd.publisher_id=pub.publisher_id
       WHERE MONTH(ssd.event_time) =month(current_date)-1
       GROUP BY DATE_PART('MONTH', ssd.event_time)
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

  dimension: pub_requests {
    type: number
    sql: ${TABLE}.pub_requests ;;
  }

  dimension: slot_requests {
    type: number
    sql: ${TABLE}.slot_requests ;;
  }

  dimension: rx_requests {
    type: number
    sql: ${TABLE}.rx_requests ;;
  }

  dimension: opportunities {
    type: number
    sql: ${TABLE}.opportunities ;;
  }

  dimension: bids {
    type: number
    sql: ${TABLE}.bids ;;
  }

  dimension: slot_attempts {
    type: number
    sql: ${TABLE}.slot_attempts ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.attempts ;;
  }

  dimension: impswins {
    type: number
    sql: ${TABLE}.impswins ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: firstparty_revenue {
    type: number
    sql: ${TABLE}.firstparty_revenue ;;
  }

  dimension: thirdparty_revenue {
    type: number
    sql: ${TABLE}.thirdparty_revenue ;;
  }

  dimension: bid_rate {
    type: number
    sql: ${TABLE}.bid_rate ;;
  }

  dimension: win_rate {
    type: number
    sql: ${TABLE}.win_rate ;;
  }

  dimension: fill_rate {
    type: number
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
