# The name of this view in Looker is "Rx Fact Segments Usage Data"
view: rx_fact_segments_usage_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name:bi_new.rx_fact_segments_usage_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Actual Cpm" in Explore.

  dimension: actual_cpm {
    type: number
    sql: ${TABLE}.actual_cpm ;;
  }

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: calculated_cost {
    type: sum
    sql: ${TABLE}.calculated_cost ;;  }

  dimension: category_id {
    type: string
    sql: ${TABLE}.category_id ;;
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
  }

  measure: contract_cpm {
    type: sum
    sql: ${TABLE}.contract_cpm ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: dmp_provider_name {
    type: string
    sql: ${TABLE}.DMP_Provider_Name ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
    type: time
    timeframes: [raw, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: granular_category_name {
    type: string
    sql: ${TABLE}.granular_category_name ;;
  }

  measure: grapeshot_cpm {
    type: sum
    sql: ${TABLE}.GRAPESHOT_CPM ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: overall_cpm {
    type: sum
    sql: ${TABLE}.Overall_CPM ;;
  }

  measure: rx_cost {
    type: sum
    sql: ${TABLE}.rx_cost ;;
  }

  measure: rx_cpm {
    type: sum
    sql: ${TABLE}.rx_cpm ;;
  }

  dimension: rx_deal_id {
    type: string
    sql: ${TABLE}.Rx_Deal_Id ;;
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
    drill_fields: [display_name, category_name, granular_category_name, dmp_provider_name, segment_name]
  }
}
