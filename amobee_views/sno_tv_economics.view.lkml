view: tv_economics {
  sql_table_name: PUBLIC.TV_ECONOMICS ;;

  dimension: economic_type_desc {
    type: string
    hidden: yes
    sql: ${TABLE}.ECONOMIC_TYPE_DESC ;;
  }

  dimension: economic_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ECONOMIC_TYPE_ID ;;
  }

  dimension: pay_schedule_desc {
    type: string
    hidden: yes
    sql: ${TABLE}.PAY_SCHEDULE_DESC ;;
  }

  dimension: pay_schedule_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PAY_SCHEDULE_ID ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
  }

  dimension: platform_client_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_NAME ;;
  }

  dimension: rev_flag {
    type: number
    hidden: yes
    sql: ${TABLE}.REV_FLAG ;;
  }

  dimension: value {
    type: number
    hidden: yes
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [platform_client_name]
  }
}
