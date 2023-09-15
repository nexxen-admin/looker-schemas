view: v_campaign_addon_product {
  sql_table_name: DIM.CAMPAIGN_ADDON_PRODUCT_VIEW ;;

  dimension: campaign_addon_id {
    type: number
    label: "Campaign Addon ID"
    description: "Identification Number for tracking Addon Products on the Platform"
    sql: ${TABLE}.CAMPAIGN_ADDON_ID ;;
    value_format_name: id
  }

  dimension: campaign_addon_active {
    type: yesno
    label: "Campaign Product Active"
    description: "A yes/no indicator if the campaign addon is active"
    sql: ${TABLE}.ADDON_ACTIVE ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: cpu {
    type: number
    label: "Campaign Product CPU"
    description: "CPU of the Campaign Add-on Product"
    value_format_name: decimal_2
    sql: ${TABLE}.CPU ;;
  }

  dimension: cpu_demand {
    type: number
    label: "Add-on CPU - Demand Currency"
    description: "CPU of the Campaign Add-on Product"
    value_format_name: decimal_2
    sql: ${TABLE}.CPU * ${v_campaign_product_exchange_rates.exchange_rate};;
  }

  dimension: fixed_cost {
    type: number
    label: "Campaign Product Fixed Cost"
    description: "Fixed Cost of the Campaign Product"
    value_format_name:  decimal_2
    sql: ${TABLE}.FIXED_COST ;;
  }

  dimension: product_id {
    type: number
    label: "Campaign Product ID"
    description: "Identification Number of the Product Addon Associated with the Campaign"
    sql: ${TABLE}.PRODUCT_ID ;;
    value_format_name: id
  }

  dimension: product_name {
    type: string
    label: "Campaign Product Name"
    description: "Campaign Addon Product Name that the Campaigns were Targeted to"
    sql: ${TABLE}.PRODUCT_NAME ;;
  }

  dimension: purchase_order {
    type: string
    label: "Campaign Product Purchase Order"
    description: "Purchase of the Campaign Product"
    sql: ${TABLE}.PURCHASE_ORDER ;;
  }

  dimension: PRODUCT_PAYER_TYPE_ID {
    type: number
    label: "Campaign Product Payer Type ID"
    description: "Identification ID of the Payer"
    sql: ${TABLE}.PRODUCT_PAYER_TYPE_ID ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
