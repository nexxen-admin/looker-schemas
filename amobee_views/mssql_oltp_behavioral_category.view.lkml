view: mssql_oltp_behavioral_category {
  sql_table_name: dbo.behavioral_category (NOLOCK) ;;

  dimension: behavioral_category_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.behavioral_category_id ;;
  }

  dimension: description {
    type: string
    label: "Industry Segment Name"
    view_label: "Brand"
    sql: COALESCE(${TABLE}.description, '') ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active ;;
  }

}
