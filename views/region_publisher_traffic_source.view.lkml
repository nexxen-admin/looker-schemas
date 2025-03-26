view: region_publisher_traffic_source {
  sql_table_name: BI_New.region_publisher_traffic_source ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
  }
  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }
  dimension: pub_ts_id {
    type: number
    sql: ${TABLE}.pub_ts_id ;;
  }
  dimension: publisher_id {
    type: number
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  measure: qps_defined {
    type: min
    sql: ${TABLE}.qps_defined ;;
  }
  measure: qps_limit {
    type: min
    sql: ${TABLE}.qps_limit ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  measure: count {
    type: count
    drill_fields: [placement_name, publisher_name]
    hidden: yes
  }
}
