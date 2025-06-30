view: monthly_enterprise_targets_changes {
  sql_table_name: BI_DSP.monthly_enterprise_targets_changes ;;

  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
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
  dimension: generalist_rep_name {
    type: string
    sql: ${TABLE}.Generalist_Rep_Name ;;
  }
  dimension: gross_revenue {
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
  dimension: net_revenue {
    type: number
    sql: ${TABLE}.Net_Revenue ;;
  }
  dimension: related_brand {
    type: string
    sql: ${TABLE}.Related_Brand ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."Year" ;;
  }
  measure: count {
    type: count
    drill_fields: [account_name, generalist_rep_name]
  }
}
