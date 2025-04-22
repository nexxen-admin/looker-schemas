view: mssql_oltp_localization_resource_13_5 {
  sql_table_name: dbo.localization_resource_13_5 (NOLOCK) ;;

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: locale_id {
    type: number
    hidden: yes
    sql: ${TABLE}.locale_id ;;
  }

  dimension: text_name {
    type: string
    hidden: yes
    sql: ${TABLE}.text_name ;;
  }

  dimension: text_value {
    type: string
    view_label: "Campaign"
    label: "Universe"
    sql: ${TABLE}.text_value ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: app_id {
    type: number
    hidden: yes
    sql: ${TABLE}.app_id ;;
  }
}
