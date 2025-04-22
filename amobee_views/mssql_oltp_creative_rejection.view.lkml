view: creative_rejection_view {
  sql_table_name: dbo.ssp_approval_history_by_creative_view_13_01 (NOLOCK) ;;
  suggestions: no

  dimension: advertiser {
    type: string
    label: "Advertiser"
    sql: ${TABLE}.Advertiser ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_brand_id ;;
  }

  dimension: advertiser_id {
    type: number
    label: "Advertiser ID"
    sql: ${TABLE}.advertiser_id ;;
    value_format_name: id
  }

  dimension: approval_status_id {
    type: number
    label: "Approval Status ID"
    sql: ${TABLE}.approval_status_id ;;
    value_format_name: id
  }

  dimension: approval_status {
    type: number
    label: "Approval Status"
    sql:  CASE WHEN ${TABLE}.approval_status_id = 1 THEN 'Pending'
          WHEN ${TABLE}.approval_status_id = 2 THEN 'Approved'
          WHEN ${TABLE}.approval_status_id = 3 THEN 'Rejected'
          WHEN ${TABLE}.approval_status_id = 4 THEN 'Custom'
          WHEN ${TABLE}.approval_status_id = 5 THEN 'Approved with blocked duration'
          WHEN ${TABLE}.approval_status_id = 6 THEN 'Rejected with reservation' ELSE 'Other' END ;;
  }


  dimension: approval_type {
    type: string
    label: "Approval Type"
    sql: ${TABLE}.approval_type ;;
  }

  dimension: approval_type_id {
    type: number
    label: "Approval Type ID"
    sql: ${TABLE}.approval_type_id ;;
    value_format_name: id
  }

  dimension: bitrate {
    type: number
    hidden: yes
    sql: ${TABLE}.bitrate ;;
  }

  dimension: brand {
    type: string
    label: "Brand"
    sql: ${TABLE}.Brand ;;
  }

  dimension: buying_market_alias {
    type: string
    hidden: yes
    sql: ${TABLE}.buying_market_alias ;;
  }

  dimension: buying_market_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buying_market_id ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: cdn_file_loc {
    type: string
    hidden: yes
    sql: ${TABLE}.cdn_file_loc ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changed_date {
    type: time
    label: "Changed"
    timeframes: [raw,time,date,month]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: dst_changed_date {
    type: time
    label: "[DST] Local Changed"
    timeframes: [raw,time,date,month]
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset.utc_offset}, ${TABLE}.changedon)
      else ${TABLE}.changedon end ;;
  }

  dimension: clock_ {
    type: string
    label: "External ID"
    description: "Clock #"
    sql: ${TABLE}."Clock #"
      ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: creative_format {
    type: string
    sql: ${TABLE}."Creative Format" ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}."Creative Name" ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: delivery_type {
    type: string
    sql: ${TABLE}."Delivery TYPE" ;;
  }

  dimension_group: end {
    type: time
    hidden: yes
    timeframes: [raw,time,date,month]
    sql: ${TABLE}."END DATE" ;;
  }

  dimension: file_size {
    type: number
    hidden: yes
    sql: ${TABLE}.file_size ;;
  }

  dimension: media_id {
    type: number
    sql: ${TABLE}.media_id ;;
    value_format_name: id
  }

  dimension: mimetype {
    type: string
    hidden: yes
    sql: ${TABLE}.mimetype ;;
  }

  dimension: notes {
    type: string
    label: "Notes"
    sql: ${TABLE}.notes ;;
  }

  dimension: office_id {
    type: number
    label: "Office ID"
    sql: ${TABLE}.office_id ;;
    value_format_name: id
  }

  dimension: partner_id {
    type: number
    label: "Publisher ID"
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  dimension: partner_name {
    type: string
    label: "Publisher"
    sql: ${TABLE}.partner_name ;;
  }

  dimension: publisher_approval_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_approval_id ;;
  }

  dimension_group: start {
    type: time
    hidden: yes
    timeframes: [raw,time,date,month]
    sql: ${TABLE}."START DATE" ;;
  }

  dimension: video_duration {
    type: number
    sql: ${TABLE}."Video Duration" ;;
  }

  measure: count {
    type: count
    drill_fields: [partner_name, creative_name, campaign_name, customer_name]
  }
}
