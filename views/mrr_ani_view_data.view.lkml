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
    sql: ${TABLE}.Bid ;;
  }


  measure: bid_rate {
    type:number
    value_format: "0.00\%"
    sql: (${bid}/NULLIF(${request},0))*100 ;;
  }

  dimension: country_iso {
    type: string
    sql: ${TABLE}.Country_ISO ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.Country_Name ;;
  }

  measure: cpm {
    type: number
    value_format: "$#,##0.00"
    sql:(${revenue}/NULLIF(${impression},0))*1000 ;;
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
    type: number
    value_format: "0.00\%"
    sql: ${impression}/NULLIF(${inventory},0)*100 ;;
  }

  measure: advertiser_fill_rate {
    type: number
    label: "Advertiser Fill Rate"
    value_format: "0.00\%"
    sql: ${impression}/NULLIF(${request},0)*100 ;;
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

  measure: player_loaded {
    type: sum
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
    hidden: yes
  }

  measure: revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue ;;
  }

  measure: rpm {
    type: number
    value_format: "$#,##0.00"
    sql: (${revenue}/NULLIF(${inventory},0))*1000 ;;
  }

  measure: count {
    type: count
    drill_fields: [country_name, publisher_name, ad_source_name, advertiser_name]
    hidden: yes
  }
}
