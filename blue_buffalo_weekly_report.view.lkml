view: blue_buffalo_weekly_report {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as date,
        'Tremor Video' as Partner,
        'True Solutions' as Product_Line,
        c2.flight_id,
        SUM(impressions) as impressions_total,
        SUM(completions) as completions_total,
        SUM(clicks) as clicks_total,
        (SUM(impressions)/1000)*30 as cost_CAD,
        NULL as cost_USD,
        CASE
        WHEN c2.flight_id = 4188816 THEN 'P1W5C1F_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist Dog English_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188826 THEN 'P1W5C2B_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist Cat English_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188856 THEN 'P1W5C2L_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist French Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188796 THEN 'P1W5C2M_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist French Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188776 THEN 'P1W5C2P_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada English Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188786 THEN 'P1W5C2Q_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada English Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188866 THEN 'P1W5C2R_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada French Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        ELSE 'P1W5C2S_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada French Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        END as DCM_Name
      from dwh.ad_data_daily add2
        inner join dwh.campaign c2 on add2.flight_id = c2.flight_id
      WHERE date BETWEEN CURRENT_DATE()-7 and CURRENT_DATE()-1
        AND c2.flight_id IN (4188816,
                  4188826,
                  4188856,
                  4188796,
                  4188776,
                  4188786,
                  4188866,
                  4188806)
        AND data_type = 'AD_DATA'
      group by 1,2,3,4
      ORDER BY date ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

  dimension: product_line {
    type: string
    sql: ${TABLE}.Product_Line ;;
  }

  dimension: flight_id {
    type: number
    sql: ${TABLE}.flight_id ;;
  }

  dimension: impressions_total {
    type: number
    sql: ${TABLE}.impressions_total ;;
  }

  dimension: completions_total {
    type: number
    sql: ${TABLE}.completions_total ;;
  }

  dimension: clicks_total {
    type: number
    sql: ${TABLE}.clicks_total ;;
  }

  dimension: cost_cad {
    type: number
    sql: ${TABLE}.cost_CAD ;;
  }

  dimension: cost_usd {
    type: number
    sql: ${TABLE}.cost_USD ;;
  }

  dimension: dcm_name {
    type: string
    sql: ${TABLE}.DCM_Name ;;
  }

  set: detail {
    fields: [
      date,
      partner,
      product_line,
      flight_id,
      impressions_total,
      completions_total,
      clicks_total,
      cost_cad,
      cost_usd,
      dcm_name
    ]
  }
}
