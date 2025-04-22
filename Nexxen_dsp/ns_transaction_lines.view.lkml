# The name of this view in Looker is "Ns Transaction Lines"
view: ns_transaction_lines {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.NS_TRANSACTION_LINES ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Manager Line" in Explore.

  dimension: account_manager_line {
    type: string
    sql: ${TABLE}.account_manager_line ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    hidden: yes
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
    hidden: yes
  }

  dimension: fulfillment_gross_amount {
    type: number
    sql: ${TABLE}.fulfillment_gross_amount ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: fulfillment_gross_rate {
    type: number
    sql: ${TABLE}.fulfillment_gross_rate ;;
    hidden: yes
  }

  dimension: gross_amount {
    type: number
    sql: ${TABLE}.gross_amount ;;
    hidden: yes
  }

  dimension: item_type_id {
    type: number
    sql: ${TABLE}.item_type_id ;;
    hidden: yes
  }

  dimension: net_amount {
    type: number
    label: "Passed Bill Amound"
    sql: ${TABLE}.net_amount ;;
  }

  dimension: net_rate {
    type: number
    sql: ${TABLE}.net_rate ;;
    hidden: yes
  }

  dimension: net_rate_usd {
    type: number
    sql: ${TABLE}.net_rate_usd ;;
    hidden: yes
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
    hidden: yes
  }

  dimension: product_family {
    type: string
    sql: ${TABLE}.product_family ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    hidden: yes
  }

  dimension: sales_rep_line {
    type: string
    sql: ${TABLE}.sales_rep_line ;;
    hidden: yes
  }

  dimension: service_type_id {
    type: number
    sql: ${TABLE}.service_type_id ;;
    hidden: yes
  }

  dimension: sf_io_line_item_name {
    type: string
    sql: ${TABLE}.sf_io_line_item_name ;;
    hidden: yes
  }

  dimension: sf_tran_line_id {
    type: string
    sql: ${TABLE}.sf_tran_line_id ;;
    hidden: yes
  }

  dimension: tax {
    type: number
    sql: ${TABLE}.tax ;;
    hidden: yes
  }

  dimension: trade_discount_amount {
    type: number
    sql: ${TABLE}.trade_discount_amount ;;
    hidden: yes
  }

  dimension: trade_discount_percent {
    type: number
    sql: ${TABLE}.trade_discount_percent ;;
    hidden: yes
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transaction_id ;;
    hidden: yes
  }

  dimension: transaction_line_id {
    type: number
    sql: ${TABLE}.transaction_line_id ;;
    hidden: yes
  }

  dimension: transaction_type {
    type: string
    sql: ${TABLE}.transaction_type ;;
  }
  measure: count {
    type: count
    drill_fields: [sf_io_line_item_name]
    hidden: yes
  }
}
