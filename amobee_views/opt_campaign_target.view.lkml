view: campaign_target {
  sql_table_name: AN_MAIN..campaign_target ;;

  dimension: campaign_target_id {
    primary_key: yes
    type: number
    description: "Videology’s ID to identify the targeted campaign"
    sql: ${TABLE}.campaign_target_id ;;
    value_format_name: id
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_id ;;
  }

  dimension: attribute_value_id {
    type: number
    label: "Attribute ID - Targeted"
    description: "Attibute ID on targeted campaigns"
    sql: ${TABLE}.attribute_value_id ;;
    value_format_name: id
  }

  dimension: campaign_id {
    type: number
    description: "Videology’s ID to identify the campaign"
    label: "Campaign ID (Camapign Tartget)"
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
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
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

  dimension: is_negative {
    type: string
    hidden: yes
    sql: ${TABLE}.is_negative ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_target_id]
  }
}
