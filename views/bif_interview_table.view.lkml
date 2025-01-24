
view: bif_interview_table {
  derived_table: {
    sql: SELECT
          -- From Sales_Log
          SL.Log_ID,
          SL.Date,
          SL.Store_ID,
          SL.Store_Name,
          SL.Employee,
          SL.Product_Type,
          SL.Items_Sold,
          SL.Revenue,

          -- From Employee
          E.Name AS Employee_Name,
          E.Referred_BY AS Referred_By,

          -- From Store_Info
          SI.Address,
          SI.State,
          SI.City,
          SI.Zip
      FROM
          bi.sales_test SL
      LEFT JOIN
          bi.Emplyee_test  E ON SL.Employee = E.Employee_ID
      LEFT JOIN
          bi.store_info_test SI ON SL.Store_ID = SI.Store_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: log_id {
    type: number
    sql: ${TABLE}.Log_ID ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype:  date
    sql: ${TABLE}."Date" ;;
  }

  dimension: store_id {
    type: number
    sql: ${TABLE}.Store_ID ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.Store_Name ;;
  }

  dimension: employee {
    type: number
    sql: ${TABLE}.Employee ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.Product_Type ;;
  }

  dimension: items_sold {
    type: number
    sql: ${TABLE}.Items_Sold ;;
  }

  dimension: revenue {
    type: number
    value_format: "$0.00"
    sql: ${TABLE}.Revenue ;;
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.Employee_Name ;;
  }

  dimension: referred_by {
    type: number
    sql: ${TABLE}.Referred_By ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.Address ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: zip {
    type: number
    value_format: "0"
    sql: ${TABLE}.Zip ;;
  }

  set: detail {
    fields: [
        log_id,
  store_id,
  store_name,
  employee,
  product_type,
  items_sold,
  revenue,
  employee_name,
  referred_by,
  address,
  state,
  city,
  zip
    ]
  }
}
