view: mssql_oltp_campaign_statistics_v3 {
  sql_table_name: dbo.campaign_statistics_v3 (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: flights_begin_datetm {
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
    sql: ${TABLE}.flights_begin_datetm ;;
  }

  dimension_group: flights_end_datetm {
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
    sql: ${TABLE}.flights_end_datetm ;;
  }

  dimension: billable_units {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_units ;;
  }

  dimension: billable_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_revenue ;;
  }
}
