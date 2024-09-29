connection: "druid_iad_prod"

include: "/**/*.view.lkml"

datagroup: dod_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM BI_DSP.fact_nexxen_dsp  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}

access_grant: advertiser_msd {
  user_attribute: advertiser
  allowed_values: ["advertiser"]
}

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}


explore: dsp_media_and_bids_advertiser {
  label: "Dsp Media and bids - MSD"
  view_name: dsp_media_and_bids
  #access_filter: {
   # field: advertisers_email.email
    #user_attribute: advertiser
  #}

#join: advertisers_email {
 # type: inner
  #sql_on: ${dsp_media_and_bids.advertiser_id}=${advertisers_email.advertiser_id} ;;
  #relationship: many_to_one
#}
}
