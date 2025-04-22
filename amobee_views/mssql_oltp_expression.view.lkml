view: mssql_oltp_expression {
  derived_table: {
    sql: SELECT
          ee.entity_id
          ,ee.entity_type_id
          ,e.expression_id
          ,e.expression_name
          ,e.expression_context_id
          ,ee.expression_entity_id
          ,e.expression_value_id
         FROM expression_v2 e (NOLOCK)
         JOIN expression_entity ee (NOLOCK) on ee.expression_id = e.expression_id and ee.active = 1 ;;
  }

  dimension: expression_id {
    type: number
    hidden: yes
    sql: ${TABLE}.expression_id ;;
  }

  dimension: expression_value_id {
    type: number
    hidden: yes
    sql: ${TABLE}.expression_value_id ;;
  }

  dimension: expression_name {
    type: string
    view_label: "Campaign"
    label: "Strategic Target Name"
    sql: ${TABLE}.expression_name ;;
  }

  dimension: expression_context_id {
    type: number
    hidden: yes
    sql: ${TABLE}.expression_context_id ;;
  }

  dimension: expression_entity_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.expression_entity_id ;;
  }

  dimension: entity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_id ;;
  }

  dimension: entity_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_type_id ;;
  }
}
