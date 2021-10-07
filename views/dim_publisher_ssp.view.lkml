view: dim_publisher_ssp {
  sql_table_name: BI_New.V_Dim_Publisher_SSP ;;

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
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.PUB_ID ;;
  }

  dimension: pub_key {
    type: number
    sql: ${TABLE}.PUB_Key ;;
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
  }

  dimension: ssp_name {
    type: string
    sql: ${TABLE}.SSP_name ;;
  }

  measure: count {
    type: count
    drill_fields: [ssp_name]
  }
}
