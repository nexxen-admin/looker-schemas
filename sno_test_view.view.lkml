view: sno_test_view {
  derived_table: {
    sql: select id, name from (values(1, 'one'), (2, 'two'), (3, 'three')) as t (id, name);;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

}
