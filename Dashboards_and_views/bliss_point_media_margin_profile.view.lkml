view: bliss_point_media_margin_profile {
  derived_table: {
    sql:
/* Partner_Audience_RevShare */

With DSP_Audience_Seg_Usage as (
Select R1.Event_Date,
  R1.Campaign_ID,
  R1.Campaign_Name,
  R1.Placement_ID,
  R1.Flight_Name,
  R1.Start_Date,
  R1.End_Date,
  R1.Agency,
  R1.Advertiser,
  R1.Screen_Type,
  R1.Buy_Type,
  R1.Vendor,
  R1.dmp,
  R1.Segment,
  R1.Seed_Segment,
  R1.Segment_Name,
  R1.Segment_Cost_final,
  R1.Orig_Seg_Cost,
  R1.Seed_seg_cost,
  R1.external_provider_final,
  R1.orig_external_provider,
  R1.seed_external_provider,
  R1.external_provider_id_final,
  R1.orig_external_provider_id,
  R1.seed_provider_id,
  R1.AMS_Entity,
  R1.Matched_Impressions,
  R1.Modeled_Impressions,
  R1.Vendor_Matched_Cost,
  R1.Vendor_Modeled_Cost,
  R1.Customer_Matched_Cost,
  R1.Customer_Modeled_Cost,
  R2.Seed_Matched_Impressions,
  Case when regexp_substr(R1.Segment_Name,'(#HHT#+)')::varchar  is not NULL
        and R1.external_provider_final = 'TV_INTELLIGENCE'
    THEN trim(right(R1.Segment_Name,length(R1.Segment_Name)-position('-' in R1.Segment_Name)))
    ELSE NULL End as Fourthwall_Segment_Name,
  coalesce(r1.seed_segment,r1.segment) as FW_Segment,
  coalesce(Case when regexp_substr(R1.Segment_Name,'(#HHT#+)')::varchar  is not NULL
        and R1.external_provider_final = 'TV_INTELLIGENCE'
    THEN trim(right(R1.Segment_Name,length(R1.Segment_Name)-position('-' in R1.Segment_Name)))
    ELSE NULL End,r1.segment_name) as Combined_FW_Segment

From
  (SELECT cast(u.date as date) as Event_Date,
    cast(c.campaign_id as varchar) as Campaign_ID,
    c.campaign_name as Campaign_Name,
    cast(u.placement as varchar) as Placement_ID,
    c.flight_name as Flight_Name,
    cast(c.start_date as date) as Start_Date,
    cast(c.end_date as date) as End_Date,
    c.agency_name as Agency,
    c.advertiser_name as Advertiser,
    t.screen_type_name as Screen_Type,
    CASE c.buy_type
      WHEN 'Guaranteed_Managed_Service' THEN 'Managed Service'
      WHEN 'Private_Exchange' THEN 'Self Service'
      WHEN 'Self_Service' THEN 'Self Service'
      WHEN 'Programmatic' THEN 'Self Service'
      ELSE 'OMP' END as Buy_Type,
      u.vendor as Vendor,
      dvm.dmp,
      u.segment as Segment,
      di.s2_segment_id as Seed_Segment,
      di.seg_name as Segment_Name,
      di.seg_cost as Segment_Cost_final,
      di.s1_seg_cost as Orig_Seg_Cost,
      di.s2_seg_cost as Seed_seg_cost,
      di.external_provider as external_provider_final,  -- as DMP,
      di.s1_external_provider as orig_external_provider,
      di.s2_external_provider as seed_external_provider,
      di.external_provider_id as external_provider_id_final,
      di.s1_external_provider_id as orig_external_provider_id,
      di.s2_external_provider_id as seed_provider_id,
      di.AMS_Entity,
      SUM(u.matched_impressions) as Matched_Impressions,
      CEIL(SUM(u.modeled_impressions)) as Modeled_Impressions,
      SUM(seg_cost * (matched_impressions / 1000)) as Vendor_Matched_Cost,
      SUM(CASE di.external_provider
      WHEN 'ICX' THEN seg_cost * (modeled_impressions / 1000)
            WHEN 'LIVERAMP_MOBILE' THEN seg_cost * (modeled_impressions / 1000)
            WHEN 'LIVERAMP_ONLINE' THEN seg_cost * (modeled_impressions / 1000)
            WHEN 'EYEOTA' THEN (seg_cost * 0.5) * (modeled_impressions / 1000)
            WHEN 'DSTILLERY' THEN
              CASE WHEN seg_cost = 0.90 THEN 0.45
              ELSE seg_cost
              END * (modeled_impressions / 1000)
            ELSE 0  END) as Vendor_Modeled_Cost,
        SUM(matched_cost) as Customer_Matched_Cost,
        SUM(modeled_cost) as Customer_Modeled_Cost
  FROM
      dwh.dmp_segment_usage u
      LEFT OUTER JOIN dwh.campaign c ON u.placement = c.flight_id
      left outer join dwh.screen_type t on u.screen_type = t.screen_type_code
      Left outer Join sandbox.svc_dmp_vendor_mapping dvm on dvm.vendor_code = u.vendor
      left outer JOIN
          (Select vendor.segment_id,
              s.segment_id as s_segment_id,
              s.s2_segment_id,
          vendor.vendor,
          case when (s.seg_name ilike 'icx_%'
              or s.seg_name ilike '% - icx_%'
              or s.seg_name ilike '% ICX %')
              then 'ICX'
            when (s.seg_name ilike 'Fyllo %'
              or s.seg_name ilike '% Fyllo %')
             then 'Fyllo'
            else s.external_provider
              End as external_provider,  --I think I can do case when seg_name ilike 'icx_%' then 'ICX' else external_provider end
          s.s1_external_provider,
          s.s2_external_provider,
          s.external_provider_id,
          s.s1_external_provider_id,
          s.s2_external_provider_id,
          s.AMS_Entity,
          s.seg_name,
          case when (s.seg_name ilike 'icx_%'
              or s.seg_name ilike '% - icx_%'
              or s.seg_name ilike '% ICX %')
            then 1.50 else s.seg_cost
            End as seg_cost,  --I think I can hardcode ICX CPM here
          s.s1_seg_cost,
          s.s2_seg_cost
        From
        (Select u.vendor,
          u.segment as segment_id,
          dvm.DMP
        From dwh.dmp_segment_usage u
        left outer join sandbox.svc_dmp_vendor_mapping   dvm on dvm.vendor_code = u.vendor
        Where u.date >= '2023-03-23'  --DATE THAT LEGACY DATA BELOW STOPS
          and u.date < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
         Group by 1, 2, 3) vendor
         Left Join  (SELECT s1.external_provider_id as s1_external_provider,
                  s1.external_provider_code as s1_external_provider_id,
                    s1.dmp,
                    s1.id as segment_id,
                    s2.id as s2_segment_id,
                    s2.external_provider_id as s2_external_provider,
                  s2.external_provider_code as s2_external_provider_id,
                  case when regexp_substr(s1.name,'(#HHT#+)')::varchar is not NULL
                    then s2.external_provider_id
                    else s1.external_provider_id end as external_provider,
                  case when regexp_substr(s1.name,'(#HHT#+)')::varchar is not NULL
                    then s2.external_provider_code
                    else s1.external_provider_code end as external_provider_id,
                  s2.dmp as s2_dmp,
                  coalesce(ent.name,'TVDSP DMP Only') as AMS_Entity,
                    MAX(s1.name) as seg_name,
                    MIN(case when regexp_substr(s1.name,'(#HHT#+)')::varchar is not NULL then s2.cost else s1.cost end) as seg_cost,
                    min(s1.cost) as s1_seg_cost,
                    min(s2.cost) as s2_seg_cost
                  FROM dwh.dmp_segment s1
                  left join (Select id,
                        name,
                        dmp,
                        round(cost,6) as cost,
                        external_provider_code,
                        max(external_provider_id) as external_provider_id
                        From dwh.dmp_segment ds
                        Group by 1, 2, 3, 4, 5) s2 on s2.id = regexp_substr(s1.name,'([0-9]+)')::varchar
                                  and regexp_substr(s1.name,'(#HHT#+)')::varchar  is not NULL
                  left join andromeda.ams_slice_definition ams on ams.id = s1.id
                                          and s1.dmp = 'RHYTHMONE'
                  left join andromeda.ams_entities ent on ent.id = ams.entity_id
                  GROUP BY 1,2,3,4,5,6,7,8,9,10,11
                    ) s ON s.segment_id = vendor.segment_id
                      and s.dmp = vendor.dmp
          ) di ON di.segment_id = u.segment
              and di.vendor = u.vendor
  WHERE u.date >= '2023-03-23'  --DATE THAT LEGACY DATA BELOW STOPS
          and u.date < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
      and c.agency_id in ('439896','446496')
  and (matched_cost > 0 OR modeled_cost > 0 OR matched_impressions > 0 OR modeled_impressions > 0)
  GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 )  R1

Left Outer JOIN

  (SELECT cast(u.date as date) as Event_Date,
    cast(c.campaign_id as varchar) as Campaign_ID,
    c.campaign_name as Campaign_Name,
    cast(u.placement as varchar) as Placement_ID,
    c.flight_name as Flight_Name,
    cast(c.start_date as date) as Start_Date,
    cast(c.end_date as date) as End_Date,
    c.agency_name as Agency,
    c.advertiser_name as Advertiser,
    t.screen_type_name as Screen_Type,
    CASE c.buy_type
      WHEN 'Guaranteed_Managed_Service' THEN 'Managed Service'
      WHEN 'Private_Exchange' THEN 'Self Service'
      WHEN 'Self_Service' THEN 'Self Service'
      WHEN 'Programmatic' THEN 'Self Service'
      ELSE 'OMP' END as Buy_Type,
      u.vendor as Vendor,
      dvm.dmp,
      u.segment as Segment,
      di.seg_name as Segment_Name,
      di.seg_cost as Segment_Cost,
      di.external_provider,
      di.external_provider_id,
      SUM(u.matched_impressions) as Seed_Matched_Impressions
  FROM
      dwh.dmp_segment_usage u
      LEFT OUTER JOIN dwh.campaign c ON u.placement = c.flight_id
      left outer join dwh.screen_type t on u.screen_type = t.screen_type_code
      Left outer Join sandbox.svc_dmp_vendor_mapping dvm on dvm.vendor_code = u.vendor
      INNER JOIN
          (Select vendor.segment_id,
              s.segment_id as s_segment_id,
          vendor.vendor,
          s.external_provider,
          s.external_provider_id,
          s.seg_name,
          s.seg_cost
        From
        (Select u.vendor,
          u.segment as segment_id,
          dvm.DMP
        From dwh.dmp_segment_usage u
        left outer join sandbox.svc_dmp_vendor_mapping   dvm on dvm.vendor_code = u.vendor
        Where u.date >= '2023-03-23'  --DATE THAT LEGACY DATA BELOW STOPS
          and u.date < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
         Group by 1, 2, 3) vendor
         Left Join  (SELECT s1.dmp,
                    s1.id as segment_id,
                  s1.external_provider_id as external_provider,
                  s1.external_provider_code as external_provider_id,
                    MAX(s1.name) as seg_name,
                    MIN(s1.cost) as seg_cost
                  FROM dwh.dmp_segment s1
                  Where --DMP = 'RHYTHMONE' or
                  external_provider_id = 'TV_INTELLIGENCE'
                  GROUP BY 1,2,3,4
                    ) s ON s.segment_id = vendor.segment_id
                      and s.dmp = vendor.dmp
          ) di ON di.segment_id = u.segment
              and di.vendor = u.vendor
  WHERE u.date >= '2023-03-23'  --DATE THAT LEGACY DATA BELOW STOPS
      and u.date < date_trunc('DAY',current_timestamp AT TIME ZONE 'America/New_York')::date
      and c.agency_id in ('439896','446496')
  and (matched_cost > 0 OR modeled_cost > 0 OR matched_impressions > 0 OR modeled_impressions > 0)
  GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)  R2 on R2.Event_Date =  R1.Event_Date
                and R2.Campaign_ID = R1.Campaign_ID
                and R2.Placement_ID = R1.Placement_ID
                and R2.segment = R1.Seed_Segment
                                and R2.Screen_Type = R1.Screen_Type
 ),

BP_Data_Current as (
 Select date_trunc('month',event_date)::date as event_month,
  agency,
  case when agency = 'Bliss Point Media- Agency' then 446496 else 439896 end as Agency_ID,
  case when agency ='Bliss Point Media (DSP)- Agency' then 'Self-Service'
    else 'Managed-Service' end as buy_type,
  --placement_id,
  external_provider_final as External_Provider,
  sum(matched_impressions) as Matched_Impressions,
  sum(modeled_impressions) as Modeled_Impressions,
  sum(vendor_matched_cost) as vendor_matched_cost,
  sum(vendor_modeled_cost) as vendor_modeled_cost,
  sum(customer_matched_cost) as customer_matched_cost,
  sum(customer_modeled_cost) as customer_modeled_cost
 From DSP_Audience_Seg_Usage seg
Group by 1, 2, 3, 4, 5--, 6
),

BP_Data_Current_Results as (
Select bp.event_month,
  bp.agency,
  bp.agency_id,
  bp.buy_type,
  bp.external_provider,
  prc.revshare / 100 as revshare_pct,
  bp.matched_impressions,
  bp.modeled_impressions,
  bp.vendor_matched_cost as Matched_Cost,
  bp.vendor_modeled_cost as Modeled_Cost,
  customer_matched_cost,
  customer_modeled_cost,
  coalesce(bp.vendor_matched_cost,0) + coalesce(bp.vendor_modeled_cost,0) as Total_Cost,
  (coalesce(bp.vendor_matched_cost,0) + coalesce(bp.vendor_modeled_cost,0)) * (coalesce(prc.revshare,0)/100) as RevShare
From BP_Data_Current bp
  left outer join bi.svc_partner_revshare_config prc on prc.event_month = bp.event_month
                            and prc.external_provider = bp.external_provider
),

BP_CPM_Spread as (
Select bp.event_month,
  bp.agency_id,
  --bp.external_provider,
  vs.Spread_Pct,
  sum(bp.total_cost) as total_cost,
  sum(bp.total_cost * vs.Spread_Pct) as Vendor_Cost_Diff
From BP_Data_Current_Results bp
  left outer join bi.svc_BPM_TVI_Vendor_Spread vs on vs.event_month = bp.event_month
                          and vs.external_provider = bp.external_provider
Where bp.external_provider = 'TV_INTELLIGENCE'
  and bp.event_month >= '2023-04-01'
Group by 1, 2, 3
),


BP_Data_Legacy as (
 Select date_trunc('month',event_date)::date as event_month,
  agency,
  case when agency = 'Bliss Point Media- Agency' then 446496 else 439896 end as Agency_ID,
  case when agency ='Bliss Point Media (DSP)- Agency' then 'Self-Service'
    else 'Managed-Service' end as buy_type,
  --placement_id,
  external_provider_final as External_Provider,
  sum(matched_impressions) as Matched_Impressions,
  sum(modeled_impressions) as Modeled_Impressions,
  sum(vendor_matched_cost) as vendor_matched_cost,
  sum(vendor_modeled_cost) as vendor_modeled_cost,
  sum(customer_matched_cost) as customer_matched_cost,
  sum(customer_modeled_cost) as customer_modeled_cost
 From sandbox.temp_di_BP_Seg_usage seg
Group by 1, 2, 3, 4, 5--, 6
),

BP_Data_Legacy_Results as (
Select bp.event_month,
  bp.agency,
  bp.agency_id,
  bp.buy_type,
  bp.external_provider,
  prc.revshare / 100 as revshare_pct,
  bp.vendor_matched_cost,
  bp.vendor_modeled_cost,
  coalesce(bp.vendor_matched_cost,0) + coalesce(bp.vendor_modeled_cost,0) as Total_Cost,
  (coalesce(bp.vendor_matched_cost,0) + coalesce(bp.vendor_modeled_cost,0)) * (coalesce(prc.revshare,0)/100) as RevShare
From BP_Data_Legacy bp
  left outer join bi.svc_partner_revshare_config prc on prc.event_month = bp.event_month
                            and prc.external_provider = bp.external_provider
),

Audience_RevShare_Final as (
Select coalesce(l.event_month,c.event_month) as Event_Month,
  coalesce(l.agency,c.agency) as agency,
  coalesce(l.agency_id,c.agency_id) as agency_id,
  coalesce(l.buy_type,c.buy_type) as buy_type,
  coalesce(l.external_provider,c.external_provider) as external_provider,
  coalesce(l.revshare_pct,c.revshare_pct) as revshare_pct,
  sum(coalesce(l.Total_Cost,0)) + sum(coalesce(c.Total_Cost,0)) as Total_Cost,
  sum(coalesce(l.revshare,0)) + sum(coalesce(c.revshare,0)) as RevShare
From BP_Data_Legacy_Results l
  full join BP_Data_Current_Results c on c.event_month = l.event_month
                    and c.agency_id = l.agency_id
                    and c.external_provider = l.external_provider
Group by 1, 2, 3, 4, 5, 6
),

/* Contextual_PA_Audience_RevShare */

Seg_Data as (
SELECT s1.external_provider_id as s1_external_provider,
    s1.external_provider_code as s1_external_provider_id,
      s1.dmp,
      s1.id as segment_id,
    s1.external_provider_id as external_provider,
    s1.external_provider_code as external_provider_id,
      MAX(s1.name) as seg_name,
      MIN(s1.cost) as seg_cost
    FROM dwh.dmp_segment s1
    GROUP BY 1,2,3,4,5,6
),

--Grabbing Segment Name and Provider ID for contextual segments from RX since TVDSP Segment table doesn't include them
RX_Context_Segment as (
Select ltrim(segment_name,'cs_') as provider_id,
  display_name as Segment_Name
From andromeda.rx_dim_segment
Where type = 'comscore'
and segment_name ilike '%_tv_%'
  and segment_name not ilike '%_pa_%'
Group by 1, 2
),

results as (
Select date_trunc('month',dsu.date)::date as event_month,
  'TVDSP' as Platform,
  Case when dsu.vendor = 'comscore' then 'Contextual'
    else 'Predictive Audience' end as CS_Segment_Type,
  Case when c.buy_type in ('Private_Exchange','Self_Service','Programmatic') then 'Self-Service'
    when c.buy_type = 'Guaranteed_Managed_Service' then 'Managed-Service'
    else 'Other' end as Buy_Type,
  c.agency_name as Agency,
  c.agency_id,
  c.advertiser_name as Advertiser,
  COALESCE(r.adpod_slot_target, 'n/a') AS "Ad Slot Target",
  --coalesce(s.seg_name,dsu.segment) as Segment_Name,
  case when dsu.vendor = 'comscore' then coalesce(rx.segment_name,dsu.segment)
    else coalesce(s.seg_name,dsu.segment) end as Segment_Name,
  --s.s1_external_provider_id as External_Provider_Id,
  case when dsu.vendor = 'comscore' then coalesce(rx.provider_id,s.s1_external_provider_id)
    else s.s1_external_provider_id end as External_Provider_Id,
  s.s1_external_provider as External_Provider,
  sum(dsu.matched_impressions) as Matched_Impressions,
  sum(dsu.modeled_impressions) as Modeled_Impressions,
  sum(dsu.matched_cost) as Matched_Cost,
  sum(dsu.modeled_cost) as Modeled_Cost,
  (sum(dsu.matched_cost)/sum(dsu.matched_impressions)) * 1000 as Matched_CPM,
  case when sum(dsu.modeled_impressions) > 0
    then (sum(dsu.modeled_cost)/sum(dsu.modeled_impressions)) * 1000
    Else 0 end as Modeled_CPM
From dwh.dmp_segment_usage dsu
  left outer join Seg_Data s on s.segment_id = dsu.segment
  left outer join RX_Context_Segment rx on rx.provider_id = dsu.segment
  inner join dwh.campaign c on c.flight_id = dsu.placement
                and c.agency_id in ('439896','446496')
  left outer join andromeda.rx_dim_supply_publisher_deal_r r on c.deal_id = r.external_deal_id
Where dsu.date >= '2022-01-01'
  and dsu.date < current_date()
  and dsu.vendor in ('cs','comscore')
  and dsu.matched_impressions > 0
Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
),

Contextual_Audience_RevShare_Final as (
Select r.event_month,
  r.agency,
  r.agency_id,
  case when r.agency_id = '439896' then 'Self-Service'
    else 'Managed-Service' end as buy_type,
  r.External_Provider,
  prc.revshare,
  prc.revshare / 100 as revshare_pct,
  Sum(r.matched_cost) as Matched_Cost,
  sum(r.modeled_cost) as Modeled_Cost,
  Sum(coalesce(r.matched_cost,0)) + sum(coalesce(r.modeled_cost,0)) as Total_Cost,
  (Sum(coalesce(r.matched_cost,0)) + sum(coalesce(r.modeled_cost,0))) * (coalesce(prc.revshare,0)/100) as CA_RevShare
From results r
    left outer join bi.svc_partner_revshare_config prc on prc.event_month = r.event_month
                            and prc.external_provider = r.external_provider
Group by 1, 2, 3, 4, 5, 6, 7
),

/*  BASE METRICS */

Current_results as (
Select date_trunc('month',ad.date)::date as event_month,
  c.agency_name,
  c.agency_id,
  case when c.agency_id = '439896' then 'Self-Service'
  else 'Managed-Service' end as buy_type,
  ad.flight_id,
  coalesce(ad.deal_id,'OMP') as Deal_ID,
     SUM(impressions) as Impressions,
     SUM(revenue) as Revenue,
     SUM(cost_inventory) as Inv_Cost,
     SUM(cost_data) as Data_Cost,
     SUM(cost_partner) as Partner_Cost,
     SUM(CASE
         WHEN c.tremor_video_dsp_fee_base_type = 'NET' THEN revenue * c.tremor_video_dsp_fee_pct/100
         WHEN c.tremor_video_dsp_fee_base_type = 'GROSS' THEN (revenue + cost_data) * c.tremor_video_dsp_fee_pct/100
         ELSE 0
     END) as Platformfee_Profit,
      SUM(CASE WHEN buy_type in ('Private_Exchange','Self_Service','Programmatic')
       THEN cost_data + cost_partner ELSE 0 end) as Platform_Cost
From dwh.ad_data_daily ad
left outer join dwh.campaign c on c.flight_id = ad.flight_id
Where ad.date >= '2023-03-23'
  and ad.date < current_date()
  and c.agency_id in ('439896','446496')
  and ad.data_type = 'AD_DATA'
  and c.buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
  and impressions > 0
Group by 1, 2, 3, 4, 5, 6
),

Flight_agg as (
Select coalesce(l.event_month,c.event_month) as Event_Month,
  coalesce(l.agency_name,c.agency_name) as agency_name,
  coalesce(l.agency_id,c.agency_id) as agency_id,
  coalesce(l.buy_type,c.buy_type) as buy_type,
  coalesce(l.flight_id,c.flight_id) as flight_id,
  coalesce(l.Deal_id,c.Deal_id) as Deal_id,
  sum(coalesce(l.impressions,0)) + sum(coalesce(c.impressions,0)) as DSP_Impressions,
  sum(coalesce(l.Revenue,0)) + sum(coalesce(c.Revenue,0)) as DSP_Revenue,
  sum(coalesce(l.Data_Cost,0)) + sum(coalesce(c.Data_Cost,0)) as DSP_Data_Cost,
  sum(coalesce(l.Partner_Cost,0)) + sum(coalesce(c.Partner_Cost,0)) as DSP_Partner_Cost,
  sum(coalesce(l.Platformfee_Profit,0)) + sum(coalesce(c.Platformfee_Profit,0)) as DSP_Platformfee_Profit,
  sum(coalesce(l.Platform_Cost,0)) + sum(coalesce(c.Platform_Cost,0)) as DSP_Platform_Cost,
  sum(coalesce(l.Inv_Cost,0)) + sum(coalesce(c.Inv_Cost,0)) as Inv_Cost
From Current_results c
  full join bi.SVC_BP_TVDSP_Base_Metrics_Up_To_3_23_23 L on l.event_month = c.event_month
                            and l.agency_id = c.agency_id
                            and l.buy_type = c.buy_type
                            and l.flight_id = c.flight_id
                            and l.Deal_id = c.Deal_id
Group by 1, 2, 3, 4, 5, 6

),

/* COMBINING */

DSP_BASE_Metrics as (

Select fa.event_month,
  fa.agency_name,
  fa.agency_id,
  fa.buy_type,
  fa.deal_id,
  sum(fa.dsp_revenue) as DSP_Revenue,
  sum(fa.dsp_data_cost) as DSP_Data_Cost,
  sum(fa.dsp_partner_cost) as DSP_Partner_Cost,
  sum(fa.dsp_Platformfee_Profit) as DSP_PlatformFee_Profit,
  sum(fa.dsp_Platform_cost) as DSP_Platform_Cost,
  sum(fa.inv_Cost) as Inv_Cost,
  0 as Partner_RevShare
From Flight_agg fa
Group by 1, 2, 3, 4, 5

UNION


Select car.event_month,
  car.agency as agency_name,
  car.agency_id as agency_id,
  car.buy_type,
  'unknown' as Deal_ID,
  0 as DSP_Revenue,
  0 as DSP_Data_Cost,
  0 as DSP_Partner_Cost,
  0 as DSP_PlatformFee_Profit,
  0 as DSP_Platform_Cost,
  0 as Inv_Cost,
  sum(car.CA_RevShare) as Partner_RevShare
From Contextual_Audience_RevShare_Final car
Group by 1, 2, 3, 4, 5

UNION

Select ar.event_month,
  ar.agency as agency_name,
  ar.agency_id as agency_id,
  ar.buy_type,
  'unknown' as Deal_ID,
  0 as DSP_Revenue,
  0 as DSP_Data_Cost,
  0 as DSP_Partner_Cost,
  0 as DSP_PlatformFee_Profit,
  0 as DSP_Platform_Cost,
  0 as Inv_Cost,
  sum(ar.RevShare) as Partner_RevShare
From Audience_RevShare_Final ar
Group by 1, 2, 3, 4, 5
),

Results_Orig as (
Select event_month,
  agency_name,
  agency_id,
  buy_type,
  NULL as deal_id,
  sum(DSP_Revenue) as DSP_Revenue,
  sum(DSP_Data_Cost) as DSP_Data_Cost,
  sum(DSP_Partner_Cost) as DSP_Partner_Cost,
  sum(DSP_PlatformFee_Profit) as DSP_PlatformFee_Profit,
  sum(DSP_Platform_Cost) as DSP_Platform_Cost,
  sum(Inv_Cost) as Inv_Cost,
  sum(Partner_RevShare) as Partner_RevShare,

  case when buy_type = 'Self-Service' THEN sum(coalesce(DSP_Revenue,0)) + sum(coalesce(DSP_Platform_Cost,0)) + sum(coalesce(DSP_PlatformFee_Profit,0)) + sum(coalesce(Partner_RevShare,0))
                    ELSE sum(coalesce(DSP_Revenue,0)) + sum(coalesce(DSP_PlatformFee_Profit,0)) + sum(coalesce(Partner_RevShare,0)) END AS Gross_Revenue,

  sum(coalesce(Inv_Cost,0)) + sum(coalesce(DSP_Data_Cost,0)) + sum(coalesce(DSP_Partner_Cost,0)) as Overall_Cost
From DSP_BASE_Metrics
Group by 1, 2, 3, 4, 5
)

Select og.event_month,
  og.agency_name,
  og.agency_id,
  og.buy_type,
  og.deal_id,
  og.DSP_Revenue,
  og.DSP_Data_Cost,
  og.DSP_Partner_Cost,
  og.DSP_PlatformFee_Profit,
  --coalesce(bps.Vendor_Cost_Diff,0) as vendor_cost_diff,
  og.DSP_Platform_Cost - coalesce(bps.Vendor_Cost_Diff,0) as DSP_Platform_Cost,
  og.Inv_Cost,
  og.Partner_RevShare,
  og.Gross_Revenue,
  og.Overall_Cost - coalesce(bps.Vendor_Cost_Diff,0) as Overall_Cost
From Results_Orig og
  left outer join BP_CPM_Spread bps on bps.event_month = og.event_month
                      and bps.agency_id = og.agency_id
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    label: "Event Month"
    sql: ${TABLE}.event_month ;;
  }

  dimension: agency_name {
    type: string
    label: "Agency"
    sql: ${TABLE}.agency_name ;;
  }

  dimension: agency_id {
    type: number
    label: "Agency ID"
    sql: ${TABLE}.agency_id ;;
  }

  dimension: buy_type {
    type: string
    label: "Buy Type"
    sql: ${TABLE}.buy_type ;;
  }

  dimension: deal_id {
    type: string
    label: "Deal ID"
    sql: ${TABLE}.deal_id ;;
  }

  measure: dsp_revenue {
    type: sum
    label: "DSP Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.DSP_Revenue ;;
  }

  measure: dsp_data_cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.DSP_Data_Cost ;;
  }

  measure: dsp_partner_cost {
    type: sum
    value_format: "$#,##0"
    label: "DSP Partner Cost"
    sql: ${TABLE}.DSP_Partner_Cost ;;
  }

  measure: dsp_platform_fee_profit {
    type: sum
    value_format: "$#,##0"
    label: "DSP Platform Fee"
    sql: ${TABLE}.DSP_PlatformFee_Profit ;;
  }

  measure: dsp_platform_cost {
    type: sum
    value_format: "$#,##0"
    label: "DSP Platform Cost"
    sql: ${TABLE}.DSP_Platform_Cost ;;
  }

  measure: inv_cost {
    type: sum
    value_format: "$#,##0"
    label: "Inventory Cost"
    sql: ${TABLE}.Inv_Cost ;;
  }

  measure: partner_rev_share {
    type: sum
    value_format: "$#,##0"
    label: "Partner Rev Share"
    sql: ${TABLE}.Partner_RevShare ;;
  }

  measure: gross_revenue {
    type: sum
    value_format: "$#,##0"
    label: "Gross Revenue"
    sql: ${TABLE}.Gross_Revenue ;;
  }

  measure: overall_cost {
    type: sum
    value_format: "$#,##0"
    label: "Combined Cost"
    sql: ${TABLE}.Overall_Cost ;;
  }

  set: detail {
    fields: [
      event_month,
      agency_name,
      agency_id,
      buy_type,
      deal_id
    ]
  }
}
