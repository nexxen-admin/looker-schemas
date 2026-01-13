view: drr_dq {
  derived_table: {
    sql: with new_rpt as (
            select Event_Date
                , Region
                , Category
                , Subcategory
                --, Media_type
                , Device_Type
                --, Impression_Type
                , Record_Type
                , File_record
                --, round(Revenue)::int as Revenue_New
                --, round(Cost)::int as Cost_New
                , sum(Revenue)::int as Revenue_New
                , sum(Cost)::int as Cost_New
            from BI.DRR_Daily_Revenue_Report
            --where  Event_Date>=(TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'Y') - INTERVAL '90 DAY')
              --Event_Date between '2025-12-14' and '2025-12-15'
            group by Event_Date
                , Region
                , Category
                , Subcategory
                , Device_Type
                , Record_Type
                , File_record
          )
          , current_rpt as (
            select Event_Date
                , Region
                , Category
                , Subcategory
                --, Media_type
                , Device_Type
                --, Impression_Type
                , Record_Type
                , File_record
          --      , round(Revenue)::int as Revenue_Legacy
          --      , round(Cost)::int as Cost_Legacy
                , sum(Revenue)::int as Revenue_Legacy
                , sum(Cost)::int as Cost_Legacy
            from BI.SVC_DRR_Daily_Revenue_Report
            --where Event_Date>=(TRUNC((CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE, 'Y') - INTERVAL '90 DAY')
              --Event_Date between '2025-12-14' and '2025-12-15'
            group by Event_Date
              , Region
              , Category
              , Subcategory
              , Device_Type
              , Record_Type
              , File_record
          )
          , combined as (
            select cr.Event_Date
                   , cr.Region
                   , cr.Category
                   , cr.Subcategory
                   , cr.Device_Type
                   , cr.Record_Type
                   , cr.File_record
                   , cr.Revenue_Legacy
                   , nr.Revenue_New
                   , cr.Cost_Legacy
                   , nr.Cost_New
               from current_rpt cr
               left join new_rpt nr on nr.Event_Date = cr.Event_Date
                               and nr.Region = cr.Region
                               and nr.Category = cr.Category
                               and nr.Subcategory = cr.Subcategory
                               --and nr.Media_type = cr.Media_type
                            and nr.Device_Type = cr.Device_Type
                            --and nr.Impression_Type = cr.Impression_Type
                               and nr.Record_Type = cr.Record_Type
                               and nr.File_record = cr.File_record
          )
             select 'NOT EQUAL' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Record_Type
                 , File_record
                 , Revenue_Legacy
                 , Revenue_New
                 , Cost_Legacy
                 , Cost_New
             from combined
             where (Revenue_New <> Revenue_Legacy or Cost_New <> Cost_Legacy)
                and  Event_Date=(CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
             --order by cr.Event_Date, cr.File_record , cr.Region , cr.Category, cr.Subcategory
             UNION
             select 'DAILY' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , sum(Revenue_Legacy) as Revenue_Legacy
                 , sum(Revenue_New) as Revenue_New
                 , sum(Cost_Legacy) as Cost_Legacy
                 , sum(Cost_New) as Cost_New
             from combined
             where Event_Date=(CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
             UNION
             select 'WEEK' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , sum(Revenue_Legacy) as Revenue_Legacy
                 , sum(Revenue_New) as Revenue_New
                 , sum(Cost_Legacy) as Cost_Legacy
                 , sum(Cost_New) as Cost_New
             from combined
             where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
            UNION
             select 'MTD' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , sum(Revenue_Legacy) as Revenue_Legacy
                 , sum(Revenue_New) as Revenue_New
                 , sum(Cost_Legacy) as Cost_Legacy
                 , sum(Cost_New) as Cost_New
             from combined
             where Event_Date >= DATE_TRUNC('month', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
            UNION
             select 'QTD' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , sum(Revenue_Legacy) as Revenue_Legacy
                 , sum(Revenue_New) as Revenue_New
                 , sum(Cost_Legacy) as Cost_Legacy
                 , sum(Cost_New) as Cost_New
             from combined
             where Event_Date >= DATE_TRUNC('quarter', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
            UNION
             select 'YTD' as Metric_Type
                 , Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , sum(Revenue_Legacy) as Revenue_Legacy
                 , sum(Revenue_New) as Revenue_New
                 , sum(Cost_Legacy) as Cost_Legacy
                 , sum(Cost_New) as Cost_New
             from combined
             where Event_Date >= DATE_TRUNC('year', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
      ;;
  }

  parameter: Report_Run_Date {
    type: date
    hidden: no
    label: "Report run date:"
    description: "Choose a date that you want to see data on. If 'any time' is selected - data for today will be loaded."
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

  dimension: Metric_Type {
    description: "Metric_Type"
    type: string
    sql: ${TABLE}.Metric_Type ;;
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

  dimension: Record_Type {
    description: "Record type"
    type: string
    sql: ${TABLE}.Record_Type ;;
  }

  dimension: File_Record {
    description: "File Record"
    type: string
    sql: ${TABLE}.File_Record ;;
  }

  measure: Gross_Revenue_Daily_New {
    description: "Total Revenue across category, subcategory, region"
    label: "GR New"
    type: sum
    sql: ${TABLE}.Revenue_New ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_Daily_Legacy {
    description: "Total Revenue across category, subcategory, region"
    label: "GR Legacy"
    type: sum
    sql: ${TABLE}.Revenue_Legacy ;;
    value_format: "$#,##0;($#,##0)"
  }

  # measure: Gross_Revenue_Previous_Day {
  #   type: sum
  #   sql: ${TABLE}.LAG_Revenue ;;
  #   value_format: "$#,##0;($#,##0)"
  # }

  # measure: Gross_Revenue_MTD {
  #   type: sum
  #   sql: ${TABLE}.Revenue_MTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Gross Rev MTD"
  # }

  # measure: Gross_Revenue_QTD {
  #   type: sum
  #   sql: ${TABLE}.Revenue_QTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Gross Rev QTD"
  # }

  # measure: Gross_Revenue_YTD {
  #   type: sum
  #   sql: ${TABLE}.Revenue_YTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Gross Rev YTD"
  # }

  measure: Cost_Daily_New {
    description: "Total Cost across category, subcategory, region"
    label: "Cost New"
    type: sum
    sql: ${TABLE}.Cost_New;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Daily_Legacy {
    description: "Total Cost across category, subcategory, region"
    label: "Cost Legacy"
    type: sum
    sql: ${TABLE}.Cost_Legacy;;
    value_format: "$#,##0;($#,##0)"
  }

  # measure: Cost_Previous_Day {
  #   label: "Cost Revenue Previous Day"
  #   type: sum
  #   sql: ${TABLE}.LAG_Cost ;;
  #   value_format: "$#,##0;($#,##0)"
  # }

  # measure: Cost_MTD {
  #   type: sum
  #   sql: ${TABLE}.Cost_MTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Cost MTD"
  # }

  # measure: Cost_QTD {
  #   type: sum
  #   sql: ${TABLE}.Cost_QTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Cost QTD"
  # }

  # measure: Cost_YTD {
  #   type: sum
  #   sql: ${TABLE}.Cost_YTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Cost YTD"
  # }

  measure: Net_Revenue_Daily_Legacy {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "NR Legacy"
    type: sum
    sql: ${TABLE}.Revenue_Legacy - ${TABLE}.Cost_Legacy ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_Daily_New {
    description: "Total Net_Revenue across category, subcategory, region"
    label: "NR New"
    type: sum
    sql: ${TABLE}.Revenue_New - ${TABLE}.Cost_New ;;
    value_format: "$#,##0;($#,##0)"
  }

  # measure: Net_Revenue_Previous_Day {
  #   type: sum
  #   sql: ${TABLE}.LAG_Net_Revenue ;;
  #   value_format: "$#,##0;($#,##0)"
  # }

  # measure: Net_Revenue_MTD {
  #   type: sum
  #   sql: ${TABLE}.Net_Revenue_MTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Net Rev MTD"
  # }

  # measure: Net_Revenue_QTD {
  #   type: sum
  #   sql: ${TABLE}.Net_Revenue_QTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Net Rev QTD"
  # }

  # measure: Net_Revenue_YTD {
  #   type: sum
  #   sql: ${TABLE}.Net_Revenue_YTD ;;
  #   value_format: "$#,##0;($#,##0)"
  #   label: "Net Rev YTD"
  # }
}
