# The name of this view in Looker is "Pub Offers Dim"
view: pub_offers_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: bi.PubOffersDim ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Offer ID" in Explore.

  dimension: offer_id {
    type: number
    sql: ${TABLE}.OfferID ;;
  }

  dimension: pub_id {
    type: number
    sql: ${TABLE}.PubId ;;
  }

  dimension: publisher_status {
    type: number
    sql: ${TABLE}.PublisherStatus ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_publisher_status {
    type: sum
    sql: ${publisher_status} ;;
  }

  measure: average_publisher_status {
    type: average
    sql: ${publisher_status} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
