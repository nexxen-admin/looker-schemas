view: itv_short_cycle {
  label: "ITV Short Cycle"
  sql_table_name: eliza.itv_short_cycle ;;

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension_group: datetime {
    type: time
    timeframes: [date, time, year, month_num, day_of_month, hour_of_day]
    label: "Event"
    sql: parse_datetime(${TABLE}.datetime, 'y-M-d H:m:s') ;;
  }

  dimension: flight_media_id {
    type: number
    label: "Flight Media ID"
    description: "Internal identifier of the flight media"
    value_format_name: id
    sql: ${TABLE}.fmid ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    description: "Total impressions"
    sql: ${TABLE}.impressions ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    description: "Internal identifier of the placement"
    value_format_name: id
    sql: ${TABLE}.pid ;;
  }
}
