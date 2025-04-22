view: mssql_oltp_domain_blacklist {
  label: "Domain Blacklist"
  sql_table_name: dbo.domain_blacklist (NOLOCK) ;;

  dimension: domain_blacklist_id {
    type: number
    primary_key: yes
    label: "Domain Blacklist ID"
    sql: ${TABLE}.domain_blacklist_id ;;
    value_format_name: id
  }

  dimension: domain {
    type:  string
    label: "Domain URL"
    description: "Blacklisted Domain URL"
    sql: ${TABLE}.url_expression ;;
  }

  dimension_group: date {
    type: time
    label: "Domain Blacklisted"
    timeframes: [time, date, month, year]
    description: "Date when domain was blacklisted"
    sql: ${TABLE}.createdon ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active ;;
  }
}
