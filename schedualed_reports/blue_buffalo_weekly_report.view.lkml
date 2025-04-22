view: blue_buffalo_weekly_report {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as Day,
        'Tremor Video' as Partner,
        'True Solutions' as Product_Line,
        c2.flight_id,
        NULL as Cost_USD,
        CASE
        WHEN c2.flight_id = 4188866 THEN 'P1W5C1F_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist Dog English_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188856 THEN 'P1W5C2B_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist Cat English_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188826 THEN 'P1W5C2L_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist French Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188816 THEN 'P1W5C2M_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Premium CTV Sitelist French Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188806 THEN 'P1W5C2P_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada English Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188776 THEN 'P1W5C2Q_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada English Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        WHEN c2.flight_id = 4188796 THEN 'P1W5C2R_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada French Dog_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        ELSE 'P1W5C2S_DBOLVNS_CPM_SS_BHV_A25-44_Behavioral Targeting + Blue Buffalo TrueSolutions CTV Custom Sitelist Canada French Cat_:15_VER_NA_N_TREMOR_HMICAL_COT_2022-01-01_2022-05-31_No_NAD_NA_1x1CC'
        END as dcm_name,
        SUM(impressions) as Impressions,
        SUM(completions) as Completions,
        SUM(clicks) as Clicks,
        (SUM(impressions)/1000)*30 as Cost_CAD
      from dwh.ad_data_daily add2
        inner join dwh.campaign c2 on add2.flight_id = c2.flight_id
      WHERE date BETWEEN CURRENT_DATE()-7 and CURRENT_DATE()-1
        AND c2.flight_id IN (4188866,
                  4188856,
                  4188826,
                  4188816,
                  4188806,
                  4188776,
                  4188796,
                  4188786)
        AND data_type = 'AD_DATA'
      group by 1,2,3,4, 5, 6
      ORDER BY date::date ASC

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: Day {
    type: date
    label: "Day"
    sql: ${TABLE}."Day" ;;
  }

  dimension: Partner {
    type: string
    label: "Partner"
    sql: ${TABLE}.Partner ;;
  }

  dimension: product_line {
    type: string
    label: "Product Line"
    sql: ${TABLE}.Product_Line ;;
  }

  dimension: flight_id {
    type: number
    sql: ${TABLE}.flight_id ;;
  }

  dimension: Impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: Completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: Clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: Cost_CAD {
    type: number
    label: "Cost (CAD)"
    sql: ${TABLE}.Cost_CAD ;;
  }

  dimension: Cost_USD {
    type: number
    label: "Cost (USD)"
    sql: ${TABLE}.Cost_USD ;;
  }

  dimension: dcm_name {
    type: string
    label: "Placement Name (DCM)"
    sql: ${TABLE}.dcm_name ;;
  }

  set: detail {
    fields: [
      Day,
      Partner,
      product_line,
      flight_id,
      Impressions,
      Completions,
      Clicks,
      Cost_CAD,
      Cost_USD,
      dcm_name
    ]
  }
}
