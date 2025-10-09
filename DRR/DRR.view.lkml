view: drr {

  sql_table_name: BI.svc_DRR_Daily_Revenue_Report ;;

  dimension: Event_Date_Dt {
    description: "Event_Date"
    type: date
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: Event_Date_Formatted {
    sql: ${TABLE}.Event_Date ;;
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

  measure: Revenue_Previous_Day {
    type: number
    sql:
        SUM(
          CASE
            WHEN ${Event_Date_Dt} = (${Event_Date_Dt} - INTERVAL '1 day')
            THEN ${TABLE}.Revenue
          END
        ) ;;
    value_format: "$#,##0;($#,##0)"
    label: "Revenue of One Day Ago"
  }

  measure: Sum_Revenue {
    description: "Total revenue across category, subcategory, region"
    label: "Total Gross Revenue"
    type: sum
    sql: ${TABLE}.Revenue ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Sum_Cost {
    description: "Total Cost across category, subcategory, region"
    label: "Total Cost"
    type: sum
    sql: ${TABLE}.Cost ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Sum_Net_Revenue {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "Total Net Revenue"
    type: sum
    sql: ${TABLE}.Revenue - ${TABLE}.Cost ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Profit_Perc{
    label: "GP %"
    type: number
    sql: ((${Sum_Revenue} - ${Sum_Cost}) / NULLIF(${Sum_Revenue}, 0)) ;;
    value_format_name: percent_1
  }
 }
