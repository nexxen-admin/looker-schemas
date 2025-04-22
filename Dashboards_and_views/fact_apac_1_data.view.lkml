# The name of this view in Looker is "Fact Apac 1 Data"
view: fact_apac_1_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.fact_apac_1_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Bd Country" in Explore.

  dimension: bd_country {
    type: string
    sql: ${TABLE}.BD_Country ;;
  }

  dimension: bd_office {
    type: string
    sql: ${TABLE}.BD_Office ;;
  }

  dimension: bd_user_id {
    type: number
    sql: ${TABLE}.bd_user_id ;;
  }

  dimension: bizdev_owner {
    type: string
    sql: ${TABLE}.bizdev_owner ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
    value_format: "$#,##0"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  # dimension_group: db_updated {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.db_updated_date ;;
  # }

  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Event_Month ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
    value_format: "#,##0"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: profit {
    type: sum
    sql: ${TABLE}.profit ;;
    value_format: "$#,##0"
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0"
  }

  dimension_group: start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date ;;
  }

  dimension: traffic_source_name {
    type: string
    sql: ${TABLE}.traffic_source_name ;;
  }
  measure: count {
    type: count
    drill_fields: [traffic_source_name, publisher_name]
  }
}
