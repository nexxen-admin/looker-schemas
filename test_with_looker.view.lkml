view: query_kill_test {

  derived_table: {

    sql: (select sleep(1800) as "sleep") ;;
  }

  dimension: sleep {

    type: number

    sql: ${TABLE}.sleep ;;

  }
}
