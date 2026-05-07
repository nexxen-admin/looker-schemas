view: svc_locked_2025_yearly_consolidated_revenue_by_region_with_amobee {
  sql_table_name: bi.svc_LOCKED_2025_yearly_consolidated_revenue_by_region_with_amobee ;;

  dimension: category {
    type: string
    label: "Category"
    sql: ${TABLE}.category ;;
  }

  dimension: quarter {
    type: number
    label: "Quarter"
    sql: ${TABLE}.Quarter ;;
  }
  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.region ;;
  }

  dimension: year {
    type: number
    label: "Year"
    sql: ${TABLE}.Year ;;
  }
  ###MEASURES####

  measure: cost {
    type: sum
    value_format: "$#,##0"
    label: "Cost"
    sql: ${TABLE}.Cost ;;
  }

  measure: revenue {
    type: sum
    value_format: "$#,##0"
    label: "Revenue"
    sql: ${TABLE}.Revenue ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      year,
      quarter,
      region,
      category,
      revenue,
      cost
    ]
  }
}
