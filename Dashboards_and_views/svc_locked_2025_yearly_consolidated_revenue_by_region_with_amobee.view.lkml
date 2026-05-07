view: svc_locked_2025_yearly_consolidated_revenue_by_region_with_amobee {
  sql_table_name: bi.svc_LOCKED_2025_yearly_consolidated_revenue_by_region_with_amobee ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }
  dimension: quarter {
    type: number
    sql: ${TABLE}.Quarter ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.Revenue ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."Year" ;;
  }
  measure: count {
    type: count
  }
}
