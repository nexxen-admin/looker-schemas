# The name of this view in Looker is "Fact Supply Chain"
view: fact_supply_chain {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.fact_supply_chain ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: datetime_hour {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.datetime_hour ;;
  }

  # dimension_group: db_update {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.db_update_date ;;
  # }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Device Type" in Explore.

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  dimension: manager_type {
    type: string
    sql: ${TABLE}.manager_type ;;
  }

  dimension: media_id {
    type: string
    sql: ${TABLE}.media_id ;;
  }

  measure: nodes {
    type: average
    sql: ${TABLE}."nodes" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: pub_success_mgr {
    type: string
    sql: ${TABLE}.pub_success_mgr ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.Requests ;;
  }

  dimension: seller_type {
    type: string
    sql: ${TABLE}.Seller_Type ;;
  }

  dimension: ssp {
    type: string
    sql: ${TABLE}.ssp ;;
  }

  dimension: supply_chain {
    type: string
    sql: ${TABLE}.supply_chain ;;
  }
  measure: count {
    type: count
    drill_fields: [publisher_name, placement_name]
  }
}
