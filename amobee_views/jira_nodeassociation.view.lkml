view: nodeassociation {
  sql_table_name: public.nodeassociation ;;

  dimension: association_type {
    type: string
    hidden: yes
    sql: ${TABLE}.association_type ;;
  }

  dimension: source_node_id {
    type: number
    hidden: yes
    sql: ${TABLE}.source_node_id ;;
  }

  dimension: sink_node_id {
    type: number
    hidden: yes
    sql: ${TABLE}.sink_node_id ;;
  }
}
