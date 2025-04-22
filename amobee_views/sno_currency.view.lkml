view: plan_currency {
  sql_table_name: DIM.CURRENCY ;;

  dimension: currency_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_ID ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: currency_abbreviation {
    type: string
    label: "Plan Currency"
    view_label: "Plan"
    description: "Currency set on the Plan."
    #required_fields: [campaign_details_base.pl_plan_id,pl_plan.native_currency_id]
    sql: ${TABLE}.CURRENCY_ABBREVIATION ;;
  }

  dimension: currency_name {
    type: string
    hidden: yes
    sql: ${TABLE}.CURRENCY_NAME ;;
  }

  dimension: currency_symbol {
    type: string
    hidden: yes
    sql: ${TABLE}.CURRENCY_SYMBOL ;;
  }


}
