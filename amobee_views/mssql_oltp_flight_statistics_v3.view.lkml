view: flight_statistics_v3 {
  sql_table_name: dbo.flight_statistics_v3 (NOLOCK) ;;
  label: "Flight Statistics"

  dimension: actual_cpm {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_cpm ;;
  }

  dimension: actual_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_spend ;;
  }

  dimension: actual_units {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_units ;;
  }

  dimension: billable_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_units_today ;;
  }

  measure: sum_billable_units_today {
    type: sum
    label: "Billable Units Today"
    sql: ${billable_units_today} ;;
  }

  dimension: budget_today {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_today ;;
  }

  dimension: cpu_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.cpu_type_id ;;
  }

  dimension: effective_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units_today ;;
  }

  dimension: flight_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.flight_id ;;
  }

  dimension: impressions_today {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions_today ;;
  }

  dimension_group: last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden: yes
    sql: ${TABLE}.last_updated ;;
  }

  dimension: pacing {
    type: number
    hidden: yes
    sql: ${TABLE}.pacing ;;
  }

  dimension: units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.units_today ;;
  }
}
