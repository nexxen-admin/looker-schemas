view: dim_publisher_traffic_source {
  sql_table_name: BI_New.V_Dim_Publisher_Traffic_Source ;;

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

  dimension: is_active {
    label: "Is Active"
    type: yesno
    sql: ${TABLE}.Is_Active ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.PUB_ID ;;
    hidden: yes
  }

  dimension: pub_key {
    type: number
    sql: ${TABLE}.PUB_Key ;;
    hidden: yes
  }

  dimension_group: pub_ts_created {
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
    sql: ${TABLE}.Pub_TS_Created_At ;;
    hidden: yes
  }

  dimension: pub_ts_id {
    type: number
    sql: ${TABLE}.PUB_TS_ID ;;
    hidden: yes
  }

  dimension: pub_ts_key {
    type: number
    sql: ${TABLE}.PUB_TS_Key ;;
    hidden: yes
  }

  dimension_group: pub_ts_update {
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
    sql: ${TABLE}.Pub_Ts_Update_At ;;
    hidden: yes
  }

  dimension: traffic_source_id {
    type: number
    sql: ${TABLE}.Traffic_Source_ID ;;
    hidden: yes
  }

  dimension: ts_key {
    type: number
    sql: ${TABLE}.TS_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
