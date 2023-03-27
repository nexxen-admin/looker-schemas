view: mssql_oltp_partner_system_of_record {
  label: "Partner System Of a Record"
  sql_table_name: dbo.partner_system_of_record (NOLOCK) ;;

  dimension: system_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.system_id ;;
  }

  dimension: description {
    type: string
    label: "System of Record"
    sql: ${TABLE}.description ;;
  }
}
