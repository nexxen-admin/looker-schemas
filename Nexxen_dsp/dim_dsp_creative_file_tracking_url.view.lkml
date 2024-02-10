# The name of this view in Looker is "Dim Dsp Creative File Tracking URL"
view: dim_dsp_creative_file_tracking_url {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_creative_file_tracking_url ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Creative File ID" in Explore.

  dimension: creative_file_id {
    type: number
    sql: ${TABLE}.creative_file_id ;;
    hidden: yes
  }

  dimension: creative_file_tracking_url_id {
    type: number
    sql: ${TABLE}.creative_file_tracking_url_id ;;
    hidden: yes
  }

  dimension: creative_file_tracking_url_key {
    type: number
    sql: ${TABLE}.creative_file_tracking_url_key ;;
    hidden: yes
  }

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

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension: platform_id {
    type: number
    sql: ${TABLE}.platform_id ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: url {
    type: string
    label: "Tracking URL"
    sql: ${TABLE}.url ;;
  }
  measure: count {
    type: count
  }
}
