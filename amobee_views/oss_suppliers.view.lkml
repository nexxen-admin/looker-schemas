view: suppliers {
  sql_table_name: public.suppliers ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: partner_id {
    type: number
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  dimension: platform_client_ids {
    type: string
    sql: ${TABLE}.platform_client_ids ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
