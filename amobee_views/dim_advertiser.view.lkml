view: dim_advertiser {
  sql_table_name: SunFlower.dim_advertiser ;;

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden: yes
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
    hidden:  yes
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden:  yes
  }
  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
    hidden: yes
  }
  dimension: external_advertiser_id {
    type: string
    sql: ${TABLE}.external_advertiser_id ;;
    hidden: yes
  }
  dimension: identity_platform_vendor_id {
    type: number
    sql: ${TABLE}.identity_platform_vendor_id ;;
    hidden: yes
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }
  dimension: local_currency_id {
    type: number
    sql: ${TABLE}.local_currency_id ;;
    hidden:  yes
  }
  dimension: market_id {
    type: number
    sql: ${TABLE}.market_id ;;
    hidden:  yes
  }
  dimension: time_zone_code {
    type: string
    sql: ${TABLE}.time_zone_code ;;
    hidden:  yes
  }
  measure: count {
    type: count
    drill_fields: [advertiser_name]
  }
}
