# The name of this view in Looker is "Fact Dataroma Data Ver1"
view: fact_dataroma_data_ver1 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.fact_dataroma_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Name" in Explore.

  dimension: account_name {
    type: string
    sql: ${TABLE}.ACCOUNT_NAME ;;
  }

  dimension: adj_impressions {
    type: number
    sql: ${TABLE}.adj_impressions ;;
    hidden: yes
  }

  measure: booked_spend {
    type: sum
    sql: ${TABLE}.Booked_Spend ;;
  }

  measure: booked_units {
    type: sum
    sql: ${TABLE}.Booked_Units ;;
  }

  measure: capped_revenue {
    type: sum
    sql: ${TABLE}.Capped_Revenue ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  dimension: io_end_date {
    type: date
    sql: ${TABLE}.io_end_date ;;
  }

  dimension: io_item_name {
    type: string
    sql: ${TABLE}.IO_Item_NAME ;;
  }

  dimension: io_key {
    type: string
    sql: ${TABLE}.IO_KEY ;;
  }

  dimension: io_name {
    type: string
    sql: ${TABLE}.IO_NAME ;;
  }

  dimension: io_region {
    type: string
    sql: ${TABLE}.IO_Region ;;
  }

  dimension_group: io_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.io_start_date ;;
  }

  dimension: media_buy_key {
    type: number
    sql: ${TABLE}.Media_Buy_KEY ;;
  }

  measure: media_clicks {
    type: sum
    sql: ${TABLE}.Media_Clicks ;;
  }

  measure: media_cost {
    type: sum
    sql: ${TABLE}.Media_Cost ;;
  }

  measure: media_impressions {
    type: sum
    sql: ${TABLE}.Media_Impressions ;;
  }

  measure: media_video_fully_played {
    type: sum
    sql: ${TABLE}.Media_Video_Fully_Played ;;
  }

  dimension: price_type {
    type: string
    sql: ${TABLE}.Price_TYPE ;;
  }

  measure: remaining_budget {
    type: sum
    sql: ${TABLE}.Remaining_Budget ;;
  }

  dimension_group: reporting {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Reporting ;;
    hidden: yes
  }

  measure: video_fully_played {
    type: sum
    sql: ${TABLE}.Video_Fully_Played ;;
  }
  measure: count {
    type: count
    drill_fields: [io_item_name, io_name, account_name]
  }
}
