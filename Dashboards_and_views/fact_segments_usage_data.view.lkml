# The name of this view in Looker is "Fact Segments Usage Data"
view: fact_segments_usage_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.fact_segments_usage_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Ad Slot Target" in Explore.

  dimension: ad_slot_target {
    type: string
    sql: ${TABLE}.ad_slot_target ;;
  }

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  dimension: ams_active {
    type: string
    sql: ${TABLE}.ams_active ;;
  }

  dimension: ams_entity {
    type: string
    sql: ${TABLE}.ams_entity ;;
  }

  dimension: ams_entity_id {
    type: string
    sql: ${TABLE}.ams_entity_id ;;
  }

  dimension: ams_partner_id {
    type: string
    sql: ${TABLE}.ams_partner_id ;;
  }

  dimension: ams_partner_segment_id {
    type: string
    sql: ${TABLE}.ams_partner_segment_id ;;
  }

  dimension: ams_root_segment_id {
    type: string
    sql: ${TABLE}.ams_root_segment_id ;;
  }

  dimension: ams_segment_name {
    type: string
    sql: ${TABLE}.ams_segment_name ;;
  }

  dimension: ams_targeting_type {
    type: string
    sql: ${TABLE}.ams_targeting_type ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
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

  dimension: delivery_type {
    type: string
    sql: ${TABLE}.delivery_type ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: dmp_provider {
    type: string
    sql: ${TABLE}.dmp_provider ;;
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  dimension: nexxen_dmp_provider {
    type: string
    sql: ${TABLE}.nexxen_dmp_provider ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.segment_name ;;
  }

  dimension: segment_type {
    type: string
    sql: ${TABLE}.segment_type ;;
  }
  measure: count {
    type: count
    drill_fields: [display_name, ams_segment_name, segment_name]
  }
}
