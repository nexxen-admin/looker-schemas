view: sam_lt_pub_metrics {
  derived_table: {
    sql:       With barter_fees as (
       Select deal_key as deal_key,
       case when deal_name ilike '%Involved_%' then 'Involved'
              when deal_name ilike '%ICON_%' then 'Icon'
              when deal_name ilike '%Orion_%' then 'Orion'
              when deal_name ilike '%Agyle_%' then 'Agyle'
              when deal_name ilike '%Evergreen%' then 'Evergreen'
              else 'other' end as Barter_Agency,
       case when deal_name ilike '%Involved_%' then 0.20
              when deal_name ilike '%ICON_%' then 0.20
              when deal_name ilike '%Orion_%' then 0.15
              when deal_name ilike '%Agyle_%' then 0.15
              when deal_name ilike '%Evergreen%' then 0.20
              else 0 end as Rebate_Percent
       From bi_new.Dim_Deal
       where (deal_name ilike '%Involved_%'
                     or deal_name ilike '%ICON_%'
                     or deal_name ilike '%Orion_%'
                     or deal_name ilike '%Agyle_%'
                     or deal_name ilike '%Evergreen%')
              and lower(right(deal_name,6)) = 'incent'),

   MM_Rebate_Percents as (
      /* only applies to Q1 2022 */
      Select date_trunc('quarter',ad.date_key)::date as Quarter_Start,
      sum(ad.sum_of_revenue) as MM_Total_Revenue,
      (sum(ad.sum_of_revenue) - 1000000) * 0.05 as rebate_value, --5% rebate because it's over 3M in total Q1 Spend
      ((sum(ad.sum_of_revenue) - 1000000) * 0.05) / sum(ad.sum_of_revenue) as eMM_Rebate_Percent,
      0.1 as NC_MM_Rebate_Percent
      From bi_new.fact_ad_daily_agg ad
      inner join bi_new.dim_dsp dsp on dsp.dsp_key = ad.DSP_Key
      inner join bi_new.dim_dsp_account da on da.dsp_account_key = dsp.dsp_account_key
      and da.dsp_account_name ilike '%mediamath%'
      Where ad.date_key >= '2022-01-01'
      and ad.date_key < '2022-04-01'  --Stopped after Q1
      and ad.sum_of_revenue > 0
      Group by 1),

   DSP_Platform_Fee_Percent as (
      Select date_trunc('quarter',ad.date_key)::date as Quarter_Start,
      925000,  --Value from Ken as Q1 Invoiced Rebate
      sum(ad.sum_of_revenue) as Pubmatic_Revenue,
      case when date_trunc('quarter',ad.date_key)::date < '2022-04-01'
      then 925000 / sum(ad.sum_of_revenue)
      when date_trunc('quarter',ad.date_key)::date < '2022-04-27'
      then '0.25'
      Else 0 end as Pubmatic_Rebate_Percent
      From bi_new.fact_ad_daily_agg ad
      inner join bi_new.dim_dsp dsp on dsp.dsp_key = ad.DSP_Key
      and dsp.dsp_account_id in ('5135','5172')
      where ad.date_key >= '2022-01-01'
      and ad.date_key < '2022-07-01'  --Periods in Q2 had 25% fee (see base data line below)
      Group by 1, 2),

Base_Data as (
Select date_trunc('quarter',date_key)::date as Quarter_Start,
        coalesce(p.ops_owner_id,'1') as Operations_Owner_ID,
        coalesce(e.employee_name,'Unassigned') as Operations_Owner,
        'Americas-Only' as Revenue_Group,
        case when p.ops_owner_id in ('64','45','37','63','60','11','74','75','80','81') then 'SAM' else 'LT' end as Pub_Group,
        case when ssp.ssp_name ilike 'rmp%'then '1P' else '3P' end as supply_source,
      Case when ssp.ssp_name ilike 'rmp%' then p.pub_id
        else ssp.ssp_id end as Supply_ID,
      Case when ssp.ssp_name ilike 'rmp%' then p.pub_name
        else ssp.ssp_name_display end as supply_name,
      coalesce(b.Rebate_Percent,0) as rebate_percent,
      pm.Pubmatic_Rebate_Percent,
      mm.NC_MM_Rebate_Percent,
      mm.eMM_Rebate_Percent,
      sum(agg.sum_of_revenue) as gross_revenue_US,
      sum(agg.sum_of_cogs) as Cogs_US,
      sum(agg.sum_of_pub_platform_fee) as pub_platform_fee_US ,
      sum(case when (dsp.dsp_account_id = '5129'  -- Bidswitch UnrulyX Account
          and dds.seat_id IN ('200','306'))
        Then agg.sum_of_revenue else 0 end) * 0.04 * -1 as Platform_Cost_US,
    sum(case when (dsp.dsp_account_id in ('5135','5172') and agg.date_key < '2022-04-27') then agg.sum_of_revenue
          When dsp.dsp_account_id = '5172' and (agg.date_key >= '2022-06-08' and agg.date_key < '2022-07-01') Then agg.sum_of_revenue
          else 0 end) * pm.Pubmatic_Rebate_Percent * -1 as Pubmatic_Platform_Fee,
     (sum(agg.sum_of_revenue) * coalesce(b.Rebate_Percent,0)) * -1 as Barter_Rebate_US,

     Sum(Case when da.dsp_account_name ilike '%mediamath%'
        and (case when ((ssp.ssp_name ilike 'rmp%' and p.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
                  or (ssp.ssp_name ilike 'rmp%' and p.pub_id = '100607' and pl.placement_id = '205973')) then 1 else 0 end) = 1
        then agg.sum_of_revenue else 0 end) * NC_MM_Rebate_Percent * -1 as MM_NC_Rebate,

     Sum(Case when da.dsp_account_name ilike '%mediamath%'
        and  (case when ((ssp.ssp_name ilike 'rmp%' and p.pub_id in ('100635','100648','100650','100653','100654','100941','102331'))
                  or (ssp.ssp_name ilike 'rmp%' and p.pub_id = '100607' and pl.placement_id = '205973')) then 1 else 0 end) = 0
      then agg.sum_of_revenue else 0 end) * eMM_Rebate_Percent * -1 as MM_Rebate,

     sum((ssp.platform_fee_spend / 100) * agg.sum_of_cogs) as SSP_Platform_Fee_US

      From bi_new.fact_ad_daily_agg agg
         join bi_new.dim_publisher_ssp pssp on pssp.pub_ssp_key = agg.PUB_SSP_Key
         join bi_new.dim_publisher p on p.pub_key = pssp.PUB_Key
                          and pssp.ssp_name ilike 'rmp%'
         join bi_new.dim_ssp ssp on ssp.ssp_key = pssp.SSP_Key
         join bi_new.dim_employee e on e.employee_key = p.ops_owner_key
         join bi_new.dim_country c on c.Country_Key = agg.Country_Key
         join bi_new.adm_svc_DI_Geo_Regions d on lower(d.country_code) = c.Country_Code
         join barter_fees b on b.deal_key= agg.Deal_Key
         join DSP_Platform_Fee_percent pm on pm.quarter_start = date_trunc('quarter',agg.Date_Key)::date
         join MM_Rebate_Percents mm on mm.quarter_start = date_trunc('quarter',agg.Date_Key)::date
         join bi_new.Dim_DSP_Seat dds on dds.DSP_Seat_Key = agg.DSP_Seat_Key
         join bi_new.dim_dsp dsp on dsp.DSP_Key = dds.DSP_Key
         join bi_new.dim_dsp_account da on da.DSP_Account_Key = dsp.DSP_Account_Key
         join bi_new.dim_placement pl on pl.Placement_Key = agg.Placement_Key
      where agg.date_key >= '2022-01-01'
        and agg.date_key < current_date()
        and d.sales_region = 'AMER'
        and (agg.sum_of_revenue > 0 or agg.sum_of_cogs > 0)
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
