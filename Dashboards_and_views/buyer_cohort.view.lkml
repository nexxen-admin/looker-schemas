
view: buyer_cohort {
  sql_table_name: BI.SVC_Buyer_Cohort_By_Event_Year ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cohort_year {
    type: number
    label: "Cohort Year"
    sql: ${TABLE}."Cohort Year" ;;
  }

  dimension: Cohort_Begin_Agg_Year {
    type: number
    label: "Cohort Start Year"
    sql: ${TABLE}.Cohort_Begin_Agg_Year ;;
  }

  dimension: cohort_number {
    type: number
    label: "Cohort Number"
    sql: ${TABLE}."Cohort Number" ;;
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.Buyer ;;
  }

  dimension: event_year {
    type: number
    label: "Event Year"
    value_format: "###0"
    sql: ${TABLE}."Event Year" ;;
  }

  measure:  Buyer_Count{
    type:  count_distinct
    sql: ${TABLE}.Buyer ;;
  }

  measure: gross_revenue {
    type: sum
    label: "Gross Revenue"
    value_format: "$#,##0.00"
    sql: COALESCE(${TABLE}.annual_gross_revenue,0) ;;
  }

  measure: cost {
    type: sum
    label: "Cost"
    value_format: "$#,##0.00"
    sql: COALESCE(${TABLE}.Cost,0) ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue"
    value_format: "$#,##0.00"
    sql: COALESCE(${TABLE}.annual_net_revenue,0) ;;
  }

  set: detail {
    fields: [
        cohort_year,
        Cohort_Begin_Agg_Year,
  cohort_number,
  buyer,
  event_year,
  gross_revenue,
  cost,
  net_revenue
  ]
  }
}
