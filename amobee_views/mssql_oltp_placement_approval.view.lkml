view: placement_approval {
  sql_table_name: dbo.placement_approval (NOLOCK) ;;

  dimension: placement_approvalid {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_approvalid ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: approval_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_status_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: publisher_approval_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_approval_id ;;
  }
}
