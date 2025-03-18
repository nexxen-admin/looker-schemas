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

# for titles

  dimension: max_date_text {
    type: string
    sql: 'Quarter Predicted: Q' || CEIL(EXTRACT(MONTH FROM ${max_real_data_date}) / 3) || ' ' || EXTRACT(YEAR FROM ${max_real_data_date}) ;;
  }

  dimension: max_real_data_date {
    type: date
    sql: ${TABLE}.max_real_data_date ;;
    label: "max_real_data_date"
  }

# regular dimentions and measures

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
    label: "Date"
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
    label: "AI Model Revenue Prediction*"

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
    label: "AI Model Cost Prediction*"

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
    label: "AI Model Net Revenue Prediction*"

    html:
    {% if date._value > max_real_data_date._value %}
    <p style="font-weight: bold;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
  }

  measure: net_revenue_no_design {
    type: sum
    sql: ${TABLE}.revenue - ${TABLE}.cost ;;
    value_format: "$#,##0"
    label: "AI Model Net Revenue Prediction"
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
    label: "Uplift-Based Model Revenue"
  }

  measure: cost_last_year_adjsted {
    type: sum
    sql: ${TABLE}.cost_last_year_adjsted ;;
    value_format: "$#,##0"
    label: "Uplift-Based Model Cost"
  }

  measure: net_revenue_last_year_adjusted{
    type: sum
    sql: ${TABLE}.revenue_last_year_adjsted - ${TABLE}.cost_last_year_adjsted ;;
    value_format: "$#,##0"
    label: "Uplift-Based Model Net Revenue"
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
