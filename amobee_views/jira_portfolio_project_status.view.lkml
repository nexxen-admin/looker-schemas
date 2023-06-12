view: portfolio_project_status {
  sql_table_name: public.issuestatus ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: iconurl {
    type: string
    hidden: yes
    sql: ${TABLE}.iconurl ;;
  }

  dimension: pname {
    type: string
    label: "Status"
    view_label: "Portfolio Project"
    sql: ${TABLE}.pname ;;
  }
}
