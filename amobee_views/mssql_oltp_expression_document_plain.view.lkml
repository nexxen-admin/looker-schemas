view: mssql_oltp_expression_document_plain {
  sql_table_name: dbo.expression_document_plain (NOLOCK) ;;

  dimension: expression_document_plain_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.expression_document_plain_id ;;
  }

  dimension: expression_document_id {
    type: number
    hidden: yes
    sql: ${TABLE}.expression_document_id ;;
  }

  dimension: expression_group_type {
    type: string
    hidden: yes
    sql: ${TABLE}.expression_group_type ;;
  }

  dimension: expression_group_item {
    type: string
    hidden: yes
    sql: ${TABLE}.expression_group_item ;;
  }

}
