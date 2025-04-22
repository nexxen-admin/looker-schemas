view: converged_payout_schedule_new {
  sql_table_name: AN_SMART..converged_payout_schedule_new (NOLOCK);;
  label: "Placement Payout Schedule"

  dimension: cpm {
    type: number
    label: "Payout Schedule CPM"
    value_format_name: decimal_2
    sql: ${TABLE}.cpm ;;
  }

  dimension: cps {
    type: number
    label: "Payout Schedule CPS"
    sql: ${TABLE}.cps ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [time, date, month]
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: end_datetm {
    type: time
    label: "End"
    timeframes: [time, date, month]
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: json_params {
    type: string
    label: "Open Parameter"
    sql: ${TABLE}.json_params ;;
  }

  dimension: payout_schedule_id {
    type: number
    label: "Payout Schedule ID"
    sql: ${TABLE}.payout_schedule_id ;;
    value_format_name: id
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension_group: start_datetm {
    type: time
    label: "Start"
    timeframes: [time, date, month]
    sql: ${TABLE}.start_datetm ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
