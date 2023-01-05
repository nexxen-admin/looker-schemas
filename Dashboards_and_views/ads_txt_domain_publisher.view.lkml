# The name of this view in Looker is "Ads Txt Domain Publisher"
view: ads_txt_domain_publisher {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.AdsTxt_Domain_Publisher ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ads Pub ID" in Explore.

  dimension: ads_pub_id {
    type: number
    sql: ${TABLE}.ads_PUB_ID ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: domain {
    type: string
    sql: ${TABLE}."DOMAIN" ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  #measure: total_impressions {
   # type: sum
   # sql: ${impressions} ;;
  #}

  #measure: average_impressions {
   # type: average
    #sql: ${impressions} ;;
  #}

  dimension: listing_status {
    type: string
    sql: ${TABLE}.LISTING_STATUS ;;
  }

  dimension: media_id {
    type: string
    sql: ${TABLE}.media_id ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.media_type ;;
  }

  dimension: ops_mgr {
    type: string
    sql: ${TABLE}.OpsMgr ;;
  }

  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}.Relationship ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  dimension: vertica_pub_id {
    type: number
    sql: ${TABLE}.vertica_pub_id ;;
  }

  measure: count {
    type: count
    drill_fields: [publisher_name]
  }
}
