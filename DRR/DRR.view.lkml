view: drr {

  sql_table_name: BI.svc_DRR_Daily_Revenue_Report ;;

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
    sql: {% parameter Report_Run_Date %} ;;
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

  dimension: Media_Type {
    description: "Media type"
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: Device_Type {
    description: "Device type"
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: Impression_Type{
    description: "Impression type"
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }

  measure: Gross_Revenue {
    label: "Gross Revenue"
    type: sum
    sql: CASE WHEN ${TABLE}.event_date=CAST('{% parameter Report_Run_Date %}' AS DATE) THEN ${TABLE}.Revenue ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_Previous_Day {
    label: "Gross Revenue Previous Day"
    type: sum
    sql: CASE WHEN ${TABLE}.event_date={% parameter Report_Run_Date %}-1 THEN ${TABLE}.Revenue ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_MTD {
    type: sum
    label: "Gross Revenue MTD"
    sql: CASE WHEN DATE_TRUNC('MONTH', ${TABLE}.event_date)=DATE_TRUNC('MONTH',{% parameter Report_Run_Date %}) AND ${TABLE}.event_date<={% parameter Report_Run_Date %} THEN ${TABLE}.Revenue ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost {
    description: "Total Cost across category, subcategory, region"
    label: "Total Cost"
    type: sum
    sql: CASE WHEN ${TABLE}.event_date={% parameter Report_Run_Date %} THEN ${TABLE}.Cost ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Previous_Day {
    type: sum
    sql: CASE WHEN ${TABLE}.event_date={% parameter Report_Run_Date %}-1 THEN ${TABLE}.Cost ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "Net Revenue"
    type: sum
    sql: CASE WHEN ${TABLE}.event_date={% parameter Report_Run_Date %} THEN ${TABLE}.Revenue - ${TABLE}.Cost ELSE 0 END ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_Previous_Day {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "Net Revenue Previous Day"
    type: number
    sql: ${Gross_Revenue_Previous_Day} - ${Cost_Previous_Day} ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Profit_Perc{
    label: "GP %"
    type: number
    sql: ((${Gross_Revenue} - ${Cost}) / NULLIF(${Gross_Revenue}, 0)) ;;
    value_format_name: percent_1
  }
 }
