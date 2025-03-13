view: revenue_prediction_report_v1 {
  derived_table: {
    sql:
    select date,
           max_real_data_date,
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
    label: "Date"
  }

  dimension: max_real_data_date {
    type: date
    sql: ${TABLE}.max_real_data_date ;;
    label: "max_real_data_date"
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
    label: "Revenue Prediction*"

    html:
    {% if date._value > max_real_data_date._value %}
      <p style="font-weight: bold;">{{ rendered_value }}</p>
    {% else %}
      <p>{{ rendered_value }}</p>
    {% endif %};;


  }


  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "Cost Prediction*"

    html:
    {% if date._value > max_real_data_date._value %}
    <p style="font-weight: bold;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.revenue - ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "Net Revenue Prediction*"

    html:
    {% if date._value > max_real_data_date._value %}
    <p style="font-weight: bold;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
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


  measure: net_revenue_no_design {
    type: sum
    sql: ${TABLE}.revenue - ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "Net Revenue Prediction"
  }


  set: detail {
    fields: [
      date,
      max_real_data_date,
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
      net_revenue_last_year_adjusted,
      net_revenue_no_design
    ]
  }

}
