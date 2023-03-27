view: mssql_oltp_global_settings {
  sql_table_name: AN_MAIN..global_settings (NOLOCK) ;;

  dimension: global_settings_id {
    type: number
    hidden: yes
    sql: ${TABLE}.global_settings_id ;;
  }

  dimension: setting_key {
    type: string
    hidden: yes
    sql: ${TABLE}.setting_key ;;
  }

  dimension: setting_value {
    type: string
    hidden: yes
    sql: ${TABLE}.setting_value ;;
  }
}
