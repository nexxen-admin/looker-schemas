
view: ncd_mapping_debugging {
  derived_table: {
    sql: SELECT f.Date_Key::date as date,
           f.account_name,
             f.advertiser_name,
           f.insertion_order_id,
           li.line_item_id,
            f.line_item_name__c,
            f.line_item_nickname,
            CASE WHEN f.line_item_nickname IS NULL THEN 'Flag'
                  ELSE 'OK'END AS line_item_nickname_status,
            f.line_item_group_b,
            f.line_item_group_c,
            p.package_id,
            p.name as package_name,
            f.package_nickname,
            CASE WHEN f.package_nickname IS NULL THEN 'Flag'
                  ELSE 'OK'END AS package_nickname_status,
            f.package_group_b,
            f.package_group_c,
            c.creative_id,
            c.creative_name,
            f.creative_group_a,
            CASE WHEN f.creative_group_a IS NULL THEN 'Flag'
                  ELSE 'OK'END AS creative_group_a_status,
            f.creative_group_b,
            f.creative_group_c,
            SUM(f.impressions) as Impressions,
            SUM(f.delivery_units) as Delivered_Units
      FROM BI_DSP.ncd_fact_nexxen_dsp_state f
        INNER JOIN BI_DSP.dim_dsp_line_item li on f.line_item_id_key = li.line_item_id_key
        INNER JOIN BI_DSP.dim_dsp_package p on f.package_id_key = p.package_id_key
        LEFT JOIN BI_DSP.dim_dsp_creative c on f.creative_id_key = c.creative_id_key
      WHERE date > '2025-01-01'
        and impressions > 0
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
      ORDER BY 1 ASC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: line_item_name__c {
    type: string
    sql: ${TABLE}.line_item_name__c ;;
  }

  dimension: line_item_nickname {
    type: string
    sql: ${TABLE}.line_item_nickname ;;
  }

  dimension: line_item_nickname_status {
    type: string
    sql: ${TABLE}.line_item_nickname_status ;;
  }

  dimension: line_item_group_b {
    type: string
    sql: ${TABLE}.line_item_group_b ;;
  }

  dimension: line_item_group_c {
    type: string
    sql: ${TABLE}.line_item_group_c ;;
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: package_name {
    type: string
    sql: ${TABLE}.package_name ;;
  }

  dimension: package_nickname {
    type: string
    sql: ${TABLE}.package_nickname ;;
  }

  dimension: package_nickname_status {
    type: string
    sql: ${TABLE}.package_nickname_status ;;
  }

  dimension: package_group_b {
    type: string
    sql: ${TABLE}.package_group_b ;;
  }

  dimension: package_group_c {
    type: string
    sql: ${TABLE}.package_group_c ;;
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension: creative_group_a {
    type: string
    sql: ${TABLE}.creative_group_a ;;
  }

  dimension: creative_group_a_status {
    type: string
    sql: ${TABLE}.creative_group_a_status ;;
  }

  dimension: creative_group_b {
    type: string
    sql: ${TABLE}.creative_group_b ;;
  }

  dimension: creative_group_c {
    type: string
    sql: ${TABLE}.creative_group_c ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
    value_format: "#,##0"
  }

  measure: Delivered_Units {
    type: sum
    label: "Delivered Units"
    sql: ${TABLE}.Delivered_Units ;;
    value_format: "#,##0"
  }

  set: detail {
    fields: [
        date,
  account_name,
  advertiser_name,
  insertion_order_id,
  line_item_id,
  line_item_name__c,
  line_item_nickname,
  line_item_nickname_status,
  line_item_group_b,
  line_item_group_c,
  package_id,
  package_name,
  package_nickname,
  package_nickname_status,
  package_group_b,
  package_group_c,
  creative_id,
  creative_name,
  creative_group_a,
  creative_group_a_status,
  creative_group_b,
  creative_group_c
    ]
  }
}
