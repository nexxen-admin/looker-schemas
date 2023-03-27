view: mssql_oltp_fm_pid_statistics {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT placement_id AS PLACEMENT_ID
      ,SUM(units_today) AS UNITS_TODAY
    FROM AN_MAIN..flight_media_placement_statistics (NOLOCK)
    GROUP BY placement_id
      ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.UNITS_TODAY ;;
  }

  measure: max_units_today {
    type: max
    label: "Units Today"
    view_label: "Placement Filler Statistics"
    description: "Number of units served by Placement."
    sql: ${units_today} ;;
  }

  measure: sum_units_today {
    type: sum
    label: "Total Units Today"
    view_label: "Placement Filler Statistics"
    description: "Number of units served"
    sql: ${units_today} ;;
  }

}
