view: dbaadmin_IDXstats_agg {

  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:  select DatabaseName, ObjectName, IndexName, StartTime,DATEDIFF(DAY,StartTime,COALESCE(
          LEAD(StartTime, 1,NULL) OVER (PARTITION BY DatabaseName, ObjectName, IndexName ORDER BY StartTime ASC), GETDATE())) AS dif
          FROM IndexStatsGoverner.tbl_CommandLog where CommandType <> 'UPDATE_STATISTICS'
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: DatabaseName {
    type: string
    sql: ${TABLE}.DatabaseName ;;
  }

  dimension: ObjectName {
    type: string
    sql: ${TABLE}.ObjectName ;;
  }

  dimension: IndexName {
    type: string
    sql: ${TABLE}.IndexName ;;
  }

  dimension: StartTime {
    type: date_time
    sql: ${TABLE}.StartTime ;;
  }

  dimension: cadence {
    type: number
    sql: ${TABLE}.dif ;;
  }

  measure: avg_cadence {
    type: average
    sql: ${cadence} ;;
  }

  measure: count {
    type: count
  }
}
