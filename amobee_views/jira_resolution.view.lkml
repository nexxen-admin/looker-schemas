view: resolution {
  sql_table_name: public.resolution ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: description {
    type: string
    label: "Resolution Description"
    hidden: yes
    view_label: "Issue"
    sql: ${TABLE}.description ;;
  }

  dimension: iconurl {
    type: string
    hidden: yes
    sql: ${TABLE}.iconurl ;;
  }

  dimension: pname {
    type: string
    label: "Resolution"
    view_label: "Issue"
    sql: ${TABLE}.pname ;;
  }

  dimension: sequence {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [id, pname]
  }
}
