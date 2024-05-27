# The name of this view in Looker is "Connatix Report"
view: connatix_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.connatix_report ;;


  measure: ad_impressions {
    type: sum
    sql: ${TABLE}.Ad_Impressions ;;
  }

  dimension: advertiser_account_name {
    type: string
    sql: ${TABLE}.Advertiser_Account_Name ;;
  }

  measure: connatix_demand_revenue {
    type: sum
    sql: ${TABLE}.Connatix_Demand_Revenue ;;
    value_format: "$#,##0.00"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."Day" ;;
  }

  dimension: line_item_name {
    type: string
    sql: ${TABLE}.Line_Item_Name ;;
  }

  dimension: player_name {
    type: string
    sql: ${TABLE}.Player_Name ;;
  }

  dimension: publisher_account_name {
    type: string
    sql: ${TABLE}.Publisher_Account_Name ;;
  }

  measure: publisher_demand_revenue {
    type: sum
    sql: ${TABLE}.Publisher_Demand_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: publisher_total_revenue {
    type: sum
    sql: ${TABLE}.Publisher_Total_Revenue ;;
    value_format: "$#,##0.00"
  }
  measure: count {
    type: count
    drill_fields: [publisher_account_name, player_name, line_item_name, advertiser_account_name]
  }
}
