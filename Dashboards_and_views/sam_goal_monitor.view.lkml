view: sam_goal_monitor {
  derived_table: {
    sql: With Global_Data As
(
Select date_trunc('quarter',event_time)::date as Quarter_Start,
  pi.operations_owner_id,
  oo.name as operations_owner,
  sum(revenue) as gross_revenue,
  sum(cogs) as Cogs,
  sum(revenue) - sum(cogs) as Net_Revenue
From andromeda.ad_data_daily ad
  inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id::varchar = ad.pub_id
    and pi.operations_owner_id in ('64','45','37','63','60','11')
  left outer join andromeda.rx_dim_publisher_operations_owner oo on oo.user_id = pi.operations_owner_id
  left outer join bi.svc_days_in_quarter q on q.event_date = date_trunc('quarter',ad.event_time)::date
Where event_time >= '2022-01-01'
  and event_time < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
  and ad.rx_ssp_name ilike 'rmp%'
  and ad.pub_id in ('102484','102838','101350','103309','83040','103037','76146','100158','71916','57782','73160','100525','47371','102530','102868','65885','102519')
  and ad.revenue > 0
Group by 1, 2, 3
),

US_Data As
(
Select date_trunc('quarter',event_time)::date as Quarter_Start,
  pi.operations_owner_id,
  oo.name as operations_owner,
  sum(revenue) as gross_revenue,
  sum(cogs) as Cogs,
  sum(revenue) - sum(cogs) as Net_Revenue
From andromeda.ad_data_daily ad
  inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id::varchar = ad.pub_id
    and pi.operations_owner_id in ('64','45','37','63','60','11')
  left outer join andromeda.rx_dim_publisher_operations_owner oo on oo.user_id = pi.operations_owner_id
  left outer join bi.svc_days_in_quarter q on q.event_date = date_trunc('quarter',ad.event_time)::date
Where event_time >= '2022-01-01'
  and event_time < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
  and ad.rx_ssp_name ilike 'rmp%'
  and ad.country_code = 'US'
  and ad.pub_id Not in ('102484','102838','101350','103309','83040','103037','76146','100158','71916','57782','73160','100525','47371','102530','102868','65885','102519')
  and ad.revenue > 0
Group by 1, 2, 3
),

ad_data as (
Select coalesce(us.Quarter_Start,g.Quarter_Start) as Quarter_Start,
  coalesce(us.operations_owner_id,g.operations_owner_id) as operations_owner_id,
  coalesce(us.operations_owner,g.operations_owner) as operations_owner,
  sum(coalesce(us.gross_revenue,0)) + sum(coalesce(g.gross_revenue,0)) as gross_revenue,
  sum(coalesce(us.Cogs,0)) + sum(coalesce(g.Cogs,0)) as Cogs,
  sum(coalesce(us.Net_Revenue,0)) + sum(coalesce(g.Net_Revenue,0)) as Net_Revenue
From US_Data us
  full join Global_Data g on g.Quarter_Start = us.Quarter_Start
            and g.operations_owner_id = us.operations_owner_id
            and g.operations_owner = us.operations_owner
Group by 1, 2, 3),

Targets as (
Select sam.operations_owner_id,
  sam.operations_owner,
  sam.Mgr_operations_owner_id,
  sam.Mgr_operations_owner,
  value_type,
  revenue,
  sam.quarter_start,
  q.days_in_quarter,
  case when sam.quarter_start < date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date then q.days_in_quarter
    When sam.quarter_start > date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date then 0
    else timestampdiff(day,date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date,current_date()) end as active_quarter_days,
  (revenue / q.days_in_quarter) *
    case when sam.quarter_start < date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date then q.days_in_quarter
    When sam.quarter_start > date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date then 0
    else timestampdiff(day,date_trunc('quarter',TIMESTAMPADD('DAY', -1, date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York'))::date)::date,current_date()) end as QTD_Revenue
From bi.svc_SAM_Quarterly_Goals sam
  left outer join bi.svc_days_in_quarter q on q.event_date = sam.quarter_start
)

Select ad.Quarter_Start as "Quarter Start Date",
  ad.operations_owner_id as "SAM ID",
  ad.operations_owner as "SAM",
  b.Mgr_operations_owner_id as "SAM Manager ID",
  b.Mgr_operations_owner as "SAM Manager",
  b.active_quarter_days as "Active Days In Quarter",
  b.days_in_quarter as "Days in Quarter",
  sum(ad.gross_revenue) as "Gross Revenue to Date",
  sum(ad.net_revenue) as "Net Revenue to Date",
  sum(b.revenue) as "Baseline Target",
  sum(b.qtd_revenue) as "QTD Baseline Target",
  sum(g.revenue) as "Goal Target",
  sum(g.qtd_revenue) as "QTD Goal Target",
  sum(gr.revenue) as "Growth Target",
  sum(gr.qtd_revenue) as "QTD Growth Target"
From ad_data ad
  left outer join Targets b on b.operations_owner_id = ad.operations_owner_id
                and b.quarter_start = ad.quarter_start
                and b.value_type = 'Baseline'
  left outer join Targets g on g.operations_owner_id = ad.operations_owner_id
                and g.quarter_start = ad.quarter_start
                and g.value_type = 'Goal'
  left outer join Targets gr on gr.operations_owner_id = ad.operations_owner_id
                and gr.quarter_start = ad.quarter_start
                and gr.value_type = 'Growth'
Group by 1, 2, 3, 4, 5, 6, 7
Order by 3, 1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: quarter_start_date {
    type: date
    label: "Quarter Start Date"
    sql: ${TABLE}."Quarter Start Date" ;;
  }

  dimension: sam_id {
    type: string
    label: "SAM ID"
    sql: ${TABLE}."SAM ID" ;;
  }

  dimension: sam {
    type: string
    label: "SAM"
    sql: ${TABLE}.SAM ;;
  }

  dimension: sam_manager_id {
    type: number
    label: "SAM Manager ID"
    sql: ${TABLE}."SAM Manager ID" ;;
  }

  dimension: sam_manager {
    type: string
    label: "SAM Manager"
    sql: ${TABLE}."SAM Manager" ;;
  }

  measure: gross_revenue_to_date {
    type: sum
    label: "Gross Revenue to Date"
    value_format: "$#,##0.00"
    sql: ${TABLE}."Gross Revenue to Date" ;;
  }

  measure: net_revenue_to_date {
    type: sum
    label: "Net Revenue to Date"
    value_format: "$#,##0.00"
    sql: ${TABLE}."Net Revenue to Date" ;;
  }

  measure: active_days_in_quarter {
    type: sum
    label: "Active Days In Quarter"
    sql: ${TABLE}."Active Days In Quarter" ;;
  }

  measure: days_in_quarter {
    type: sum
    label: "Days in Quarter"
    sql: ${TABLE}."Days in Quarter" ;;
  }

  measure: baseline_target {
    type: sum
    label: "Baseline Target"
    value_format: "$#,##0"
    sql: ${TABLE}."Baseline Target" ;;
  }

  measure: qtd_baseline_target {
    type: sum
    label: "QTD Baseline Target"
    value_format: "$#,##0"
    sql: ${TABLE}."QTD Baseline Target" ;;
  }

  measure: goal_target {
    type: sum
    label: "Goal Target"
    value_format: "$#,##0"
    sql: ${TABLE}."Goal Target" ;;
  }

  measure: qtd_goal_target {
    type: sum
    label: "QTD Goal Target"
    value_format: "$#,##0"
    sql: ${TABLE}."QTD Goal Target" ;;
  }

  measure: growth_target {
    type: sum
    label: "Growth Target"
    value_format: "$#,##0"
    sql: ${TABLE}."Growth Target" ;;
  }

  measure: qtd_growth_target {
    type: sum
    label: "QTD Growth Target"
    value_format: "$#,##0"
    sql: ${TABLE}."QTD Growth Target" ;;
  }

  set: detail {
    fields: [
      quarter_start_date,
      sam_id,
      sam,
      sam_manager_id,
      sam_manager,
      active_days_in_quarter,
      days_in_quarter
    ]
  }
}
