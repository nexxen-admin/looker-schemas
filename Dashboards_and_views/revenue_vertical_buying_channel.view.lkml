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
    label: "Sub Vertical"
    sql: ${TABLE}.advertiser_category ;;
    drill_fields: [advertiser]
  }

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  dimension: advertiser {
    type: string
    sql: ${TABLE}.advertiser ;;
  }

  dimension: New_Vertical {
    type: string
    label: "Vertical"
    sql: case when ${TABLE}.New_Vertical = 'PERSONAL_FINANCE' then 'FINANCE'
              when ${TABLE}.New_Vertical = 'REAL_ESTATE' then 'REAL ESTATE' else ${TABLE}.New_Vertical end;;
    drill_fields: [advertiser_category]
  }


  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
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
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue ;;
  }

  dimension: buy_type {
    type: string
    sql: case when ${TABLE}.Buying_Channel='Firstparty - Other' OR ${TABLE}.Buying_Channel='Firstparty - Tvdsp'
    then 'First Party'
              when ${TABLE}.Buying_Channel='Omp' then 'OMP'
              when ${TABLE}.Buying_Channel='Pmp' then 'PMP'
              else ${TABLE}.Buying_Channel end ;;
  }

  dimension_group: current_date {
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
    sql: current_date ;;
  }

  dimension: is_current_month {
    type: string
    sql: case when ${event_month_month} = ${current_date_month}
      then 'Yes' else 'No' end;;
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
