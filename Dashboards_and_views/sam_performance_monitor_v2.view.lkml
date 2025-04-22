view: sam_performance_monitor_v2 {
  derived_table: {
    sql:   with barter_fees as (
        Select deal_id_external as rx_deal_id,
    case when deal_description ilike '%Involved_%' then 'Involved'
      when deal_description ilike '%ICON_%' then 'Icon'
      when deal_description ilike '%Orion_%' then 'Orion'
      when deal_description ilike '%Agyle_%' then 'Agyle'
      when deal_description ilike '%Evergreen%' then 'Evergreen'
      else 'other' end as Barter_Agency,
    case when deal_description ilike '%Involved_%' then 0.20
      when deal_description ilike '%ICON_%' then 0.20
      when deal_description ilike '%Orion_%' then 0.15
      when deal_description ilike '%Agyle_%' then 0.15
      when deal_description ilike '%Evergreen%' then 0.20
      else 0 end as Rebate_Percent
  From andromeda.rx_dim_deal
  where (deal_description ilike '%Involved_%'
    or deal_description ilike '%ICON_%'
    or deal_description ilike '%Orion_%'
    or deal_description ilike '%Agyle_%'
    or deal_description ilike '%Evergreen%')
    and lower(right(deal_description,6)) = 'incent'),

      MM_Rebate_Percents as (
      /* only applies to Q1 2022 */
      Select date_trunc('quarter',event_time)::date as Quarter_Start,
      sum(revenue) as MM_Total_Revenue,
      (sum(revenue) - 1000000) * 0.05 as rebate_value, --5% rebate because it's over 3M in total Q1 Spend
      ((sum(revenue) - 1000000) * 0.05) / sum(revenue) as eMM_Rebate_Percent,
      0.1 as NC_MM_Rebate_Percent
      From andromeda.ad_data_daily ad
      inner join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
      inner join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      and da.rx_dsp_account_name ilike '%mediamath%'
      Where event_time >= '2022-01-01'
      and event_time < '2022-04-01'  --Stopped after Q1
      and revenue > 0
      Group by 1
      ),


      DSP_Platform_Fee_percent as (
      Select date_trunc('quarter',event_time)::date as Quarter_Start,
      925000,  --Value from Ken as Q1 Invoiced Rebate
      sum(revenue) as Pubmatic_Revenue,
      case when date_trunc('quarter',event_time)::date < '2022-04-01'
      then 925000 / sum(revenue)
      when date_trunc('quarter',event_time)::date < '2022-04-27'
      then '0.25'
      Else 0 end as Pubmatic_Rebate_Percent
      From andromeda.ad_data_daily ad
      inner join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
      and dsp.rx_dsp_account_id in ('5135','5172')
      where event_time >= '2022-01-01'
      and event_time < '2022-04-27'  --Final date of Pubmatic Rebate Agreement
      Group by 1, 2),


      Base_Data as (
      Select date_trunc('quarter',event_time)::date as Quarter_Start,
        coalesce(pi.operations_owner_id,'1') as operations_owner_id,
        coalesce(oo.name,'Unassigned') as operations_owner,
        Case when pi.operations_owner_id in ('64','45','37','63','60','11','74','75','80','81')
         then 'SAM' else 'Long-Tail' end as Commission_Group,
       /* Case when (pi.operations_owner_id in ('64','45','37','63','60','11')
          and ad.pub_id in ('102484','102838','101350','103309','83040','103037','76146','100158','71916','57782','73160','100525','47371','102530','102868','65885','102519'))
          Then 'Intl' else 'US-Only' end as Revenue_Group,  --Modifying so all pubs are US-Only  */
      'US-Only' as Revenue_Group,
      ad.pub_id,
      sp.publisher_name,
      b.Rebate_Percent,
      mm.eMM_Rebate_Percent,
      mm.NC_MM_Rebate_Percent,
      pm.Pubmatic_Rebate_Percent,

      sum(case when di.sales_region = 'AMER' then revenue else 0 end) as gross_revenue_US,
      sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then revenue else 0 end) as gross_revenue_ROW,
      sum(case when di.sales_region = 'AMER' then cogs else 0 end) as Cogs_US,
      sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then cogs else 0 end) as Cogs_ROW,


      sum(case when di.sales_region = 'AMER' then pub_platform_fee else 0 end) as pub_platform_fee_US,
      sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then pub_platform_fee else 0 end) as pub_platform_fee_ROW,

      sum(case when (di.sales_region = 'AMER'
          and dsp.rx_dsp_account_id = '5129'  -- Bidswitch UnrulyX Account
          and ad.dsp_seat IN ('200','306'))
        Then revenue else 0 end) * 0.04 * -1 as Platform_Cost_US,
      sum(case when ((di.sales_region != 'AMER' or ad.country_code is NULL)
          and dsp.rx_dsp_account_id = '5129'  -- Bidswitch UnrulyX Account
          and ad.dsp_seat IN ('200','306'))
        Then revenue else 0 end) * 0.04 * -1 as Platform_Cost_ROW,


      Sum(Case when di.sales_region = 'AMER'
      and da.rx_dsp_account_name ilike '%mediamath%'
      and  (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 1
      then revenue else 0 end) * NC_MM_Rebate_Percent * -1 as MM_US_NC_Rebate,

      Sum(Case when (di.sales_region != 'AMER' or ad.country_code is NULL)
      and da.rx_dsp_account_name ilike '%mediamath%'
      and  (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 1
      then revenue else 0 end) * NC_MM_Rebate_Percent * -1 as MM_ROW_NC_Rebate,

      Sum(Case when di.sales_region = 'AMER'
      and da.rx_dsp_account_name ilike '%mediamath%'
      and  (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 0
      then revenue else 0 end) * eMM_Rebate_Percent * -1 as MM_US_Rebate,

      Sum(Case when (di.sales_region != 'AMER' or ad.country_code is NULL)
      and da.rx_dsp_account_name ilike '%mediamath%'
      and  (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 0
      then revenue else 0 end) * eMM_Rebate_Percent * -1 as MM_ROW_Rebate,


      sum(case when di.sales_region = 'AMER' and dsp.rx_dsp_account_id in ('5135','5172')
      then revenue else 0 end) * pm.Pubmatic_Rebate_Percent * -1 as DSP_Platform_Fee_US,

      sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) and dsp.rx_dsp_account_id in ('5135','5172')
      then revenue else 0 end) * pm.Pubmatic_Rebate_Percent * -1 as DSP_Platform_Fee_ROW,



      (sum(case when di.sales_region = 'AMER' then revenue else 0 end) * b.Rebate_Percent) * -1 as Barter_Rebate_US,
      (sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then revenue else 0 end) * b.Rebate_Percent) * -1 as Barter_Rebate_ROW,

      sum(case when di.sales_region = 'AMER' then revenue else 0 end) - sum(case when di.sales_region = 'AMER' then cogs else 0 end) as Net_Revenue_US,
      sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then revenue else 0 end) - sum(case when (di.sales_region != 'AMER' or ad.country_code is NULL) then cogs else 0 end) as Net_Revenue_ROW

      From andromeda.ad_data_daily ad
      inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id::varchar = ad.pub_id
      left outer join andromeda.rx_dim_publisher_operations_owner oo on oo.user_id = pi.operations_owner_id
      left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id::varchar = ad.pub_id
      Left outer join barter_fees b on b.rx_deal_id = ad.rx_deal_id
      left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
      left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      left outer join MM_Rebate_Percents mm on mm.quarter_start = date_trunc('quarter',ad.event_time)::date
      left outer join DSP_Platform_Fee_percent pm on pm.quarter_start = date_trunc('quarter',ad.event_time)::date
                and ad.event_time < '2022-04-27'  --Final date of Pubmatic Agreement
      left outer join bi.svc_di_geo_classification di on di.country_code = ad.country_code

      Where event_time >= timestampadd('quarter',-1,date_trunc('quarter',current_date()))::date    --'2022-01-01' reducing for performance
      and event_time < current_date()
      and ad.rx_ssp_name ilike 'rmp%'
      and (ad.revenue > 0 or ad.cogs > 0)
      and pi.operations_owner_id in ('64','45','37','63','60','11','74','75','80','81')
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11),

      agg_data as (
      Select quarter_start,
      operations_owner_id,
      operations_owner,
      commission_group,
      revenue_group,
      pub_id,
      publisher_name,
      sum(coalesce(gross_revenue_US,0)) as gross_revenue_US,
      sum(coalesce(gross_revenue_ROW,0)) as gross_revenue_ROW,
      sum(coalesce(Cogs_US,0)) as Cogs_US,
      sum(coalesce(Cogs_ROW,0)) as Cogs_ROW,
      sum(coalesce(pub_platform_fee_US,0)) as pub_platform_fee_US,
      sum(coalesce(pub_platform_fee_ROW,0)) as pub_platform_fee_ROW,
      sum(coalesce(Barter_Rebate_US,0)) as Barter_Rebate_US,
      sum(coalesce(Barter_Rebate_ROW,0)) as Barter_Rebate_ROW,
      sum(coalesce(Platform_Cost_US,0)) as Platform_Cost_US,
      sum(coalesce(Platform_Cost_ROW,0)) as Platform_Cost_ROW,
      sum(coalesce(MM_US_NC_Rebate,0)) + sum(coalesce(MM_US_Rebate,0)) as MM_Rebate_US,
      sum(coalesce(MM_ROW_NC_Rebate,0)) + sum(coalesce(MM_ROW_Rebate,0)) as MM_Rebate_ROW,
      sum(coalesce(DSP_Platform_Fee_US,0)) as DSP_Platform_Fee_US,
      sum(coalesce(DSP_Platform_Fee_ROW,0)) as DSP_Platform_Fee_ROW,



      case when revenue_group = 'Intl' then sum(coalesce(gross_revenue_US,0)) + sum(coalesce(gross_revenue_ROW,0))
      else sum(coalesce(gross_revenue_US,0)) end as Final_Gross_revenue,

      case when revenue_group = 'Intl' then sum(coalesce(Cogs_US,0)) + sum(coalesce(Cogs_ROW,0))
      else sum(coalesce(Cogs_US,0)) end as Final_Cogs,

      case when revenue_group = 'Intl' then sum(coalesce(pub_platform_fee_US,0)) + sum(coalesce(pub_platform_fee_ROW,0))
      else sum(coalesce(pub_platform_fee_US,0)) end as Final_Pub_Platform_Fee,

      case when revenue_group = 'Intl' then sum(coalesce(Barter_Rebate_US,0)) + sum(coalesce(Barter_Rebate_ROW,0))
      else sum(coalesce(Barter_Rebate_US,0)) end as Final_Barter_Rebate,

      case when revenue_group = 'Intl' then sum(coalesce(Platform_Cost_US,0)) + sum(coalesce(Platform_Cost_ROW,0))
      else sum(coalesce(Platform_Cost_US,0)) end as Final_Platform_Cost,

      case when revenue_group = 'Intl' then sum(coalesce(MM_US_NC_Rebate,0)) + sum(coalesce(MM_US_Rebate,0)) + sum(coalesce(MM_ROW_NC_Rebate,0)) + sum(coalesce(MM_ROW_Rebate,0))
      else sum(coalesce(MM_US_NC_Rebate,0)) + sum(coalesce(MM_US_Rebate,0)) end as Final_MM_Rebate,

      case when revenue_group = 'Intl' then sum(coalesce(DSP_Platform_Fee_US,0)) + sum(coalesce(DSP_Platform_Fee_ROW,0))
      else sum(coalesce(DSP_Platform_Fee_US,0)) end as Final_DSP_Platform_Fee,

      case when revenue_group = 'Intl' then (sum(coalesce(gross_revenue_US,0)) + sum(coalesce(gross_revenue_ROW,0))
      + sum(coalesce(pub_platform_fee_US,0)) + sum(coalesce(pub_platform_fee_ROW,0))
      + sum(coalesce(Barter_Rebate_US,0)) + sum(coalesce(Barter_Rebate_ROW,0))
      + sum(coalesce(Platform_Cost_US,0)) + sum(coalesce(Platform_Cost_ROW,0))
      + sum(coalesce(MM_US_NC_Rebate,0)) + sum(coalesce(MM_US_Rebate,0)) + sum(coalesce(MM_ROW_NC_Rebate,0)) + sum(coalesce(MM_ROW_Rebate,0))
      + sum(coalesce(DSP_Platform_Fee_US,0)) + sum(coalesce(DSP_Platform_Fee_ROW,0))
      )      - (sum(coalesce(Cogs_US,0)) + sum(coalesce(Cogs_ROW,0)))
      Else (sum(coalesce(gross_revenue_US,0))
      + sum(coalesce(pub_platform_fee_US,0))
      + sum(coalesce(Barter_Rebate_US,0))
      + sum(coalesce(Platform_Cost_US,0))
      + sum(coalesce(MM_US_NC_Rebate,0)) + sum(coalesce(MM_US_Rebate,0))
      + sum(coalesce(DSP_Platform_Fee_US,0))
      ) - sum(coalesce(Cogs_US,0)) end as Final_Net_Revenue
      From Base_Data
      Group by 1, 2, 3, 4, 5, 6, 7),


      ad_data as (
      Select Quarter_Start as Quarter_Start,
      operations_owner_id as operations_owner_id,
      operations_owner as operations_owner,
      sum(Final_Gross_revenue) as gross_revenue,
      sum(Final_Cogs) as Cogs,
      sum(Final_Pub_Platform_Fee) as Pub_Platform_Fee,
      sum(Final_Barter_Rebate) as Barter_Rebate,
      sum(Final_Platform_Cost) as Platform_Cost,
      sum(Final_MM_Rebate) as MM_Rebate,
      sum(Final_DSP_Platform_Fee) as DSP_Platform_Cost,
      sum(Final_Net_Revenue) as Net_Revenue
      From agg_data
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
      sum(ad.cogs) as "COGS to Date",
      sum(ad.Pub_Platform_Fee) as "Pub Platform Fee to Date",
      sum(ad.Barter_Rebate) as "Barter Rebate to Date",
      sum(ad.Platform_Cost) as "Platform Cost to Date",
      sum(ad.MM_Rebate) as "MM Rebate to Date",
      sum(ad.DSP_Platform_Cost) as "DSP Platform Cost to Date",
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

  measure: gross_revenue_to_date {
    type: sum
    label: "Gross Revenue to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."Gross Revenue to Date" ;;
  }

  measure: cogs_to_date {
    type: sum
    label: "COGS to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."COGS to Date" ;;
  }

  measure: pub_platform_fee_to_date {
    type: sum
    label: "Pub Platform Fee to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."Pub Platform Fee to Date" ;;
  }

  measure: barter_rebate_to_date {
    type: sum
    label: "Barter Rebate to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."Barter Rebate to Date" ;;
  }

  measure: platform_cost_to_date {
    type: sum
    label: "Platform Cost to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."Platform Cost to Date" ;;
  }

  measure: mm_rebate_to_date {
    type: sum
    label: "MM Rebate to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."MM Rebate to Date" ;;
  }

  measure: dsp_platform_cost_to_date {
    type: sum
    label: "DSP Platform Cost to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."DSP Platform Cost to Date" ;;
  }

  measure: net_revenue_to_date {
    type: sum
    label: "Net Revenue to Date"
    value_format: "$#,##0"
    sql: ${TABLE}."Net Revenue to Date" ;;
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
