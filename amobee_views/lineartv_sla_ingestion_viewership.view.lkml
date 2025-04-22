include: "itv_sla_raw_metric_minute.view.lkml"
view: ingestion_viewership {

  extends: [raw_metric_minute]

  derived_table: {
    # dedup records with the same metric_time, and select the record with the latest created-time and metric_time in est
    # platform_client_id is not included and when included, it won't return records with null values like tivo metrics
    sql:

    select * from sla.raw_metric_minute
    where (metric_id, date(CONVERT_TIMEZONE('UTC', 'America/New_York', metric_time)), region, metric_tag, created_time) in
        (select metric_id, date(CONVERT_TIMEZONE('UTC', 'America/New_York', metric_time)) metric_date_est, region, metric_tag, max(created_time)
         from sla.raw_metric_minute
         where (metric_id like 'ltv.viewership.%')
         group by metric_id, metric_date_est, region, metric_tag) ;;
  }

}
