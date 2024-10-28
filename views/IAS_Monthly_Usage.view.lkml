# The name of this view in Looker is "Thirdpartybeacon Daily"
view: IAS_Monthly_Usage {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: Andromeda.thirdpartybeacon_daily ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "App Bundle" in Explore.


  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }


  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }


  dimension: product_method {
    type: string
    sql: ${TABLE}.product_method ;;
  }


  dimension: third_party_partner {
    type: string
    sql: ${TABLE}.third_party_partner ;;
  }
  measure: count {
    type: count
  }
}
