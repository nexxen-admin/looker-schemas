view: customfieldvalue_rag_status {
  sql_table_name: public.customfieldvalue ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.customfield ;;
  }

  dimension: rag_status {
    type: string
    view_label: "Custom Fields"
    sql: CASE WHEN ${TABLE}.stringvalue = '27642' THEN 'RED'
       WHEN ${TABLE}.stringvalue = '27643' THEN 'AMBER'
       WHEN ${TABLE}.stringvalue = '27644' THEN 'GREEN'
       END ;;
    html: <b><font color={% if value == 'AMBER' %}'orange'{% else %} {{value}} {% endif %}>
    {{value}} </font></b>;;
  }
}
