# The name of this view in Looker is "Pub Deals Performance"
view: pub_deals_performance {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.pub_deals_performance ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Bids" in Explore.

  measure: bids {
    type: sum
    sql: ${TABLE}.Bids ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.DealID ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EventDate ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: inventory_package_id {
    type: string
    sql: ${TABLE}.InventoryPackageID ;;
  }

  dimension: package {
    type: string
    sql: ${TABLE}.Package ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.PlacementID ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.PlacementName ;;
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

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  measure: wins {
    type: sum
    sql: ${TABLE}.Wins ;;
  }
  measure: count {
    type: count
    drill_fields: [publisher_name, placement_name]
  }
}
