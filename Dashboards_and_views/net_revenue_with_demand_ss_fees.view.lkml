view: net_revenue_with_demand_ss_fees {
  derived_table: {
    sql: Select Event_Month,
        Publisher,
        Buyer,
        Advertiser,
        upper(Device_Type) as Device_Type,
        upper(Impression_Type) as Impression_Type,
        coalesce(P1_Exch_Revenue,0) as P1_Exch_Revenue,
        coalesce(P1_Exch_Cost,0) as P1_Exch_Cost,
        coalesce(P1_Exch_Net,0) as P1_Exch_Net,
        coalesce(P2_Exch_Revenue,0) as P2_Exch_Revenue,
        coalesce(P2_Exch_cost,0) as P2_Exch_cost,
        coalesce(P2_Exch_Net,0) as P2_Exch_Net,
        coalesce(P1_DMND_Revenue,0) as P1_DMND_Revenue,
        coalesce(P1_DMND_Cost,0) as P1_DMND_Cost,
        coalesce(P1_DMND_Net,0) as P1_DMND_Net,
        coalesce(P2_DMND_Revenue,0) as P2_DMND_Revenue,
        coalesce(P2_DMND_cost,0) as P2_DMND_cost,
        coalesce(P2_DMND_Net,0) as P2_DMND_Net,
        coalesce(P1_E2E_Revenue,0) as P1_E2E_Revenue,
        coalesce(P1_E2E_Cost,0) as P1_E2E_Cost,
        coalesce(P1_E2E_Net,0) as P1_E2E_Net,
        coalesce(P2_E2E_Revenue,0) as P2_E2E_Revenue,
        coalesce(P2_E2E_cost,0) as P2_E2E_cost,
        coalesce(P2_E2E_Net,0) as P2_E2E_Net
      From BI.SVC_TRMRCon_Net_Revenue_Retention_with_DMND_SS_Fees
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

  measure: p1_exch_revenue {
    type: sum
    sql: ${TABLE}.P1_Exch_Revenue ;;
  }

  measure: p1_exch_cost {
    type: sum
    sql: ${TABLE}.P1_Exch_Cost ;;
  }

  measure: p1_exch_net {
    type: sum
    sql: ${TABLE}.P1_Exch_Net ;;
  }

  measure: p2_exch_revenue {
    type: sum
    sql: ${TABLE}.P2_Exch_Revenue ;;
  }

  measure: p2_exch_cost {
    type: sum
    sql: ${TABLE}.P2_Exch_cost ;;
  }

  measure: p2_exch_net {
    type: sum
    sql: ${TABLE}.P2_Exch_Net ;;
  }

  measure: p1_dmnd_revenue {
    type: sum
    sql: ${TABLE}.P1_DMND_Revenue ;;
  }

  measure: p1_dmnd_cost {
    type: sum
    sql: ${TABLE}.P1_DMND_Cost ;;
  }

  measure: p1_dmnd_net {
    type: sum
    sql: ${TABLE}.P1_DMND_Net ;;
  }

  measure: p2_dmnd_revenue {
    type: sum
    sql: ${TABLE}.P2_DMND_Revenue ;;
  }

  measure: p2_dmnd_cost {
    type: sum
    sql: ${TABLE}.P2_DMND_cost ;;
  }

  measure: p2_dmnd_net {
    type: sum
    sql: ${TABLE}.P2_DMND_Net ;;
  }

  measure: p1_e2_e_revenue {
    type: sum
    sql: ${TABLE}.P1_E2E_Revenue ;;
  }

  measure: p1_e2_e_cost {
    type: sum
    sql: ${TABLE}.P1_E2E_Cost ;;
  }

  measure: p1_e2_e_net {
    type: sum
    sql: ${TABLE}.P1_E2E_Net ;;
  }

  measure: p2_e2_e_revenue {
    type: sum
    sql: ${TABLE}.P2_E2E_Revenue ;;
  }

  measure: p2_e2_e_cost {
    type: sum
    sql: ${TABLE}.P2_E2E_cost ;;
  }

  measure: p2_e2_e_net {
    type: sum
    sql: ${TABLE}.P2_E2E_Net ;;
  }

  measure: New_Gross_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Revenue!=0
             AND ${TABLE}.P2_E2E_Revenue =0)
           then ${TABLE}.P1_E2E_Revenue else 0 end ;;
  }

  measure: New_Net_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Net!=0
             AND ${TABLE}.P2_E2E_Net =0)
           then ${TABLE}.P1_E2E_Net else 0 end ;;
  }

  measure: Retained_Gross_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Revenue!=0
             AND ${TABLE}.P2_E2E_Revenue !=0)
           then ${TABLE}.P1_E2E_Revenue else 0 end ;;
  }

  measure: Retained_Net_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Net!=0
             AND ${TABLE}.P2_E2E_Net !=0)
           then ${TABLE}.P1_E2E_Net else 0 end ;;
  }

  #measure: Retention_Rate_E2E {
  # type: sum
  #sql: ${TABLE}.Retained_Gross_E2E/${TABLE}.Total_Gross_E2E ;;
  #}

  measure: Lost_Gross_P1_E2E {
    type: sum
    sql: 0 ;;
  }

  measure: Churn_Gross_P1_E2E {
    type: sum
    sql: 0 ;;
  }

  measure: Lost_Gross_P2_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Revenue=0
             AND ${TABLE}.P2_E2E_Revenue !=0)
           then ${TABLE}.P2_E2E_Revenue else 0 end ;;
  }

  measure: Lost_Net_P2_E2E {
    type: sum
    sql: case when (${TABLE}.P1_E2E_Net=0
             AND ${TABLE}.P2_E2E_Net !=0)
           then ${TABLE}.P2_E2E_Net else 0 end ;;
  }

  #measure: Total_Gross_E2E {
  # type: sum
  #sql: ${TABLE}.New_Gross_E2E + ${TABLE}.Lost_Gross_P1_E2E + ${TABLE}.Retained_Gross_E2E ;;
  #}

  set: detail {
    fields: [
      event_month,
      publisher,
      buyer,
      advertiser,
      device_type,
      impression_type,
      p1_exch_revenue,
      p1_exch_cost,
      p1_exch_net,
      p2_exch_revenue,
      p2_exch_cost,
      p2_exch_net,
      p1_dmnd_revenue,
      p1_dmnd_cost,
      p1_dmnd_net,
      p2_dmnd_revenue,
      p2_dmnd_cost,
      p2_dmnd_net,
      p1_e2_e_revenue,
      p1_e2_e_cost,
      p1_e2_e_net,
      p2_e2_e_revenue,
      p2_e2_e_cost,
      p2_e2_e_net
    ]
  }
}
