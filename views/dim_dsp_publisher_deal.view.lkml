view: dim_dsp_publisher_deal {
  sql_table_name: BI_DSP.dim_dsp_publisher_deal ;;

  dimension: ad_size {
    type: string
    sql: ${TABLE}.ad_size ;;
  }
  dimension: all_markets {
    type: number
    sql: ${TABLE}.all_markets ;;
  }
  dimension: always_on {
    type: number
    sql: ${TABLE}.always_on ;;
  }
  dimension: ao_deal {
    type: number
    sql: ${TABLE}.ao_deal ;;
  }
  dimension: auction_type {
    type: number
    sql: ${TABLE}.auction_type ;;
  }
  dimension: availability_id {
    type: number
    sql: ${TABLE}.availability_id ;;
  }
  dimension: avails {
    type: string
    sql: ${TABLE}.avails ;;
  }
  dimension: contact_details {
    type: string
    sql: ${TABLE}.contact_details ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }
  dimension: cr_approval_required {
    type: number
    sql: ${TABLE}.cr_approval_required ;;
  }
  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
  }
  dimension: currency_id {
    type: number
    sql: ${TABLE}.currency_id ;;
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
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deal_type {
    type: number
    sql: ${TABLE}.deal_type ;;
  }
  dimension: default_flat_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.default_flat_bid ;;
  }
  dimension_group: end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date ;;
  }
  dimension: estimated_price {
    type: number
    sql: ${TABLE}.estimated_price ;;
  }
  dimension: expandable {
    type: number
    sql: ${TABLE}.expandable ;;
  }
  dimension: external_order_id {
    type: string
    sql: ${TABLE}.external_order_id ;;
  }
  dimension: from_storefront {
    type: number
    sql: ${TABLE}.from_storefront ;;
  }
  dimension: geo {
    type: string
    sql: ${TABLE}.geo ;;
  }
  dimension: hd_video_required {
    type: number
    sql: ${TABLE}.hd_video_required ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: ingestion_status {
    type: number
    sql: ${TABLE}.ingestion_status ;;
  }
  dimension: inv_src_id {
    type: number
    sql: ${TABLE}.inv_src_id ;;
  }
  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }
  dimension: kpi_id {
    type: number
    sql: ${TABLE}.kpi_id ;;
  }
  dimension_group: last_dist {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_dist_time ;;
  }
  dimension_group: last_modified_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
  }
  dimension: market_id {
    type: number
    sql: ${TABLE}.market_id ;;
  }
  dimension: media_channel_id {
    type: number
    sql: ${TABLE}.media_channel_id ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: other_info {
    type: string
    sql: ${TABLE}.other_info ;;
  }
  dimension: placement {
    type: string
    sql: ${TABLE}.placement ;;
  }
  dimension: preferred {
    type: number
    sql: ${TABLE}.preferred ;;
  }
  dimension: preferred_deal {
    type: number
    sql: ${TABLE}.preferred_deal ;;
  }
  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }
  dimension: price_type {
    type: number
    sql: ${TABLE}.price_type ;;
  }
  dimension: private_deal {
    type: number
    sql: ${TABLE}.private_deal ;;
  }
  dimension: publisher_deal_id {
    type: number
    sql: ${TABLE}.publisher_deal_id ;;
  }
  dimension: publisher_deal_key {
    type: number
    sql: ${TABLE}.publisher_deal_key ;;
    hidden:  yes
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: publisher_url {
    type: string
    sql: ${TABLE}.publisher_url ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  dimension_group: start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date ;;
  }
  dimension: terms {
    type: string
    sql: ${TABLE}.terms ;;
  }
  dimension: transitional {
    type: number
    sql: ${TABLE}.transitional ;;
  }
  dimension: uniques {
    type: number
    sql: ${TABLE}.uniques ;;
  }
  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }
  dimension_group: version_last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.version_last_modified_date ;;
  }
  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
  }
  measure: count {
    type: count
    drill_fields: [publisher_name, name]
    hidden:  yes
  }
}
