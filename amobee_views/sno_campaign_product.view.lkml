view: campaign_product {
  sql_table_name: DIM.PRODUCT ;;

  dimension: product_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: checksum {
    type: number
    hidden: yes
    sql: ${TABLE}.CHECKSUM ;;
  }

  dimension: cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.CPU ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_ID ;;
  }

  dimension: fixed_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.FIXED_COST ;;
  }

  dimension: is_exclusive {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_EXCLUSIVE ;;
  }

  dimension: is_hidden {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_HIDDEN ;;
  }

  dimension: minimum_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.MINIMUM_SPEND ;;
  }

  dimension: minumum_units {
    type: number
    hidden: yes
    sql: ${TABLE}.MINUMUM_UNITS ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.NOTES ;;
  }

  dimension: product_category_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PRODUCT_CATEGORY_ID ;;
  }

  dimension: product_code {
    type: string
    hidden: yes
    sql: ${TABLE}.PRODUCT_CODE ;;
  }

  dimension: product_description {
    type: string
    hidden: yes
    sql: ${TABLE}.PRODUCT_DESCRIPTION ;;
  }

  dimension: product_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PRODUCT_NAME ;;
  }

  dimension: product_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PRODUCT_TYPE_ID ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [product_id, product_name]
  }
}
