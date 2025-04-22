include: "itv_sla_raw_metric_minute.view.lkml"
view: reporting {

  extends: [raw_metric_minute]

  derived_table: {
      sql:
          select *
          from sla.raw_metric_minute
          where metric_id like 'atv.reporting.%' and check_json(metric_tag) is NULL ;;
  }

  dimension: campaign_id {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'campaignId');;
  }

  dimension: report_name {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'reportName');;
  }

  dimension: error_message {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'errorMessage');;
  }

}
