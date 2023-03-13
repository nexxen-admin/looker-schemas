view: pub_req_content_attributes_report {
  derived_table: {
    sql: select *
      from Andromeda.pub_req_content_attributes_report
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_time {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_time ;;
  }

  dimension: pubid {
    type: string
    sql: ${TABLE}.pubid ;;
  }

  dimension: cntcontentrating {
    type: string
    sql: ${TABLE}.cntcontentrating ;;
  }

  dimension: contentratingnorm {
    type: string
    sql: ${TABLE}.contentratingnorm ;;
  }

  dimension: cntgenre {
    type: string
    sql: ${TABLE}.cntgenre ;;
  }

  dimension: genrenorm {
    type: string
    sql: ${TABLE}.genrenorm ;;
  }

  dimension: cntlanguage {
    type: string
    sql: ${TABLE}.cntlanguage ;;
  }

  dimension: cntlanguagenorm {
    type: string
    sql: ${TABLE}.cntlanguagenorm ;;
  }

  measure: count_ {
    type: sum
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [
      pubid,
      cntcontentrating,
      contentratingnorm,
      cntgenre,
      genrenorm,
      cntlanguage,
      cntlanguagenorm,
      count_
    ]
  }
}
