view: viewer_weekly {
  derived_table: {
    sql: select viewer_type,
  timeperiod_type,
  viewer_key,
  viewer_timeperiod_key,
  start_effective_date,
  start_epoch,
  end_effective_date,
  end_epoch,
  age,
  gender,
  effective_weight,
  timeperiod_date_key
from VIEWERSHIP.viewer
where timeperiod_type = 'w';;}

  dimension: age {
    type: number
    view_label: "Weekly"
    label: "Viewer Age"
    sql: ${TABLE}.AGE ;;
  }

  dimension: effective_weight {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_WEIGHT ;;
  }

  measure: sum_effective_weight {
    type: sum
    label: "Weekly Viewer Effective Weight"
    view_label: "Weekly"
    value_format_name: decimal_0
    sql: ${effective_weight} ;;
  }

  dimension_group: end_effective {
    type: time
    view_label: "Dates"
    label: "Weekly Effective End Date"
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
    sql: ${TABLE}.END_EFFECTIVE_DATE ;;
  }

  dimension: end_epoch {
    type: number
    hidden: yes
    sql: ${TABLE}.END_EPOCH ;;
  }

  dimension: gender {
    type: string
    view_label: "Weekly"
    sql: ${TABLE}.GENDER ;;
  }

  dimension_group: start_effective {
    type: time
    label: "Weekly Effective Start Date"
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
    sql: ${TABLE}.START_EFFECTIVE_DATE ;;
  }

  dimension: start_epoch {
    type: number
    hidden: yes
    sql: ${TABLE}.START_EPOCH ;;
  }


  dimension: timeperiod_date_key {
    type: number
    #hidden: yes
    label: "Weekly Viewer Weight Timeperiod"
    view_label: "Weekly"
    description: "The timeperiod for which the viewer was effective.  This will be in the form of yyyyww where ww is the week of the year."
    sql: ${TABLE}.TIMEPERIOD_DATE_KEY ;;
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

  dimension: viewer_timeperiod_key {
    type: string
    hidden: yes
    sql: ${TABLE}.VIEWER_TIMEPERIOD_KEY ;;
  }

  dimension: viewer_type {
    type: string
    view_label: "Weekly"
    sql: CASE when ${TABLE}.VIEWER_TYPE = 'h' then 'Household'
              when ${TABLE}.VIEWER_TYPE = 'p' then 'Panelist'
              else 'Other' end;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
