include: "itv_sla_raw_metric_minute.view.lkml"
view: campaign_setup_and_ui {

    extends: [raw_metric_minute]

    derived_table: {
      sql:
          select *
          from sla.raw_metric_minute
          where metric_id like 'atv.linear.campaign.%' and check_json(metric_tag) is NULL ;;
    }

    dimension: campaign_id {
      type: string
      sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'campaignId');;
    }

    dimension: campaign_type {
      type: string
      sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'campaignType');;
    }

  }
