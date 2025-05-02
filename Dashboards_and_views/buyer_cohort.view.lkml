
view: buyer_cohort {
  derived_table: {
    sql: With base_data as (
      Select bm.buyer_new as Buyer,
        year(event_month) as Event_Year,
        sum(E2E_Revenue) as Annual_Gross_Revenue,
        sum(E2E_Cost) as Annual_Cost,
        sum(E2E_Revenue) - sum(E2E_Cost) as Annual_Net_Revenue
      From BI.SVC_TRMRCon_Consolidated con
        left outer join BI.SVC_Buyer_Mapping_Master bm on upper(bm.buyer_original) = upper(con.billing_agency)
      where event_month >= '2020-01-01'
        and event_month < '2025-01-01'
      and (abs(E2E_Revenue) > 0 or abs(E2E_Cost) > 0)
      Group by 1, 2
      ),

      First_Revenue_Year as (
      Select Buyer,
        min(event_year) as First_Year
      From base_data
      Group by 1
      ),

      Cohort_Labeled as (
      Select bd.buyer,
        bd.event_year,
        bd.annual_gross_revenue,
        bd.annual_cost,
        bd.Annual_Net_Revenue,
        fr.first_year,
        fr.first_year - (2020-1) as Cohort
      From base_data bd
        inner join first_revenue_year fr on bd.buyer = fr.buyer
      )

      Select first_year as 'Cohort Year',
        cohort as 'Cohort Number',
        buyer as Buyer,
        event_year as 'Event Year',
        annual_gross_revenue,
        annual_cost as Cost,
        annual_net_revenue
      From Cohort_Labeled
      Order by 1, 3, 4 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cohort_year {
    type: number
    label: "Cohort Year"
    sql: ${TABLE}."Cohort Year" ;;
  }

  dimension: cohort_number {
    type: number
    label: "Cohort Number"
    sql: ${TABLE}."Cohort Number" ;;
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.Buyer ;;
  }

  dimension: event_year {
    type: number
    label: "Event Year"
    sql: ${TABLE}."Event Year" ;;
  }

  measure: gross_revenue {
    type: sum
    label: "Gross Revenue"
    value_format: "$#,##0.00"
    sql: ${TABLE}.annual_gross_revenue ;;
  }

  measure: cost {
    type: sum
    label: "Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.Cost ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue"
    value_format: "$#,##0.00"
    sql: ${TABLE}.annual_net_revenue ;;
  }

  set: detail {
    fields: [
        cohort_year,
  cohort_number,
  buyer,
  event_year,
  gross_revenue,
  cost,
  net_revenue
  ]
  }
}
