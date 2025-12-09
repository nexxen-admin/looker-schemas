# The name of this view in Looker is "Dim Dsp Package Budget Schedule"
view: dim_dsp_package_budget_schedule {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_dim_dsp_package_budget_schedule ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Daily Cap" in Explore.

  dimension: daily_cap {
    type: number
    sql: ${TABLE}.daily_cap ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.pack
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: end {
    type:date
    label: "End Date"
    sql: ${TABLE}.end_date ;;
    hidden: yes
  }

  dimension: rpm {
    type: number
    label: "RPM"
    sql: ${TABLE}.rpm ;;
  }

  dimension: flight_impressions {
    type: number
    sql: ${TABLE}.flight_impressions ;;
  }

  dimension: impressions_cap {
    type: number
    sql: ${TABLE}.impressions_cap ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;

  }

  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: modified_by_api {
    type: number
    sql: ${TABLE}.modified_by_api ;;
    hidden: yes
  }

  dimension: packag_budget_schedule_id {
    type: number
    sql: ${TABLE}.packag_budget_schedule_id ;;
    hidden: yes
  }

  dimension: package_budget_schedule_key {
    type: number
    sql: ${TABLE}.package_budget_schedule_key ;;
    hidden: yes
  }

  dimension: package_id {
    type: number

    sql: ${TABLE}.package_id ;;
  }

  dimension: prepay_approved {
    type: number
    sql: ${TABLE}.prepay_approved ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: salesforce_line_item_id {
    type: string
    sql: ${TABLE}.salesforce_line_item_id ;;
    description: "Line item ID from DSP"
  }

  dimension: spending_cap {
    type: number
    sql: ${TABLE}.spending_cap ;;
  }

  dimension: spending_capl {
    type: number
    sql: ${TABLE}.spending_capl ;;
  }

  dimension: start {
    type: date
    label: "Start Date"
    sql: ${TABLE}.start_date ;;
    hidden: yes
  }

  dimension: end_date_in_timezone {
    type: date
    label: "DSP SF End Date"
    sql: ${TABLE}.end_date_in_timezone ;;
    description: "End date from DSP"
  }

  dimension: start_date_in_timezone {
    type: date
    label: "DSP SF Start Date "
    sql: ${TABLE}.start_date_in_timezone ;;
    description: "Start date from DSP"
  }

}
