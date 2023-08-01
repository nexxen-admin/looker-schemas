# The name of this view in Looker is "Schain Report"
view: schain_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.schain_report ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Device Type" in Explore.

  dimension: device_type {
    type: string
    sql: ${TABLE}.DeviceType ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end_time {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.End_Time ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.ImpType ;;
  }

  dimension: manager_type {
    type: string
    sql: ${TABLE}.Manager_Type ;;
  }

  measure: nodes {
    type: average
    sql: ${TABLE}."Nodes" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: origin_domain {
    type: string
    sql: ${TABLE}.Origin_Domain ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.PlacementID ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.PlacementName ;;
  }

  dimension: pub_success_mgr {
    type: string
    sql: ${TABLE}.PubSuccessMgr ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.PublisherID ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.PublisherName ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.Requests ;;
  }

  dimension: seller_type {
    type: string
    sql: ${TABLE}.SellerType ;;
  }

  dimension: ssp {
    type: string
    sql: ${TABLE}.SSP ;;
  }

  dimension_group: start_time {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Start_Time ;;
  }

  dimension: supply_chain {
    type: string
    sql: ${TABLE}.Supply_Chain ;;
  }
  measure: count {
    type: count
    drill_fields: [publisher_name, placement_name]
  }
}
