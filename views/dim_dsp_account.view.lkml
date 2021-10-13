view: dim_dsp_account {
  sql_table_name: BI_New.V_Dim_DSP_Account ;;

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
    label: "DSP Account ID"
    type: number
    sql: ${TABLE}.DSP_Account_ID ;;
  }

  dimension: dsp_account_key {
    type: number
    sql: ${TABLE}.DSP_Account_Key ;;
    hidden: yes
  }

  dimension: dsp_account_name {
    label: "DSP Account"
    type: string
    sql: ${TABLE}.DSP_Account_Name ;;
  }

  dimension: supply_brand {
    label: "Supply Brand"
    type: string
    sql: ${TABLE}.Supply_Brand ;;
  }

  measure: count {
    type: count
    drill_fields: [dsp_account_name]
    hidden: yes
  }
}
