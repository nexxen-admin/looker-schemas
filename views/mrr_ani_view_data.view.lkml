# The name of this view in Looker is "Mrr Ani View Data"
view: ani_view_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.MRR_AniView_Data ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: activity {
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
    sql: ${TABLE}.Activity_Date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Source Name" in Explore.

  dimension: ad_source_name {
    type: string
    sql: ${TABLE}.Ad_Source_Name ;;
  }

  dimension: ad_source_platform {
    type: string
    sql: ${TABLE}.Ad_Source_Platform ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.Advertiser_Name ;;
  }

  measure: bid {
    type: sum
    value_format_name: id
    sql: ${TABLE}.Bid ;;
  }

  measure: bid_rate {
    type: sum
    sql: ${TABLE}.BidRate ;;
  }

  dimension: country_iso {
    type: string
    sql: ${TABLE}.Country_ISO ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.Country_Name ;;
  }

  dimension: cpm {
    type: number
    sql: ${TABLE}.CPM ;;
  }

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  measure: fill_rate {
    type: sum
    sql: ${TABLE}.FillRate ;;
  }

  dimension: grouped_domain {
    type: string
    sql: ${TABLE}.Grouped_Domain ;;
  }

  measure: impression {
    type: sum
    sql: ${TABLE}.Impression ;;
  }

  measure: inventory {
    type: sum
    sql: ${TABLE}.Inventory ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.Os ;;
  }

  dimension: player_loaded {
    type: number
    sql: ${TABLE}.PlayerLoaded ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.Publisher_Name ;;
  }

  measure: request {
    type: sum
    sql: ${TABLE}.Request ;;
  }

  dimension: request_fill_rate {
    type: number
    sql: ${TABLE}.Request_Fill_Rate ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: rpm {
    type: number
    sql: ${TABLE}.RPM ;;
  }

  measure: count {
    type: count
    drill_fields: [country_name, publisher_name, ad_source_name, advertiser_name]
    hidden: yes
  }
}
