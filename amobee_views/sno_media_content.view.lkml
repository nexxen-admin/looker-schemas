view: media_content {
  sql_table_name: VIEWERSHIP.MEDIA_CONTENT ;;

  dimension: media_content_id {
    type: string
    sql: ${TABLE}.MEDIA_CONTENT_ID ;;
  }

  dimension_group: instance {
    type: time
    label: "Instance"
    view_label: "Media Content"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.INSTANCE_DATE ;;
  }

  dimension: instance_date_epoch {
    type: number
    hidden: yes
    sql: ${TABLE}.INSTANCE_DATE_EPOCH ;;
  }

  dimension: instance_duration {
    type: number
    view_label: "Media Content"
    sql: ${TABLE}.INSTANCE_DURATION ;;
  }

  dimension: instance_endtime {
    type: string
    view_label: "Media Content"
    sql: ${TABLE}.INSTANCE_ENDTIME ;;
  }

  dimension: instance_starttime {
    type: string
    view_label: "Media Content"
    sql: ${TABLE}.INSTANCE_STARTTIME ;;
  }

  dimension: media_content_group {
    type: string
    view_label: "Media Content"
    sql: ${TABLE}.MEDIA_CONTENT_GROUP ;;
  }

  dimension: media_content_instance_id {
    type: string
    label: "Media Content Instance ID"
    view_label: "Media Content"
    sql: ${TABLE}.MEDIA_CONTENT_INSTANCE_ID ;;
  }

  dimension: media_content_key {
    type: string
    primary_key: yes
    view_label: "Media Content"
    sql: ${TABLE}.MEDIA_CONTENT_KEY ;;
  }

  dimension: media_content_name {
    type: string
    view_label: "Media Content"
    label: "Program"
    sql: ${TABLE}.MEDIA_CONTENT_NAME ;;
  }

  dimension: media_content_parent {
    type: string
    view_label: "Media Content"
    label: "Network"
    sql: ${TABLE}.MEDIA_CONTENT_PARENT ;;
  }

  dimension: media_content_sub_instance_id {
    type: string
    view_label: "Media Content"
    sql: ${TABLE}.MEDIA_CONTENT_SUB_INSTANCE_ID ;;
  }

  dimension: media_daypart_id {
    type: string
    view_label: "Media Content"
    label: "Daypart"
    sql: ${TABLE}.MEDIA_DAYPART_ID ;;
  }

  dimension: media_instance_name {
    type: string
    view_label: "Media Content"
    sql: ${TABLE}.MEDIA_INSTANCE_NAME ;;
  }

  dimension: network_daypart_eventtime {
    view_label: "Media Content"
    hidden:  yes
    sql: ${media_content_parent}||' - '||${media_daypart_id}||' - '||viewing_fact.event_start_datetime ;;
  }

  measure: network_daypart_ad_count {
    type: count_distinct
    description: "Count of ads by Network-Daypart"
    view_label: "Media Content"
    sql: ${network_daypart_eventtime} ;;
  }

}
