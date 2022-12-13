view: ONE_OFF{
  derived_table: {
    sql: SELECT * FROM BI_NEW.ONE_OFF
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: business_unit {
    type: string
    sql: ${TABLE}.Business_Unit ;;
  }

  measure: gross_revenue {
    type: sum
    sql: ${TABLE}.gross_revenue ;;
  }

  set: detail {
    fields: [business_unit, gross_revenue]
  }
}
