view: v_netsuite_international_report {
sql_table_name: BI_DSP.v_netsuite_international_report ;;

dimension: account_id {
  type: string
  sql: ${TABLE}.account_id ;;
  label: "Account ID"
}

dimension: actions {
  type: number
  sql: ${TABLE}.actions ;;
  label: "Actions"
}

dimension: billing_clicks {
  type: number
  sql: ${TABLE}.billing_clicks ;;
  label: "Billing Clicks"
}

dimension: billing_cost {
  type: number
  sql: ${TABLE}.billing_cost ;;
  label: "Billing Cost"
}

dimension: booked_rate {
  type: number
  sql: ${TABLE}.booked_rate ;;
  label: "Booked Rate"
}

dimension_group: date_key {
  type: time
  timeframes: [raw, time, date, week, month, quarter, year]
  sql: ${TABLE}.date_key ;;
  label: "Date Key"
}

dimension: do_not_bill {
  type: string
  sql: ${TABLE}.do_not_bill ;;
  label: "Do Not Bill"
}

dimension_group: IO_End {
  type: time
  timeframes: [raw, time, date, week, month, quarter, year]
  sql: ${TABLE}.io_end_date ;;
}

dimension: io_id {
  type: string
  sql: ${TABLE}.io_id ;;
  label: "IO ID"
}

dimension: io_key {
  type: string
  sql: ${TABLE}.io_key ;;
  label: "IO Key"
}

dimension: legal_entity {
  type: string
  sql: ${TABLE}.legal_entity ;;
  label: "Legal Entity"
}

dimension: line_item_name {
  type: string
  sql: ${TABLE}.line_item_name ;;
}

dimension: netsuite_billing_revenue {
  type: number
  sql: ${TABLE}.netsuite_billing_revenue ;;
  label: "NetSuite Billing Revenue"
}

dimension: netsuite_final_impressions {
  type: number
  sql: ${TABLE}.netsuite_final_impressions ;;
  label: "NetSuite Final Impressions"
}

dimension: partner_account_for_netsuite_revenue_feed {
  type: string
  sql: ${TABLE}.partner_account_for_netsuite_revenue_feed ;;
  label: "Partner Account for NetSuite Revenue Feed"
}

dimension: po_item_price_fixed_local_for_netsuite_revenue_feed {
  type: string
  sql: ${TABLE}.po_item_price_fixed_local_for_netsuite_revenue_feed ;;
  label: "PO Item Price (Fixed) (LOCAL) for NetSuite Revenue Feed"
}

dimension: po_item_price_type_for_netsuite_revenue_feed {
  type: string
  sql: ${TABLE}.po_item_price_type_for_netsuite_revenue_feed ;;
  label: "PO Item Price Type for NetSuite Revenue Feed"
}

dimension: po_number_for_netsuite_revenue_feed {
  type: string
  sql: ${TABLE}.po_number_for_netsuite_revenue_feed ;;
  label: "PO # for NetSuite Revenue Feed"
}

dimension: price_type {
  type: string
  sql: ${TABLE}.price_type ;;
  label: "Price Type"
}

dimension: io_type {
  type: string
  sql: ${TABLE}.io_type ;;
  label: "IO Type"
}

dimension: stage {
  type: string
  sql: ${TABLE}.stage ;;
  label: "Stage"
}
}
