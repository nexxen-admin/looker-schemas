view: dim_deal_camp {
  sql_table_name: BI_New.Dim_Deal ;;

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.deal_key ;;
    hidden: yes
  }

  dimension: deal_campaign {
    type: string
    sql: ${TABLE}.deal_campaign ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
