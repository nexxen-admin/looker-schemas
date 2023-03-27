view: videology_flightmedia_statistics_view {
  sql_table_name: dbo.videology_flightmedia_statistics_view (NOLOCK) ;;
  label: "Flight Media Statistics"

  dimension: actual_billable_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_billable_units_spent ;;
  }

  dimension: actual_billable_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_billable_units_today ;;
  }

  dimension: actual_effective_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_effective_units_spent ;;
  }

  dimension: actual_effective_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_effective_units_today ;;
  }

  dimension: actual_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_units_spent ;;
  }

  dimension: actual_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_units_today ;;
  }

  dimension: billable_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_units_spent ;;
  }

  measure: sum_billable_units_spent {
    type: sum
    label: "Billable Units Spent"
    sql: ${billable_units_spent} ;;
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

  measure: total_billable_units {
    type: number
    label: "Total Billable Units"
    sql: ${sum_billable_units_spent} + ${sum_billable_units_today} ;;
  }

  dimension: budget_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_spent ;;
  }

  dimension: budget_spent_today {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_spent_today ;;
  }

  dimension: effective_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units_spent ;;
  }

  dimension: effective_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units_today ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: iseligible {
    type: string
    hidden: yes
    sql: ${TABLE}.iseligible ;;
  }

  dimension: preferred_delivery_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.preferred_delivery_pct ;;
  }

  dimension: rowid {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.rowid ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.units ;;
  }

  dimension: units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.units_spent ;;
  }

  dimension: units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.units_today ;;
  }
}
