view: sam_lt_pub_metrics {
  derived_table: {
    sql: With barter_fees as (
       Select deal_id_external as rx_deal_id,
       case when deal_description ilike '%Involved_%' then 'Involved'
              when deal_description ilike '%ICON_%' then 'Icon'
              when deal_description ilike '%Orion_%' then 'Orion'
              when deal_description ilike '%Agyle_%' then 'Agyle'
              else 'other' end as Barter_Agency,
       case when deal_description ilike '%Involved_%' then 0.20
              when deal_description ilike '%ICON_%' then 0.20
              when deal_description ilike '%Orion_%' then 0.15
              when deal_description ilike '%Agyle_%' then 0
              else 0 end as Rebate_Percent
       From andromeda.rx_dim_deal
       where (deal_description ilike '%Involved_%'
                     or deal_description ilike '%ICON_%'
                     or deal_description ilike '%Orion_%'
                     or deal_description ilike '%Agyle_%')
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
      'Americas-Only' as Revenue_Group,
      case when pi.operations_owner_id in ('64','45','37','63','60','11') then 'SAM' else 'LT' end as Pub_Group,
      case when ad.rx_ssp_name ilike 'rmp%' then '1P' else '3P' end as supply_source,
      Case when ad.rx_ssp_name ilike 'rmp%' then ad.pub_id
      else ssp.rx_ssp_id end as Supply_ID,
      Case when ad.rx_ssp_name ilike 'rmp%' then sp.publisher_name
      else ssp.rx_ssp_name_display end as supply_name,
      coalesce(b.Rebate_Percent,0) as rebate_percent,
      pm.Pubmatic_Rebate_Percent,
      NC_MM_Rebate_Percent,
      eMM_Rebate_Percent,
      sum(revenue) as gross_revenue_US,
      sum(cogs) as Cogs_US,

      sum(pub_platform_fee) as pub_platform_fee_US,

      sum(case when (dsp.rx_dsp_account_id = '5129'  -- Bidswitch UnrulyX Account
      and ad.dsp_seat IN ('200','306'))
      Then revenue else 0 end) * 0.04 * -1 as Platform_Cost_US,

      sum(case when (dsp.rx_dsp_account_id in ('5135','5172') and event_time < '2022-04-27') then revenue else 0 end) * pm.Pubmatic_Rebate_Percent * -1 as Pubmatic_Platform_Fee,

      (sum(revenue) * coalesce(b.Rebate_Percent,0)) * -1 as Barter_Rebate_US,


      Sum(Case when da.rx_dsp_account_name ilike '%mediamath%'
      and (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 1
      then revenue else 0 end) * NC_MM_Rebate_Percent * -1 as MM_NC_Rebate,

      Sum(Case when da.rx_dsp_account_name ilike '%mediamath%'
      and  (case when ((ad.rx_ssp_name ilike 'rmp%' and ad.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
      or (ad.rx_ssp_name ilike 'rmp%' and ad.pub_id = '100607' and ad.rx_site_id = '205973')) then 1 else 0 end) = 0
      then revenue else 0 end) * eMM_Rebate_Percent * -1 as MM_Rebate,


      sum((ssp.platform_fee_spend / 100) * ad.cogs) as SSP_Platform_Fee_US

      From andromeda.ad_data_daily ad
      inner join bi.svc_di_geo_classification di on di.country_code = ad.country_code
      left outer join andromeda.rx_dim_publisher_info pi on pi.publisher_id::varchar = ad.pub_id
      and ad.rx_ssp_name ilike 'rmp%'
      left outer join andromeda.rx_dim_publisher_operations_owner oo on oo.user_id = pi.operations_owner_id
      left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id::varchar = ad.pub_id
      and ad.rx_ssp_name ilike 'rmp%'
      left outer join andromeda.rx_dim_ssp ssp on ssp.rx_ssp_name = ad.rx_ssp_name
      Left outer join barter_fees b on b.rx_deal_id = ad.rx_deal_id
      left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
      left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      left outer join MM_Rebate_Percents mm on mm.quarter_start = date_trunc('quarter',ad.event_time)::date
      left outer join DSP_Platform_Fee_percent pm on pm.quarter_start = date_trunc('quarter',ad.event_time)::date
      and ad.event_time < '2022-04-27'  --Final date of Pubmatic Agreement
      Where event_time >= '2022-01-01'
      and event_time < current_date()
      and di.sales_region = 'AMER'
      and (ad.revenue > 0 or ad.cogs > 0)
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
      )

      Select quarter_start,
      operations_owner_id,
      operations_owner,
      revenue_group,
      pub_group,
      supply_source,
      supply_id,
      supply_name,
      sum(gross_revenue_us) as gross_revenue_AMER,
      sum(cogs_us) as cogs_AMER,
      sum(coalesce(pub_platform_fee_us,0)) as Pub_Platform_Fee,
      sum(coalesce(Pubmatic_Platform_Fee,0)) as Pubmatic_Platform_Fee,
      sum(coalesce(platform_cost_us,0)) as Bidswitch_Platform_Cost,
      sum(coalesce(barter_rebate_us,0)) as Barter_Rebate,
      sum(coalesce(SSP_Platform_Fee_US,0)) as SSP_Platform_Fee,
      sum(coalesce(MM_NC_Rebate,0)) + sum(coalesce(MM_Rebate,0)) as MediaMath_Rebate,
      (sum(coalesce(gross_revenue_us,0)) + sum(coalesce(pub_platform_fee_us,0)) + sum(coalesce(Pubmatic_Platform_Fee,0)) + sum(coalesce(platform_cost_us,0)) + sum(coalesce(barter_rebate_us,0)) + sum(coalesce(MM_NC_Rebate,0)) + sum(coalesce(MM_Rebate,0)) + sum(coalesce(SSP_Platform_Fee_US,0))) - sum(coalesce(cogs_us,0)) as Net_Revenue
      From Base_Data
      Group by 1, 2, 3, 4, 5, 6, 7, 8
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: quarter_start {
    type: date
    label: "Quarter Start Date"
    sql: ${TABLE}.quarter_start ;;
  }

  dimension: operations_owner_id {
    type: string
    label: "Ops ID"
    sql: ${TABLE}.operations_owner_id ;;
  }

  dimension: operations_owner {
    type: string
    label: "Ops Owner"
    sql: ${TABLE}.operations_owner ;;
  }

  dimension: revenue_group {
    type: string
    label: "Revenue Group"
    sql: ${TABLE}.revenue_group ;;
  }

  dimension: pub_group {
    type: string
    label: "Pub Group"
    sql: ${TABLE}.pub_group ;;
  }

  dimension: supply_source {
    type: string
    label: "Supply Source"
    sql: ${TABLE}.supply_source ;;
  }

  dimension: supply_id {
    type: number
    label: "Supply ID"
    sql: ${TABLE}.supply_id ;;
  }

  dimension: supply_name {
    type: string
    label: "Supply Name"
    sql: ${TABLE}.supply_name ;;
  }

  measure: gross_revenue_amer {
    type: sum
    label: "Gross Revenue QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.gross_revenue_AMER ;;
  }

  measure: cogs_amer {
    type: sum
    label: "COGS QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.cogs_AMER ;;
  }

  measure: pub_platform_fee {
    type: sum
    label: "Pub Platform Fee QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.Pub_Platform_Fee ;;
  }

  measure: pubmatic_platform_fee {
    type: sum
    label: "Pubmatic Platform Fee QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.Pubmatic_Platform_Fee ;;
  }

  measure: bidswitch_platform_cost {
    type: sum
    label: "Bidswitch Platform Cost QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.Bidswitch_Platform_Cost ;;
  }

  measure: barter_rebate {
    type: sum
    label: "Barter Rebates QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.Barter_Rebate ;;
  }

  measure: ssp_platform_fee {
    type: sum
    label: "SSP Platform Fee QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.SSP_Platform_Fee ;;
  }

  measure: media_math_rebate {
    type: sum
    label: "MediaMath Rebate QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.MediaMath_Rebate ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue QTD"
    value_format: "$#,##0"
    sql: ${TABLE}.Net_Revenue ;;
  }

  set: detail {
    fields: [
      quarter_start,
      operations_owner_id,
      operations_owner,
      revenue_group,
      pub_group,
      supply_source,
      supply_id,
      supply_name
    ]
  }
}
