view: drr_dq_flags {

  sql_table_name: BI.DRR_DQ_flags ;;

  dimension: Event_Date {
    type: string
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: Category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: Subcategory {
    type: string
    sql: ${TABLE}.Subcategory ;;
  }

  measure: Cost {
    type: sum
    sql: ${TABLE}.Cost ;;
    value_format: "$#,##0;($#,##0)"
    label: "Cost"
  }

  measure: Revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0;($#,##0)"
    label: "Revenue"
  }


  measure: mean_Cost {
    type: number
    sql: ${TABLE}.mean_Cost ;;
    label: "mean_Cost"
  }

  measure: mean_Revenue {
    type: number
    sql: ${TABLE}.mean_Revenue ;;
    label: "mean_Revenue"
  }

  measure: std_Cost {
    type: number
    sql: ${TABLE}.std_Cost ;;
    label: "std_Cost"
  }

  measure: std_Revenue {
    type: number
    sql: ${TABLE}.std_Revenue ;;
    label: "std_Revenue"
  }

  measure: z_score_Cost {
    type: number
    sql: ${TABLE}.z_score_Cost ;;
    label: "z_score_Cost"
  }

  measure: z_score_Revenue {
    type: number
    sql: ${TABLE}.z_score_Revenue ;;
    label: "z_score_Revenue"
  }

  measure: indicator_Cost {
    type:  number
    sql: ${TABLE}.indicator_Cost ;;
    label: "indicator_Cost"
  }

  measure: indicator_Revenue {
    type: number
    sql: ${TABLE}.indicator_Revenue ;;
    label: "indicator_Revenue"
  }

  measure: ind_dq {
    type: sum
    sql: case when ${TABLE}.indicator_Revenue = 1 and ${TABLE}.indicator_Cost = 1 then 1 else 0 end ;;
    label: "indicator_dq"
  }

}
