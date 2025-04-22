view: opt_main_pricing_vendor {
  # You can specify the table name if it's different from the view name:
  sql_table_name: AN_MAIN..pricing_vendor ;;

  # Define your dimensions and measures here, like this:
  dimension: pricing_vendor_id {
    description: "Vendor ID"
    type: number
    sql: ${TABLE}.pricing_vendor_id ;;
    value_format_name: id
  }

  dimension: vendor_name {
    description: "Pricing Vendor Name"
    type: string
    sql: ${TABLE}.description ;;
  }

}
