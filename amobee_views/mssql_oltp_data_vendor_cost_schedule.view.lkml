view: mssql_oltp_data_vendor_cost_schedule {
  view_label: "Vendor Cost Schedule"
  sql_table_name: dbo.data_vendor_cost_schedule (NOLOCK) ;;

  dimension: data_vendor_cost_schedule_id {
    primary_key: yes
    type: number
    label: "Cost Schedule ID"
    sql: ${TABLE}.data_vendor_cost_schedule_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: cost {
    type: number
    label: "Cost"
    value_format_name: decimal_2
    sql: ${TABLE}.cost ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: payout_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.payout_type_id ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension_group: begin_date {
    type: time
    label: "Begin"
    timeframes: [date]
    sql: CONVERT(VARCHAR, ${TABLE}.begin_datetime, 101) ;;
  }

  dimension_group: end_datetime {
    type: time
    label: "End"
    timeframes: [date]
    sql: CONVERT(VARCHAR, ${TABLE}.end_datetime, 101) ;;
  }
}
