view: tremor_forecasting_data_daily {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: WITH /*+ENABLE_WITH_CLAUSE_MATERIALIZATION */ Salesforce_Meta_Data AS(
      SELECT sf.start_date::date as start_date,
           sf.end_date::date as end_date,
           sf.flight_duration as flight_duration,
           date_trunc('quarter', (CURRENT_DATE()-1))::date as first_day_of_quarter,
           timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date as last_day_of_quarter,
           CASE WHEN sf.end_date::date > CURRENT_DATE() THEN DATEDIFF(DAY, CURRENT_DATE()+1, sf.end_date) ELSE 0 END as remaining_days,-- DATEDIFF(DAY, sf.end_date, CURRENT_DATE()+1) as remaining_days,
           CASE WHEN sf.end_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date THEN 0
                 WHEN sf.start_date::date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date THEN 0
                 WHEN sf.start_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, date_trunc('quarter', (CURRENT_DATE()-1)), timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date)+1
                 WHEN sf.start_date::date >= date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, sf.start_date, timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date)+1
                 WHEN sf.start_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date <= timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, date_trunc('quarter', (CURRENT_DATE()-1)), sf.end_date::date)+1
                 WHEN sf.start_date::date >=  date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date <= timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, sf.start_date::date, sf.end_date::date)+1
                 ELSE 0 END AS days_live_in_current_quarter,
           so.name as opportunity_name,
           so.id as opportunity_id,
           sa.name as account_name,
           so.billing_agency,
           sf.flight_number As flight_number,
           so.stage,
           su.full_name as seller,
           su2.full_name as csm,
           CASE WHEN su.seller_region ISNULL THEN 'Unknown' ELSE su.seller_region END as region,
           sf.flight_booked_revenue as flight_booked_revenue,
           sf.flight_booked_revenue / (DATEDIFF(DAY,sf.start_date, sf.end_date)+1) AS daily_revenue_goal,
           (sf.flight_booked_revenue / (DATEDIFF(DAY,sf.start_date, sf.end_date)+1)) * (CASE WHEN sf.end_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date THEN 0
                 WHEN sf.start_date::date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date THEN 0
                 WHEN sf.start_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, date_trunc('quarter', (CURRENT_DATE()-1)), timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date)+1
                 WHEN sf.start_date::date >= date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, sf.start_date, timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date)+1
                 WHEN sf.start_date::date < date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date <= timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, date_trunc('quarter', (CURRENT_DATE()-1)), sf.end_date::date)+1
                 WHEN sf.start_date::date >=  date_trunc('quarter', (CURRENT_DATE()-1))::date AND sf.end_date::date <= timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date
                     THEN DATEDIFF(DAY, sf.start_date::date, sf.end_date::date)+1
                 ELSE 0 END) AS booked_revenue_current_quarter
      FROM Andromeda.sf_flight sf
        LEFT OUTER JOIN Andromeda.sf_opportunity so on so.id = sf.opportunity_id
        LEFT OUTER JOIN Andromeda.sf_account sa on sa.id = so.account_id
        LEFT OUTER JOIN Andromeda.sf_user su on so.seller_id = su.id
        LEFT JOIN Andromeda.sf_user su2 on so.csm_id = su2.id
      WHERE sf.end_date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
          AND sf.start_date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
          AND so.stage NOT IN ('Lost / Inactive Proposal', 'Closed Won - Cancelled')
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
      ORDER BY 2 ASC
      ),


      current_quarter_campaigns_tvdsp AS (
      SELECT add2.flight_id,
      c.start_date,
      c.end_date
      FROM dwh.ad_data_daily add2
      INNER JOIN dwh.campaign c on c.flight_id = add2.flight_id
      WHERE add2.date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      and add2.date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      AND c.end_date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      and data_type = 'AD_DATA'
      and buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
      and impressions > 0
      GROUP BY 1,2,3
      ORDER BY 2 ASC
      ),

      Start_Date AS (
      SELECT MIN(start_date) as start_date
      FROM current_quarter_campaigns_tvdsp
      ),

      TVDSP_Fact_Data AS (
      SELECT ad.flight_id,
      c.flight_number as flight_number,
      c.start_date,
      c.end_date,
      'Tremor TVDSP' as Classification,
      c.agency_name,
      SUM(CASE WHEN date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN revenue else 0 end) AS cq_revenue,
      SUM(CASE WHEN date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN cost_data else 0 end) as cq_data_cost,
      SUM(CASE WHEN date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN cost_inventory else 0 end) as cq_inventory_cost,
      SUM(CASE WHEN date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN cost_partner else 0 end) as cq_partner_cost,
      SUM(CASE WHEN date < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN revenue else 0 end ) AS all_prior_revenue,
      SUM(CASE WHEN date < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN cost_data  else 0 end ) AS all_prior_data_cost,
      SUM(CASE WHEN date < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN cost_inventory else 0 end ) AS all_prior_inventory_cost,
      SUM(CASE WHEN date < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN cost_partner else 0 end ) AS all_prior_partner_cost,
      SUM(revenue) AS Total_Revenue,
      SUM(cost_data) AS Total_Data_Cost,
      SUM(cost_inventory) AS Total_Inventory_Cost,
      SUM(cost_partner) AS Total_Partner_Cost,
      (SUM(revenue) - SUM(cost_inventory) - SUM(cost_data) - SUM(cost_partner))/ SUM(revenue) AS Total_Margin
      FROM dwh.ad_data_daily ad
      LEFT OUTER JOIN dwh.campaign c on c.flight_id = ad.flight_id
      WHERE date >= (select start_date from Start_Date)
      AND date < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      and data_type = 'AD_DATA'
      and buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
      and impressions > 0
      GROUP BY 1,2,3,4,5,6
      ORDER BY 4 ASC
      ),

      amobee_billing_agency AS (
      Select f.name as flight_number,
      opp.opportunity_auto_number as Opportunity_ID,
      opp.name as Opportunity_Name,
      a.name as Account_Name,
      pa.name as Parent_Account,
      ba.name as Billing_agency,
      pba.name as Parent_Billing_Agency
      From andromeda.sf_flight_r f
      left outer join andromeda.sf_opportunity_r opp on opp.id = f.opportunity_id
      Left Outer Join andromeda.sf_user_r u on u.id = opp.owner_id
      Left Outer Join andromeda.sf_account_r a on a.id = opp.account_id
      Left Outer Join andromeda.sf_account_r pa on pa.id = a.parent_id
      Left Outer Join andromeda.sf_account_r ba on ba.id = opp.billing_agency
      Left Outer Join andromeda.sf_account_r pba on pba.id = ba.parent_id
      Group by 1, 2, 3, 4, 5, 6, 7
      ),

      Amobee_Fact_Data AS (
      SELECT amobee_flight_no as flight_number,
      package_start_date as start_date,
      package_end_date as end_date,
      aba.Billing_agency,
      'Amobee Seat 1058' as Classification,
      SUM(CASE WHEN event_time >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND event_time < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN revenue else 0 end) AS cq_revenue,
      SUM(CASE WHEN event_time >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND event_time < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      THEN cost else 0 end) as cq_cost,
      SUM(CASE WHEN event_time < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN revenue else 0 end ) AS all_prior_revenue,
      SUM(CASE WHEN event_time < timestampadd('quarter',0,date_trunc('quarter',current_date()))::date THEN cost  else 0 end ) AS all_prior_cost,
      SUM(revenue) AS Total_Revenue,
      SUM(cost) AS Total_Data_Cost,
      (SUM(revenue) - SUM(cost))/ SUM(revenue) AS Total_Margin
      FROM dwh.tp_amobee_daily_report tadr
      LEFT JOIN amobee_billing_agency aba on tadr.amobee_flight_no = aba.flight_number
      WHERE event_time >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      and event_time < timestampadd('quarter',+1,date_trunc('quarter',current_date()))::date
      AND package_end_date >= timestampadd('quarter',0,date_trunc('quarter',current_date()))::date
      AND impressions > 0
      GROUP BY 1,2,3,4,5
      ORDER BY 3 ASC
      ),

      Combined_Fact_Data AS (
      SELECT COALESCE(tv.classification, amb.classification) AS Classification,--'Tremor MS' as Classification,
      COALESCE(tv.agency_name, amb.Billing_agency) AS agency,
      case when amb.flight_number is not NULL then 'Yes' else 'No' end as Ran_On_Amobee,
      case when tv.flight_number is not NULL then 'Yes' else 'No' end as Ran_On_TVDSP,
      coalesce(tv.flight_number,amb.flight_number) as Flight_Number,
      sum(coalesce(tv.cq_inventory_cost ,0)) + sum(coalesce(tv.cq_data_cost,0)) + sum(coalesce(tv.cq_partner_cost,0)) + sum(coalesce(amb.cq_cost,0)) as Current_Quarter_Cost,
      sum(coalesce(tv.cq_revenue,0)) + sum(coalesce(amb.cq_revenue,0)) as Current_Quarter_Revenue,
      sum(coalesce(tv.all_prior_inventory_cost,0)) + sum(coalesce(tv.all_prior_data_cost,0)) + sum(coalesce(tv.all_prior_partner_cost)) + sum(coalesce(amb.all_prior_cost,0)) as All_Prior_Cost,
      sum(coalesce(tv.all_prior_revenue,0)) + sum(coalesce(amb.all_prior_revenue,0)) AS All_Prior_Revenue,
      sum(coalesce(tv.Total_Revenue,0)) + sum(coalesce(amb.Total_Revenue,0)) AS Total_Revenue,
      sum(coalesce(tv.Total_Inventory_Cost,0)) + sum(coalesce(tv.Total_Data_Cost,0)) + sum(coalesce(tv.Total_Partner_Cost)) + sum(coalesce(amb.Total_Data_Cost,0)) AS Total_Cost,
      sum(coalesce(tv.Total_Margin,0)) + sum(coalesce(amb.Total_Margin,0)) AS Total_Margin
      FROM TVDSP_Fact_Data tv
      Full join amobee_fact_data amb on amb.flight_number = tv.flight_number
      Group by 1, 2, 3, 4, 5
      )


      --Final Select Statement
      Select /*salesforce dimensions*/
      smd.flight_number,
      smd.opportunity_id,
      smd.opportunity_name,
      smd.account_name,
      REPLACE(cfd.agency, '- Agency', '') AS Agency,
      smd.stage,
      smd.seller,
      smd.region,
      smd.csm,
      smd.start_date,
      smd.end_date,
      cfd.classification,
      smd.days_live_in_current_quarter,
      smd.flight_booked_revenue,
      smd.booked_revenue_current_quarter,
      smd.daily_revenue_goal,
      /*measures from fact data*/
      cfd.Current_Quarter_Revenue,
      cfd.Current_Quarter_Cost,
      cfd.All_Prior_Revenue,
      cfd.All_Prior_Cost,
      cfd.Total_Revenue,
      cfd.Total_Cost,
      cfd.Total_Margin,
      SUM(cfd.Current_Quarter_Revenue - cfd.Current_Quarter_Cost) AS CQ_Net_Revenue,
      SUM(cfd.All_Prior_Revenue - cfd.All_Prior_Cost) AS Previous_to_CQ_Net_Revenue,
      SUM(cfd.Total_Revenue - cfd.Total_Cost) AS Total_Net_Revenue,
      CASE WHEN cfd.Total_Revenue > smd.flight_booked_revenue THEN 'Y' ELSE 'N' END AS Over_Budget_Y_N,
      CASE WHEN cfd.Total_Revenue > smd.flight_booked_revenue THEN SUM(cfd.Total_Revenue - smd.flight_booked_revenue) ELSE 0 END AS amount_over_budget,
      CASE WHEN smd.end_date <= timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date AND smd.end_date >= CURRENT_DATE() AND cfd.Total_Revenue < smd.flight_booked_revenue THEN SUM(smd.flight_booked_revenue - cfd.Total_Revenue)
      WHEN smd.end_date < CURRENT_DATE() THEN 0
      ELSE SUM(smd.booked_revenue_current_quarter - cfd.Current_Quarter_Revenue) END as Current_Quarter_Rev_Remaining,
      CASE WHEN smd.end_date > CURRENT_DATE()-1 AND cfd.Total_Revenue < smd.flight_booked_revenue THEN SUM(smd.flight_booked_revenue - cfd.Total_Revenue) ELSE 0 END as Total_Rev_Remaining,
      CASE WHEN smd.end_date > timestampadd('day',-1,timestampadd('quarter',1,date_trunc('quarter',(CURRENT_DATE()-1))))::date AND cfd.Total_Revenue < smd.flight_booked_revenue
      THEN SUM((smd.flight_booked_revenue - cfd.Total_Revenue) - (smd.booked_revenue_current_quarter - cfd.Current_Quarter_Revenue))
      ELSE 0 END as Future_Rev_Remaining
      FROM Combined_Fact_Data cfd
      LEFT JOIN Salesforce_Meta_Data smd on cfd.flight_number = smd.flight_number
      WHERE smd.booked_revenue_current_quarter != 0
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
      ORDER BY 11,14 ASC
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}.flight_number ;;
  }

  dimension: opportunity_id {
    type: string
    label: "Opportunity ID"
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: opportunity_name {
    type: string
    label: "Opportunity Name"
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: account_name {
    type: string
    label: "Account Name"
    sql: ${TABLE}.account_name ;;
  }

  dimension: agency {
    type: string
    label: "Agency"
    sql: ${TABLE}.Agency ;;
  }

  dimension: stage {
    type: string
    label: "Stage"
    sql: ${TABLE}.stage ;;
  }

  dimension: seller {
    type: string
    label: "Seller"
    sql: ${TABLE}.seller ;;
  }

  dimension: region {
    type: string
    label: "Seller Region"
    sql: ${TABLE}.region ;;
  }

  dimension: csm {
    type: string
    label: "CSM"
    sql: ${TABLE}.csm ;;
  }

  dimension: start_date {
    type: date
    label: "Start Date"
    sql: ${TABLE}.start_date ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: end_date {
    type: date
    label: "End Date"
    sql: ${TABLE}.end_date ;;
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: classification {
    type: string
    label: "Classification"
    sql: ${TABLE}.classification ;;
  }

  dimension: days_live_in_current_quarter {
    type: number
    label: "Days Live in Current Quarter"
    sql: ${TABLE}.days_live_in_current_quarter ;;
  }

  dimension: flight_booked_revenue {
    type: number
    value_format: "0.00"
    label: "Total Flight Booked Gross Revenue"
    sql: ${TABLE}.flight_booked_revenue ;;
  }

  dimension: booked_revenue_current_quarter {
    type: number
    value_format: "0.00"
    label: "Booked Gross Revenue CQ"
    sql: ${TABLE}.booked_revenue_current_quarter ;;
  }

  dimension: daily_revenue_goal {
    type: number
    value_format: "0.00"
    label: "Daily Revenue Goal"
    sql: ${TABLE}.daily_revenue_goal ;;
  }

  dimension: current_quarter_revenue {
    type: number
    value_format: "0.00"
    label: "CQ Gross Revenue"
    sql: ${TABLE}.Current_Quarter_Revenue ;;
  }

  dimension: current_quarter_cost {
    type: number
    value_format: "0.00"
    label: "CQ Cost"
    sql: ${TABLE}.Current_Quarter_Cost ;;
  }

  dimension: all_prior_revenue {
    type: number
    value_format: "0.00"
    label: "All Revenue Prior to CQ"
    sql: ${TABLE}.All_Prior_Revenue ;;
  }

  dimension: all_prior_cost {
    type: number
    value_format: "0.00"
    label: "All Cost Prior to CQ"
    sql: ${TABLE}.All_Prior_Cost ;;
  }

  dimension: total_revenue {
    type: number
    value_format: "0.00"
    label: "Total Gross Revenue"
    sql: ${TABLE}.Total_Revenue ;;
  }

  dimension: total_cost {
    type: number
    value_format: "0.00"
    label: "Total Cost"
    sql: ${TABLE}.Total_Cost ;;
  }

  dimension: total_margin {
    type: number
    value_format: "0%"
    label: "Total Margin"
    sql: ${TABLE}.Total_Margin ;;
  }

  dimension: cq_net_revenue {
    type: number
    value_format: "0.00"
    label: "CQ Net Revenue"
    sql: ${TABLE}.CQ_Net_Revenue ;;
  }

  dimension: previous_to_cq_net_revenue {
    type: number
    value_format: "0.00"
    label: "Previous to CQ Net Revenue"
    sql: ${TABLE}.Previous_to_CQ_Net_Revenue ;;
  }

  dimension: total_net_revenue {
    type: number
    value_format: "0.00"
    label: "Total Net Revenue"
    sql: ${TABLE}.Total_Net_Revenue ;;
  }

  dimension: over_budget_y_n {
    type: string
    label: "Over Budget Y/N"
    sql: ${TABLE}.Over_Budget_Y_N ;;
  }

  dimension: amount_over_budget {
    type: number
    value_format: "0.00"
    label: "Amount Over budget"
    sql: ${TABLE}.amount_over_budget ;;
  }

  dimension: current_quarter_rev_remaining {
    type: number
    value_format: "0.00"
    label: "CQ Gross Revenue Remaining"
    sql: ${TABLE}.Current_Quarter_Rev_Remaining ;;
  }

  dimension: total_rev_remaining {
    type: number
    value_format: "0.00"
    label: "Total Gross Revenue Remaining"
    sql: ${TABLE}.Total_Rev_Remaining ;;
  }

  dimension: future_rev_remaining {
    type: number
    value_format: "0.00"
    label: "Future Gross Revenue Remaining "
    sql: ${TABLE}.Future_Rev_Remaining ;;
  }

  set: detail {
    fields: [
      flight_number,
      opportunity_id,
      opportunity_name,
      account_name,
      agency,
      stage,
      seller,
      region,
      csm,
      start_date,
      end_date,
      classification,
      days_live_in_current_quarter,
      flight_booked_revenue,
      booked_revenue_current_quarter,
      daily_revenue_goal,
      current_quarter_revenue,
      current_quarter_cost,
      all_prior_revenue,
      all_prior_cost,
      total_revenue,
      total_cost,
      total_margin,
      cq_net_revenue,
      previous_to_cq_net_revenue,
      total_net_revenue,
      over_budget_y_n,
      amount_over_budget,
      current_quarter_rev_remaining,
      total_rev_remaining,
      future_rev_remaining
    ]
  }
}
