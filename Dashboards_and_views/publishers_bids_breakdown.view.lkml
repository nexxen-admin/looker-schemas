view: publishers_bids_breakdown {
  derived_table: {
    sql: WITH bid_prices AS (
        SELECT
          distinct publisher_name,
          rx_device_type,
          rx_imp_type,
          country,
          greatest(rx_bid_floor, ssp_bid_floor) AS greatest_bid_floor,
          dsp_bid_price,
          greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price AS diff_floor_price,
          CASE
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.1 THEN '0-10%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.1 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.2 THEN '11-20%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.2 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.3 THEN '21-30%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.3 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.4 THEN '31-40%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.4 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.5 THEN '41-50%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.5 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.6 THEN '51-60%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.6 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.7 THEN '61-70%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.7 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.8 THEN '71-80%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.8 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 0.9 THEN '81-90%'
            WHEN (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) > 0.9 AND (greatest(rx_bid_floor, ssp_bid_floor) - dsp_bid_price) / greatest(rx_bid_floor, ssp_bid_floor) <= 1 THEN '91-100%'
            ELSE 'Other'
          END AS range_from_bid_floor
      from andromeda.ad_data_daily
        WHERE
          event_time >= '2023-01-01'
          AND rx_response_status = 'bidpricefloor'
      )
      SELECT
        publisher_name,
        rx_device_type,
        rx_imp_type,
        country,
        range_from_bid_floor,
        COUNT(*) AS count,
        concat(cast(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY publisher_name, rx_device_type, rx_imp_type, country) as decimal(20,2)),'%') AS percentage
      FROM
        bid_prices
      GROUP BY
        publisher_name,
        rx_device_type,
        rx_imp_type,
        country,
        range_from_bid_floor ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: rx_device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.rx_device_type ;;
  }

  dimension: rx_imp_type {
    type: string
    label: "Imp Type"
    sql: ${TABLE}.rx_imp_type ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: range_from_bid_floor {
    type: string
    sql: ${TABLE}.range_from_bid_floor ;;
  }


  measure: percentage {
    type: number
    sql: ${TABLE}.percentage ;;
  }

  set: detail {
    fields: [
        publisher_name,
  rx_device_type,
  rx_imp_type,
  country,
  range_from_bid_floor,
  percentage
    ]
  }
}
