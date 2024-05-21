# The name of this view in Looker is "V Monthly Billing Report Diff Live Locked"
view: v_monthly_billing_report_diff_live_locked {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_monthly_billing_report_diff_live_locked ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Booked Budget From Live Report" in Explore.

  dimension: booked_budget_from_live_report {
    type: string
    sql: ${TABLE}.Booked_Budget_from_live_report ;;
  }

  dimension: booked_budget_locked_report {
    type: string
    sql: ${TABLE}.Booked_Budget_locked_report ;;
  }

  dimension: booked_units_from_live_report {
    type: string
    sql: ${TABLE}.Booked_Units_from_live_report ;;
  }

  dimension: booked_units_from_locked_report {
    type: string
    sql: ${TABLE}.Booked_Units_from_locked_report ;;
  }

  measure: capped_revenue_before_adj_from_live_report {
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj_from_live_report ;;
  }

  measure: capped_revenue_before_adj_locked_report {
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj_locked_report ;;
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  measure: clicks_from_live_report {
    type: sum
    sql: ${TABLE}.Clicks_from_live_report ;;
  }

  measure: clicks_locked_report {
    type: sum
    sql: ${TABLE}.Clicks_locked_report ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }

  dimension: diff_columns {
    type: string
    sql: ${TABLE}.diff_columns ;;
  }

  dimension: diff_reason {
    type: string
    sql: ${TABLE}.diff_reason ;;
  }

  measure: final_billable_revenue_after_adj_from_live_report {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_from_live_report ;;
  }

  measure: final_billable_revenue_after_adj_from_locked_report {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_from_locked_report ;;
  }

  measure: impressions_from_live_report {
    type: sum
    sql: ${TABLE}.impressions_from_live_report ;;
  }

  measure: impressions_locked_report {
    type: sum
    sql: ${TABLE}.impressions_locked_report ;;
  }

  measure: p_rev_from_live_report {
    type: sum
    label: "1P rev from live report"
    sql: ${TABLE}.one_p_rev_from_live_report ;;
  }

  measure: p_rev_from_locked_report {
    type: sum
    label: "1P rev from locked report"
    sql: ${TABLE}.one_p_rev_from_locked_report ;;
  }

  dimension: passed_bill_amount_from_live_report {
    type: string
    sql: ${TABLE}.Passed_Bill_Amount_from_live_report ;;
  }

  dimension: passed_bill_amount_locked_report {
    type: string
    sql: ${TABLE}.Passed_Bill_Amount_locked_report ;;
  }

  dimension: rate_from_live_report {
    type: string
    sql: ${TABLE}.Rate_from_live_report ;;
  }

  dimension: rate_from_locked_report {
    type: string
    sql: ${TABLE}.Rate_from_locked_report ;;
  }

  measure: third_party_impressions_from_live_report {
    type: sum
    sql: ${TABLE}.third_party_impressions_from_live_report ;;
  }

  measure: third_party_impressions_locked_report {
    type: sum
    sql: ${TABLE}.third_party_impressions_locked_report ;;
  }

  measure: uncapped_revenue_from_live_report {
    type: sum
    sql: ${TABLE}.uncapped_revenue_from_live_report ;;
  }

  measure: uncapped_revenue_locked_report {
    type: sum
    sql: ${TABLE}.uncapped_revenue_locked_report ;;
  }
  measure: count {
    type: count
  }
}
