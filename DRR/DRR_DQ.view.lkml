view: drr_dq {
  derived_table: {
    sql: with new_rpt as (
            select Event_Date
                , Region
                , Category
                , Subcategory
                , Device_Type
                , Record_Type
                , File_record
                , sum(Revenue)::int as Revenue_New
                , sum(Cost)::int as Cost_New
            from BI.DRR_Daily_Revenue_Report
            --where File_record <>'Amobee - Monthly LOB'
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
                , Device_Type
                , Record_Type
                , File_record
                , sum(Revenue)::int as Revenue_Legacy
                , sum(Cost)::int as Cost_Legacy
            from BI.SVC_DRR_Daily_Revenue_Report
            --where File_record <>'Amobee - Monthly LOB'
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
                               and nr.Device_Type = cr.Device_Type
                               and nr.Record_Type = cr.Record_Type
                               and nr.File_record = cr.File_record
          )
          , new_report_totals as (
            select Event_Date
                  , sum(Revenue_New) as Revenue_New_Total
                  , sum(Cost_New) as Cost_New_Total
            from new_rpt
            where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
            group by Event_Date
          )
          , current_report_totals as (
            select Event_Date
                  , sum(Revenue_Legacy) as Revenue_Legacy_Total
                  , sum(Cost_Legacy) as Cost_Legacy_Total
            from current_rpt
            where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
            group by Event_Date
          )
          , new_report_totals_noMlob as (
            select Event_Date
                  , sum(Revenue_New) as Revenue_New_Total
                  , sum(Cost_New) as Cost_New_Total
            from new_rpt
            where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
            and File_record <>'Amobee - Monthly LOB'
            group by Event_Date
          )
          , current_report_totals_noMlob as (
            select Event_Date
                  , sum(Revenue_Legacy) as Revenue_Legacy_Total
                  , sum(Cost_Legacy) as Cost_Legacy_Total
            from current_rpt
            where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
            and File_record <>'Amobee - Monthly LOB'
            group by Event_Date
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where (Revenue_New <> Revenue_Legacy or Cost_New <> Cost_Legacy)
                and  Event_Date=(CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where Event_Date=(CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Revenue_New_Total
                 , Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where Event_Date >= (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE - INTERVAL '6 DAYS' AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Revenue_New_Total
                 , Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where Event_Date >= DATE_TRUNC('month', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Revenue_New_Total
                 , Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where Event_Date >= DATE_TRUNC('quarter', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Revenue_New_Total
                 , Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
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
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from combined
             where Event_Date >= DATE_TRUNC('year', (CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE - INTERVAL '1 DAY' ELSE {% parameter Report_Run_Date %} END)::DATE)::date AND Event_Date <= CASE WHEN {% parameter Report_Run_Date %} IS NULL THEN CURRENT_DATE ELSE {% parameter Report_Run_Date %} END
             group by Event_Date
                 , Region
                 , Category
                 , Subcategory
                 , Device_Type
                 , Revenue_New_Total
                 , Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
            UNION
             select 'TOTALS' as Metric_Type
                 , Event_Date
                 , '' as Region
                 , '' as Category
                 , '' as Subcategory
                 , '' as Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , 0 as Revenue_Legacy
                 , 0 as Revenue_New
                 , 0 as Cost_Legacy
                 , 0 as Cost_New
                 , Revenue_New_Total
                 , Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from new_report_totals
            UNION
             select 'TOTALS' as Metric_Type
                 , Event_Date
                 , '' as Region
                 , '' as Category
                 , '' as Subcategory
                 , '' as Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , 0 as Revenue_Legacy
                 , 0 as Revenue_New
                 , 0 as Cost_Legacy
                 , 0 as Cost_New
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
             from current_report_totals
            UNION
             select 'TOTALS_NOMLOB' as Metric_Type
                 , Event_Date
                 , '' as Region
                 , '' as Category
                 , '' as Subcategory
                 , '' as Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , 0 as Revenue_Legacy
                 , 0 as Revenue_New
                 , 0 as Cost_Legacy
                 , 0 as Cost_New
                 , Revenue_New_Total
                 , Cost_New_Total
                 , 0 as Revenue_Legacy_Total
                 , 0 as Cost_Legacy_Total
             from new_report_totals_noMlob
            UNION
             select 'TOTALS_NOMLOB' as Metric_Type
                 , Event_Date
                 , '' as Region
                 , '' as Category
                 , '' as Subcategory
                 , '' as Device_Type
                 , '' as Record_Type
                 , '' as File_record
                 , 0 as Revenue_Legacy
                 , 0 as Revenue_New
                 , 0 as Cost_Legacy
                 , 0 as Cost_New
                 , 0 as Revenue_New_Total
                 , 0 as Cost_New_Total
                 , Revenue_Legacy_Total
                 , Cost_Legacy_Total
             from current_report_totals_noMlob
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





  measure: Gross_Revenue_Totals_New {
    description: "Total Revenue across event_date"
    label: "GR New Total"
    type: sum
    sql: ${TABLE}.Revenue_New_Total ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Gross_Revenue_Totals_Legacy {
    description: "Total Revenue across event_date"
    label: "GR Legacy Total"
    type: sum
    sql: ${TABLE}.Revenue_Legacy_Total ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Totals_New {
    description: "Total Cost across event_date"
    label: "Cost New Total"
    type: sum
    sql: ${TABLE}.Cost_New_Total;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Cost_Totals_Legacy {
    description: "Total Cost across event_date"
    label: "Cost Legacy Total"
    type: sum
    sql: ${TABLE}.Cost_Legacy_Total;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_Totals_Legacy {
    description: "Total Net_Revenue across event_date"
    label: "NR Legacy Total"
    type: sum
    sql: ${TABLE}.Revenue_Legacy_Total - ${TABLE}.Cost_Legacy_Total ;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: Net_Revenue_Totals_New {
    description: "Total Net_Revenue event_date"
    label: "NR New Total"
    type: sum
    sql: ${TABLE}.Revenue_New_Total - ${TABLE}.Cost_New_Total ;;
    value_format: "$#,##0;($#,##0)"
  }


}
