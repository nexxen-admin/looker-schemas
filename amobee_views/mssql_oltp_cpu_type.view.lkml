view: mssql_oltp_cpu_type {
  label: "Campaign"
  sql_table_name: dbo.cpu_type (NOLOCK) ;;

  dimension: cpu_type_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.cpu_type_id ;;
  }

  dimension: description {
    type: string
    label: "CPU Type"
    sql: ${TABLE}.description ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
