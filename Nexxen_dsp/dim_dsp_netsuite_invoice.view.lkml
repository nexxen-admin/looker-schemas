# The name of this view in Looker is "Dim Dsp Netsuite Invoice"
view: dim_dsp_netsuite_invoice {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_Netsuite_invoice ;;


  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Monthly Budget Amount" in Explore.

  dimension: monthly_budget_amount {
    type: number
    label: "Past Billed Amount"
    sql: COALESCE(${TABLE}.monthly_budget_amount,0) ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: netsuite_invoice_key {
    type: number
    sql: ${TABLE}.Netsuite_invoice_key ;;
    hidden: yes
  }

  dimension: opportunitylineitem {
    type: string
    sql: ${TABLE}.opportunitylineitem ;;
    hidden: yes
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  measure: passed_bill_amount_measure {
    type: max
    sql: ${monthly_budget_amount} ;;
  }


  measure: count {
    type: count
  }
}
