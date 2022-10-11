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

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
  }

  dimension: ssp_name {
    type: string
    sql: ${TABLE}.SSP_name ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [ssp_name]
    hidden: yes
  }
}
