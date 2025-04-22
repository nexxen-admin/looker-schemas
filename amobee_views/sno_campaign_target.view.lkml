view: sno_campaign_target {
  sql_table_name: DIM.CAMPAIGN_TARGET ;;
  label: "Campaign Target"

  dimension: campaign_target_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_TARGET_ID ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ATTRIBUTE_ID ;;
  }

  dimension: attribute_value_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: is_negative {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_NEGATIVE ;;
  }
}
