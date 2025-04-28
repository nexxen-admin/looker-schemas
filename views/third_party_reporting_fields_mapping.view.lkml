view: third_party_reporting_fields_mapping {
  sql_table_name: BI_DSP.third_party_reporting_fields_mapping ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }
  dimension: source_field {
    type: string
    sql: ${TABLE}.source_field ;;
  }
  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
  }
  dimension: target_field {
    type: string
    sql: ${TABLE}.target_field ;;
  }
}
