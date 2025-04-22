view: issuestatus {
  sql_table_name: public.issuestatus ;;

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
    label: "Status"
    view_label: "Issue"
    sql: ${TABLE}.pname ;;
  }

  dimension: sequence {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence ;;
  }

  dimension: statuscategory {
    type: number
    hidden: yes
    sql: ${TABLE}.statuscategory ;;
  }

  measure: not_closed_issues_count {
    type: sum
    view_label: "Issue"
    sql: CASE WHEN ${issuestatus.statuscategory} != 3 THEN 1 END ;;
  }
}
