view: base_data_retention_analysis {
  derived_table: {
    sql: With NRR_data as (
                  Select event_month,
                      Upper(Billing_Agency) as Billing_Agency,
                      sum(exchange_revenue) as exchange_revenue,
                      sum(exchange_cost) as exchange_cost,
                      sum(coalesce(Demand_Revenue,0)) --+ sum(coalesce(DMND_SS_Platform_Revenue,0))
                        as Demand_Revenue,
                      sum(Demand_Cost) as Demand_Cost,
                      sum(coalesce(E2E_revenue,0)) --+ sum(coalesce(DMND_SS_Platform_Revenue,0))
                        as E2E_revenue,
                      sum(E2E_cost) as E2E_cost,
                      case when {% parameter period_start %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '1 year')
                            else {% parameter period_start %}::DATE end as current_period_start,
                      case when {% parameter period_end %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '1 day')
                            else {% parameter period_end %}::DATE end as current_period_end,
                      case when {% parameter period_start %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '2 year'))
                            else ADD_MONTHS({% parameter period_start %}::DATE, -12) end as previous_period_start,
                      case when {% parameter period_end %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '1 day' - INTERVAL '1 year')
                            else ADD_MONTHS({% parameter period_end %}::DATE, -12) end as previous_period_end
                  From BI.SVC_TRMRCon_Consolidated
                  Where event_month >= case when {% parameter period_start %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '2 year')) else ADD_MONTHS({% parameter period_start %}::DATE, -12) end
                      and event_month < case when {% parameter period_end %} is null then DATE(DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '1 day') else {% parameter period_end %}::DATE end
                      and LENGTH(Billing_Agency) != 0
                  Group by 1, 2)
         , nrr_data_II as
         (
            Select bm.buyer_new as buyer,
                case when {% parameter mapped_unmapped %} = 'mapped' then bm.buyer_new
                        when {% parameter mapped_unmapped %} = 'unmapped' then nrr.billing_agency end as original_buyer,
               event_month,
               current_period_start,
               current_period_end,
               previous_period_start,
               previous_period_end,
               sum(case when event_month >= current_period_start and event_month < current_period_end Then E2E_revenue else 0 end) as P1_Gross,
               sum(case when event_month >= current_period_start and event_month < current_period_end Then E2E_cost else 0 end) as P1_Cost,
               sum(case when event_month >= previous_period_start and event_month < previous_period_end
                   Then E2E_revenue else 0 end) as P2_Gross,
               sum(case when event_month >= previous_period_start and event_month < previous_period_end
                   Then E2E_cost else 0 end) as P2_cost
           From nrr_data nrr
           left outer join BI.SVC_Buyer_Mapping_Master bm on upper(bm.buyer_original) = upper(nrr.Billing_Agency)
           Group by 1, 2, 3, 4, 5, 6, 7 --, 3
         ),
         results as
         (
            Select Buyer,
                original_buyer,
                current_period_start,
                current_period_end,
                previous_period_start,
                previous_period_end,
                sum(P1_gross) as p1_rev,
                sum(p2_gross) as P2_rev,
                sum(p1_cost) as P1_cost,
                sum(p2_cost) as P2_cost,
                sum(coalesce(P1_gross,0)) - sum(coalesce(p1_cost,0)) as p1_net,
                sum(coalesce(p2_gross,0)) - sum(coalesce(p2_cost,0)) as P2_net
            From nrr_data_II
            Group by 1, 2, 3, 4, 5, 6
        )
          Select buyer,
                original_buyer,
                current_period_start,
                current_period_end,
                previous_period_start,
                previous_period_end,
                P2_net as P1_E2E_net,
                p1_net as P2_E2E_net,
                case when abs(p1_net) > 0 and abs(P2_net) > 0 then 'Existing'
                   when abs(P2_net) > 0 then 'Churn'
                   else 'New'
                  end as E2E_Retention_Type
          From results
          Where Buyer != 'DELETE'
          Group by 1, 2, 3, 4, 5, 6, 7, 8
          Order by 9
       ;;
  }

  parameter: period_start{
    type: date
    hidden: no
    label: "Start of current period:"
    description: "Start date of period."
  }

  parameter: period_end{
    type: date
    hidden: no
    label: "End of current period:"
    description: "End date of period."
  }

  parameter: mapped_unmapped{
    type: string
    hidden: no
    label: "Mapped/unmapped buyer:"
    allowed_value: {label: "mapped" value: "mapped"}
    allowed_value: {label: "unmapped" value: "unmapped"}
  }

  dimension: buyer {
    type: string
    sql: ${TABLE}.buyer ;;
  }

  dimension: original_buyer {
    type: string
    sql: ${TABLE}.original_buyer ;;
  }

  dimension: report_dates_current{
    type: string
    sql:
        'Current period: '
        || TO_CHAR(${TABLE}.current_period_start, 'YYYY-MM-DD')
        || ' - '
        || TO_CHAR(${TABLE}.current_period_end, 'YYYY-MM-DD');;
  }

  dimension: report_dates_previous{
    type: string
    sql:
        'Previous period: '
        || TO_CHAR(${TABLE}.previous_period_start, 'YYYY-MM-DD')
        || ' - '
        || TO_CHAR(${TABLE}.previous_period_end, 'YYYY-MM-DD');;
  }

  dimension: E2E_Retention_Type {
    type: string
    sql: ${TABLE}.E2E_Retention_Type ;;
  }

  measure: P2_E2E_net {
    label: "Current Net"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.P2_E2E_net ;;
  }

  measure: P1_E2E_net {
    label: "Previous Net"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.P1_E2E_net ;;
  }

}
