# The name of this view in Looker is "Monthly Revenue Dsp Classification Deal"
view: monthly_revenue_dsp_classification_deal {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.monthly_revenue_dsp_classification_deal_new ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Name" in Explore.

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: billing_agency {
    type: string
    sql: ${TABLE}.Billing_agency ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.Classification ;;
  }

  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_sales_people_count {
    type: number
    sql: ${TABLE}.Deal_Sales_People_Count ;;
  }

  dimension: deal_sales_person {
    type: string
    sql: ${TABLE}.Deal_Sales_Person ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: dsp_account {
    type: string
    sql: ${TABLE}.dsp_account ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: opportunity {
    type: string
    sql: ${TABLE}.opportunity ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: parent_account {
    type: string
    sql: ${TABLE}.Parent_Account ;;
  }

  dimension: parent_billing_agency {
    type: string
    sql: ${TABLE}.parent_billing_agency ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
  }

  measure: split_deal_cogs {
    type: sum
    sql: ${TABLE}.Split_Deal_COGS ;;
    value_format: "$#,##0.00"
  }

  measure: split_deal_impressions {
    type: sum
    sql: ${TABLE}.Split_Deal_Impressions ;;
    value_format: "$#,##0"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: split_deal_revenue {
    type: sum
    sql: ${TABLE}.Split_Deal_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: total_cogs {
    type: sum
    sql: ${TABLE}.Total_COGS ;;
    value_format: "$#,##0.00"
  }

  measure: total_impressions {
    type: sum
    sql: ${TABLE}.Total_Impressions ;;
    value_format: "$#,##0"
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.Total_Revenue ;;
    value_format: "$#,##0"
  }

  dimension: un_opportunity {
    type: string
    sql: ${TABLE}.un_opportunity ;;
  }
  measure: count {
    type: count
    drill_fields: [opportunity_name, account_name]
  }
}
