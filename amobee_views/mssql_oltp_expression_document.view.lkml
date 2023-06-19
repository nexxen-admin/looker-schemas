view: mssql_oltp_expression_document {
  sql_table_name: dbo.expression_document (NOLOCK) ;;

  dimension: expression_document_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.expression_document_id ;;
  }

  dimension: expression {
    type: string
    view_label: "Campaign"
    label: "Buy Demo Audience"
    sql: ${TABLE}.expression ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

}
