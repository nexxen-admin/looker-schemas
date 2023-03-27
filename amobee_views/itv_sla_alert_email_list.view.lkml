view: sla_alert_email_list {
    sql_table_name: "SLA"."SLA_ALERT_EMAIL_LIST"
      ;;

    dimension: sla_alert_email_list_id {
      primary_key: yes
      type: string
      sql: ${TABLE}."SLA_ALERT_EMAIL_LIST_ID" ;;
    }

    dimension: to_list {
      type: string
      sql: ${TABLE}."TO_LIST" ;;
    }

    dimension: cc_list {
      type: string
      sql: ${TABLE}."CC_LIST" ;;
    }
}
