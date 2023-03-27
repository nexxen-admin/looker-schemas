view: weekly_viewer_avid {
  derived_table: {sql:
    select VIEWER_KEY,
  TIMEPERIOD_TYPE,
  TIMEPERIOD_START_DATETIME,
  TIMEPERIOD_END_DATETIME,
  ATTRIBUTE_VALUE_ID,
  TIMEPERIOD_DATE_KEY

from VIEWERSHIP.VIEWER_AVID
where timeperiod_type = 'w' ;;}

  dimension: attribute_value_id {
    type: number
    label: "Weekly Attrbitue Value ID"
    view_label: "Weekly"
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
    value_format_name: id
  }

  dimension: timeperiod_date_key {
    type: number
    #hidden: yes
    label: "Weekly Attribute Value Timeperiod"
    view_label: "Weekly"
    description: "The timeperiod for which the attribute value was effective.  This will be in the form of yyyyww where ww is the week of the year."
    sql: ${TABLE}.TIMEPERIOD_DATE_KEY ;;
    value_format_name: id
  }

  dimension: timeperiod_end_datetime {
    type: string
    hidden: yes
    sql: ${TABLE}.TIMEPERIOD_END_DATETIME ;;
  }

  dimension: timeperiod_start_datetime {
    type: string
    hidden: yes
    sql: ${TABLE}.TIMEPERIOD_START_DATETIME ;;
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
