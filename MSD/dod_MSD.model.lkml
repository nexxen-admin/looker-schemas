connection: "druid_iad_prod"

include: "/**/*.view.lkml"

datagroup: dod_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dod_default_datagroup

access_grant: advertiser_msd {
  user_attribute: advertiser
  allowed_values: ["advertiser"]
}

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}



explore: dsp_media_and_bids_advertiser {
  label: "Dsp Media and bids - MSD"
  view_name: dsp_media_and_bids
  # access_filter: {
  #   field: advertisers_email.email
  #   user_attribute: advertiser
  # }

}
