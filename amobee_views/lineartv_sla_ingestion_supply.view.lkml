include: "itv_sla_raw_metric_minute.view.lkml"
view: ingestion_supply {

  extends: [raw_metric_minute]

  derived_table: {
    # dedup records with the same metric_time, and select the record with the latest created-time and metric_time in est
    sql:

    select * from sla.raw_metric_minute
    where (metric_id, date(CONVERT_TIMEZONE('UTC', 'America/New_York', metric_time)), region, metric_tag, platform_client_id, created_time) in
        (select metric_id, date(CONVERT_TIMEZONE('UTC', 'America/New_York', metric_time)) metric_date_est, region, metric_tag, platform_client_id,  max(created_time)
         from sla.raw_metric_minute
         where (metric_id like 'ltv.supply.%')
         group by metric_id, metric_date_est, region, metric_tag, platform_client_id) ;;
  }

}
