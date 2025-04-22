view: dim_pad_agreement {
  sql_table_name: BI_New.dim_pad_agreement ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden:  yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
  dimension: pad_agreement_id {
    type: number
    sql: ${TABLE}.pad_agreement_id ;;
  }
  dimension: pad_agreement_key {
    type: number
    sql: ${TABLE}.pad_agreement_key ;;
    hidden: yes
  }
  dimension: pad_agreement_name {
    type: string
    sql: ${TABLE}.pad_agreement_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  measure: count {
    type: count
    drill_fields: [pad_agreement_name]
    hidden: yes
  }
}
