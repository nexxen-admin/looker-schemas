view: weekly_viewer_rta_group {
  derived_table: {
  sql: select rta_group_id,
  timeperiod_type,
  viewer_key,
  timeperiod_start_datetime,
  timeperiod_end_datetime,
  effective_weight,
  timeperiod_date_key
from VIEWERSHIP.viewer_rta_group
where timeperiod_type = 'w';;}

  dimension: effective_weight {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_WEIGHT ;;
  }

  measure: weekly_effective_weight {
    label: "Weekly RTA Effective Weight"
    view_label: "Weekly"
    type: sum
    sql: ${effective_weight} ;;
  }


  dimension: rta_group_id {
    type: number
    label: "Weekly RTA Group ID"
    view_label: "Weekly"
    sql: ${TABLE}.RTA_GROUP_ID ;;
    value_format_name: id
  }

  dimension: timeperiod_date_key {
    type: number
    #hidden: yes
    label: "Weekly RTA Weight Timeperiod"
    view_label: "Weekly"
    description: "The timeperiod for which the RTA group was effective.  This will be in the form of yyyyww where ww is the week of the year."
    sql: ${TABLE}.TIMEPERIOD_DATE_KEY ;;
    value_format_name: id
  }

  dimension_group: end_effective {
    type: time
    label: "Weekly RTA Effective End Date"
    view_label: "Dates"
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.TIMEPERIOD_END_DATETIME;;
  }


  dimension_group: start_effective {
    type: time
    label: "Weekly RTA Effective Start Date"
    view_label: "Dates"
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.TIMEPERIOD_START_DATETIME;;
  }


  dimension: timeperiod_type {
    type: string
    hidden: yes
    sql: ${TABLE}.TIMEPERIOD_TYPE ;;
  }

  dimension: viewer_key {
    type: string
    hidden: yes
    sql: ${TABLE}.VIEWER_KEY ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
