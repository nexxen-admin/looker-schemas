view: dim_device_type {
  sql_table_name: BI_New.V_Dim_Device_Type ;;

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

  dimension: device_type {
    label: "Device Type"
    description: "The device type in which the ad was displayed"
    type: string
    sql: ${TABLE}.Device_Type_ID ;;
    drill_fields: [dim_buying_channel.buying_channel, dim_dsp.dsp_display_name, dim_a_domain.a_domain, dim_o_domain.o_domain]

  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
