connection: "purple_labs"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

explore: purple_labs_audience_quality {
  label: "Purple Labs Audience Quality"
  hidden: no
  access_filter: {
    field: purple_labs_audience_quality.market_id
    user_attribute: purple_labs
  }
}

explore: purplelabs_audience_quality_monthly {
  label: "Purple Labs Audience Quality Monthly"
  hidden: no
  access_filter: {
    field: purplelabs_audience_quality_monthly.market_id
    user_attribute: purple_labs
  }
}

explore: purplelabs_script_metrics {
  label: "Purple Labs Script Metrics"
  hidden: no
  access_filter: {
    field: purplelabs_script_metrics.market_id
    user_attribute: purple_labs
  }
}

explore: purple_labs_audience_quality_nebo {
  label: "Purple Labs Audience Quality - Nebo"
  hidden: no
  access_filter: {
    field: purple_labs_audience_quality_nebo.market_id
    user_attribute: purple_labs
  }
}

explore: purple_labs_script_metrics_nebo {
  label: "Purple Labs Script Metrics - Nebo"
  hidden: no
  access_filter: {
    field: purple_labs_script_metrics_nebo.market_id
    user_attribute: purple_labs
  }
}
