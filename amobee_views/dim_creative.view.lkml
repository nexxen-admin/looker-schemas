view: dim_creative {
  sql_table_name: SunFlower.dim_creative ;;

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden:  yes
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden:  yes
  }
  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
    hidden:  yes
  }
  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden:  yes
  }
  dimension: tpa_external_id {
    type: string
    sql: ${TABLE}.tpa_external_id ;;
    hidden:  yes
  }
  measure: count {
    type: count
    drill_fields: [creative_name]
    hidden:  yes
  }
}
