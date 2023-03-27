view: mssql_oltp_platform_client_preference {
  sql_table_name: AN_MAIN..platform_client_preference (NOLOCK) ;;

  dimension: platform_client_preference_id {
    type: number
    hidden: yes
    primary_key: yes
    value_format_name: id
    sql: ${TABLE}.platform_client_preference_id ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: preference_key {
    type: string
    hidden: yes
    sql: ${TABLE}.preference_key ;;
  }

  dimension: preference_value {
    type: string
    hidden: yes
    sql: COALESCE(${TABLE}.preference_value, 'False') ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
