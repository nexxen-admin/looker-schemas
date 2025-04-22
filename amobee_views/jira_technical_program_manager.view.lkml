view: technical_program_manager {
  sql_table_name: public.cwd_user ;;


  dimension: user_email {
    type: string
    hidden: yes
    sql: ${TABLE}.lower_email_address ;;
  }

  dimension: manager {
    type: string
    view_label: "Custom Fields"
    sql: ${TABLE}.display_name ;;
  }
}
