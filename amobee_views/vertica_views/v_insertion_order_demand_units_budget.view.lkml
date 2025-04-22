view: v_insertion_order_demand_units_budget {
  sql_table_name: DIM.DEMAND_UNITS_BUDGET_VIEW ;;

  dimension: budget {
    type: number
    label: "Insertion Order Budget"
    view_label: "Insertion Order"
    hidden: yes
    description: "The insertion order budget as it is setup in the system."
    sql: ${TABLE}.BUDGET ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_budget {
    type: sum
    label: "Insertion Order Budget"
    view_label: "Insertion Order"
    description: "The Insertion Order Budget."
    #hidden: yes
    value_format_name: decimal_2
    sql: ${TABLE}.BUDGET ;;
  }

  measure: avg_daily_budget {
    type: number
    label: "Average Daily Budget"
    view_label: "Insertion Order"
    description: "The average daily budget for an insertion order."
    hidden: yes
    value_format_name: decimal_2
    sql: ${sum_budget}/${v_insertion_order_details.total_days} ;;
  }

  measure: avg_monthly_budget {
    type: number
    label: "Average Monthly Budget"
    view_label: "Insertion Order"
    description: "The average monthly budget for an insertion order."
    hidden: yes
    value_format_name: decimal_2
    sql: CASE WHEN datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})>30
      THEN COALESCE((${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0)*30),0)
      ELSE 0
      END
      ;;
  }

  measure: 2018_budget {
    type: number
    label: "2018 Budget"
    view_label: "Insertion Order"
    description: "The total insertion order budget for 2018."
    hidden: yes
    value_format_name: decimal_2
    sql: COALESCE (${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0), 0) *
      CASE WHEN (${v_insertion_order_details.io_end_date} > '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} < '2019-01-01')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-12-31')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, '2019-01-01 04:59:59') +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} < '2019-01-01 04:59:59')
                THEN (datediff(dd, '2018-01-01 04:59:59', ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_begin_date} < '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-12-31 04:59:59')
                THEN 365
        ELSE 0
            END ;;
  }


  measure: 2018_q1_budget {
    type: number
    label: "2018 Q1 Budget"
    view_label: "Insertion Order"
    description: "The total insertion order budget for the 1st Quarter of 2018."
    hidden: yes
    value_format_name: decimal_2
    sql: COALESCE (${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0), 0) *
      CASE WHEN (${v_insertion_order_details.io_end_date} < '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-01-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-01-01 04:59:59')
                THEN 90
           WHEN (${v_insertion_order_details.io_end_date} < '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-01-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-01-01 04:59:59')
                THEN (datediff(dd, '2018-01-01 04:59:59', ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} < '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-01-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, '2018-03-31 04:59:59') +1)
        ELSE 0
            END ;;
  }

  measure: 2018_q2_budget {
    type: number
    label: "2018 Q2 Budget"
    view_label: "Insertion Order"
    description: "The total insertion order budget for the 2nd Quarter of 2018."
    hidden: yes
    value_format_name: decimal_2
    sql: COALESCE (${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0), 0) *
      CASE WHEN (${v_insertion_order_details.io_end_date} < '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-04-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-04-01 04:59:59')
                THEN 90
           WHEN (${v_insertion_order_details.io_end_date} < '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-04-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-04-01 04:59:59')
                THEN (datediff(dd, '2018-04-01 04:59:59', ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} < '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-04-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, '2018-06-30 04:59:59') +1)
        ELSE 0
            END ;;
  }

  measure: 2018_q3_budget {
    type: number
    label: "2018 Q3 Budget"
    view_label: "Insertion Order"
    description: "The total insertion order budget for the 3rd Quarter of 2018."
    hidden: yes
    value_format_name: decimal_2
    sql: COALESCE (${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0), 0) *
      CASE WHEN (${v_insertion_order_details.io_end_date} < '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-07-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-07-01 04:59:59')
                THEN 90
           WHEN (${v_insertion_order_details.io_end_date} < '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-07-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-07-01 04:59:59')
                THEN (datediff(dd, '2018-07-01 04:59:59', ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} < '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-07-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, '2018-09-30 04:59:59') +1)
        ELSE 0
            END ;;
  }

  measure: 2018_q4_budget {
    type: number
    label: "2018 Q4 Budget"
    view_label: "Insertion Order"
    description: "The total insertion order budget for the 4th Quarter of 2018."
    hidden: yes
    value_format_name: decimal_2
    sql: COALESCE (${sum_budget}::FLOAT/NULLIF((datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date})+1), 0), 0) *
      CASE WHEN (${v_insertion_order_details.io_end_date} < '2019-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-10-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2019-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-10-01 04:59:59')
                THEN 90
           WHEN (${v_insertion_order_details.io_end_date} < '2019-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} <= '2018-10-01 04:59:59'
              AND ${v_insertion_order_details.io_end_date} > '2018-10-01 04:59:59')
                THEN (datediff(dd, '2018-10-01 04:59:59', ${v_insertion_order_details.io_end_date}) +1)
           WHEN (${v_insertion_order_details.io_end_date} > '2019-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} < '2019-01-01 04:59:59'
              AND ${v_insertion_order_details.io_begin_date} >= '2018-10-01 04:59:59')
                THEN (datediff(dd, ${v_insertion_order_details.io_begin_date}, '2018-12-31 04:59:59') +1)
        ELSE 0
            END ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_ID ;;
  }

  dimension: flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: insertion_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
  }

  dimension: keyid {
    type: number
    value_format_name: id
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.KEYID ;;
  }

  dimension: pl_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PL_PLAN_ID ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.UNITS ;;
  }

  measure: max_units {
    type: max
    hidden: yes
    sql: ${units} ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
