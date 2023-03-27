view: opt_retargeting_attribute {
  sql_table_name: AN_MAIN..retargeting_attribute ;;

  dimension: retargeting_attribute_id {
    primary_key: yes
    type: number
    description: "Videology’s ID to identify the segment"
    sql: ${TABLE}.retargeting_attribute_id ;;
    value_format_name: id
  }

  dimension: active {
    type: string
    description: "Status on retargeting attribute"
    sql: ${TABLE}.active ;;
  }

  dimension: behavioral_category_id {
    type: number
    hidden: yes
    sql: ${TABLE}.behavioral_category_id ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
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
    hidden: yes
    sql: ${TABLE}.changedon ;;
  }

  dimension: collider_payout_order {
    type: number
    hidden: yes
    sql: ${TABLE}.collider_payout_order ;;
  }

  dimension: cookies_set {
    type: number
    hidden: yes
    sql: ${TABLE}.cookies_set ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
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
    description: "Date Segment was Created"
    sql: ${TABLE}.createdon ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: data_vendor_cost_id {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vendor_cost_id ;;
  }

  dimension: format_type_category_id {
    type: number
    hidden: yes
    sql: ${TABLE}.format_type_category_id ;;
  }

  dimension: is_hidden {
    type: string
    hidden: yes
    sql: ${TABLE}.is_hidden ;;
  }

  dimension: is_mediaplanner_only {
    type: string
    hidden: yes
    sql: ${TABLE}.is_mediaplanner_only ;;
  }

  dimension: is_postalcode_targets_enabled {
    type: string
    hidden: yes
    sql: ${TABLE}.is_postalcode_targets_enabled ;;
  }

  dimension: is_secured {
    type: string
    hidden: yes
    sql: ${TABLE}.is_secured ;;
  }

  dimension_group: last_received {
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
    hidden: yes
    sql: ${TABLE}.last_received ;;
  }

  dimension: long_description {
    type: string
    hidden: yes
    sql: ${TABLE}.long_description ;;
  }

  dimension: lookback_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.lookback_hours ;;
  }

  dimension: lookback_unit {
    type: number
    hidden: yes
    sql: ${TABLE}.lookback_unit ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: monthly_population_estimate {
    type: number
    hidden: yes
    sql: ${TABLE}.monthly_population_estimate ;;
  }

  dimension: network_coverage_pct {
    type: number
    sql: ${TABLE}.network_coverage_pct ;;
  }

  dimension: original_data_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.original_data_vendor_id ;;
  }

  dimension: payout_order {
    type: number
    hidden: yes
    sql: ${TABLE}.payout_order ;;
  }

  dimension: pixel_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pixel_type_id ;;
  }

  dimension: platform_client_id {
    type: number
    description: "Videology’s ID to identify the platform client"
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: ref_key_id {
    type: number
    label: "Data Provider ID"
    description: "Videology ID of the Data Provider"
    sql: ${TABLE}.ref_key_id ;;
    value_format_name: id
  }

  dimension: retargeting_attribute_description {
    type: string
    hidden: yes
    sql: ${TABLE}.retargeting_attribute_description ;;
  }

  dimension: retargeting_attribute_name {
    type: string
    description: "Videology’s name to identify the segment"
    sql: ${TABLE}.retargeting_attribute_name ;;
  }

  dimension: retargeting_attribute_type_id {
    type: number
    sql: ${TABLE}.retargeting_attribute_type_id ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: [retargeting_attribute_id, retargeting_attribute_name]
  }
}
