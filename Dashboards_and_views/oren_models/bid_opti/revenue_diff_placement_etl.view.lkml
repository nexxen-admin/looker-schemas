view: revenue_diff_placement_etl {
  derived_table: {
    sql: select date_trunc,
       pub_id as publisher_id,
       publisher_name,
       media_id as placement_id,
       placement_name,
      operations_owner_name,
       -- requests
       SUM(CASE WHEN opti in ('bidfloor','pubcost','pubcost_bidfloor','no_opti') THEN requests ELSE 0 END) AS requests_enabled,
       SUM(CASE WHEN opti not in ('bidfloor','pubcost','pubcost_bidfloor','no_opti') THEN requests ELSE 0 END) AS requests_not_enabled,
       SUM(requests) as total_requests,
       -- revenue
       SUM(CASE WHEN opti in ('bidfloor','pubcost','pubcost_bidfloor','no_opti') THEN revenue ELSE 0 END) AS revenue_enabled,
       SUM(CASE WHEN opti not in ('bidfloor','pubcost','pubcost_bidfloor','no_opti') THEN revenue ELSE 0 END) AS revenue_not_enabled,
       SUM(revenue) as total_revenue
from bi.opti_bid_raw_v1
where opti != 'null_bucket'
group by 1,2,3,4,5,6 ;;

  }



  dimension: date_trunc {
    type: date
    sql: CAST(${TABLE}.date_trunc AS DATE) ;;
    label: "Date"
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
    label: "Publisher ID"
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
    label: "Publisher Name"
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
    label: "Placement ID"
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
    label: "Placement Name"
  }

  dimension: operations_owner_name {
    type: string
    sql: ${TABLE}.operations_owner_name ;;
    label: "Owner Name"
  }



# measu

  measure: requests_enabled {
    type: sum
    sql: ${TABLE}.requests_enabled ;;
    value_format: "#,##0"
    label: "Request (Enabled)"
  }

  measure: requests_not_enabled {
    type: sum
    sql: ${TABLE}.requests_not_enabled ;;
    value_format: "#,##0"
    label: "Request (Not Enabled)"
  }

  measure: total_requests {
    type: sum
    sql: ${TABLE}.total_requests ;;
    value_format: "#,##0"
    label: "Total Requests"
  }

  measure: revenue_enabled {
    type: sum
    sql: ${TABLE}.revenue_enabled ;;
    value_format: "$#,##0"
    label: "Revenue (Enabled)"
  }

  measure: revenue_not_enabled {
    type: sum
    sql: ${TABLE}.revenue_not_enabled ;;
    value_format: "$#,##0"
    label: "Revenue (Not Enabled)"
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    value_format: "$#,##0"
    label: "Total Revenue"
  }



  set: detail {
    fields: [
      date_trunc,
      publisher_id,
      date_trunc,
      publisher_name,
      placement_id,
      placement_name,
      operations_owner_name,

      requests_enabled,
      requests_not_enabled,
      total_requests,
      revenue_enabled,
      revenue_not_enabled,
      total_revenue
    ]
  }

}
