view: mssql_oltp_country {
  view_label: "Country"
  sql_table_name: dbo.country (NOLOCK) ;;

  dimension: country_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.country_id ;;
  }

  dimension: description {
    type: string
    label: "Country"
    sql: ${TABLE}.description ;;
  }
}
