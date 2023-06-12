view: project {
  sql_table_name: public.project ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: assigneetype {
    type: number
    hidden: yes
    sql: ${TABLE}.assigneetype ;;
  }

  dimension: avatar {
    type: number
    hidden: yes
    sql: ${TABLE}.avatar ;;
  }

  dimension: description {
    type: string
    label: "Project Description"
    view_label: "Project"
    sql: ${TABLE}.description ;;
  }

  dimension: lead {
    type: string
    label: "Project Lead"
    view_label: "Project"
    sql: ${TABLE}.lead ;;
  }

  dimension: originalkey {
    type: string
    hidden: yes
    sql: ${TABLE}.originalkey ;;
  }

  dimension: pcounter {
    type: number
    hidden: yes
    sql: ${TABLE}.pcounter ;;
  }

  dimension: project_pkey {
    type: string
    hidden: yes
    sql: ${TABLE}.pkey ;;
  }

  dimension: pname {
    type: string
    label: "Project Name"
    view_label: "Project"
    sql: ${TABLE}.pname ;;
  }

  dimension: projecttype {
    type: string
    label: "Project Type"
    view_label: "Project"
    sql: ${TABLE}.projecttype ;;
  }

  dimension: url {
    type: string
    #hidden: yes
    sql: ${TABLE}.url ;;
  }

  measure: count {
    type: count
    drill_fields: [id, pname]
  }
}
