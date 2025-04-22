view: approval_status {
  sql_table_name: dbo.approval_status (NOLOCK) ;;

  dimension: approval_status_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.approval_status_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Approval Status"
    description: "Placement approval status."
    sql: ${TABLE}.description ;;
  }
}
