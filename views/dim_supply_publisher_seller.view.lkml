view: dim_supply_publisher_seller {
  sql_table_name: BI_New.dim_supply_publisher_seller ;;

  dimension_group: db_create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }
  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }
  dimension: pub_seller_id {
    type: number
    sql: ${TABLE}.pub_seller_id ;;
    hidden: yes
  }
  dimension: publisher_id {
    type: number
    sql: ${TABLE}.publisher_id ;;
    hidden: yes
  }
  dimension: seller_id {
    type: string
    sql: ${TABLE}.seller_id ;;
  }
  dimension: seller_type {
    type: string
    sql: ${TABLE}.seller_type ;;
  }
  measure: count {
    type: count
    hidden: yes
  }
}
