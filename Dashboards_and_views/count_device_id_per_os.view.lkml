view: count_device_id_per_os {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
       BB.os as os,
       AA.device_id as device_id
FROM dragon.viewership_content_sessions_combined_daily AA
LEFT JOIN dragon.device_info_r BB
ON AA.device_id = BB.device_id
 ;;
  }

  dimension: count {
    type: number
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}."os" ;;
  }

  dimension: device_id {
    type: string
    sql: ${TABLE}."device_id" ;;
  }


  set: detail {
    fields: [date, os,device_id]
  }
}
