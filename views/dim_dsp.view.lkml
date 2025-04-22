view: dim_dsp {
  sql_table_name: BI_New.V_Dim_DSP ;;

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

  dimension: dsp_account_id {
    type: number
    description: " "
    sql: ${TABLE}.DSP_Account_ID ;;
    hidden: yes
  }

  dimension: dsp_account_key {
    type: number
    sql: ${TABLE}.DSP_Account_Key ;;
    hidden: yes
  }

  dimension: dsp_display_name {
    label: "DSP"
    description: "DSP seat Name - the gateway in which a speficic inventory is sent to the DSP"
    type: string
    sql: ${TABLE}.DSP_DISPLAY_NAME ;;
    drill_fields: [dim_device_type.device_type, dim_buying_channel.buying_channel, dim_publisher.pub_name, dim_a_domain.a_domain, dim_placement.media_type, dim_imp_type.imp_type]
  }

  dimension: dsp_id {
    description: "The uniqe ID recevied from the DSP in order to identify him"
    label: "DSP ID"
    type: string
    sql: ${TABLE}.DSP_ID ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_name {
    description: "RX_DSP_Name"
    label: "RX_DSP_Name"
    type: string
    sql: ${TABLE}.DSP_Name ;;
    #hidden: yes
  }


  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [dsp_display_name, dsp_name]
    hidden: yes
  }
}
