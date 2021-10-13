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
    sql: ${TABLE}.DSP_Account_ID ;;
    hidden: yes
  }

  dimension: dsp_account_key {
    type: number
    sql: ${TABLE}.DSP_Account_Key ;;
    hidden: yes
  }

  dimension: dsp_display_name {
    label: "DSP Display Name"
    type: string
    sql: ${TABLE}.DSP_DISPLAY_NAME ;;
    hidden: yes
  }

  dimension: dsp_id {
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
    label: "DSP"
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: is_1st_party {
    label: "Is 1st Party"
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
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
