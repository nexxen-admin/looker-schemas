view: monthly_strategic_targets_changes {
  sql_table_name: BI_DSP.monthly_strategic_targets_changes ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
  measure: gross_revenue {
    type: number
    sql: ${TABLE}.Gross_Revenue ;;
  }
  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }
  dimension: month {
    type: number
    sql: ${TABLE}."Month" ;;
  }
  measure: net_revenue {
    type: number
    sql: ${TABLE}.Net_Revenue ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.Opportunity_Owner ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."Year" ;;
  }
  measure: count {
    type: count
  }
}
