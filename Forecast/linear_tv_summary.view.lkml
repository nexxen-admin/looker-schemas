view: linear_tv_summary {

  derived_table: {
    sql: SELECT 'Linear TV - Strategic' AS team,
                fact_forecast_strategy_summary.event_month AS event_month,
                COALESCE(SUM(fact_forecast_strategy_summary.NR_Forecast_Full_Credit ), 0) AS nr_forecast,
                COALESCE(SUM(fact_forecast_strategy_summary.Net_Revenue_Booked ), 0) AS nr_booked,
                COALESCE(SUM(fact_forecast_strategy_summary.net_revenue_target ), 0) AS nr_target,
                CASE WHEN COALESCE(SUM(fact_forecast_strategy_summary.net_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_strategy_summary.Net_Revenue_Booked ), 0) / NULLIF(COALESCE(SUM(fact_forecast_strategy_summary.net_revenue_target ), 0), 0) END AS p_of_target_nr_booked,
                COALESCE(SUM(fact_forecast_strategy_summary.GR_Forecast_Full_Credit ), 0) AS gr_forecast,
                COALESCE(SUM(fact_forecast_strategy_summary.Booked_Full_Credit ), 0) AS gr_booked,
                COALESCE(SUM(fact_forecast_strategy_summary.gross_revenue_target ), 0) AS gr_target,
                CASE WHEN COALESCE(SUM(fact_forecast_strategy_summary.gross_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_strategy_summary.Booked_Full_Credit ), 0) / NULLIF(COALESCE(SUM(fact_forecast_strategy_summary.gross_revenue_target ), 0), 0) END AS p_of_target_gr_booked
            FROM BI_DSP.fact_forecast_strategy_summary AS fact_forecast_strategy_summary
                LEFT JOIN BI_DSP.dim_sfdb_user ON LOWER(fact_forecast_strategy_summary.seller) = LOWER(dim_sfdb_user.firstname || ' ' || dim_sfdb_user.lastname)
            WHERE fact_forecast_strategy_summary.revenue_line = 'TV' AND ((CASE WHEN COALESCE(dim_sfdb_user.strat_sales_team, fact_forecast_strategy_summary.Strat_Sales_Team)='Strat Sales - Southwast' THEN 'Strat Sales - Southwest'
                ELSE COALESCE(dim_sfdb_user.strat_sales_team, fact_forecast_strategy_summary.Strat_Sales_Team) END)!='Unknown')
            GROUP BY 1, 2
        UNION
        SELECT 'Linear TV - Enterprise' AS team,
            fact_forecast_enterprise_summary.event_month AS event_month,
            COALESCE(SUM(fact_forecast_enterprise_summary.Net_Revenue_Booked ), 0) AS nr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.NR_Forecast_Full_Credit ), 0) AS nr_forecast,
            COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0) AS nr_target,
            CASE WHEN COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_enterprise_summary.Net_Revenue_Booked ), 0) / NULLIF(COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0), 0) END AS p_of_target_nr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.GR_Forecast_Full_Credit ), 0) AS gr_forecast,
            COALESCE(SUM(fact_forecast_enterprise_summary.Booked_Full_Credit ), 0) AS gr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0) AS gr_target,
            CASE WHEN COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_enterprise_summary.Booked_Full_Credit ), 0) / NULLIF(COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0), 0) END AS p_of_target_gr_booked
        FROM BI_DSP.fact_forecast_enterprise_summary
            LEFT JOIN BI_DSP.dim_sfdb_user ON LOWER(fact_forecast_enterprise_summary.Generalist_Name) = LOWER(dim_sfdb_user.firstname || ' ' || dim_sfdb_user.lastname)
        WHERE  fact_forecast_enterprise_summary.revenue_line = 'TV' AND ((COALESCE(dim_sfdb_user.new_enterprise_team, fact_forecast_enterprise_summary.new_enterprise_team) ) <> 'Linear TV (Maloy)' OR (COALESCE(dim_sfdb_user.new_enterprise_team, fact_forecast_enterprise_summary.new_enterprise_team) ) IS NULL) AND ((COALESCE(dim_sfdb_user.new_enterprise_team, fact_forecast_enterprise_summary.new_enterprise_team))!='Unknown' OR (
            fact_forecast_enterprise_summary.account_name ILIKE '%Klick Health%' OR
            fact_forecast_enterprise_summary.account_name ILIKE '%301 Digital Media%' OR
            fact_forecast_enterprise_summary.account_name ILIKE '%Good Karma Brands%' OR
            fact_forecast_enterprise_summary.account_name ILIKE '%Guru%' OR
            fact_forecast_enterprise_summary.account_name ILIKE '%U.S. HealthConnect%' OR
            fact_forecast_enterprise_summary.account_name ILIKE '%Active International%'OR
            fact_forecast_enterprise_summary.account_name ILIKE '%Starcom - US%'OR
            fact_forecast_enterprise_summary.account_name ILIKE '%Rescue Agency%'
          ) )
        GROUP BY 1, 2
          UNION
          SELECT 'Linear TV (Maloy)' AS team,fact_forecast_enterprise_summary.event_month AS event_month,
            COALESCE(SUM(fact_forecast_enterprise_summary.Net_Revenue_Booked ), 0) AS nr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.NR_Forecast_Full_Credit ), 0) AS nr_forecast,
            COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0) AS nr_target,
            CASE WHEN COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_enterprise_summary.Net_Revenue_Booked ), 0) / NULLIF(COALESCE(SUM(fact_forecast_enterprise_summary.net_revenue_target ), 0), 0) END AS p_of_target_nr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.GR_Forecast_Full_Credit ), 0) AS gr_forecast,
            COALESCE(SUM(fact_forecast_enterprise_summary.Booked_Full_Credit ), 0) AS gr_booked,
            COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0) AS gr_target,
            CASE WHEN COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0) = 0 THEN 0 ELSE COALESCE(SUM(fact_forecast_enterprise_summary.Booked_Full_Credit ), 0) / NULLIF(COALESCE(SUM(fact_forecast_enterprise_summary.gross_revenue_target ), 0), 0) END AS p_of_target_gr_booked
          FROM BI_DSP.fact_forecast_enterprise_summary AS fact_forecast_enterprise_summary
              LEFT JOIN BI_DSP.dim_sfdb_user AS dim_sfdb_user ON LOWER(fact_forecast_enterprise_summary.Generalist_Name) = LOWER(dim_sfdb_user.firstname || ' ' || dim_sfdb_user.lastname)
          WHERE  (COALESCE(dim_sfdb_user.new_enterprise_team, fact_forecast_enterprise_summary.new_enterprise_team) ) = 'Linear TV (Maloy)' AND ((COALESCE(dim_sfdb_user.new_enterprise_team, fact_forecast_enterprise_summary.new_enterprise_team))!='Unknown' OR (
              fact_forecast_enterprise_summary.account_name ILIKE '%Klick Health%' OR
              fact_forecast_enterprise_summary.account_name ILIKE '%301 Digital Media%' OR
              fact_forecast_enterprise_summary.account_name ILIKE '%Good Karma Brands%' OR
              fact_forecast_enterprise_summary.account_name ILIKE '%Guru%' OR
              fact_forecast_enterprise_summary.account_name ILIKE '%U.S. HealthConnect%' OR
              fact_forecast_enterprise_summary.account_name ILIKE '%Active International%'OR
              fact_forecast_enterprise_summary.account_name ILIKE '%Starcom - US%'OR
              fact_forecast_enterprise_summary.account_name ILIKE '%Rescue Agency%'
            ) )
          GROUP BY 1, 2
   ;;
  }

  dimension: event_month {
    type: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: team {
    type: string
    description: "Shows which branch of sales provides the numbers: Strategic TV Revenue Line, Enterprise TV Revenue Line or Enterprise Linear TV Team"
    sql: ${TABLE}.team ;;
  }

  measure: nr_booked {
    type: sum
    label: "NR Booked"
    sql: ${TABLE}.nr_booked ;;
    value_format: "$#,##0"
  }

  measure: gr_booked {
    type: sum
    label: "GR Booked"
    sql: ${TABLE}.gr_booked ;;
    value_format: "$#,##0"
  }

  measure: nr_forecast {
    type: sum
    label: "NR Forecast"
    sql: ${TABLE}.nr_forecast ;;
    value_format: "$#,##0"
  }

  measure: gr_forecast {
    type: sum
    label: "GR Forecast"
    sql: ${TABLE}.gr_forecast ;;
    value_format: "$#,##0"
  }

  measure: nr_target {
    type: sum
    label: "NR Target"
    sql: ${TABLE}.nr_target ;;
    value_format: "$#,##0"
  }

  measure: gr_target {
    type: sum
    label: "GR Target"
    sql: ${TABLE}.gr_target ;;
    value_format: "$#,##0"
  }

  measure: p_of_target_nr_booked {
    type: average
    label: "% of Target NR Booked"
    sql: ${TABLE}.p_of_target_nr_booked ;;
    value_format: "0%"
  }

  measure: p_of_target_gr_booked {
    type: average
    label: "% of Target GR Booked"
    sql: ${TABLE}.p_of_target_gr_booked ;;
    value_format: "0%"
  }

}
