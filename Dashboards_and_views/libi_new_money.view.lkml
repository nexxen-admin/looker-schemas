view: libi_new_money {
  derived_table: {
    sql: select*from  bi_new.New_Money_Unruly_Player
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month_year {
    type: string
    sql: ${TABLE}.month_year ;;
  }

  dimension_group: start_date {
    type: time
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end_date {
    type: time
    sql: ${TABLE}.End_Date ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.Pub_ID ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.Publisher_Name ;;
  }

  dimension: biz_dev {
    type: string
    sql: ${TABLE}.BizDev ;;
  }

  dimension: requests {
    type: number
    sql: ${TABLE}.Requests ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.Wins ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.Revenue ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }

  dimension: net_revenue {
    type: number
    sql: ${TABLE}.Net_Revenue ;;
  }

  set: detail {
    fields: [
      month_year,
      start_date_time,
      end_date_time,
      pub_id,
      publisher_name,
      biz_dev,
      requests,
      wins,
      impressions,
      clicks,
      revenue,
      cost,
      net_revenue
    ]
  }
}
