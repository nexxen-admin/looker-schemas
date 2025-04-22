# The name of this view in Looker is "V Dim Netsuite Daily Exchange Rate Target Currency"
view: v_dim_netsuite_daily_exchange_rate_target_currency {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_dim_netsuite_daily_exchange_rate_target_currency ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Exchange Rate" in Explore.

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension: exchange_rate_to_target_currency_key {
    type: number
    sql: ${TABLE}.exchange_rate_to_target_currency_key ;;
    hidden: yes
  }



  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: from_currency_id {
    type: number
    sql: ${TABLE}.from_currency_id ;;
  }

  dimension: from_currency_iso {
    type: string
    sql: ${TABLE}.from_currency_iso ;;
  }

  dimension: netsuite_daily_exchange_rate_key {
    type: number
    sql: ${TABLE}.netsuite_daily_exchange_rate_key ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: to_currency_id {
    type: number
    sql: ${TABLE}.to_currency_id ;;
  }

  dimension: to_currency_iso {
    type: string
    sql: ${TABLE}.to_currency_iso ;;
  }
  measure: count {
    type: count
  }
}
