# The name of this view in Looker is "Dim Dsp Creative File"
view: dim_dsp_creative_file {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_creative_file ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Aspect Ratio ID" in Explore.

  dimension: aspect_ratio_id {
    type: number
    sql: ${TABLE}.aspect_ratio_id ;;
    hidden: yes
  }

  dimension: audio_bitrate {
    type: number
    sql: ${TABLE}.audio_bitrate ;;
    hidden: yes
  }

  dimension: audio_format_id {
    type: number
    sql: ${TABLE}.audio_format_id ;;
    hidden: yes
  }

  dimension: click_url {
    type: string
    sql: ${TABLE}.click_url ;;
    hidden: yes
  }

  dimension: codec_name {
    type: string
    sql: ${TABLE}.codec_name ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden: yes
  }

  dimension: creative_file_id {
    type: number
    sql: ${TABLE}.creative_file_id ;;
    hidden: yes
  }

  dimension: creative_file_key {
    type: number
    sql: ${TABLE}.creative_file_key ;;
    hidden: yes
  }

  dimension: creative_file_type_id {
    type: number
    sql: ${TABLE}.creative_file_type_id ;;
    hidden: yes
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
    hidden: yes
  }

  dimension: external_cdn_url {
    type: string
    sql: ${TABLE}.external_cdn_url ;;
    hidden: yes
  }

  dimension: file_size {
    type: number
    sql: ${TABLE}.file_size ;;
    hidden: yes
  }

  dimension: flash_click_tag_id {
    type: number
    sql: ${TABLE}.flash_click_tag_id ;;
    hidden: yes
  }

  dimension: frame_rate {
    type: string
    sql: ${TABLE}.frame_rate ;;
    hidden: yes
  }

  dimension: height {
    type: number
    sql: ${TABLE}.height ;;
    hidden: yes
  }

  dimension: html {
    type: string
    sql: ${TABLE}.html ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: layout_id {
    type: number
    sql: ${TABLE}.layout_id ;;
    hidden: yes
  }

  dimension: media_file_id {
    type: string
    sql: ${TABLE}.media_file_id ;;
    hidden: yes
  }

  dimension: mime_type_id {
    type: number
    sql: ${TABLE}.mime_type_id ;;
    hidden: yes
  }

  dimension: original_file_name {
    type: string
    sql: ${TABLE}.original_file_name ;;
    hidden: yes
  }

  dimension: path {
    type: string
    hidden: yes
    sql: ${TABLE}.path ;;
  }

  dimension: platform_id {
    type: number
    sql: ${TABLE}.platform_id ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: thumbnail_large {
    type: string
    sql: ${TABLE}.thumbnail_large ;;
    hidden: yes
  }

  dimension: thumbnail_medium {
    type: string
    sql: ${TABLE}.thumbnail_medium ;;
    hidden: yes
  }

  dimension: thumbnail_small {
    type: string
    sql: ${TABLE}.thumbnail_small ;;
    hidden: yes
  }

  dimension: video_bitrate {
    type: number
    sql: ${TABLE}.video_bitrate ;;
    hidden: yes
  }

  dimension: width {
    type: number
    sql: ${TABLE}.width ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [original_file_name, codec_name]
    hidden: yes
  }
}
