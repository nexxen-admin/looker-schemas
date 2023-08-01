view: campaign_details_plan {
  derived_table: {
    sql: SELECT cd.campaign_id AS campaign_id
                ,cd.pl_plan_id AS io_id
                ,MAX(fmd.begin_date) AS io_start_date
                ,MAX(fmd.end_date) AS io_end_date
                ,MAX(i.budget) AS io_budget
          FROM (
                SELECT pl_plan_id
                      ,MIN(fmd.begin_datetm) begin_date
                      ,MAX(fmd.end_datetm) end_date
                FROM dim.flight_media_details_base_view fmd
                INNER JOIN dim.campaign_details_base_view cd ON fmd.campaign_id = cd.campaign_id
                GROUP BY pl_plan_id
                ) fmd
          INNER JOIN dim.campaign_details_base_view cd ON cd.pl_plan_id = fmd.pl_plan_id
          INNER JOIN dim.insertion_order_campaign_view ioc ON cd.campaign_id = ioc.campaign_id
          INNER JOIN dim.insertion_order_details_view IO ON IO.insertion_order_id = ioc.insertion_order_id
          INNER JOIN (
                SELECT cd.pl_plan_id
                      ,sum(DISTINCT (dub.budget)) budget
                FROM dim.insertion_order_details_view IO
                INNER JOIN dim.campaign_details_base_view cd ON cd.insertion_order_id = IO.insertion_order_id
                INNER JOIN dim.demand_units_budget_view dub ON IO.insertion_order_id = dub.insertion_order_id
                      AND dub.campaign_id IS NULL
                GROUP BY cd.pl_plan_id
                ) i ON i.pl_plan_id = cd.pl_plan_id
          GROUP BY cd.pl_plan_id
                ,cd.campaign_id;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: io_id {
    type: number
    sql: ${TABLE}.io_id ;;
    value_format_name: id
  }

  dimension: io_start_date {
    type: date
    sql: ${TABLE}.io_start_date ;;
  }

  dimension: io_end_date {
    type: date
    sql: ${TABLE}.io_end_date ;;
  }

  dimension: io_budget {
    type: number
    sql: ${TABLE}.io_budget ;;
  }

}
