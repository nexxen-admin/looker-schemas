# The name of this view in Looker is "Rupi Datamine"
view: rupi_datamine {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.rupi_datamine ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Advertiser ID" in Explore.

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  measure: click {
    type: sum
    sql: ${TABLE}.click ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  dimension: custom_event_name {
    type: string
    sql: ${TABLE}.custom_event_name ;;
  }

  measure: custom_events {
    type: sum
    sql: ${TABLE}.custom_events ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }

  measure: impression {
    type: sum
    sql: ${TABLE}.impression ;;
  }

  dimension: insertion_order_id {
    type: string
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }

  dimension: is_advanced_creative {
    type: number
    sql: ${TABLE}.is_advanced_creative ;;
  }

  dimension: line_item_id {
    type: string
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }

  dimension: package_id {
    type: string
    sql: ${TABLE}.package_id ;;
  }

  dimension: package_name {
    type: string
    sql: ${TABLE}.package_name ;;
  }
  measure: count {
    type: count
    drill_fields: [line_item_name, package_name, advertiser_name, insertion_order_name, custom_event_name]
  }
}
