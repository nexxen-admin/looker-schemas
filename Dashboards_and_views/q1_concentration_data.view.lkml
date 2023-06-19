view: q1_concentration_data {
  derived_table: {
    sql: Select
          Event_Month,
          trim(Publisher) as Seller,
          case when Billing_Agency ilike '%bidswitch%'
          then 'Bidswitch'
          else trim(Billing_Agency) end as Buyer,
        ModBuyer as Modified_Buyer,
          trim(Advertiser_Name) as Advertiser,
          case when length(REGEXP_SUBSTR((case when Billing_Agency ilike '%bidswitch%'
          then 'Bidswitch'
          else trim(Billing_Agency) end),trim(leading 'ACCSS - ' from advertiser))) > 1
        or length(REGEXP_SUBSTR(trim(leading 'ACCSS - ' from advertiser),(case when Billing_Agency ilike '%bidswitch%'
          then 'Bidswitch'
          else trim(Billing_Agency) end))) > 1 Then 'Yes' else 'No' end as Buyer_Direct,
        case when length(REGEXP_SUBSTR(ModBuyer,trim(leading 'ACCSS - ' from advertiser))) > 1
          or length(REGEXP_SUBSTR(trim(leading 'ACCSS - ' from advertiser),ModBuyer)) > 1 Then 'Yes' else 'No' end as Modified_Buyer_Direct,
          trim(upper(Device_Type)) as Device_Type,
          trim(upper(Impression_Type)) as Impression_Type,
          sum(Exchange_Revenue) as Exchange_Revenue,
          sum(Exchange_Cost) as Exchange_Cost,
          sum(Exchange_Revenue) -  sum(Exchange_Cost) as Exchange_Net,
          sum(coalesce(Demand_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0)) as Demand_Revenue,
          sum(Demand_Cost) as Demand_Cost,
          sum(coalesce(Demand_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0)) - sum(Demand_Cost) as Demand_Net,
          sum(coalesce(E2E_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0)) as E2E_Revenue,
          sum(E2E_Cost) as E2E_Cost,
          sum(coalesce(E2E_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0)) - sum(E2E_Cost) as E2E_Net
      From BI.SVC_TRMRCon_Consolidated_ModBuyer
      Where event_month >= '2023-01-01'
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    label: "Event Month"
    sql: ${TABLE}.Event_Month ;;
  }

  dimension: seller {
    type: string
    label: "Seller"
    sql: ${TABLE}.Seller ;;
  }

  dimension: buyer {
    type: string
    label: "Buyer, Original"
    sql: ${TABLE}.Buyer ;;
  }

  dimension: modified_buyer {
    type: string
    label: "Buyer, Modified"
    sql: ${TABLE}.Modified_Buyer ;;
  }

  dimension: advertiser {
    type: string
    label: "Advertiser"
    sql: ${TABLE}.Advertiser ;;
  }

  dimension: buyer_direct {
    type: string
    label: "Direct - Orig Buyer"
    sql: ${TABLE}.Buyer_Direct ;;
  }

  dimension: modified_buyer_direct {
    type: string
    label: "Direct - Mod Buyer"
    sql: ${TABLE}.Modified_Buyer_Direct ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: impression_type {
    type: string
    label: "Impression Type"
    sql: ${TABLE}.Impression_Type ;;
  }

  measure: exchange_revenue {
    type: sum
    label: "Exchange Gross Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.Exchange_Revenue ;;
  }

  measure: exchange_cost {
    type: sum
    label: "Exchange Cost"
    value_format: "$#,##0"
    sql: ${TABLE}.Exchange_Cost ;;
  }

  measure: exchange_net {
    type: sum
    label: "Exchange Net Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.Exchange_Net ;;
  }

  measure: demand_revenue {
    type: sum
    label: "Demand Gross Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.Demand_Revenue ;;
  }

  measure: demand_cost {
    type: sum
    label: "Demand Cost"
    value_format: "$#,##0"
    sql: ${TABLE}.Demand_Cost ;;
  }

  measure: demand_net {
    type: sum
    label: "Demand Net Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.Demand_Net ;;
  }

  measure: e2_e_revenue {
    type: sum
    label: "E2E Gross Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.E2E_Revenue ;;
  }

  measure: e2_e_cost {
    type: sum
    label: "E2E Cost"
    value_format: "$#,##0"
    sql: ${TABLE}.E2E_Cost ;;
  }

  measure: e2_e_net {
    type: sum
    label: "E2E Net Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.E2E_Net ;;
  }

  set: detail {
    fields: [
      event_month,
      seller,
      buyer,
      modified_buyer,
      advertiser,
      buyer_direct,
      modified_buyer_direct,
      device_type,
      impression_type
    ]
  }
}
