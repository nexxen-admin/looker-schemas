view: daypart {
  sql_table_name: DIM.DAYPART ;;

  dimension: daypart_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.DAYPART_ID ;;
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ATTRIBUTE_ID ;;
  }

  dimension: day_abbreviation {
    type: string
    label: "Daypart - Day of the Week"
    view_label: "Conversion Facets"
    description: "The daypart (Day of Week) that a request was served. This is based on the day and time of the viewer."
    sql: ${TABLE}.DAY_ABBREVIATION ;;
  }

  dimension: day_of_week {
    type: number
    hidden: yes
    sql: ${TABLE}.DAY_OF_WEEK ;;
  }

  dimension: description {
    type: string
    label: "Daypart"
    view_label: "Conversion Facets"
    description: "The daypart (day and time) that a request was served.
    This is based on the day and time of the viewer."
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: hour_description {
    type: string
    label: "Daypart - Hour of the Day"
    view_label: "Conversion Facets"
    description: "The daypart (Hour of Day) that a request was served. This is based on the day and time of the viewer."
    sql: ${TABLE}.HOUR_DESCRIPTION ;;
  }

  dimension: hour_of_day {
    type: number
    hidden: yes
    sql: ${TABLE}.HOUR_OF_DAY ;;
  }

  dimension: hour_daypart_id {
    type: number
    hidden: yes
    sql: ${TABLE}.HOUR_DAYPART_ID ;;
  }

  dimension: minute_of_hour {
    type: number
    hidden: yes
    sql: ${TABLE}.MINUTE_OF_HOUR ;;
  }
}
