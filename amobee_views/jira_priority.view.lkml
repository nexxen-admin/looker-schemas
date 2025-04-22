view: priority {
  sql_table_name: public.priority ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

  dimension: iconurl {
    type: string
    hidden: yes
    sql: ${TABLE}.iconurl ;;
  }

  dimension: pname {
    type: string
    label: "Priority"
    view_label: "Issue"
    sql: ${TABLE}.pname ;;
  }

  dimension: sequence {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence ;;
  }

  dimension: status_color {
    type: string
    hidden: yes
    sql: ${TABLE}.status_color ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [id, pname]
  }
}
