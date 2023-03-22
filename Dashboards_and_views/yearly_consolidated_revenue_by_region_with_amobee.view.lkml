view: yearly_consolidated_revenue_by_region_with_amobee {
  derived_table: {
    sql: Select  year as Year,
  quarter as Quarter,
  case when region not in ('Unknown','APAC','EMEA','Americas','Other') then 'Other'
        else region end as region,
  category,
  sum(revenue) as Revenue,
  sum(cost) as Cost
From bi.svc_legacy_2020_daily_rev_report_data
Group by 1, 2, 3, 4
UNION
Select  year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else region end as region,
  category,
  sum(revenue) as Revenue,
  sum(cost) as Cost
From bi.SVC_Daily_Revenue_Report_V6
Where event_date >= '2020-10-01'
  and event_date < '2021-01-01'
Group by 1, 2, 3, 4
UNION
Select  year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else region end as region,
  category,
  sum(case when event_date >= '2022-01-01' and record_type = 'Interco' then 0 else revenue end) as Revenue,
  sum(case when event_date >= '2022-01-01' and record_type = 'Interco' then 0 else cost end) as Cost
From BI.SVC_DRR_Daily_Revenue_Report
Where event_date >= '2021-01-01'
  and event_date < CURRENT_DATE()
Group by 1, 2, 3, 4
union
--Exchange Interco
Select  year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when geo_region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else geo_region end as region,
  'Exchange' as category,
  sum(revenue) as Revenue,
  sum(cost) as Cost
From BI.SVC_DRR_Exch_1P_Demand_Offset
Where event_date >= '2022-01-01'
  and event_date < CURRENT_DATE()
Group by 1, 2, 3, 4
union
--TVDSP Interco
Select  year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when geo_region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else geo_region end as region,
  'DSP' as category,
  sum(0) as Revenue,
  sum(inv_cost * -1) as Cost
From BI.SVC_DRR_DSP_TVDSP_Base_Metrics
Where event_date >= '2022-01-01'
  and event_date < CURRENT_DATE()
Group by 1, 2, 3, 4
UNION
--Amobee Interco
Select  year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when geo_region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else geo_region end as region,
  'DSP' as category,
  sum(0) as Revenue,
  sum(Tremor_Cost * -1) as Cost
From BI.SVC_DRR_DSP_Amobee_Base_Metrics
Where event_date >= '2022-01-01'
  and event_date < CURRENT_DATE()
Group by 1, 2, 3, 4
Union
Select year(event_date) as Year,
  quarter(event_date) as Quarter,
  case when geo_region not in ('Unknown','APAC','EMEA','Americas') then 'Other'
        else geo_region end as region,
  'DSP' as Category,
  sum(0) as Revenue,
  sum(Tremor_Cost * -1) as Cost
--Select *
From BI.SVC_DRR_AmobeeDSP_Base_Metrics d
Where event_date >= '2022-09-01'
  and event_date < CURRENT_DATE()
  and abs(tremor_cost) > 0
Group by 1, 2, 3, 4
Order by 1, 2, 3, 4


       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year {
    type: number
    label: "Year"
    sql: ${TABLE}."Year" ;;
  }

  dimension: quarter {
    type: number
    label: "Quarter"
    sql: ${TABLE}.Quarter ;;
  }

  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.region ;;
  }

  dimension: category {
    type: string
    label: "Category"
    sql: ${TABLE}.category ;;
  }

  measure: revenue {
    type: sum
    value_format: "0.00"
    label: "Revenue"
    sql: ${TABLE}.Revenue ;;
  }

  measure: cost {
    type: sum
    value_format: "0.00"
    label: "Cost"
    sql: ${TABLE}.Cost ;;
  }

  set: detail {
    fields: [
      year,
      quarter,
      region,
      category,
      revenue,
      cost
    ]
  }
}
