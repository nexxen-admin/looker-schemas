view: investor_kpi_dq {
  derived_table: {
    sql: with new_report as (
              select Event_Month
                  , Screen_type
                  , Imp_Type
                  , sum(Total_revenue) as Total_revenue
                  , sum(Cost) as Cost
                  , sum(Bid_Requests) as Bid_Requests
                  , sum(Impressions) as Impressions
              from  BI.KPI_Investor_KPIs
              group by Event_Month
                    , Screen_type
                    , Imp_Type
          ),
          legacy_report as (
              select Event_Month
                  , Screen_type
                  , Imp_Type
                  , sum(Total_revenue) as Total_revenue
                  , sum(Cost) as Cost
                  , sum(Bid_Requests) as Bid_Requests
                  , sum(Impressions) as Impressions
              from  BI.svc_Investor_KPIs
              group by Event_Month
                    , Screen_type
                    , Imp_Type
          )
          select 'Not equal values' as DQ_Type
                , nr.Event_Month
                , nr.Screen_type
                , nr.Imp_Type
                , nr.Total_revenue as Total_revenue_new
                , nr.Cost as Cost_new
                , nr.Bid_Requests as Bid_Requests_new
                , nr.Impressions as Impressions_new
                , lr.Total_revenue as Total_revenue_legacy
                , lr.Cost as Cost_legacy
                , lr.Bid_Requests as Bid_Requests_legacy
                , lr.Impressions as Impressions_legacy
          from new_report nr
          join legacy_report lr on lr.Event_Month = nr.Event_Month
                                and lr.Screen_type  = nr.Screen_type
                                and lr.Imp_Type = nr.Imp_Type
          where (lr.Total_revenue <> nr.Total_revenue
                or lr.Cost <> nr.Cost
                or lr.Bid_Requests <> nr.Bid_Requests
                or lr.Impressions <> nr.Impressions)
          UNION ALL
          select 'Missing in legacy report'
                , nr.Event_Month
                , nr.Screen_type
                , nr.Imp_Type
                , 0 as Total_revenue
                , 0 as Cost
                , 0 as Bid_Requests
                , 0 as Impressions
                , 0 as Total_revenue
                , 0 as Cost
                , 0 as Bid_Requests
                , 0 as Impressions
          from new_report nr
          left join legacy_report lr on lr.Event_Month = nr.Event_Month
                                and lr.Screen_type  = nr.Screen_type
                                and lr.Imp_Type = nr.Imp_Type
          where lr.Event_Month is null
          UNION ALL
          select 'Missing in new report'
                , lr.Event_Month
                , lr.Screen_type
                , lr.Imp_Type
                , 0 as Total_revenue
                , 0 as Cost
                , 0 as Bid_Requests
                , 0 as Impressions
                , 0 as Total_revenue
                , 0 as Cost
                , 0 as Bid_Requests
                , 0 as Impressions
          from legacy_report lr
          left join new_report nr on lr.Event_Month = nr.Event_Month
                                and lr.Screen_type  = nr.Screen_type
                                and lr.Imp_Type = nr.Imp_Type
          where nr.Event_Month is null

      ;;
  }

    dimension: category {
      type: string
      sql: ${TABLE}.DQ_Type ;;
    }

    dimension: month {
      type: string
      sql: ${TABLE}.month ;;
    }

    dimension: year {
      type: string
      sql: ${TABLE}.year ;;
    }

    dimension_group: event_month {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.Event_Month ;;
    }

    dimension: event_month_number {
      type: number
      sql: EXTRACT(MONTH FROM ${event_month_date}) ;;
    }

    dimension: imp_type {
      type: string
      sql: ${TABLE}.Imp_Type ;;
    }

    dimension: screen_type {
      type: string
      sql: ${TABLE}.Screen_Type ;;
    }

    dimension: source {
      type: string
      sql: ${TABLE}."Source" ;;
    }

    dimension_group: current_date {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: current_date ;;
    }

    dimension: previous_month {
      type: string
      sql: LEFT(CAST(DATE_TRUNC('MONTH', TO_DATE(${current_date_month} || '-01', 'YYYY-MM-DD')) - INTERVAL '1 month' AS VARCHAR), 7) ;;
    }

    dimension: is_current_month {
      type: string
      sql: case when ${event_month_month} = ${previous_month}
        then 'Yes' else 'No' end;;
    }

    measure: bid_requests_new {
      type: sum
      sql: ${TABLE}.Bid_Requests_new ;;
    }

    measure: cost_new {
      type: sum
      sql: ${TABLE}.Cost_new ;;
    }

    measure: total_revenue_new {
      type: sum
      sql: ${TABLE}.Total_Revenue_new ;;
      value_format: "$#,##0"
    }

    measure: Net_Revenue_new{
      type: sum
      value_format: "$#,##0"
      sql: ${TABLE}.Total_Revenue_new-${TABLE}.Cost_new ;;
    }

    measure: impressions_new {
      type: sum
      sql: ${TABLE}.Impressions_new ;;
    }

    measure: Margin_new {
      type: sum
      sql: (${TABLE}.Total_Revenue_new-${TABLE}.Cost_new)/${TABLE}.Total_Revenue_new ;;
    }

    measure: bid_requests_legacy {
      type: sum
      sql: ${TABLE}.Bid_Requests_legacy ;;
    }

    measure: cost_legacy {
      type: sum
      sql: ${TABLE}.Cost_legacy ;;
    }

    measure: total_revenue_legacy {
      type: sum
      sql: ${TABLE}.Total_Revenue_legacy ;;
      value_format: "$#,##0"
    }

    measure: Net_Revenue_legacy{
      type: sum
      value_format: "$#,##0"
      sql: ${TABLE}.Total_Revenue_legacy-${TABLE}.Cost_legacy ;;
    }

    measure: impressions_legacy {
      type: sum
      sql: ${TABLE}.Impressions_legacy ;;
    }

    measure: Margin_legacy {
      type: sum
      sql: (${TABLE}.Total_Revenue_legacy-${TABLE}.Cost_legacy)/${TABLE}.Total_Revenue_legacy ;;
    }

    measure: count {
      type: count
      drill_fields: []
    }
}
