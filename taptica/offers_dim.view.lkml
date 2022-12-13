# The name of this view in Looker is "Offers Dim"
view: offers_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: bi.OffersDim ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Offer ID" in Explore.

  dimension: offer_id {
    type: number
    sql: ${TABLE}.OfferID ;;
  }

  dimension: offer_name {
    type: string
    sql: ${TABLE}.OfferName ;;
  }

  dimension: offer_status {
    type: string
    sql: ${TABLE}.OfferStatus ;;
  }

  measure: count {
    type: count
    drill_fields: [offer_name]
    hidden: yes
  }
}
