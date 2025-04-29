view: snapshot_quarterly_forecast {
  sql_table_name: BI_DSP.Snapshot_Quarterly_Forecast ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}."account manager" ;;
  }
  dimension: account_manager_2 {
    type: string
    sql: ${TABLE}."account manager 2" ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}."deal type" ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}."generalist rep" ;;
  }
  dimension: holding_company {
    type: string
    sql: ${TABLE}."holding company" ;;
  }
  dimension: io_group_name {
    type: string
    sql: ${TABLE}."io group name" ;;
  }
  dimension: io_region {
    type: string
    sql: ${TABLE}."io region" ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}."io super region" ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}."io type" ;;
  }
  dimension: net_revenue_booked {
    type: number
    sql: ${TABLE}."net revenue booked" ;;
  }
  dimension: net_revenue_forecast {
    type: number
    sql: ${TABLE}."net revenue forecast" ;;
  }
  dimension: opp_or_order_id {
    type: string
    sql: ${TABLE}."opp or order id" ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}."opportunity owner" ;;
  }
  dimension: related_brand {
    type: string
    sql: ${TABLE}."related brand" ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}."schedule converted revenue v2" ;;
  }
  dimension: scheduled_net_revenue_v2 {
    type: number
    sql: ${TABLE}."scheduled net revenue v2" ;;
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}."social specialist" ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension_group: today {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.today ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}."tv specialist" ;;
  }
  measure: count {
    type: count
    drill_fields: [io_group_name]
  }
}
