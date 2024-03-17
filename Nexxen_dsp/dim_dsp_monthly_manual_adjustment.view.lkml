# The name of this view in Looker is "Dim Dsp Monthly Manual Adjustment"
view: dim_dsp_monthly_manual_adjustment {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_monthly_manual_adjustment ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }

  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Manual Adjustment" in Explore.

  dimension: monthly_adjustable_billable_revenue {
    type: number
    label: "Adjustment Billable Revenue"
    sql: COALESCE(${TABLE}.monthly_adjustable_billable_revenue , 0) ;;
  }

  dimension: monthly_adjustable_billable_impressions {
    type: number
    label: "Adjustment Billable Impressions"
    sql: COALESCE(${TABLE}.monthly_adjustable_billable_impressions , 0) ;;
  }

  dimension: monthly_adjustable_billable_clicks {
    type: number
    label: "Adjustment Billable Clicks"
    sql: COALESCE(${TABLE}.monthly_adjustable_billable_clicks , 0) ;;
  }

  dimension: monthly_adjustable_billable_actions {
    type: number
    label: "Adjustment Billable Actions"
    sql: COALESCE(${TABLE}.monthly_adjustable_billable_actions , 0) ;;
  }

  dimension: monthly_adjustable_billable_video_completes {
    type: number
    label: "Adjustment Billable Video Completes"
    sql: COALESCE(${TABLE}.monthly_adjustable_billable_video_completes , 0) ;;
  }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: manual_adjustment_key {
    type: number
    sql: ${TABLE}.manual_adjustment_key ;;
  }

  dimension: opportunitylineitem {
    type: string
    sql: ${TABLE}.opportunitylineitem ;;
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  measure: count {
    type: count
  }
}
