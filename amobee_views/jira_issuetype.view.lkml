view: issuetype {
  sql_table_name: public.issuetype ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: avatar {
    type: number
    hidden: yes
    sql: ${TABLE}.avatar ;;
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
    label: "Type"
    view_label: "Issue"
    sql: ${TABLE}.pname ;;
  }

  dimension: pstyle {
    type: string
    hidden: yes
    sql: ${TABLE}.pstyle ;;
  }

  dimension: sequence {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence ;;
  }


}
