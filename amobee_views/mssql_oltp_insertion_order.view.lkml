view: mssql_oltp_insertion_order {
  sql_table_name: dbo.insertion_order (NOLOCK) ;;
  label: "Insertion Order"

  dimension: insertion_order_id {
    primary_key: yes
    type: number
    description: "The internal identifier of the Insertion Order."
    sql: ${TABLE}.insertion_order_id ;;
    value_format_name: id
  }

  dimension: insertion_order_name {
    type: string
    label: "Insertion Order"
    description: "The name of the Insertion Order."
    sql: ${TABLE}.insertion_order_name ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.insertion_order_name
  }

  dimension: io_active {
    type: yesno
    label: "IO Active"
    description: "A yes/no indicator if the Insertion Order is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: io_status {
    type: string
    label: "IO Status"
    sql: case when ${io_active} then 'Approved' else 'Not Approved' end ;;
  }

  dimension_group: io_createdon {
    type: time
    label: "IO Created"
    description: "The date the advertiser was created in the system."
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: io_begin_date {
    type: time
    label: "IO Begin"
    description: "The start date of the Insertion Order"
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.begin_date ;;
  }

  dimension_group: io_end_date {
    type: time
    label: "IO End"
    description: "The end date of the Insertion Order"
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.end_date ;;
  }

  dimension: io_impressions {
    type: number
    hidden: yes
    label: "Insertion Order Impressions"
    description: "Impressions set on the IO"
    sql: ${TABLE}.impressions ;;
  }

  dimension: budget {
    type: number
    label: "Insertion Order Budget"
    description: "The insertion order budget as it is setup in the system."
    sql: ${TABLE}.budget ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

}
