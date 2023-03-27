view: insertion_order_details {
  sql_table_name: DIM.INSERTION_ORDER_DETAILS ;;
  view_label: "Insertion Order"

  dimension: account_rep {
    type: string
    label: "IO Account Rep ID"
    hidden: yes
    sql: ${TABLE}.ACCOUNT_REP ;;
  }

  dimension: advertiser_brand_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
  }

  dimension: business_hemisphere_description {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_HEMISPHERE_DESCRIPTION ;;
  }

  dimension: business_hemisphere_id {
    type: number
    hidden: yes
    sql: ${TABLE}.BUSINESS_HEMISPHERE_ID ;;
  }

  dimension: business_region_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_CURRENCY_ID ;;
  }

  dimension: business_region_description {
    type: string
    label: "Business Region"
    description: "The business region of the demand customer (Americas, EMEA, or APAC)."
    sql: ${TABLE}.BUSINESS_REGION_DESCRIPTION;;
    drill_fields: [platform_client_group_description, platform_client_description]
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_ID ;;
  }

  dimension: changedon {
    type: date
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: contract_number {
    type: string
    label: "Contract Number"
    description: "The Insertion Order contract number."
    sql: ${TABLE}.CONTRACT_NUMBER ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.contract_number
  }

  dimension: createdon {
    type: date
    label: "Created Date"
    description: "The date the Insertion Order was created in the system."
    #hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: dst_createdon {
    type: date
    label: "[DST] Local Created Date"
    description: "The date the Insertion Order was created in the system in local time accounting DST."
    #hidden: yes
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.CREATEDON)
      else ${TABLE}.CREATEDON end ;;
  }

  dimension: currency_abbreviation {
    type: string
    sql: ${TABLE}.CURRENCY_ABBREVIATION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.currency_abbreviation
  }

  dimension: customer_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: insertion_order_id {
    type: number
    primary_key: yes
    label: "Insertion Order ID"
    description: "The internal identifier of the Insertion Order."
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
    value_format_name: id
  }

  dimension: insertion_order_name {
    type: string
    label: "Insertion Order"
    description: "The name of the Insertion Order."
    sql: ${TABLE}.INSERTION_ORDER_NAME ;;
    drill_fields: [campaign_details_base.plan_name, campaign_details_base.campaign_name, flight_details.flight_description, flight_media_details_base.media_name, flight_media_details_base.flight_media_id]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.insertion_order_name
    }

  measure: count_of_insertion_orders {
    type: number
    label: "Count of Insertion Orders"
    description: "The distinct count of Insertion Orders."
    sql: count(distinct ${insertion_order_id}) ;;
  }

  dimension: insertion_order_status_description {
    type: string
    label: "Insertion Order Status"
    description: "The current status of the Insertion Order."
    sql: ${TABLE}.INSERTION_ORDER_STATUS_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.insertion_order_status_description
  }

  dimension: insertion_order_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.INSERTION_ORDER_STATUS_ID ;;
  }

  dimension: io_active {
    type: yesno
    label: "IO Active"
    description: "A yes/no indicator if the Insertion Order is currently active."
    sql: ${TABLE}.IO_ACTIVE ;;
  }

  dimension: io_begin_date {
    type: date
    label: "IO Begin Date"
    description: "The start date of the Insertion Order"
    sql: ${TABLE}.IO_BEGIN_DATE ;;
  }

  dimension: dst_io_begin_date {
    type: date
    label: "[DST] IO Local Begin Date"
    description: "The start date of the Insertion Order in local time accounting DST"
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.IO_BEGIN_DATE)
      else ${TABLE}.IO_BEGIN_DATE end ;;
  }

  dimension: io_end_date {
    type: date
    label: "IO End Date"
    description: "The end date of the Insertion Order"
    sql: DATEADD(m, -1, ${TABLE}.IO_END_DATE) ;;
  }

  dimension: dst_io_end_date {
    type: date
    label: "[DST] IO Local End Date"
    description: "The end date of the Insertion Order in local time accounting DST"
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, DATEADD(m, -1, ${TABLE}.IO_END_DATE))
      else DATEADD(m, -1, ${TABLE}.IO_END_DATE) end ;;
  }

  dimension: io_impressions {
    type: number
    label: "Insertion Order Impressions"
    description: "Impressions set on the IO"
    sql: ${TABLE}.IO_IMPRESSIONS ;;
  }

  dimension: native_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NATIVE_CURRENCY_ID ;;
  }

  dimension: office_id {
    type: string
    hidden: yes
    sql: ${TABLE}.OFFICE_ID ;;
  }

  dimension: office_name {
    type: string
    label: "Insertion Order Office"
    hidden: yes
    sql: ${TABLE}.OFFICE_NAME ;;
  }

  dimension: pitch_description {
    type: string
    hidden: yes
    sql: ${TABLE}.PITCH_DESCRIPTION ;;
  }

  dimension: pitch_id {
    type: number
    label: "Pitch ID"
    sql: ${TABLE}.PITCH_ID ;;
    value_format_name: id
  }

  dimension: pitch_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PITCH_NAME ;;
  }

  dimension: platform_client_description {
    type: string
    label: "Platform Client"
    description: "The name of the Platform Client"
    sql: ${TABLE}.PLATFORM_CLIENT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.patform_client_description


  }

  dimension: platform_client_group_description {
    type: string
    label: "Platform Client Group"
    description: "A logical grouping of platform clients."
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_DESCRIPTION ;;
  }

  dimension: platform_client_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_ID ;;
  }

  dimension: platform_client_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
  }

  dimension: reporting_business_unit_description {
    type: string
    label: "IO Reporting Business Unit"
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.io_reporting_business_unit_description
  }

  dimension: reporting_business_unit_id {
    type: number
    label: "IO Reporting Business Unit ID"
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_ID ;;
    value_format_name: id
  }

  dimension: salesperson {
    type: string
    hidden: yes
    sql: ${TABLE}.SALESPERSON ;;
  }

  dimension: salesperson_name {
    type: string
    label: "Salesperson"
    description: "The name of the salesperson for the IO, if applicable."
    sql: ${TABLE}.SALESPERSON_NAME ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.salesperson_name
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_days {
    type: number
    label: "Total Days"
    description: "The total days an Insertion Order is active."
    sql: (datediff(hour, ${io_begin_date}, ${io_end_date})/24) ;;
  }

  measure: 2018_total_days {
    type: number
    label: "2018 Total Days"
    view_label: "Insertion Order"
    description: "The total days an insertion order is open in 2018."
    hidden: yes
    sql: CASE WHEN (${io_end_date} > '2018-01-01 04:59:59'
                AND ${io_begin_date} >= '2018-01-01 04:59:59'
                  AND ${io_end_date} < '2019-01-01 00:00:00')
                    THEN (datediff(dd, ${io_begin_date}, ${io_end_date}) +1)
              WHEN (${io_end_date} > '2018-01-01 04:59:59'
                AND ${io_begin_date} > '2018-01-01 04:59:59'
                  AND ${io_end_date} >= '2019-01-01 00:00:00')
                    THEN (datediff(dd, ${io_begin_date}, '2019-01-01 00:00:00') +1)
              WHEN (${io_end_date} > '2018-01-01 04:59:59'
                AND ${io_begin_date} < '2018-01-01 04:59:59'
                  AND ${io_end_date} < '2019-01-01 04:59:59')
                    THEN (datediff(dd, '2018-01-01 05:00:00', ${io_end_date}) +1)
              WHEN (${io_begin_date} < '2018-01-01 04:59:59'
                AND ${io_end_date} > '2018-12-31 04:59:59')
                    THEN 365
              ELSE 0
        END ;;
  }

  measure: 2018_Q1_days {
    type: number
    label: "2018 Q1 Days"
    view_label: "Insertion Order"
    description: "The total days an insertion order is open in Q1 2018."
    hidden: yes
    sql: CASE WHEN (${io_end_date} < '2018-04-01 04:59:59'
                AND ${io_begin_date} >= '2018-01-01 04:59:59')
                  THEN (datediff(dd, ${io_begin_date}, ${io_end_date}) +1)
              WHEN ( ${io_end_date} > '2018-04-01 04:59:59'
                AND  ${io_begin_date} < '2018-01-01 04:59:59')
                  THEN 90
              WHEN (${io_end_date} < '2018-04-01 04:59:59'
                AND ${io_begin_date} < '2018-01-01 04:59:59'
                  AND ${io_end_date} > '2018-01-01 04:59:59')
                    THEN (datediff(dd, '2018-01-01 04:59:59', ${io_end_date}) +1)
              WHEN (${io_end_date} > '2018-04-01 04:59:59'
                AND ${io_begin_date} >= '2018-01-01 04:59:59'
                  AND ${io_begin_date} < '2018-04-01 04:59:59')
                    THEN (datediff(dd, ${io_begin_date}, '2018-03-31 04:59:59') +1)
              ELSE 0
        END ;;
  }

  measure: 2018_Q2_days {
    type: number
    label: "2018 Q2 Days"
    view_label: "Insertion Order"
    description: "The total days an insertion order is open in Q2 2018."
    hidden: yes
    sql: CASE WHEN (${io_end_date} < '2018-07-01 04:59:59'
                AND ${io_begin_date} >= '2018-04-01 04:59:59')
                  THEN (datediff(dd, ${io_begin_date}, ${io_end_date}) +1)
              WHEN ( ${io_end_date} > '2018-07-01 04:59:59'
                AND  ${io_begin_date} < '2018-04-01 04:59:59')
                  THEN 90
              WHEN (${io_end_date} < '2018-07-01 04:59:59'
                AND ${io_begin_date} < '2018-04-01 04:59:59'
                  AND ${io_end_date} > '2018-04-01 04:59:59')
                    THEN (datediff(dd, '2018-04-01 04:59:59', ${io_end_date}) +1)
              WHEN (${io_end_date} > '2018-07-01 04:59:59'
                AND ${io_begin_date} >= '2018-04-01 04:59:59'
                  AND ${io_begin_date} < '2018-07-01 04:59:59')
                    THEN (datediff(dd, ${io_begin_date}, '2018-06-30 04:59:59') +1)
              ELSE 0
        END ;;
  }

  measure: 2018_Q3_days {
    type: number
    label: "2018 Q3 Days"
    view_label: "Insertion Order"
    description: "The total days an insertion order is open in Q3 2018."
    hidden: yes
    sql: CASE WHEN (${io_end_date} < '2018-10-01 04:59:59'
                AND ${io_begin_date} >= '2018-07-01 04:59:59')
                  THEN (datediff(dd, ${io_begin_date}, ${io_end_date}) +1)
              WHEN ( ${io_end_date} > '2018-10-01 04:59:59'
                AND  ${io_begin_date} < '2018-07-01 04:59:59')
                  THEN 90
              WHEN (${io_end_date} < '2018-10-01 04:59:59'
                AND ${io_begin_date} < '2018-07-01 04:59:59'
                  AND ${io_end_date} > '2018-07-01 04:59:59')
                    THEN (datediff(dd, '2018-07-01 04:59:59', ${io_end_date}) +1)
              WHEN (${io_end_date} > '2018-10-01 04:59:59'
                AND ${io_begin_date} >= '2018-07-01 04:59:59'
                  AND ${io_begin_date} < '2018-10-01 04:59:59')
                    THEN (datediff(dd, ${io_begin_date}, '2018-09-30 04:59:59') +1)
              ELSE 0
        END ;;
  }

  measure: 2018_Q4_days {
    type: number
    label: "2018 Q4 Days"
    view_label: "Insertion Order"
    description: "The total days an insertion order is open in Q4 2018."
    hidden: yes
    sql: CASE WHEN (${io_end_date} < '2019-01-01 04:59:59'
                AND ${io_begin_date} >= '2018-10-01 04:59:59')
                  THEN (datediff(dd, ${io_begin_date}, ${io_end_date}) +1)
              WHEN ( ${io_end_date} > '2019-01-01 04:59:59'
                AND  ${io_begin_date} < '2018-10-01 04:59:59')
                  THEN 90
              WHEN (${io_end_date} < '2019-01-01 04:59:59'
                AND ${io_begin_date} < '2018-10-01 04:59:59'
                  AND ${io_end_date} > '2018-10-01 04:59:59')
                    THEN (datediff(dd, '2018-10-01 04:59:59', ${io_end_date}) +1)
              WHEN (${io_end_date} > '2019-01-01 04:59:59'
                AND ${io_begin_date} >= '2018-10-01 04:59:59'
                  AND ${io_begin_date} < '2019-01-01 04:59:59')
                    THEN (datediff(dd, ${io_begin_date}, '2018-12-31 04:59:59') +1)
              ELSE 0
        END ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      pitch_name,
      office_name,
      insertion_order_name,
      salesperson_name,
      platform_client.platform_client_id,
      platform_client.platform_type_name,
      platform_client.office_name
    ]
  }
}
