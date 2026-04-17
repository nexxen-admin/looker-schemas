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
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
    hidden: yes
  }

  dimension: ssp_name {
    type: string
    sql: ${TABLE}.SSP_name ;;
    hidden: yes
  }
  dimension: native_tv_supply_source {
    type: string
    label: "Native TV Supply Source"
    sql:   CASE WHEN ${TABLE}.PUB_ID = '78345' THEN 'LG'
                WHEN ${TABLE}.PUB_ID = '106233' THEN 'TCL'
                WHEN ${TABLE}.PUB_ID = '103128' THEN 'VIDAA'
            ELSE 'TBD' END ;;
    hidden: yes
  }


  measure: count {
    type: count
    drill_fields: [ssp_name]
    hidden: yes
  }
}
