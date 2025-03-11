view: revenue_prediction_report_v1 {
    derived_table: {
      sql:
select date,
       CURRENT_DATE AS current_date,
       category,
       subcategory,
       revenue,
       cost,
       revenue_last_year,
       cost_last_year,
       revenue_last_year_adjsted,
       cost_last_year_adjsted,

        CASE
          WHEN date <= CURRENT_DATE THEN revenue_last_year
          ELSE NULL
        END AS revenue_past_solid,

        CASE
          WHEN date > CURRENT_DATE THEN revenue_last_year
          ELSE NULL
        END AS revenue_past_dotted

from BI.revenue_prediction
        ;;

    }



    dimension: date {
      type: date
      sql: ${TABLE}.date ;;
      label: "Date"

         html:
      {% assign current_date = "now" | date: "%Y-%m-%d" %}
      {% assign tomorrow_date = current_date | date: "%Y-%m-%d" | date_add: 4 %}  {% assign value_date = value | date: "%Y-%m-%d" %}
      {% if value_date > tomorrow_date %}
      <span style="font-style: italic; font-weight: bold;">{{ rendered_value }}</span>
      {% else %}
      {{ rendered_value }}
      {% endif %};;
    }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Category"
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
    label: "Subcategory"
  }


# measu

  measure: revenue {
      type: sum
      sql: ${TABLE}.revenue ;;
      value_format: "$#,##0"
      label: "Revenue Prediction"
    }


  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "Cost Prediction"
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.revenue - ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "Net Revenue Prediction"
  }

  measure: revenue_last_year {
    type: sum
    sql: ${TABLE}.revenue_last_year ;;
    value_format: "$#,##0"
    label: "Revenue (Last Year)"
  }

  measure: cost_last_year {
    type: sum
    sql: ${TABLE}.cost_last_year ;;
    value_format: "$#,##0"
    label: "Cost (Last Year)"
  }

  measure: net_revenue_last_year{
    type: sum
    sql: ${TABLE}.revenue_last_year - ${TABLE}.cost_last_year ;;
    value_format: "$#,##0"
    label: "Net Revenue (Last Year)"
  }

  measure: revenue_last_year_adjsted {
    type: sum
    sql: ${TABLE}.revenue_last_year_adjsted ;;
    value_format: "$#,##0"
    label: "Adjusted Revenue (Last Year)"
  }

  measure: cost_last_year_adjsted {
    type: sum
    sql: ${TABLE}.cost_last_year_adjsted ;;
    value_format: "$#,##0"
    label: "Adjusted Cost (Last Year)"
  }

  measure: net_revenue_last_year_adjusted{
    type: sum
    sql: ${TABLE}.revenue_last_year_adjsted - ${TABLE}.cost_last_year_adjsted ;;
    value_format: "$#,##0"
    label: "Adjusted Net Revenue (Last Year)"
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
