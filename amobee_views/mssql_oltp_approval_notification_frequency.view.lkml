view: approval_notification_frequency {
  sql_table_name: dbo.approval_notification_frequency (NOLOCK) ;;

  dimension: approval_notification_frequency_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.approval_notification_frequency_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: description {
    type: string
    label: "Publisher Approval Notification Frequency"
    view_label: "Publisher"
    sql: ${TABLE}.description ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [approval_notification_frequency_id]
  }
}
