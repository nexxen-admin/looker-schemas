view: base_data_without_demand {
  derived_table: {
    sql: Select
          Event_Month,
          to_char(Event_Month, 'mm') as month,
          to_char(Event_Month, 'yyyy') as year,
          upper(trim(Publisher)) as Publisher,
          case when {% parameter mapped_unmapped %} = 'mapped' then upper(Coalesce(bm.buyer_new,trm.billing_agency))
                when {% parameter mapped_unmapped %} = 'unmapped' then upper(trm.billing_agency) end as Buyer,
          Upper(trim(Advertiser_Name)) as Advertiser,
          trim(upper(Device_Type)) as Device_Type,
          trim(upper(Impression_Type)) as Impression_Type,
          sum(Exchange_Revenue) as Exchange_Revenue,
          sum(Exchange_Cost) as Exchange_Cost,
          sum(Demand_Revenue) as Demand_Revenue,
          sum(Demand_Cost) as Demand_Cost,
          sum(E2E_Revenue) as E2E_Revenue,
          sum(E2E_Cost) as E2E_Cost
      From BI.SVC_TRMRCon_Consolidated trm
        left outer join BI.SVC_Buyer_Mapping_Master bm on upper(bm.buyer_original) = upper(trm.Billing_Agency)
      Where bm.buyer_new != 'DELETE'
      Group by 1, 2, 3, 4, 5, 6,7,8
       ;;
  }

  parameter: mapped_unmapped{
    type: string
    hidden: no
    label: "Mapped/unmapped buyer:"
    allowed_value: {label: "mapped" value: "mapped"}
    allowed_value: {label: "unmapped" value: "unmapped"}
    default_value: "mapped"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    sql: ${TABLE}.Event_Month ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
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
