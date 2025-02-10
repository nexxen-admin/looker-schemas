view: scope3_processed {
  derived_table: {
    sql:
select file_name,
       atp,
       is_app,
       country,
       seller_id,
       device_type,
       inventory_id,
       utc_datetime,
       ad_opportunities,
       inventory_coverage,
       max_placement_size,
       seller_placement_id,
       ad_opportunities_processed,
       gmp_eligible::boolean as gmp_eligible
from bi.scope3_processed_data
      ;;

  }





  dimension: file_name {
    type: string
    sql: ${TABLE}."file_name" ;;
  }


  dimension: atp {
    type: string
    sql: ${TABLE}."atp" ;;
  }

  dimension: is_app {
    type: string
    sql: ${TABLE}."is_app" ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}."country" ;;
  }

  dimension: seller_id {
    type: string
    sql: ${TABLE}."seller_id" ;;
  }


  dimension: device_type {
    type: string
    sql: ${TABLE}."device_type" ;;
  }


  dimension: inventory_id {
    type: string
    sql: ${TABLE}."inventory_id" ;;
  }


  dimension: utc_datetime {
    type: string
    sql: ${TABLE}."utc_datetime" ;;
  }


  dimension: ad_opportunities {
    type: number
    sql: ${TABLE}."ad_opportunities" ;;
  }


  dimension: inventory_coverage {
    type: string
    sql: ${TABLE}."inventory_coverage" ;;
  }


  dimension: max_placement_size {
    type: string
    sql: ${TABLE}."max_placement_size" ;;
  }


  dimension: seller_placement_id {
    type: string
    sql: ${TABLE}."seller_placement_id" ;;
  }


  dimension: ad_opportunities_processed {
    type: number
    sql: ${TABLE}."ad_opportunities_processed" ;;
  }

  dimension: gmp_eligible {
    type: number
    sql: ${TABLE}."gmp_eligible" ;;
  }


  set: detail {
    fields: [
      file_name,
       atp,
       is_app,
       country,
       seller_id,
       device_type,
       inventory_id,
       utc_datetime,
       ad_opportunities,
       inventory_coverage,
       max_placement_size,
       seller_placement_id,
       ad_opportunities_processed,
       gmp_eligible

    ]
  }
}
