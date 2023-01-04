view: tremor_concentration_report_with_demand_w_out_amobee{
  derived_table: {
    sql: Select date_trunc('quarter',c.event_month)::date as event_quarter,
        bc.Cohort,
        c.Billing_Agency as Buyer,
        c.Buying_Channel,
        c.device_type,
        c.impression_type,
        sum(coalesce(E2E_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0)) as E2E_Gross_Revenue,
        sum(c.E2E_Cost) as E2E_Cost,
        (sum(coalesce(E2E_Revenue,0)) + sum(coalesce(DMND_SS_Platform_Revenue,0))) - sum(c.E2E_Cost) as E2E_Net_Revenue
      From BI.SVC_TRMRCon_Consolidated c
        inner join BI.SVC_TRMRCon_Consolidated_Buyer_Cohort bc on bc.billing_agency = c.Billing_Agency
      Where c.event_month >= '2020-01-01'
        and c.event_month < date_trunc('month',current_date())
        and (c.E2E_Revenue > 0
          or c.E2E_Cost > 0)
      Group by 1, 2, 3, 4, 5, 6
      Order by 1, 3
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_quarter {
    type: date
    sql: ${TABLE}.event_quarter ;;
  }

  dimension: cohort {
    type: string
    sql: ${TABLE}.Cohort ;;
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.Buyer ;;
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: impression_type {
    type: string
    sql: ${TABLE}.impression_type ;;
  }

  measure: e2_e_gross_revenue {
    type: sum
    sql: ${TABLE}.E2E_Gross_Revenue ;;
  }

  measure: e2_e_cost {
    type: sum
    sql: ${TABLE}.E2E_Cost ;;
  }

  measure: e2_e_net_revenue {
    type: sum
    sql: ${TABLE}.E2E_Net_Revenue ;;
  }

  set: detail {
    fields: [
      event_quarter,
      cohort,
      buyer,
      buying_channel,
      device_type,
      impression_type,
      e2_e_gross_revenue,
      e2_e_cost,
      e2_e_net_revenue
    ]
  }
}
