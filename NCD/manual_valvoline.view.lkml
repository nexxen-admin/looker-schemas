view: manual_valvoline {
  sql_table_name: BI_DSP.manual_valvoline ;;

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: advertiser_invoice {
    type: number
    sql: ${TABLE}.advertiser_invoice ;;
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: beacon_id {
    type: string
    sql: ${TABLE}.beacon_id ;;
  }
  dimension: beacon_name {
    type: string
    sql: ${TABLE}.beacon_name ;;
  }
  dimension: creative_id {
    type: string
    sql: ${TABLE}.creative_id ;;
  }
  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }
  dimension: custom_customer_type {
    type: string
    sql: ${TABLE}.custom_customer_type ;;
  }
  dimension: custom_discount_amt {
    type: number
    sql: ${TABLE}.custom_discount_amt ;;
  }
  dimension: custom_store_id {
    type: string
    sql: ${TABLE}.custom_store_id ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.data_date ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }
  dimension: dma {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.dma ;;
  }
  dimension: franchise {
    type: string
    sql: ${TABLE}.franchise ;;
  }
  dimension: household_action_value {
    type: number
    sql: ${TABLE}.household_action_value ;;
  }
  dimension: insertion_order_id {
    type: string
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  dimension: line_item_id {
    type: string
    sql: ${TABLE}.line_item_id ;;
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }
  dimension: package_id {
    type: string
    sql: ${TABLE}.package_id ;;
  }
  dimension: package_name {
    type: string
    sql: ${TABLE}.package_name ;;
  }

  dimension: turn_tpc {
    type: number
    sql: ${TABLE}.turn_tpc ;;
  }
  dimension: two_sec_viewable_imps {
    type: number
    sql: ${TABLE}.two_sec_viewable_imps ;;
  }
  dimension: xd_actions {
    type: number
    sql: ${TABLE}.xd_actions ;;
  }
  dimension: xd_shopping_cart_value_cta {
    type: number
    sql: ${TABLE}.xd_shopping_cart_value_cta ;;
  }
  dimension: xd_shopping_cart_value_vta {
    type: number
    sql: ${TABLE}.xd_shopping_cart_value_vta ;;
  }


  measure: actions {
    type: sum
    sql: ${TABLE}.actions ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: complete_events {
    type: sum
    sql: ${TABLE}.complete_events ;;
  }
  measure: derived_actions {
    type: sum
    label: "Customers"
    sql: ${TABLE}.derived_actions ;;
  }
  measure: household_actions {
    type: sum
    sql: ${TABLE}.household_actions ;;
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }
  measure: measurable_impressions {
    type: sum
    sql: ${TABLE}.measurable_imps ;;
  }
  measure: shopping_cart_value_cta {
    type: average
    sql: ${TABLE}.shopping_cart_value_cta ;;
  }
  measure: shopping_cart_value_vta {
    type: average
    sql: ${TABLE}.shopping_cart_value_vta ;;
  }
  measure: transaction_amount {
    type: sum
    sql:  ${TABLE}.transaction_amount ;;
    value_format: "$#,##0"
  }

  measure: html_kpi_transaction_amount {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Transaction Amount
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ transaction_amount._rendered_value }}
              </div>
            </div>;;
  }

  measure: html_kpi_derived_actions {
    type: count
    hidden: yes
    html:
           <div style=" display: inline-block; font-size: 15px; letter-spacing: 0.01em;">
              Customers
              <div style=" line-height: 15px; font-size: 23px; font-weight: 500;">
                {{ derived_actions._rendered_value }}
              </div>
            </div>;;
  }
}
