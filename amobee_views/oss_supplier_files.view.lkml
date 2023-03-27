view: supplier_files {
  sql_table_name: public.supplier_files ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: contents {
    type: string
    sql: ${TABLE}.contents ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension_group: ingested {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ingested_at ;;
  }

  measure: last_ingestion_date {
    type: date_time
    sql: max(${TABLE}.ingested_at);;
  }

  measure: days_since_last_ingest {
    type: number
    sql: current_date - max(${TABLE}.ingested_at)::date ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: supplier_id {
    type: string
    sql: ${TABLE}.supplier_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
