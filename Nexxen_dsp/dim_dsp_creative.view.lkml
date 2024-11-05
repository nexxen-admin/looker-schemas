# The name of this view in Looker is "Dim Dsp Creative"
view: dim_dsp_creative {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_creative ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Ad Format ID" in Explore.

  dimension: ad_format_id {
    type: number
    label: "AD Format ID"
    sql: ${TABLE}.ad_format_id ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden: yes
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
    hidden: yes
  }

  dimension: click_url {
    type: string
    label: "Click URL"
    sql: ${TABLE}.click_url ;;
  }

  dimension: client_status_id {
    type: number
    sql: ${TABLE}.client_status_id ;;
    hidden: yes
  }

  dimension: creative_id {
    type: string
    label: "Creative ID"
    sql: ${TABLE}.creative_id ;;
  }

  dimension: creative_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_id_key ;;
    hidden: yes

  }

  dimension: creative_name {
    type: string
    label: "Creative Name"
    sql: ${TABLE}.creative_name ;;
  }

  dimension: creative_type_id {
    type: number
    label: "Creative Type ID"
    sql: ${TABLE}.creative_type_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: display_url {
    type: string
    label: "Display URL"
    sql: ${TABLE}.display_url ;;
  }

  dimension: end {
    type: date
    label: "Date"
    sql: ${TABLE}.end_date ;;
    hidden: yes
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

  dimension: media_channel_id {
    type: number
    label: "Media Channel id"
    description: "1 - Display; 2 - Video; 3 - Social; 4 - Mobile"
    sql: ${TABLE}.media_channel_id ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: start {
    type: date
    label: "Creative Start Date"
    sql: ${TABLE}.start_date ;;
    hidden: yes
  }

  dimension: title {
    type: string
    label: "Title"
    sql: ${TABLE}.title ;;
  }

  dimension: tpa_external_id {
    type: string
    label: "3P Placement ID"
    sql: ${TABLE}.tpa_external_id ;;
  }

  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
    hidden: yes
  }
}
