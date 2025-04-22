view: approval_review_type {
  sql_table_name: dbo.approval_review_type (NOLOCK) ;;

  dimension: approval_review_type_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.approval_review_type_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: description {
    type: string
    label: "Publisher Approval Review Type"
    view_label: "Publisher"
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.approval_review_type
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

}
