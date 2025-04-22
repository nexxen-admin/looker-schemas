view: v_retarg_by_vendor_coverage {
  label: "Coverage Metrics"
  derived_table: {
    sql:
      SELECT p.gmt_date
      ,p.placement_id
      ,p.placement_name
      ,coalesce(vendor_id, 0) AS vendor_id
      ,coalesce(udv.description, '') AS vendor
      ,p.country_id
      ,p.country
      ,p.business_region_id
      ,p.business_region
      ,p.device_type_id
      ,p.device_type
      ,pub_requests
      ,vendor_requests
      ,attributecount
    FROM (
      SELECT gmt_date
        ,pd.placement_country_id AS country_id
        ,max(pd.placement_country) AS country
        ,pd.business_region_id AS business_region_id
        ,max(pd.business_region) AS business_region
        ,pd.device_type_id
        ,s.placement_id
        ,max(pd.device_type) AS device_type
        ,max(pd.placement_name) AS placement_name
        ,sum(publisher_requests) AS pub_requests
      FROM supply_mart.daily_placement_core_stats s
      JOIN dim.placement_details pd ON s.placement_id = pd.placement_id
      WHERE gmt_date >= dateadd(d, - 90, current_date())
        AND gmt_date < current_date()
        AND s.unserved_code IN (1,0,- 3,- 4,- 5)
      GROUP BY gmt_date
        ,pd.placement_country_id
        ,pd.business_region_id
        ,pd.device_type_id
        ,s.placement_id
      ) p
    JOIN (
      SELECT keydate
        ,vendor_id
        ,vendor_type
        ,pd.placement_country AS country
        ,pd.business_region
        ,pd.device_type
        ,pd.placement_id
        ,sum(requests) AS vendor_requests
        ,sum(coalesce(attributecount, 0)) AS attributecount
      FROM dataops.daily_retarg_by_vendor r
      JOIN dim.placement_details pd ON r.placement_id = pd.placement_id
      GROUP BY keydate
        ,vendor_id
        ,vendor_type
        ,pd.placement_country
        ,pd.business_region
        ,pd.device_type
        ,pd.placement_id
        ) rbv
      ON
          p.gmt_date = rbv.keydate
      AND p.country = rbv.country
      AND p.placement_id = rbv.placement_id
      AND p.business_region = rbv.business_region
      AND p.device_type = rbv.device_type
    JOIN dim.user_data_vendor_view udv ON rbv.vendor_id = udv.user_data_vendor_id AND
                                     rbv.vendor_type = udv.user_data_vendor_type_id ;;
  }

  dimension_group: gmt {
    type: time
    label: "GMT"
    view_label: "Dates"
    timeframes: [date,week,month,month_name,week_of_year]
    convert_tz: no
    description: "The date/time of the request in GMT"
    sql: ${TABLE}.gmt_date ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    description: "The ID of the placement"
    view_label: "Coverage Facets"
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: placement_name{
    type: string
    label: "Placement Name"
    description: "The name of the Placement."
    view_label: "Coverage Facets"
    sql: ${TABLE}.placement_name ;;
  }

  dimension: vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.vendor_id ;;
  }

  dimension: vendor {
    type: string
    label: "Data Provider"
    description: "The name of the data provider"
    view_label: "Coverage Facets"
    sql: ${TABLE}.vendor ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: country {
    type: string
    label: "Publisher Country"
    description: "The country of the office of the publisher."
    view_label: "Coverage Facets"
    sql: ${TABLE}.country ;;
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }

  dimension: business_region {
    type: string
    label: "Publisher Business Region"
    description: "The business region of the publisher."
    view_label: "Coverage Facets"
    sql: ${TABLE}.business_region ;;
  }

  dimension: device_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.device_type_id ;;
  }

  dimension: device_type {
    type: number
    label: "Placement Device"
    description: "The device type of the placement (PC, Mobile, etc.)"
    view_label: "Coverage Facets"
    sql: ${TABLE}.device_type_id ;;
  }

  dimension: pub_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.pub_requests ;;
  }

  measure: sum_pub_requests {
    type: sum
    label: "Publisher Requests"
    description: "The total number of all requests sent by a Publisher"
    value_format_name: decimal_0
    sql: ${pub_requests} ;;
  }

  dimension: vendor_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.vendor_requests ;;
  }

  measure: sum_vendor_requests {
    type: sum
    label: "Vendor Requests"
    description: "The total number of requests with at least one attribute from the provider."
    value_format_name: decimal_0
    sql: ${vendor_requests} ;;
  }

  dimension: attributecount {
    type: number
    hidden: yes
    sql: ${TABLE}.attributecount ;;
  }

  measure: sum_attributecount {
    type: sum
    label: "Attribute Count"
    description: "Total count of BT attributes."
    sql: ${attributecount} ;;
  }

  measure: coverage  {
    type: number
    label: "Coverage"
    description: "Vendor Requests / Publisher Requests"
    value_format_name: percent_2
    sql: ${sum_vendor_requests} / ${sum_pub_requests} ;;
  }

  measure: attribute_rate {
    type: number
    label: "Average Attribute Count"
    description: "Attribute Count / Vendor Requests"
    value_format_name: decimal_0
    sql: ${sum_attributecount} / ${sum_vendor_requests} ;;
  }
}
