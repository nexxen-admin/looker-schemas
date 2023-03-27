view: mssql_oltp_timezone_offset {
  sql_table_name: AN_MAIN..timezone_offset (NOLOCK) ;;

  dimension: timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.timezone_id ;;
  }

  dimension_group: time_range_start_date {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time_range_start_date ;;
  }

  dimension_group: time_range_end_date {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time_range_end_date ;;
  }

  dimension: utc_offset {
    type: number
    hidden: yes
    sql: ${TABLE}.utc_offset ;;
  }

  dimension: isDST {
    type: yesno
    hidden: yes
    sql: ${EXTENDED}.isDST = 1 ;;
  }

}
