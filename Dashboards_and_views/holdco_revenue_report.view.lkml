view: holdco_revenue_report {
  derived_table: {
    sql: With DSP_Seat_HoldCo as (
      Select dsh.seat_id,
             dsp.rx_dsp_name as DSP_name,
             bi_dsp.dsp_key as DSP_Key,
             da.rx_dsp_account_name as DSP_Account,
             dsh.HoldCo
      From bi.svc_dim_DSP_Seat_HoldCo dsh
             left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_account_id = dsh.dsp_account_id
             left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsh.dsp_account_id
             left outer join bi_new.dim_dsp bi_dsp on bi_dsp.DSP_Name = dsp.rx_dsp_name
      ),

      Base_Metrics as (
      Select coalesce(dah.HoldCo,dsh.HoldCo) as HoldCo,
      ad.rx_deal_id,
      dd.rx_deal_id as deal_id_internal,
      dd.deal_description,
      dag.agency as deal_agency,
      db.brand,
      dp.rx_personnel_name as Seller,
      da.rx_dsp_account_name as DSP_Account,
      ad.rx_dsp_name,
      ad.dsp_seat,
      ad.rx_device_type as Format,
      ad.rx_imp_type as Channel,
      CASE WHEN ((ad.dsp_deal_type = 'pub') AND (ad.platformfee_type = 'pub_initiated')) THEN 'SSP SS'
      WHEN (((ad.dsp_deal_type = 'rx') AND (ad.revenue_type = 'thirdparty')) or
      ((ad.dsp_deal_type = 'pub') AND (ad.platformfee_type = 'unruly_initiated') AND (ad.revenue_type = 'thirdparty'))) THEN 'PMP'
      WHEN (ad.dsp_deal_type = 'pub') AND ad.rx_deal_id = 'CampaignOverride' THEN '1st Party Demand'
      WHEN (ad.revenue_type = 'firstparty') THEN '1st Party Demand'
      ELSE 'OMP' END AS Classification,

      sum(case when ad.event_time >= current_date()-1 and ad.event_time < current_date()
      THEN revenue else NULL end) as Yst_Revenue,

      sum(case when ad.event_time >= TIMESTAMPADD (year, -1,date_trunc('year',current_date()-1))::date
      and ad.event_time < TIMESTAMPADD (year, -1,current_date())::date
      THEN revenue else NULL end) as Yst_LY_Revenue,

      sum(case when ad.event_time >= date_trunc('quarter',current_date()-1)::date and ad.event_time < current_date()
      THEN revenue else NULL end)  as QTD_Revenue,

      sum(case when ad.event_time >= TIMESTAMPADD (year, -1,date_trunc('quarter',current_date()-1))::date
      and ad.event_time < TIMESTAMPADD (year, -1,current_date())::date
      THEN revenue else NULL end)  as QTD_LY_Revenue,

      sum(case when ad.event_time >= date_trunc('year',current_date()-1)::date and ad.event_time < current_date()
      THEN revenue else NULL end)  as YTD_Revenue,

      sum(case when ad.event_time >= TIMESTAMPADD (year, -1,date_trunc('year',current_date()-1))::date
      and ad.event_time < TIMESTAMPADD (year, -1,current_date())::date
      THEN revenue else NULL end)  as YTD_LY_Revenue

      From andromeda.ad_data_daily ad
      left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
      left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      left outer join andromeda.rx_dim_deal dd on dd.deal_id_external = ad.rx_deal_id
      left outer join andromeda.rx_dim_deal_agency dag on dag.id = dd.agency_id
      left outer join andromeda.rx_dim_deal_brand db on db.id = dd.brand_id
      left outer join andromeda.rx_dim_deal_personnel dp on dp.rx_deal_id = dd.rx_deal_id
      and dp.rx_personnel_role = 'Sales'
      left outer join DSP_Seat_HoldCo dsh on dsh.dsp_name = ad.rx_dsp_name
      and dsh.seat_id = ad.dsp_seat
      left outer join bi.svc_dim_Deal_Agency_HoldCo dah on dah.deal_agency_id = dd.agency_id
      Where ((ad.event_time >= date_trunc('year',current_date()-1)::date
      and ad.event_time < current_date())
      or (ad.event_time >= TIMESTAMPADD (year, -1,date_trunc('year',current_date()-1))::date
      and ad.event_time < TIMESTAMPADD (year, -1,current_date())::date))
      and ad.revenue > 0
      and (dsh.holdco is not NULL or dah.holdco is not NULL)
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
      ),

      Deal_Owners as
      (select dpp.rx_deal_id,
      count(distinct case when dpp.rx_personnel_role = 'Sales'
      or dpp.rx_personnel_id = '163' THEN dpp.rx_personnel_ID ELSE NULL END) as SCount,
      count(distinct case when dpp.rx_personnel_role = 'Account Manager'
      and dpp.rx_personnel_id != '163' THEN dpp.rx_personnel_ID ELSE NULL END) as AMCount,
      count(distinct case when dpp.rx_personnel_role = 'AdOps'
      and dpp.rx_personnel_id != '163' THEN dpp.rx_personnel_ID ELSE NULL END) as OpsCount,
      count(distinct dpp.rx_personnel_id) as SalesPeople
      From andromeda.rx_dim_deal_personnel dpp
      Group by 1)

      Select bm.HoldCo,
      bm.rx_deal_id,
      bm.deal_id_internal,
      bm.deal_description,
      bm.deal_agency,
      bm.brand,
      bm.Seller,
      coalesce(sp.SCount,0) as SPCount,
      bm.DSP_Account,
      bm.rx_dsp_name,
      bm.dsp_seat,
      bm.Format,
      bm.Channel,
      bm.Classification,
      /*
      bm.Yst_Revenue as Total_Deal_Yst_Revenue,
      bm.Yst_LY_Revenue as Total_Deal_Yst_LY_Revenue,
      bm.QTD_Revenue as Total_Deal_QTD_Revenue,
      bm.QTD_LY_Revenue as Total_Deal_QTD_LY_Revenue,
      bm.YTD_Revenue as Total_Deal_YTD_Revenue,
      bm.YTD_LY_Revenue as Total_Deal_YTD_LY_Revenue,
      */
      case when bm.Yst_Revenue / sp.SCount = 'Infinity' or bm.Yst_Revenue / sp.SCount IS NULL THEN bm.Yst_Revenue else bm.Yst_Revenue / sp.SCount end as Yst_SalesSplitRevenue,
      case when bm.Yst_LY_Revenue / sp.SCount = 'Infinity' or bm.Yst_LY_Revenue / sp.SCount IS NULL THEN bm.Yst_LY_Revenue else bm.Yst_LY_Revenue / sp.SCount end as Yst_LY_SalesSplitRevenue,
      case when bm.QTD_Revenue / sp.SCount = 'Infinity' or bm.QTD_Revenue / sp.SCount IS NULL THEN bm.QTD_Revenue else bm.QTD_Revenue / sp.SCount end as QTD_SalesSplitRevenue,
      case when bm.QTD_LY_Revenue / sp.SCount = 'Infinity' or bm.QTD_LY_Revenue / sp.SCount IS NULL THEN bm.QTD_LY_Revenue else bm.QTD_LY_Revenue / sp.SCount end as QTD_LY_SalesSplitRevenue,
      case when bm.YTD_Revenue / sp.SCount = 'Infinity' or bm.YTD_Revenue / sp.SCount IS NULL THEN bm.YTD_Revenue else bm.YTD_Revenue / sp.SCount end as YTD_SalesSplitRevenue,
      case when bm.YTD_LY_Revenue / sp.SCount = 'Infinity' or bm.YTD_LY_Revenue / sp.SCount IS NULL THEN bm.YTD_LY_Revenue else bm.YTD_LY_Revenue / sp.SCount end as YTD_LY_SalesSplitRevenue

      From Base_Metrics bm
      left outer join Deal_Owners sp on sp.rx_deal_id = bm.deal_id_internal
      Order by 2
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hold_co {
    type: string
    sql: ${TABLE}.HoldCo ;;
  }

  dimension: rx_deal_id {
    type: string
    label: "Deal ID"
    sql: ${TABLE}.rx_deal_id ;;
  }

  dimension: deal_id_internal {
    type: number
    label: "Deal ID Internal"
    sql: ${TABLE}.deal_id_internal ;;
  }

  dimension: deal_description {
    type: string
    label: "Deal Description"
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_agency {
    type: string
    label: "Agency"
    sql: ${TABLE}.deal_agency ;;
  }

  dimension: brand {
    type: string
    label: "Brand"
    sql: ${TABLE}.brand ;;
  }

  dimension: seller {
    type: string
    label: "Seller"
    sql: ${TABLE}.Seller ;;
  }

  dimension: spcount {
    type: number
    label: "Sales People"
    sql: ${TABLE}.SPCount ;;
  }

  dimension: dsp_account {
    type: string
    label: "DSP Account"
    sql: ${TABLE}.DSP_Account ;;
  }

  dimension: rx_dsp_name {
    type: string
    label: "DSP Endpoint"
    sql: ${TABLE}.rx_dsp_name ;;
  }

  dimension: dsp_seat {
    type: string
    label: "DSP Seat ID"
    sql: ${TABLE}.dsp_seat ;;
  }

  dimension: format {
    type: string
    label: "Format"
    sql: ${TABLE}."Format" ;;
  }

  dimension: channel {
    type: string
    label: "Channel"
    sql: ${TABLE}.Channel ;;
  }

  dimension: classification {
    type: string
    label: "Buy Type"
    sql: ${TABLE}.Classification ;;
  }

  measure: yst_sales_split_revenue {
    type: sum
    label: "Yesterday Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.Yst_SalesSplitRevenue ;;
  }

  measure: yst_ly_sales_split_revenue {
    type: sum
    label: "Yesterday LY Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.Yst_LY_SalesSplitRevenue ;;
  }

  measure: qtd_sales_split_revenue {
    type: sum
    label: "QTD Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.QTD_SalesSplitRevenue ;;
  }

  measure: qtd_ly_sales_split_revenue {
    type: sum
    label: "QTD LY Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.QTD_LY_SalesSplitRevenue ;;
  }

  measure: ytd_sales_split_revenue {
    type: sum
    label: "YTD Rev"
    sql: ${TABLE}.YTD_SalesSplitRevenue ;;
  }

  measure: ytd_ly_sales_split_revenue {
    type: sum
    label: "YTD LY Rev"
    value_format: "$#,##0"
    sql: ${TABLE}.YTD_LY_SalesSplitRevenue ;;
  }

  set: detail {
    fields: [
      hold_co,
      rx_deal_id,
      deal_id_internal,
      deal_description,
      deal_agency,
      brand,
      seller,
      spcount,
      dsp_account,
      rx_dsp_name,
      dsp_seat,
      format,
      channel,
      classification
    ]
  }
}
