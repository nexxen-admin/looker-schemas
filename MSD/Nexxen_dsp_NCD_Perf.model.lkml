connection: "looker_ms"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key_in_timezone) FROM BI_DSP.fact_nexxen_dsp_ncd_perf_test  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}


explore: fact_nexxen_ncd_perf_advertiser  {
  #required_access_grants: [advertiser_msd]
  view_name: fact_nexxen_dsp_ncd_perf_test
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Advertiser"
  view_label: "Measures"
  access_filter: {
    field: dim_dsp_advertiser.advertiser_id
    user_attribute: advertiser
  }
  #hidden: yes

  join: dim_dsp_insertion_order {
    type: inner
    view_label: "Insertion Order"
    sql_on: ${dim_dsp_line_item.insertion_order_id}=${dim_dsp_insertion_order.insertion_order_id} ;;
    relationship: many_to_one
  }

  join: dim_dsp_format {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp_ncd_perf_test.format_id}=${dim_dsp_format.format_id} ;;
  }

  join: dim_dsp_dma{
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp_ncd_perf_test.dma_key}=${dim_dsp_dma.dma_key} ;;
  }
  join: dim_dsp_device_type {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp_ncd_perf_test.device_type_key}=${dim_dsp_device_type.device_type_key} ;;
  }

  join: dim_dsp_region{
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp_ncd_perf_test.region_key}=${dim_dsp_region.region_key} ;;
  }

  join: dim_dsp_mobile_app {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp_ncd_perf_test.mobile_app_key}=${dim_dsp_mobile_app.mobile_app_key} ;;
  }

  join: dim_dsp_creative {
    type: left_outer
    view_label: "Creative"
    sql_on: ${dim_dsp_creative.creative_id_key}=${fact_nexxen_dsp_ncd_perf_test.creative_id_key} ;;
    relationship: many_to_one
  }

  join: v_dim_dsp_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${v_dim_dsp_date.date_key_raw} = ${fact_nexxen_dsp_ncd_perf_test.date_key_in_timezone_raw} ;;
    relationship: many_to_one

  }

  join: dim_dsp_advertiser {
    type: inner
    view_label: "Advertiser"
    sql_on: ${dim_dsp_advertiser.advertiser_id_key} = ${fact_nexxen_dsp_ncd_perf_test.advertiser_id_key} ;;
    relationship: many_to_one
  }

  join: dim_sfdb_account {
    type: inner
    view_label: "Salesforce Account"
    sql_on: ${dim_sfdb_account.account_id_key} = ${fact_nexxen_dsp_ncd_perf_test.account_id_key};;
    relationship: many_to_one

  }

  join: dim_sfdb_opportunity {
    type: inner
    view_label: "Salesforce Opportunity"
    sql_on: ${dim_sfdb_opportunity.opportunity_id_key} = ${fact_nexxen_dsp_ncd_perf_test.opportunity_id_key} ;;
    relationship: many_to_one
  }

  join:  dim_sfdb_opportunitylineitem_ncd_perf {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${dim_sfdb_opportunitylineitem_ncd_perf.opportunitylineitem_key} =${fact_nexxen_dsp_ncd_perf_test.opportunitylineitem_key} ;;
    relationship: many_to_one
  }

  join: ncd_pacing {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${ncd_pacing.opportunitylineitem_key}=${dim_sfdb_opportunitylineitem_ncd_perf.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${v_dim_dsp_date.date_key_date};;
    relationship: many_to_one
  }


  join: dim_sfdb_related_accounts {
    type: left_outer
    view_label: "Salesforce Account"
    sql_on: ${dim_sfdb_related_accounts.id}=${dim_sfdb_opportunity.related_account__c} ;;
    relationship: many_to_one
  }

  join: dim_dsp_package {
    type: inner
    view_label: "Package"
    sql_on: ${dim_dsp_package.package_id_key}=${fact_nexxen_dsp_ncd_perf_test.package_id_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_line_item {
    type: inner
    view_label: "Line Item"
    sql_on: ${dim_dsp_line_item.line_item_id_key}=${fact_nexxen_dsp_ncd_perf_test.line_item_key} ;;
    relationship: many_to_one
  }
}

explore: fact_reach_advertiser {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen dsp MSD= - Reach Advertiser"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  # access_filter: {
  #   field: dim_dsp_advertiser.advertiser_id
  #   user_attribute: advertiser
  # }
  hidden: yes
}

explore: fact_nexxen_ncd_perf_agency  {
  #required_access_grants: [advertiser_msd]
  view_name: fact_nexxen_dsp_ncd_perf_test
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Agency"
  view_label: "Measures"
  access_filter: {
    field: dim_dsp_advertiser.advertiser_id
    user_attribute: advertiser
  }
  #hidden: yes

  join: dim_dsp_insertion_order {
    type: inner
    view_label: "Insertion Order"
    sql_on: ${dim_dsp_line_item.insertion_order_id}=${dim_dsp_insertion_order.insertion_order_id} ;;
    relationship: many_to_one
  }

    join: dim_dsp_format {
      type: left_outer
      view_label: "Request Attributes"
      relationship: many_to_one
      sql_on: ${fact_nexxen_dsp_ncd_perf_test.format_id}=${dim_dsp_format.format_id} ;;
    }

    join: dim_dsp_dma{
      type: left_outer
      view_label: "Geo"
      relationship: many_to_one
      sql_on: ${fact_nexxen_dsp_ncd_perf_test.dma_key}=${dim_dsp_dma.dma_key} ;;
    }
    join: dim_dsp_device_type {
      type: left_outer
      view_label: "Request Attributes"
      relationship: many_to_one
      sql_on: ${fact_nexxen_dsp_ncd_perf_test.device_type_key}=${dim_dsp_device_type.device_type_key} ;;
    }

    join: dim_dsp_region{
      type: left_outer
      view_label: "Geo"
      relationship: many_to_one
      sql_on: ${fact_nexxen_dsp_ncd_perf_test.region_key}=${dim_dsp_region.region_key} ;;
    }

    join: dim_dsp_mobile_app {
      type: left_outer
      view_label: "Request Attributes"
      relationship: many_to_one
      sql_on: ${fact_nexxen_dsp_ncd_perf_test.mobile_app_key}=${dim_dsp_mobile_app.mobile_app_key} ;;
    }

    join: dim_dsp_creative {
      type: left_outer
      view_label: "Creative"
      sql_on: ${dim_dsp_creative.creative_id_key}=${fact_nexxen_dsp_ncd_perf_test.creative_id_key} ;;
      relationship: many_to_one
    }

    join: v_dim_dsp_date {
      type: inner
      view_label: "Time Frame"
      sql_on: ${v_dim_dsp_date.date_key_raw} = ${fact_nexxen_dsp_ncd_perf_test.date_key_in_timezone_raw} ;;
      relationship: many_to_one

    }

    join: dim_dsp_advertiser {
      type: inner
      view_label: "Advertiser"
      sql_on: ${dim_dsp_advertiser.advertiser_id_key} = ${fact_nexxen_dsp_ncd_perf_test.advertiser_id_key} ;;
      relationship: many_to_one
    }

    join: dim_sfdb_account {
      type: inner
      view_label: "Salesforce Account"
      sql_on: ${dim_sfdb_account.account_id_key} = ${fact_nexxen_dsp_ncd_perf_test.account_id_key};;
      relationship: many_to_one

    }

    join: dim_sfdb_opportunity {
      type: inner
      view_label: "Salesforce Opportunity"
      sql_on: ${dim_sfdb_opportunity.opportunity_id_key} = ${fact_nexxen_dsp_ncd_perf_test.opportunity_id_key} ;;
      relationship: many_to_one
    }

    join:  dim_sfdb_opportunitylineitem_ncd_perf {
      type: inner
      view_label: "Salesforce Opportunity Line Item"
      sql_on: ${dim_sfdb_opportunitylineitem_ncd_perf.opportunitylineitem_key} =${fact_nexxen_dsp_ncd_perf_test.opportunitylineitem_key} ;;
      relationship: many_to_one
    }

    join: ncd_pacing {
      type: inner
      view_label: "Salesforce Opportunity Line Item"
      sql_on: ${ncd_pacing.opportunitylineitem_key}=${dim_sfdb_opportunitylineitem_ncd_perf.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${v_dim_dsp_date.date_key_date};;
      relationship: many_to_one
    }


    join: dim_sfdb_related_accounts {
      type: left_outer
      view_label: "Salesforce Account"
      sql_on: ${dim_sfdb_related_accounts.id}=${dim_sfdb_opportunity.related_account__c} ;;
      relationship: many_to_one
    }

    join: dim_dsp_package {
      type: inner
      view_label: "Package"
      sql_on: ${dim_dsp_package.package_id_key}=${fact_nexxen_dsp_ncd_perf_test.package_id_key} ;;
      relationship: many_to_one
    }

    join: dim_dsp_line_item {
      type: inner
      view_label: "Line Item"
      sql_on: ${dim_dsp_line_item.line_item_id_key}=${fact_nexxen_dsp_ncd_perf_test.line_item_key} ;;
      relationship: many_to_one
    }
}

explore: fact_reach_agency {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen dsp MSD - Reach Agency"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  # access_filter: {
  #   field: dim_dsp_advertiser.advertiser_id
  #   user_attribute: advertiser
  # }
  hidden: yes
}
