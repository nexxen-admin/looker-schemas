
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
           "All Others" / total_billable as "All Others",
          null as "TV Amplifier",
          null as "Dynamic Localization",
          null as "Lifestyles/Amobee Audiences"

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

  measure: total_billable {
    type: sum
    sql: ${TABLE}."total_billable" ;;
  }

  measure: net_revenue_pct {
    type: sum
    sql: ${TABLE}."net_revenue_pct" ;;
  }

  measure: tech_fee__managed_fee {
    type: sum
    label: "Tech Fee + Managed Fee"
    sql: ${TABLE}."Tech Fee + Managed Fee" ;;
  }

  measure: publisher_gp {
    type: sum
    label: "Publisher GP"
    sql: ${TABLE}."Publisher GP" ;;
  }

  measure: bid_saving {
    type: sum
    label: "Bid Saving"
    sql: ${TABLE}."Bid Saving" ;;
  }

  measure: data {
    type: sum
    sql: ${TABLE}."Data" ;;
  }

  measure: demo_audiences {
    type: sum
    label: "Demo Audiences"
    sql: ${TABLE}."Demo Audiences" ;;
  }

  measure: interests {
    type: sum
    sql: ${TABLE}."Interests" ;;
  }

  measure: TV_Amplifier {
    type: sum
    label: "TV Amplifier"
    sql: ${TABLE}."TV Amplifier" ;;
  }

  measure: Dynamic_Localization {
    type: sum
    label: "Dynamic Localization"
    sql: ${TABLE}."Dynamic Localization" ;;
  }

  measure: Lifestyles_Amobee_Audiences {
    type: sum
    label: "Lifestyles/Amobee Audiences"
    sql: ${TABLE}."Lifestyles/Amobee Audiences" ;;
  }

  measure: ifo {
    type: sum
    sql: ${TABLE}."IFO" ;;
  }

  measure: viewability {
    type: sum
    sql: ${TABLE}."Viewability" ;;
  }

  measure: crossdevice {
    type: sum
    sql: ${TABLE}."Cross-Device" ;;
  }

  measure: audience {
    type: sum
    sql: ${TABLE}."Audience" ;;
  }

  measure: algos_nielsen {
    type: sum
    label: "Algos (Nielsen)"
    sql: ${TABLE}."Algos (Nielsen)" ;;
  }

  measure: partner_audiences {
    type: sum
    label: "Partner Audiences"
    sql: ${TABLE}."Partner Audiences" ;;
  }

  measure: precision_targets_bi {
    type: sum
    label: "Precision Targets (BI)"
    sql: ${TABLE}."Precision Targets (BI)" ;;
  }

  measure: smart_tv_amplifier {
    type: sum
    label: "Smart TV Amplifier"
    sql: ${TABLE}."Smart TV Amplifier" ;;
  }

  measure: custom_bi_persona {
    type: sum
    label: "Custom BI Persona"
    sql: ${TABLE}."Custom BI Persona" ;;
  }

  measure: compliance_oba {
    type: sum
    label: "Compliance (OBA)"
    sql: ${TABLE}."Compliance (OBA)" ;;
  }

  measure: other {
    type: sum
    sql: ${TABLE}."Other" ;;
  }

  measure: 1st_party_lal {
    type: sum
    label: "1st party LAL"
    sql: ${TABLE}."1st party LAL" ;;
  }

  measure: interestsamobee_audiences {
    type: sum
    label: "Interests/Amobee Audiences"
    sql: ${TABLE}."Interests/Amobee Audiences" ;;
  }

  measure: content {
    type: sum
    sql: ${TABLE}."Content" ;;
  }

  measure: spo_custom {
    type: sum
    label: "SPO Custom"
    sql: ${TABLE}."SPO Custom" ;;
  }

  measure: rich_media {
    type: sum
    label: "Rich Media"
    sql: ${TABLE}."Rich Media" ;;
  }

  measure: propensity_scoring_bpo {
    type: sum
    label: "Propensity Scoring (BPO)"
    sql: ${TABLE}."Propensity Scoring (BPO)" ;;
  }

  measure: lifestyles {
    type: sum
    sql: ${TABLE}."Lifestyles" ;;
  }

  measure: all_others {
    type: sum
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
