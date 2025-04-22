view: rta_rules_present {
  view_label: "RTA Rules Present"
  sql_table_name: an_smart..rules_violation ;;
  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: rta_group_id {
    type: number
    label: "RTA Group ID"
    sql: ${TABLE}.rta_group_id ;;
    value_format_name: id
  }

  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    description: "The internal system identifier for the campaign."
    sql: ${TABLE}.campaign_id;;
    value_format_name: id
  }

  dimension: campaign_name {
    type: string
    label: "Campaign"
    description: "The Camapaign Name"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_status_id {
    type: number
    label: "Campaign Status ID"
    description: "The ID of the campaign status."
    sql: ${TABLE}.campaign_status_id ;;
    value_format_name: id
  }

  dimension_group: begin_date {
    type: time
    label: "Campaign Begin"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time that the campaign starts(ed)."
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension_group: end_date {
    type: time
    label: "Campaign End"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time that the campaign ends(ed)."
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: flight_media_id {
    type: number
    #hidden: yes
    sql: ${TABLE}.flight_media_id;;
    value_format_name: id
  }

  dimension: attribute_value_id {
    type: number
    label: "Attribute Value ID"
    sql: ${TABLE}.attribute_value_id ;;
    value_format_name: id
  }

  dimension: attribute_value_name {
    type: string
    label: "Attribute Value Description"
    sql: ${TABLE}.retargeting_attribute_name ;;
  }

  dimension: bt_rule_present {
    type: number
    hidden: yes
    label: "BT Rule Present"
    sql: ${TABLE}.bt_rule_present ;;
  }

  measure: sum_bt_rule_present {
    type: sum
    hidden: yes
    label: "BT Rule Present"
    sql: ${bt_rule_present} ;;
  }

  measure:  bt_rule_is_present{
    type: string
    label: "BT Rule Present"
    sql: CASE when ${sum_bt_rule_present} <= 0 then 'No' else 'Yes' end ;;
  }



  dimension: demo_rule_present {
    type: number
    hidden: yes
    label: "Demo Rule Present"
    sql: ${TABLE}.demo_rule_present ;;
  }

  measure: sum_demo_rule_present {
    type: sum
    hidden: yes
    label: "Demo Rule Present"
    sql: ${demo_rule_present} ;;
  }

  measure:  demo_rule_is_present{
    type: string
    label: "Demo Rule Present"
    sql: CASE when ${sum_demo_rule_present} <= 0 then 'No' else 'Yes' end ;;
  }

  measure:  in_failure_state{
    type: string
    label: "In Failure State"
    sql: CASE when ${sum_demo_rule_present} + ${sum_bt_rule_present} <= 0 then 'No' else 'Yes' end ;;
  }

  measure: count {
    type: count
    }


 }
