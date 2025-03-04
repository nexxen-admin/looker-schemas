view: revenue_prediction_report_v1 {
    derived_table: {
      sql:
select date,
       category,
       subcategory,
       revenue,
       cost,
       revenue_last_year,
       cost_last_year,
       revenue_last_year_adjsted,
       cost_last_year_adjsted
from BI.revenue_prediction
        ;;

    }



    dimension: date {
      type: date
      sql: ${TABLE}.date ;;
    }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }


# measu

    measure: revenue {
      type: sum
      sql: ${TABLE}.revenue ;;
      value_format: "#,##0"
    }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "#,##0"
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.revenue - ${TABLE}.cost ;;
    value_format: "#,##0"
  }

  measure: revenue_last_year {
    type: sum
    sql: ${TABLE}.revenue_last_year ;;
    value_format: "#,##0"
  }

  measure: cost_last_year {
    type: sum
    sql: ${TABLE}.cost_last_year ;;
    value_format: "#,##0"
  }

  measure: net_revenue_last_year{
    type: sum
    sql: ${TABLE}.revenue_last_year} - ${TABLE}.cost_last_year ;;
    value_format: "#,##0"
  }

  measure: revenue_last_year_adjsted {
    type: sum
    sql: ${TABLE}.revenue_last_year_adjsted ;;
    value_format: "#,##0"
  }

  measure: cost_last_year_adjsted {
    type: sum
    sql: ${TABLE}.cost_last_year_adjsted ;;
    value_format: "#,##0"
  }

  measure: net_revenue_last_year_adjusted{
    type: sum
    sql: ${TABLE}.revenue_last_year_adjsted - ${TABLE}.cost_last_year_adjsted ;;
    value_format: "#,##0"
  }




    set: detail {
      fields: [
        date,
        category,
        subcategory,
        revenue,
        cost,
        revenue_last_year,
        cost_last_year,
        revenue_last_year_adjsted,
        cost_last_year_adjsted,
        net_revenue,
        net_revenue_last_year,
        net_revenue_last_year_adjusted
      ]
    }

  }
