view: drr {
  derived_table: {
    sql: WITH BASE_DATA AS (
                      SELECT Event_Date
                               , Region
                               , Category
                               , Subcategory
                               , Device_Type
                               , SUM(Revenue) AS Revenue
                               , SUM(Cost) AS Cost
                               , SUM(Revenue - Cost) AS Net_Revenue
                               , TRUNC(Event_Date, 'MM')::date AS Month_Start
                               , TRUNC(Event_Date, 'Q')::date AS Quarter_Start
                               , TRUNC(Event_Date, 'Y')::date AS Year_Start
                      FROM BI.DRR_Daily_Revenue_Report drr
                      WHERE Event_Date>=(TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'Y') - INTERVAL '90 DAY')
                      GROUP BY Event_Date, Region, Category, Subcategory, Device_Type
                )
                --SELECT * FROM BASE_DATA;
                , PERIODS_DATA_YEAR AS (
                    SELECT Year_Start
                            , Region
                            , Category
                            , Subcategory
                            , Device_Type
                            , SUM(Revenue) AS Revenue_YTD
                            , SUM(Cost) AS Cost_YTD
                            , SUM(Net_Revenue) AS Net_Revenue_YTD
                    FROM BASE_DATA
                    WHERE Event_Date >= TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'Y')::date AND Event_Date <= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
                    GROUP BY Region, Category, Subcategory, Device_Type, Year_Start
                )
                --SELECT * FROM PERIODS_DATA_YEAR;
                , PERIODS_DATA_QUARTER AS (
                    SELECT Quarter_Start
                            , Region
                            , Category
                            , Subcategory
                            , Device_Type
                            , SUM(Revenue) AS Revenue_QTD
                            , SUM(Cost) AS Cost_QTD
                            , SUM(Net_Revenue) AS Net_Revenue_QTD
                    FROM BASE_DATA
                    WHERE Event_Date >= TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'Q')::date AND Event_Date <= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
                    GROUP BY Region, Category, Subcategory, Device_Type, Quarter_Start
                )
                --SELECT * FROM PERIODS_DATA_QUARTER;
                , PERIODS_DATA_MONTH AS (
                    SELECT Month_Start
                            , Region
                            , Category
                            , Subcategory
                            , Device_Type
                            , SUM(Revenue) AS Revenue_MTD
                            , SUM(Cost) AS Cost_MTD
                            , SUM(Net_Revenue) AS Net_Revenue_MTD
                    FROM BASE_DATA
                    WHERE Event_Date >= TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'MM')::date AND Event_Date <= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
                    GROUP BY Region, Category, Subcategory, Device_Type, Month_Start
                )
                --SELECT * FROM PERIODS_DATA_MONTH;
                , DAILY_DATA AS (
                   SELECT Event_Date
                           , Region
                           , Category
                           , Subcategory
                           , Device_Type
                           , Revenue
                           , LAG(Revenue) OVER w_base AS LAG_Revenue
                           , Cost
                           , LAG(Cost) OVER w_base AS LAG_Cost
                           , Net_Revenue
                           , LAG(Net_Revenue) OVER w_base AS LAG_Net_Revenue
                           , Month_Start
                           , Quarter_Start
                           , Year_Start
                   FROM BASE_DATA bd
                   where Event_Date >= ((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::date - INTERVAL '1 DAY') AND Event_Date <= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::date
                   WINDOW
                        w_base AS (PARTITION BY Region, Category, Subcategory, Device_Type ORDER BY Event_Date)
                )
                --SELECT * FROM DAILY_DATA;
                , NINTY_DAY_DATA AS (
                   SELECT Event_Date
                           , Region
                           , Category
                           , Subcategory
                           , Device_Type
                           , Revenue
                           , Cost
                           , Net_Revenue
                   FROM BASE_DATA bd
                   where Event_Date >= ((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::date - INTERVAL '90' DAY) AND Event_Date <= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::date
                )
                --SELECT * FROM NINTY_DAY_DATA;
                , DAILY_DATA_FILTERED AS (
                    SELECT *
                    FROM DAILY_DATA
                    WHERE Event_Date=(CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)
                )
                --SELECT * FROM DAILY_DATA_FILTERED;
                SELECT  'Yearly metrics' as Data_Type
                        , NULL AS Event_Date
                        , Region
                        , Category
                        , Subcategory
                        , Device_Type
                        , NULL AS Revenue
                        , NULL AS Cost
                        , NULL AS Net_Revenue
                        , NULL AS LAG_Revenue
                        , NULL AS LAG_Cost
                        , NULL AS LAG_Net_Revenue
                        , Revenue_YTD AS Revenue_YTD
                        , Cost_YTD AS Cost_YTD
                        , Net_Revenue_YTD AS Net_Revenue_YTD
                        , NULL AS Revenue_QTD
                        , NULL AS Cost_QTD
                        , NULL AS Net_Revenue_QTD
                        , NULL AS Revenue_MTD
                        , NULL AS Cost_MTD
                        , NULL AS Net_Revenue_MTD
                FROM PERIODS_DATA_YEAR
                UNION
                SELECT  'Quarterly metrics' as Data_Type
                        , NULL AS Event_Date
                        , Region
                        , Category
                        , Subcategory
                        , Device_Type
                        , NULL AS Revenue
                        , NULL AS Cost
                        , NULL AS Net_Revenue
                        , NULL AS LAG_Revenue
                        , NULL AS LAG_Cost
                        , NULL AS LAG_Net_Revenue
                        , NULL AS Revenue_YTD
                        , NULL AS Cost_YTD
                        , NULL AS Net_Revenue_YTD
                        , Revenue_QTD AS Revenue_QTD
                        , Cost_QTD AS Cost_QTD
                        , Net_Revenue_QTD AS Net_Revenue_QTD
                        , NULL AS Revenue_MTD
                        , NULL AS Cost_MTD
                        , NULL AS Net_Revenue_MTD
                FROM PERIODS_DATA_QUARTER
                UNION
                SELECT  'Monthly metrics' as Data_Type
                        , NULL AS Event_Date
                        , Region
                        , Category
                        , Subcategory
                        , Device_Type
                        , NULL AS Revenue
                        , NULL AS Cost
                        , NULL AS Net_Revenue
                        , NULL AS LAG_Revenue
                        , NULL AS LAG_Cost
                        , NULL AS LAG_Net_Revenue
                        , NULL AS Revenue_YTD
                        , NULL AS Cost_YTD
                        , NULL AS Net_Revenue_YTD
                        , NULL AS Revenue_QTD
                        , NULL AS Cost_QTD
                        , NULL AS Net_Revenue_QTD
                        , Revenue_MTD AS Revenue_MTD
                        , Cost_MTD AS Cost_MTD
                        , Net_Revenue_MTD AS Net_Revenue_MTD
                FROM PERIODS_DATA_MONTH
                UNION
                SELECT 'Daily metrics' as Data_Type
                        , Event_Date as Event_Date
                        , Region
                        , Category
                        , Subcategory
                        , Device_Type
                        , Revenue
                        , Cost
                        , Net_Revenue
                        , LAG_Revenue
                        , LAG_Cost
                        , LAG_Net_Revenue
                        , NULL AS Revenue_YTD
                        , NULL AS Cost_YTD
                        , NULL AS Net_Revenue_YTD
                        , NULL AS Revenue_QTD
                        , NULL AS Cost_QTD
                        , NULL AS Net_Revenue_QTD
                        , NULL AS Revenue_MTD
                        , NULL AS Cost_MTD
                        , NULL AS Net_Revenue_MTD
                FROM DAILY_DATA_FILTERED D
                UNION
                SELECT 'Ninty days metrics' as Data_Type
                        , Event_Date as Event_Date
                        , Region
                        , Category
                        , Subcategory
                        , Device_Type
                        , Revenue
                        , Cost
                        , Net_Revenue
                        , NULL AS LAG_Revenue
                        , NULL AS LAG_Cost
                        , NULL AS LAG_Net_Revenue
                        , NULL AS Revenue_YTD
                        , NULL AS Cost_YTD
                        , NULL AS Net_Revenue_YTD
                        , NULL AS Revenue_QTD
                        , NULL AS Cost_QTD
                        , NULL AS Net_Revenue_QTD
                        , NULL AS Revenue_MTD
                        , NULL AS Cost_MTD
                        , NULL AS Net_Revenue_MTD
                FROM NINTY_DAY_DATA N
                UNION
                SELECT 'POP metrics' AS Data_Type
                        , NULL AS Event_Date
                        , PD_Y.Region
                        , PD_Y.Category
                        , PD_Y.Subcategory
                        , PD_Y.Device_Type
                        , DD.Revenue
                        , DD.Cost
                        , DD.Net_Revenue
                        , NULL AS LAG_Revenue
                        , NULL AS LAG_Cost
                        , NULL AS LAG_Net_Revenue
                        , PD_Y.Revenue_YTD
                        , PD_Y.Cost_YTD
                        , PD_Y.Net_Revenue_YTD
                        , PD_Q.Revenue_QTD
                        , PD_Q.Cost_QTD
                        , PD_Q.Net_Revenue_QTD
                        , PD_MM.Revenue_MTD
                        , PD_MM.Cost_MTD
                        , PD_MM.Net_Revenue_MTD
                FROM PERIODS_DATA_YEAR PD_Y
                LEFT JOIN PERIODS_DATA_QUARTER PD_Q ON PD_Y.Region = PD_Q.Region AND PD_Y.Category = PD_Q.Category AND PD_Y.Subcategory = PD_Q.Subcategory AND PD_Y.Device_Type = PD_Q.Device_Type
                LEFT JOIN PERIODS_DATA_MONTH PD_MM ON PD_Y.Region = PD_MM.Region AND PD_Y.Category = PD_MM.Category AND PD_Y.Subcategory = PD_MM.Subcategory AND PD_Y.Device_Type = PD_MM.Device_Type
                LEFT JOIN DAILY_DATA_FILTERED DD ON PD_Y.Region = DD.Region AND PD_Y.Category = DD.Category AND PD_Y.Subcategory = DD.Subcategory AND PD_Y.Device_Type = DD.Device_Type
      ;;
  }

  parameter: Report_Run_Date {
    type: date
    hidden: no
    label: "Report run date:"
    description: "Choose a date that you want to see data on. If 'any time' is selected - data for today will be loaded."
  }

  dimension: Data_Type {
    description: "Data_Type"
    type: string
    sql: ${TABLE}.Data_Type ;;
  }

  dimension: Event_Date_Dt {
    description: "Event_Date"
    type: date
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: Event_Date_Formatted {
    sql: ${Event_Date_Dt} ;;
    html: {% assign formatted_date = rendered_value | date: "%B %d, %Y" %}
          {{ formatted_date }}
        ;;
  }

  dimension: Region {
    description: "Region"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: Category {
    description: "Product category"
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: Subcategory {
    description: "Product Subcategory"
    type: string
    sql: ${TABLE}.Subcategory ;;
  }

  dimension: Device_Type {
    description: "Device type"
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  measure: Gross_Revenue_Daily {
    description: "Total Revenue across category, subcategory, region"
    label: "Gross Rev Daily"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_Previous_Day {
    type: sum
    sql: ${TABLE}.LAG_Revenue ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_MTD {
    type: sum
    sql: ${TABLE}.Revenue_MTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Gross Rev MTD"
  }

  measure: Gross_Revenue_QTD {
    type: sum
    sql: ${TABLE}.Revenue_QTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Gross Rev QTD"
  }

  measure: Gross_Revenue_YTD {
    type: sum
    sql: ${TABLE}.Revenue_YTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Gross Rev YTD"
  }

  measure: Cost_Daily {
    description: "Total Cost across category, subcategory, region"
    label: "Cost Daily"
    type: sum
    sql: ${TABLE}.Cost;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Previous_Day {
    label: "Cost Revenue Previous Day"
    type: sum
    sql: ${TABLE}.LAG_Cost ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_MTD {
    type: sum
    sql: ${TABLE}.Cost_MTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Cost MTD"
  }

  measure: Cost_QTD {
    type: sum
    sql: ${TABLE}.Cost_QTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Cost QTD"
  }

  measure: Cost_YTD {
    type: sum
    sql: ${TABLE}.Cost_YTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Cost YTD"
  }

  measure: Net_Revenue_Daily {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "Net Rev Daily"
    type: sum
    sql: ${TABLE}.Net_Revenue ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_Previous_Day {
    type: sum
    sql: ${TABLE}.LAG_Net_Revenue ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_MTD {
    type: sum
    sql: ${TABLE}.Net_Revenue_MTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Net Rev MTD"
  }

  measure: Net_Revenue_QTD {
    type: sum
    sql: ${TABLE}.Net_Revenue_QTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Net Rev QTD"
  }

  measure: Net_Revenue_YTD {
    type: sum
    sql: ${TABLE}.Net_Revenue_YTD ;;
    value_format: "$#,##0;($#,##0)"
    label: "Net Rev YTD"
  }
}
