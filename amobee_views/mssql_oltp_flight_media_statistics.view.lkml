view: mssql_oltp_flight_media_statistics {
  sql_table_name: dbo.flight_media_statistics (NOLOCK) ;;

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

  dimension: delivery_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units_spent ;;
  }

  dimension: delivery_units_spent_today {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units_spent_today ;;
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
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: hh_units_spent {
    type: number
    hidden: yes
    sql: ${TABLE}.hh_units_spent ;;
  }

  dimension: hh_units_today {
    type: number
    hidden: yes
    sql: ${TABLE}.hh_units_today ;;
  }

  dimension_group: lastimp_datetm {
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
    sql: ${TABLE}.lastimp_datetm ;;
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

  measure: sum_units_spent {
    type: sum
    hidden: yes
    sql: ${units_spent} ;;
  }

  measure: units_remaining {
    type: number
    label: "Flight Units Remaining"
    view_label: "Flight"
    sql: {% if mssql_oltp_flight.flight_id._in_query %} ${mssql_oltp_flight.max_planned_volume} - ${sum_units_spent} {% else %} NULL {% endif %} ;;
  }

}
