view: request_volume {
  sql_table_name: DIM.M_OVERRIDE ;;

  dimension: m_override_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.M_OVERRIDE_ID ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TIMEZONE_ID ;;
  }

  dimension: start_datetm {
    type: date_raw
    sql: ${TABLE}.START_DATETM ;;
  }

  dimension: end_datetm {
    type: date_raw
    sql: ${TABLE}.END_DATETM ;;
  }

  dimension: m_value {
    type: number
    hidden: yes
    sql: ${TABLE}.M_VALUE ;;
  }

  dimension: m_value_adjusted {
    type: number
    sql: ${TABLE}.M_VALUE_ADJUSTED ;;
  }

  measure: sum_request_volume {
    type: sum
    label: "Request Volume"
    sql: ${m_value_adjusted} ;;
  }

  measure: payout_new {
    type: sum
    label: "Payouts from Supply Volume"
    sql: (${TABLE}.M_VALUE_ADJUSTED/1000) * ${placement_details_base.default_min_cpm} ;;
  }

  dimension: active {
    type: number
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: added_by {
    type: string
    hidden: yes
    sql: ${TABLE}.ADDED_BY ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGE_SOURCE ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDBY ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: checksum_value {
    type: number
    hidden: yes
    sql: ${TABLE}.CHECKSUM_VALUE ;;
  }

  dimension: createdby {
    type: string
    sql: ${TABLE}.CREATEDBY ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: expiration_date {
    type: string
    hidden: yes
    sql: ${TABLE}.EXPIRATION_DATE ;;
  }

  dimension: media_run_type {
    type: string
    hidden: yes
    sql: ${TABLE}.MEDIA_RUN_TYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [m_override_id]
  }
}
