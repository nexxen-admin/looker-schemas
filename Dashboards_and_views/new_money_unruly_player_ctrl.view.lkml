# The name of this view in Looker is "New Money Unruly Player Ctrl"
view: new_money_unruly_player_ctrl {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.New_Money_Unruly_Player_CTRL ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Biz Dev" in Explore.

  dimension: biz_dev {
    type: string
    sql: ${TABLE}.BizDev ;;
  }


  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.End_Date ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }



  dimension: month_year {
    type: string
    sql: ${TABLE}.month_year ;;
    suggest_persist_for: "0 seconds"
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.Net_Revenue ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.Pub_ID ;;
  }

  dimension: ctrl_publisher_name {
    type: string
    sql: ${TABLE}.Publisher_Name ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.Requests ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_date ;;
  }

  measure: wins {
    type: sum
    sql: ${TABLE}.Wins ;;
  }

}
