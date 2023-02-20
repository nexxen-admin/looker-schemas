view: base_data_without_demand {
  derived_table: {
    sql: Select
          Event_Month,
          trim(Publisher) as Publisher,
          case when Billing_Agency ilike '%bidswitch%'
          then 'Bidswitch'
          else trim(Billing_Agency) end as Buyer,
          trim(Advertiser_Name) as Advertiser,
          trim(upper(Device_Type)) as Device_Type,
          trim(upper(Impression_Type)) as Impression_Type,
          sum(Exchange_Revenue) as Exchange_Revenue,
          sum(Exchange_Cost) as Exchange_Cost,
          sum(Demand_Revenue) as Demand_Revenue,
          sum(Demand_Cost) as Demand_Cost,
          sum(E2E_Revenue) as E2E_Revenue,
          sum(E2E_Cost) as E2E_Cost
      From BI.SVC_TRMRCon_Consolidated
      Group by 1, 2, 3, 4, 5, 6
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    sql: ${TABLE}.Event_Month ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.Publisher ;;
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.Buyer ;;
  }

  dimension: advertiser {
    type: string
    sql: ${TABLE}.Advertiser ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: impression_type {
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }

  measure: exchange_revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Exchange_Revenue ;;
  }

  measure: exchange_cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Exchange_Cost ;;
  }

  measure: demand_revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Demand_Revenue ;;
  }

  measure: demand_cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Demand_Cost ;;
  }

  measure: e2_e_revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.E2E_Revenue ;;
  }

  measure: e2_e_cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.E2E_Cost ;;
  }

  set: detail {
    fields: [
      event_month,
      publisher,
      buyer,
      advertiser,
      device_type,
      impression_type,
      exchange_revenue,
      exchange_cost,
      demand_revenue,
      demand_cost,
      e2_e_revenue,
      e2_e_cost
    ]
  }
}
