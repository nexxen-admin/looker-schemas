view: dim_dsp_adstxt_seller_status {
  sql_table_name: BI_DSP.dim_dsp_adstxt_seller_status ;;

  dimension: adstxt_seller_status {
    type: string
    label: "AdsTxt Seller Status"
    sql: ${TABLE}.adstxt_seller_status ;;
  }
  dimension: adstxt_seller_status_key {
    type: number
    sql: ${TABLE}.adstxt_seller_status_key ;;
    hidden: yes
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
