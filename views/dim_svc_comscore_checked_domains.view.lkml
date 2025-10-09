view: dim_svc_comscore_checked_domains {
  sql_table_name: bi.svc_comscore_checked_domains ;;

  dimension_group: create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date ;;
    hidden: yes
  }
  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
    hidden: yes
  }
  dimension: origin_domain_bi_key {
    type: number
    sql: ${TABLE}.origin_domain_bi_key ;;
    hidden: yes
  }
  dimension_group: update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.update_date ;;
    hidden: yes
  }
}
