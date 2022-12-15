# The name of this view in Looker is "Publishers Dim"
view: publishers_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: bi.PublishersDim ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Media Manager" in Explore.

  dimension: media_manager {
    type: string
    sql: ${TABLE}.MediaManager ;;
  }

  dimension: media_team {
    type: string
    sql: ${TABLE}.MediaTeam ;;
  }

  dimension: pub_id {
    type: number
    sql: ${TABLE}.PubId ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.PublisherName ;;
  }

}
