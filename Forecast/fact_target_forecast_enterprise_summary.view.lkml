view: fact_target_forecast_enterprise_summary {
  sql_table_name: BI_DSP.fact_forecast_enterprise_summary ;;

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }
  dimension: booked_full_credit {
    type: number
    sql: ${TABLE}.Booked_Full_Credit ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
  dimension: generalist_name {
    type: string
    sql: ${TABLE}.Generalist_Name ;;
  }
  dimension: generalist_name_key {
    type: string
    sql: LOWER(${TABLE}.Generalist_Name) ;;
    hidden: yes
  }
  dimension: gr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
  }
  dimension: gross_revenue_target {
    type: number
    sql: ${TABLE}.gross_revenue_target ;;
  }
  dimension: net_revenue_booked {
    type: number
    sql: ${TABLE}.Net_Revenue_Booked ;;
  }
  dimension: net_revenue_target {
    type: number
    sql: ${TABLE}.net_revenue_target ;;
  }
  dimension: nr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
  }
  dimension: nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
  }
  dimension: nr_forecast_nr_upside_weighted_new {
    type: number
    sql: ${TABLE}.NR_Forecast_NR_Upside_Weighted_NEW ;;
    value_format: "0%"
  }
  dimension: percent_of_target_gr_forecast {
    type: number
    sql: ${TABLE}.percent_of_target_gr_forecast ;;
    value_format: "0%"
  }
  dimension: percent_of_target_nr_forecast {
    type: number
    sql: ${TABLE}.percent_of_target_nr_forecast ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: related_brand {
    type: string
    sql: ${TABLE}.Related_Brand ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
  }
  dimension: unweighted_nr_forecast_tremor_leadership {
    type: number
    sql: ${TABLE}.Unweighted_NR_Forecast_Tremor_Leadership ;;
  }
  dimension: unweighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Unweighted_NR_Upside_New_Forecast_v2 ;;
  }
  dimension: unweighted_tl_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
  }
  dimension: weighted_forecasted_spend_tremor_leadership {
    type: number
    sql: ${TABLE}.Weighted_Forecasted_Spend_Tremor_Leadership ;;
  }
  dimension: weighted_nr_forecast_tremor_leadership {
    type: number
    sql: ${TABLE}.Weighted_NR_Forecast_Tremor_Leadership ;;
  }
  dimension: weighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
  }
  dimension: weighted_scheduled_converted_revenue {
    type: number
    sql: ${TABLE}.Weighted_Scheduled_Converted_Revenue ;;
  }
  dimension: weighted_tl_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
  }

  dimension: Strat_Sales_Team {
    type: string
    sql: COALESCE(${forecast_dim_sfdb_user.strat_sales_team}, ${TABLE}.Strat_Sales_Team)  ;;
  }

  dimension: new_enterprise_team {
    type: string
    sql: COALESCE(${forecast_dim_sfdb_user.new_enterprise_team}, ${TABLE}.new_enterprise_team) ;;
  }

  dimension: Strat_Sales_RVP {
    type: string
    sql: ${TABLE}.Strat_Sales_RVP ;;
  }


  dimension: CS_pod {
    type: string
    sql: ${TABLE}.CS_pod ;;
    label: "Enterprise CS Regional Pods"
  }

  # dimension: enterprise_cs_regional_pods {
  #   type: string
  #   sql: CASE
  #         WHEN ${account_name} LIKE '%Coegi%' THEN 'East/Central'
  #         WHEN ${account_name} LIKE '%Underscore Marketing%' THEN 'East/Central'
  #         WHEN ${account_name} LIKE '%Klick Health%' THEN 'East/Central'
  #         WHEN ${account_name} LIKE '%Grapeseed Media%' THEN 'East/Central'
  #         WHEN ${new_enterprise_team} = 'Enterprise Sales - East' THEN 'East/Central'
  #         WHEN ${new_enterprise_team} = 'Enterprise Sales - Central' THEN 'East/Central'

  #         WHEN ${new_enterprise_team} = 'Enterprise Sales - West' THEN 'West'

  #         WHEN ${new_enterprise_team} = 'Enterprise Sales House Accounts' THEN 'Rest'
  #         WHEN ${new_enterprise_team} = 'Enterprise Services - National' THEN 'Rest'
  #         WHEN ${new_enterprise_team} = 'Political' THEN 'Rest'
  #         WHEN ${new_enterprise_team} = 'Linear TV (Maloy)' THEN 'Rest'

  #         WHEN ${new_enterprise_team} = 'Unknown' THEN 'Unknown'

  #     ELSE NULL
  #     END ;;
  #   label: "Enterprise CS Regional Pods"
  # }


  # dimension: sales_team_chance_org{
  #   type: string
  #   sql:
  #   CASE
  #     WHEN ${new_enterprise_team} IN (
  #       'Enterprise Sales House Accounts',
  #       'West',
  #       'East',
  #       'Central',
  #       'Political',
  #       'ATV',
  #       'ITV',
  #       'Linear TV (Maloy)'
  #     ) THEN CONCAT('Enterprise Sales - ', ${new_enterprise_team})

  #     WHEN ${Strat_Sales_Team} LIKE '%Strat Sales%' THEN CONCAT('Strategic Sales - ', ${Strat_Sales_RVP})

  #     ELSE NULL
  #   END ;;
  #   label: "Sales Team (Chance Org)"
  # }

  # dimension: Chance_Sales_Team_Consolidated {
  #   type: string
  #   sql:
  #   CASE
  #     WHEN ${sales_team_chance_org} LIKE '%Enterprise Sales%' THEN 'Enterprise Sales'
  #     WHEN ${sales_team_chance_org} LIKE '%Strategic Sales%' THEN 'Strategic Sales'
  #     ELSE NULL
  #   END ;;
  #   label: "Chance Sales Team (Consolidated)"
  # }

  # dimension: tech_services_group {
  #   type: string
  #   sql:
  #   CASE
  #     WHEN ${account_name} = 'ITV' THEN NULL
  #     WHEN ${account_name} = 'LG Electronics' THEN NULL

  #     WHEN ${Chance_Sales_Team_Consolidated} LIKE '%Enterprise Sales%' AND ${sales_team_chance_org} != 'Enterprise Sales - Linear TV (Maloy)'
  #       THEN 'Tech Services - Enterprise Sales'

  #     WHEN ${sales_team_chance_org} LIKE '%Strategic Sales%'
  #       THEN 'Tech Services - Strategic Sales'

  #     WHEN ${account_name} LIKE '%Klick Health%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%301 Digital Media%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Good Karma Brands%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Guru%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Rescue Agency%' THEN 'Tech Services - Strategic Sales'

  #     ELSE NULL
  #   END ;;
  #   label: "Enterprise Technical Services"
  # }


  dimension: sales_team_chance_org {
    type: string
    label: "Sales Team (Chance Org)"
    sql: CASE WHEN ${new_enterprise_team} ILIKE '%Enterprise Sales%' THEN ${new_enterprise_team}
              --WHEN ${new_enterprise_team} ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  ${new_enterprise_team} ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN ${Strat_Sales_Team}  ILIKE '%Barter Direct%' THEN ${Strat_Sales_Team}
            ELSE CONCAT('Strategic Sales - ', ${Strat_Sales_Team}) END ;;
  }

  dimension: chance_team {
    type: string
    label: "Chance Team (Consolidated)"
    sql: CASE WHEN ${sales_team_chance_org} ILIKE '%Enterprise Sales%' THEN 'Enterprise Sales'
              WHEN ${sales_team_chance_org} ILIKE '%Strategic Sales%' THEN 'Strategic Sales'
              WHEN ${sales_team_chance_org} ILIKE '%Barter Direct%' THEN 'Barter Direct'
            END;;
  }

  dimension: tech_services_sales_team {
    type: string
    sql:
    CASE
      WHEN ${account_name} = 'ITV' THEN NULL
      WHEN ${account_name} = 'LG Electronics' THEN NULL

      WHEN ${chance_team} ILIKE '%Enterprise Sales%'
      AND ${sales_team_chance_org} != 'Enterprise Sales - Linear TV (Maloy)'
      THEN 'Tech Services - Enterprise Sales'

      WHEN ${sales_team_chance_org} ILIKE '%Strategic Sales%'
      AND ${CS_pod} IS NOT NULL
      THEN 'Tech Services - Strategic Sales'

      WHEN ${account_name} ILIKE '%Klick Health%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%301 Digital Media%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Good Karma Brands%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Guru%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Rescue Agency%' THEN 'Tech Services - Strategic Sales'

      ELSE NULL
      END ;;
  }


  ###--MEASURES--###



  ###--"GR Forecast"--###

  measure: sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    value_format: "$#,##0"
    label: "GR Forecast"
    view_label: "GR Forecast"
  }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0"
    label: "GR Unweighted Upside"
    view_label: "GR Forecast"
  }

  measure: sum_weighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0"
    label: "GR weighted Upside"
    view_label: "GR Forecast"
  }

  measure: sum_percent_of_target_gr_forecast {
    type: sum
    sql: ${TABLE}.percent_of_target_gr_forecast ;;
    value_format: "0%"
    label: "% Of Target GR Forecast"
    view_label: "GR Forecast"
  }

  ###--"NR Forecast"--###
  measure: sum_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
    value_format: "$#,##0"
    label: "NR Forecast"
    view_label: "NR Forecast"
  }

  measure: sum_unweighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_NR_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0"
    label: "NR Unweighted Upside"
    view_label: "NR Forecast"
  }

  measure: sum_weighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0"
    label: "NR weighted Upside"
    view_label: "NR Forecast"
  }

  measure: delta_nr_forecast {
    type: number
    label: "Delta Between NR Forecast and Target"
    sql: ${sum_nr_forecast_full_credit} - ${sum_net_revenue_target} ;;
    value_format: "$#,##0"
    view_label: "NR Forecast"
  }

  # measure: sum_percent_of_target_nr_forecast {
  #   type: sum
  #   sql: ${TABLE}.percent_of_target_nr_forecast ;;
  #   value_format: "0%"
  #   label: "% Of Target NR Forecast"
  #   view_label: "NR Forecast"
  # }


  measure: sum_percent_of_target_nr_forecast {
    type: number
    label: "% of Target NR Forecast"
    sql: CASE
          WHEN ${fact_target_forecast_enterprise_summary.sum_net_revenue_target} = 0 THEN 0
          ELSE ${fact_target_forecast_enterprise_summary.sum_nr_forecast_full_credit}
               / NULLIF(${fact_target_forecast_enterprise_summary.sum_net_revenue_target}, 0)
       END ;;
    value_format: "0%"
    view_label: "NR Forecast"
  }

  measure: sum_weighted_nr_upside_and_nr_forecast {
    type: sum
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 + ${TABLE}.NR_Forecast_Full_Credit;;
    value_format: "$#,##0"
    label: "NR Forecast + NR Upside (Weighted)"
    view_label: "NR Forecast"
  }

  measure: sum_weighted_nr_upside_and_nr_forecast_to_target {
    type: average
    sql: CASE
          WHEN ${TABLE}.net_revenue_target = 0 THEN 0
          ELSE (${TABLE}.Weighted_NR_Upside_New_Forecast_v2 + ${TABLE}.NR_Forecast_Full_Credit)
               / NULLIF(${TABLE}.net_revenue_target, 0)
       END ;;
    value_format: "0%"
    label: "NR Forecast + NR Upside % to Target"
    view_label: "NR Forecast"
  }



     ###--"GR Booked"--###

  measure: sum_booked_full_credit {
    type: sum
    sql: ${TABLE}.Booked_Full_Credit ;;
    value_format: "$#,##0"
    label: "GR Booked"
    view_label: "GR Booked"
  }


  measure:sum_gr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
    view_label: "GR Booked"
  }



    ###--"NR Booked"--###
  measure: sum_net_revenue_booked {
    type: sum
    sql: ${TABLE}.Net_Revenue_Booked ;;
    value_format: "$#,##0"
    label: "NR Booked"
    view_label: "NR Booked"
  }

  measure:sum_nr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
    view_label: "NR Booked"
  }

  measure: delta_nr_booked {
    type: number
    label: "Delta Between NR Booked and Target"
    sql: ${sum_net_revenue_booked} - ${sum_net_revenue_target} ;;
    value_format: "$#,##0"
    view_label: "NR Booked"
  }

  measure: P_of_Target_NR_Booked {
    type: number
    label: "% of Target NR Booked"
    sql: CASE
    WHEN ${fact_target_forecast_enterprise_summary.sum_net_revenue_target} = 0 THEN 0
    ELSE ${fact_target_forecast_enterprise_summary.sum_net_revenue_booked}
    / NULLIF(${fact_target_forecast_enterprise_summary.sum_net_revenue_target}, 0)
    END ;;
    value_format: "0%"
    view_label: "NR Booked"
  }



        ###--"Target"--###
  measure: sum_net_revenue_target {
    type: sum
    sql: ${TABLE}.net_revenue_target ;;
    value_format: "$#,##0"
    label: "NR Target"
  }

  measure: sum_gross_revenue_target {
    type: sum
    sql: ${TABLE}.gross_revenue_target ;;
    value_format: "$#,##0"
    label: "GR Target"
  }


  measure: count {
    type: count
    drill_fields: [account_name, generalist_name]
  }
}
