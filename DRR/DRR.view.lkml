view: drr {
  # Or, you could make this view a derived table, like this:
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
                  , TRUNC(Event_Date, 'MM') AS Month_Start
                  , TRUNC(Event_Date, 'Q') AS Quarter_Start
                  , TRUNC(Event_Date, 'Y') AS Year_Start
         FROM BI.svc_DRR_Daily_Revenue_Report drr
         GROUP BY Event_Date, Region, Category, Subcategory, Device_Type
      ),
      BASE_DATA_WINDOWS AS (
        SELECT Event_Date
                      , Region
                      , Category
                      , Subcategory
                      , Device_Type
                      , Revenue
                      , LAG(Revenue) OVER w_base AS LAG_Revenue
                      , SUM(Revenue) OVER w_month AS Revenue_MTD
                      , SUM(Revenue) OVER w_quarter AS Revenue_QTD
                      , SUM(Revenue) OVER w_year AS Revenue_YTD
                      , Cost
                      , LAG(Cost) OVER w_base AS LAG_Cost
                      , SUM(Cost) OVER w_month AS Cost_MTD
                      , SUM(Cost) OVER w_quarter AS Cost_QTD
                      , SUM(Cost) OVER w_year AS Cost_YTD
                      , Net_Revenue
                      , LAG(Net_Revenue) OVER w_base AS LAG_Net_Revenue
                      , SUM(Net_Revenue) OVER w_month AS Net_Revenue_MTD
                      , SUM(Net_Revenue) OVER w_quarter AS Net_Revenue_QTD
                      , SUM(Net_Revenue) OVER w_year AS Net_Revenue_YTD
                      , Month_Start
                      , Quarter_Start
                      , Year_Start
        FROM BASE_DATA
        WINDOW
              w_base    AS (PARTITION BY Region, Category, Subcategory, Device_Type ORDER BY Event_Date),
              w_month   AS (PARTITION BY Region, Category, Subcategory, Device_Type, Month_Start ORDER BY Event_Date),
              w_quarter AS (PARTITION BY Region, Category, Subcategory, Device_Type, Quarter_Start ORDER BY Event_Date),
              w_year    AS (PARTITION BY Region, Category, Subcategory, Device_Type, Year_Start ORDER BY Event_Date)
      )
      SELECT Event_Date
              , Region
              , Category
              , Subcategory
              , Device_Type
              , Revenue
              , LAG_Revenue
              , Revenue_MTD
              , Revenue_QTD
              , Revenue_YTD
              , Cost
              , LAG_Cost
              , Cost_MTD
              , Cost_QTD
              , Cost_YTD
              , Net_Revenue
              , LAG_Net_Revenue
              , Net_Revenue_MTD
              , Net_Revenue_QTD
              , Net_Revenue_YTD
      FROM BASE_DATA_WINDOWS bd
      ;;
  }

  parameter: Report_Run_Date {
    type: date
    label: "Report run date:"
    description: "Choose a date that you want to see data on."
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

  measure: Gross_Revenue {
  description: "Total Revenue across category, subcategory, region"
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

  measure: Cost {
    description: "Total Cost across category, subcategory, region"
    type: sum
    sql: ${TABLE}.Cost;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Previous_Day {
    label: "Gross Revenue Previous Day"
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

  measure: Net_Revenue {
    description: "Total Net_Revenue across category, subcategory, region"
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

  measure: Gross_Profit_Perc{
    label: "GP %"
    type: number
    sql: ((${Gross_Revenue} - ${Cost}) / NULLIF(${Gross_Revenue}, 0)) ;;
    value_format_name: percent_1
  }
 }
