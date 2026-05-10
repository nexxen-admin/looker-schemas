 view: yearly_consolidated_revenue_by_region_with_amobee_TEST {

    derived_table: {
      sql:
      -- Locked FY2025 and prior (from locked table)
      SELECT Year, Quarter, region, category, Revenue, Cost
      FROM bi.svc_LOCKED_2025_yearly_consolidated_revenue_by_region_with_amobee
      ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: year {
      type: number
      label: "Year"
      sql: ${TABLE}.Year ;;
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

    dimension: category {
      type: string
      label: "Category"
      sql: ${TABLE}.category ;;
    }

    measure: revenue {
      type: sum
      value_format: "$#,##0"
      label: "Revenue"
      sql: ${TABLE}.Revenue ;;
    }

    measure: cost {
      type: sum
      value_format: "$#,##0"
      label: "Cost"
      sql: ${TABLE}.Cost ;;
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
