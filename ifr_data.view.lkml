
view: ifr_data {
  derived_table: {
    sql: WITH rev as (
        select
        distinct 
        rs.period_name ,
        rs.ns_customer_id ,  
        rs.customer_name ,
        rs.advertiser_home_mkt_id as market_id, rs.advertiser_home_mkt_name as market_name,
        sum(rs.total_billable) as total_billable,
        sum(rs.gross_profit+rs.publisher_variance_adj) as gross_profit,
        case sum(rs.total_billable) when 0 then 0 else (sum(rs.gross_profit)/ sum(rs.total_billable)) end as net_revenue_pct,
        sum(rs.turn_fee) as turn_fee, sum(rs.tac - rs.publisher_cost) as tac_gp, sum(rs.bid_saving_fee) as bid_saving_fee,
        sum(rs.turn_data_cost_total - rs.turn_net_data_cost) as turn_data_cost_adj 
        from financial.fact_programmatic_revenue_summary_by_day rs 
        where rs.ifr_period >= CURRENT_DATE - INTERVAL '3 months' and rs.ifr_period <= CURRENT_DATE
        AND rs.advertiser_home_mkt_id::integer IN (141,861,927,999,1356,1379,1405,1472,2048,2101,2132,2139,2143,2145,2147, 1602)
        and rs."source" = 'BILLINGS'
        group by 1,2,3,4,5 )
        
      
        SELECT rev.period_name, ns_customer_id, 
        customer_name,
        rev.market_id,
        market_name, total_billable, net_revenue_pct,  
          rev.turn_fee / total_billable  as "Tech Fee + Managed Fee",
          tac_gp / total_billable  as "Publisher GP",
          bid_saving_fee / total_billable as "Bid Saving",
          turn_data_cost_adj / total_billable  as "Data",
          "Demo Audiences" / total_billable as "Demo Audiences", 
          "Interests" / total_billable as "Interests",
          "IFO" / total_billable as "IFO",
          "Viewability" / total_billable as "Viewability",
          "Cross-Device" / total_billable as "Cross-Device",
          "Audience" / total_billable as "Audience",
          "Algos (Nielsen)" / total_billable as "Algos (Nielsen)",
          "Partner Audiences" / total_billable as "Partner Audiences", 
          "Precision Targets (BI)" / total_billable as "Precision Targets (BI)", 
          "Smart TV Amplifier" / total_billable as "Smart TV Amplifier", 
          "Custom BI Persona" / total_billable as "Custom BI Persona", 
          "Compliance (OBA)" / total_billable as "Compliance (OBA)",    
          "Other" / total_billable as "Other", 
          "1st party LAL" / total_billable as "1st party LAL",
          "Interests/Amobee Audiences" / total_billable as  "Interests/Amobee Audiences",    
          "Content" / total_billable as "Content",    
          "SPO Custom" / total_billable as "SPO Custom", 
          "Rich Media" / total_billable as "Rich Media", 
          "Propensity Scoring (BPO)" / total_billable as "Propensity Scoring (BPO)",
           "Lifestyles" / total_billable as "Lifestyles",
           "All Others" / total_billable as "All Others"
          
      FROM rev LEFT JOIN  dem_Pivot_ord_4 pivottab ON 
      rev.period_name = pivottab.period_name 
      AND rev.market_id = pivottab.market_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: period_name {
    type: string
    sql: ${TABLE}."period_name" ;;
  }

  dimension: ns_customer_id {
    type: string
    sql: ${TABLE}."ns_customer_id" ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}."customer_name" ;;
  }

  dimension: market_id {
    type: string
    sql: ${TABLE}."market_id" ;;
  }

  dimension: market_name {
    type: string
    sql: ${TABLE}."market_name" ;;
  }

  dimension: total_billable {
    type: number
    sql: ${TABLE}."total_billable" ;;
  }

  dimension: net_revenue_pct {
    type: number
    sql: ${TABLE}."net_revenue_pct" ;;
  }

  dimension: tech_fee__managed_fee {
    type: number
    label: "Tech Fee + Managed Fee"
    sql: ${TABLE}."Tech Fee + Managed Fee" ;;
  }

  dimension: publisher_gp {
    type: number
    label: "Publisher GP"
    sql: ${TABLE}."Publisher GP" ;;
  }

  dimension: bid_saving {
    type: number
    label: "Bid Saving"
    sql: ${TABLE}."Bid Saving" ;;
  }

  dimension: data {
    type: number
    sql: ${TABLE}."Data" ;;
  }

  dimension: demo_audiences {
    type: number
    label: "Demo Audiences"
    sql: ${TABLE}."Demo Audiences" ;;
  }

  dimension: interests {
    type: number
    sql: ${TABLE}."Interests" ;;
  }

  dimension: ifo {
    type: number
    sql: ${TABLE}."IFO" ;;
  }

  dimension: viewability {
    type: number
    sql: ${TABLE}."Viewability" ;;
  }

  dimension: crossdevice {
    type: number
    sql: ${TABLE}."Cross-Device" ;;
  }

  dimension: audience {
    type: number
    sql: ${TABLE}."Audience" ;;
  }

  dimension: algos_nielsen {
    type: number
    label: "Algos (Nielsen)"
    sql: ${TABLE}."Algos (Nielsen)" ;;
  }

  dimension: partner_audiences {
    type: number
    label: "Partner Audiences"
    sql: ${TABLE}."Partner Audiences" ;;
  }

  dimension: precision_targets_bi {
    type: number
    label: "Precision Targets (BI)"
    sql: ${TABLE}."Precision Targets (BI)" ;;
  }

  dimension: smart_tv_amplifier {
    type: number
    label: "Smart TV Amplifier"
    sql: ${TABLE}."Smart TV Amplifier" ;;
  }

  dimension: custom_bi_persona {
    type: number
    label: "Custom BI Persona"
    sql: ${TABLE}."Custom BI Persona" ;;
  }

  dimension: compliance_oba {
    type: number
    label: "Compliance (OBA)"
    sql: ${TABLE}."Compliance (OBA)" ;;
  }

  dimension: other {
    type: number
    sql: ${TABLE}."Other" ;;
  }

  dimension: 1st_party_lal {
    type: number
    label: "1st party LAL"
    sql: ${TABLE}."1st party LAL" ;;
  }

  dimension: interestsamobee_audiences {
    type: number
    label: "Interests/Amobee Audiences"
    sql: ${TABLE}."Interests/Amobee Audiences" ;;
  }

  dimension: content {
    type: number
    sql: ${TABLE}."Content" ;;
  }

  dimension: spo_custom {
    type: number
    label: "SPO Custom"
    sql: ${TABLE}."SPO Custom" ;;
  }

  dimension: rich_media {
    type: number
    label: "Rich Media"
    sql: ${TABLE}."Rich Media" ;;
  }

  dimension: propensity_scoring_bpo {
    type: number
    label: "Propensity Scoring (BPO)"
    sql: ${TABLE}."Propensity Scoring (BPO)" ;;
  }

  dimension: lifestyles {
    type: number
    sql: ${TABLE}."Lifestyles" ;;
  }

  dimension: all_others {
    type: number
    label: "All Others"
    sql: ${TABLE}."All Others" ;;
  }

  set: detail {
    fields: [
        period_name,
	ns_customer_id,
	customer_name,
	market_id,
	market_name,
	total_billable,
	net_revenue_pct,
	tech_fee__managed_fee,
	publisher_gp,
	bid_saving,
	data,
	demo_audiences,
	interests,
	ifo,
	viewability,
	crossdevice,
	audience,
	algos_nielsen,
	partner_audiences,
	precision_targets_bi,
	smart_tv_amplifier,
	custom_bi_persona,
	compliance_oba,
	other,
	1st_party_lal,
	interestsamobee_audiences,
	content,
	spo_custom,
	rich_media,
	propensity_scoring_bpo,
	lifestyles,
	all_others
    ]
  }
}
