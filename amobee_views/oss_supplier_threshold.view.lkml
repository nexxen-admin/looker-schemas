view: supplier_threshold {
  sql_table_name: public.supplier_threshold ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: threshold_days {
    type: number
    hidden: yes
    sql: ${TABLE}.threshold_days ;;
  }

  measure: num_threshold_days {
    type: max
    sql: ${threshold_days} ;;

  }

  measure: days_over_treshold {
    type: number
    sql: ${supplier_files.days_since_last_ingest} - ${supplier_threshold.num_threshold_days} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
