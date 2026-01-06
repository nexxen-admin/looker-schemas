connection: "druid_iad_prod"

include: "/**/*.view.lkml"




datagroup: dod_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: dod_default_datagroup

explore: social_media {
  hidden: yes
}

explore: dsp_media_and_bids {
hidden: no
}

explore: dod_partner_ops {}
