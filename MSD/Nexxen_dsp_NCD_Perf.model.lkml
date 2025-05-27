connection: "ncd_vertica"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key_in_timezone) FROM BI_DSP.ncd_fact_nexxen_dsp_state  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}


explore: fact_nexxen_ncd_perf_advertiser  {
  #required_access_grants: [advertiser_msd]
  view_name: ncd_fact_nexxen_dsp_state
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Advertiser"
  view_label: "Measures"
  access_filter: {
    field: ncd_fact_nexxen_dsp_state.advertiser_id
    user_attribute: advertiser
  }
  #hidden: yes


  join: ncd_pacing {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${ncd_pacing.opportunitylineitem_key}=${ncd_fact_nexxen_dsp_state.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${ncd_fact_nexxen_dsp_state.date_key_date};;
    relationship: many_to_one
  }

}

explore: fact_reach_advertiser {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen DSP NCD - Reach Advertiser"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  access_filter: {
    field: fact_reach_frequency.advertiser_id
    user_attribute: advertiser
  }
  hidden: yes
}

explore: fact_nexxen_ncd_perf_agency  {
  #required_access_grants: [advertiser_msd]
  view_name: ncd_fact_nexxen_dsp_state
  persist_with: CleanCash_datagroup
  label: "Nexxen DSP - NCD Agency"
  view_label: "Measures"
  access_filter: {
    field: ncd_fact_nexxen_dsp_state.account_id
    user_attribute: agency
  }
  #hidden: yes

     join: ncd_pacing {
      type: inner
      view_label: "Salesforce Opportunity Line Item"
      sql_on: ${ncd_pacing.opportunitylineitem_key}=${ncd_fact_nexxen_dsp_state.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${ncd_fact_nexxen_dsp_state.date_key_date};;
      relationship: many_to_one
    }

}

explore: fact_reach_agency {
  # required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen DSP NCD - Reach Agency"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  access_filter: {
    field: fact_reach_frequency.account_id
    user_attribute: agency
  }
  hidden: yes
}
