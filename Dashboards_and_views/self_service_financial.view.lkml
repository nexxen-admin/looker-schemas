# The name of this view in Looker is "Self Service Financial"
view: self_service_financial {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.self_service_financial ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Advertiser Name" in Explore.

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: buy_type {
    type: string
    sql: ${TABLE}.buy_type ;;
  }

  dimension: cost_data {
    type: number
    sql: ${TABLE}.CostData ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: cost_partner {
    type: sum
    sql: ${TABLE}.CostPartner ;;
    value_format: "$#,##0"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE" ;;
  }

  dimension: placement_idst {
    type: string
    sql: ${TABLE}.PlacementIdst ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0"
  }

  dimension: screen_type_code {
    type: string
    sql: ${TABLE}.screen_type_code ;;
  }

  dimension: tremor_video_dsp_fee_base_type {
    type: string
    sql: ${TABLE}.tremor_video_dsp_fee_base_type ;;
  }

  measure: tremor_video_dsp_fee_pct {
    type: sum
    sql: ${TABLE}.tremor_video_dsp_fee_pct ;;
  }
  measure: count {
    type: count
    drill_fields: [agency_name, advertiser_name]
  }
}
