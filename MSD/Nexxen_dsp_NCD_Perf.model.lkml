connection: "looker_ms"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key_in_timezone) FROM BI_DSP.ncd_fact_nexxen_dsp_test_raw_rev2  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}


explore: fact_nexxen_ncd_perf_advertiser  {
  #required_access_grants: [advertiser_msd]
  view_name: ncd_fact_nexxen_dsp_test_raw_rev2
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Advertiser"
  view_label: "Measures"
  access_filter: {
    field: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_id
    user_attribute: advertiser
  }
  #hidden: yes


  join: ncd_pacing {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${ncd_pacing.opportunitylineitem_key}=${ncd_fact_nexxen_dsp_test_raw_rev2.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date};;
    relationship: many_to_one
  }

}

explore: fact_reach_advertiser {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen DSP NCD - Reach Advertiser"
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
  view_name: ncd_fact_nexxen_dsp_test_raw_rev2
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Agency"
  view_label: "Measures"
  access_filter: {
    field: ncd_fact_nexxen_dsp_test_raw_rev2.account_id
    user_attribute: agency
  }
  #hidden: yes

     join: ncd_pacing {
      type: inner
      view_label: "Salesforce Opportunity Line Item"
      sql_on: ${ncd_pacing.opportunitylineitem_key}=${ncd_fact_nexxen_dsp_test_raw_rev2.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date};;
      relationship: many_to_one
    }

}

explore: fact_reach_agency {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen DSP NCD - Reach Agency"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  # access_filter: {
  #   field: dim_dsp_advertiser.advertiser_id
  #   user_attribute: advertiser
  # }
  hidden: yes
}
