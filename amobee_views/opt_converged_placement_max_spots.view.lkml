view: converged_placement_max_spots {
  sql_table_name: AN_SMART..converged_placement_max_spots (NOLOCK) ;;
  label: "Placement Spots"

  dimension: category {
    type: string
    label: "Spot Category"
    sql: ${TABLE}.category ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [time, date, month]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: end_datetm {
    type: time
    label: "End"
    timeframes: [time, date, month]
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: spots {
    type: number
    label: "Spots"
    sql: ${TABLE}.spots ;;
  }

  dimension_group: start_datetm {
    type: time
    label: "Start"
    timeframes: [time, date, month]
    sql: ${TABLE}.start_datetm ;;
  }


}
