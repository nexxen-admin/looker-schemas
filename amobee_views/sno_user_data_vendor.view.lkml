view: user_data_vendor {
  sql_table_name: DIM.USER_DATA_VENDOR ;;

  dimension: user_data_vendor_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.USER_DATA_VENDOR_ID ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: collider_payout_order {
    type: number
    hidden: yes
    sql: ${TABLE}.COLLIDER_PAYOUT_ORDER ;;
  }

  dimension: created_on {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATED_ON ;;
  }

  dimension: description {
    type: string
    label: "Data Cost Provider"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: expire_time {
    type: number
    hidden: yes
    sql: ${TABLE}.EXPIRE_TIME ;;
  }

  dimension: frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.FREQUENCY ;;
  }

  dimension: frequency_period {
    type: number
    hidden: yes
    sql: ${TABLE}.FREQUENCY_PERIOD ;;
  }

  dimension: is_modeling_allowed {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_MODELING_ALLOWED ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.LOOKUP_LOCALE_ID ;;
  }

  dimension: network_coverage_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.NETWORK_COVERAGE_PCT ;;
  }

  dimension: payout_order {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT_ORDER ;;
  }

  dimension: payout_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT_TYPE_ID ;;
  }

  dimension: preference_order {
    type: number
    hidden: yes
    sql: ${TABLE}.PREFERENCE_ORDER ;;
  }

  dimension: realtime_redirect_logger {
    type: yesno
    hidden: yes
    sql: ${TABLE}.REALTIME_REDIRECT_LOGGER ;;
  }

  dimension: realtime_redirect_request {
    type: yesno
    hidden: yes
    sql: ${TABLE}.REALTIME_REDIRECT_REQUEST ;;
  }

  dimension: user_data_vendor_type {
    type: string
    sql: ${TABLE}.USER_DATA_VENDOR_TYPE ;;
  }

  dimension: user_data_vendor_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_DATA_VENDOR_TYPE_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [user_data_vendor_id]
  }
}
