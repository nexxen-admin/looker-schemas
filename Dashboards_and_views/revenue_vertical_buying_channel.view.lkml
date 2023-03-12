# The name of this view in Looker is "Revenue Vertical Buying Channel"
view: revenue_vertical_buying_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Revenue_Vertical_Buying_Channel ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Advertiser Category" in Explore.

  dimension: advertiser_category {
    type: string
    sql: ${TABLE}.advertiser_category ;;
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  dimension: buy_type {
    type: string
    sql: case when ${revenue_vertical_buying_channel.buying_channel}='Firstparty - Other' OR ${revenue_vertical_buying_channel.buying_channel}='Firstparty - Tvdsp'
    then 'First Party'
              when ${revenue_vertical_buying_channel.buying_channel}='Omp' then 'OMP'
              when(${revenue_vertical_buying_channel.buying_channel}='Pmp' then 'PMP'
              else ${revenue_vertical_buying_channel.buying_channel} end ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_revenue {
  #   type: sum
  #   sql: ${revenue} ;;
  # }

  # measure: average_revenue {
  #   type: average
  #   sql: ${revenue} ;;
  # }

  measure: count {
    type: count
    drill_fields: []
  }
}
